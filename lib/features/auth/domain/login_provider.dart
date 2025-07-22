import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../models/login_response.dart';
import '../../../network/api_service.dart';
import '../../../network/api_url.dart';
import '../../../network/models.dart';
import '../../../res/loader.dart';
import '../../../res/strings.dart';
import '../../../res/toasts.dart';
import '../../../res/utilities.dart';
import '../../../res/utils.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final Loader _loader = Loader();
  bool hidePassword = true;
  bool sendToken = false;
  ValueNotifier<bool> rememberMe = ValueNotifier<bool>(false);
  LoginResponse loginResponse = LoginResponse();
  bool isDataFetched = false;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  BuildContext? context;
  bool obsecurePassword = true;

  setHidePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }
  callRememberMe(bool remember) {
    rememberMe.value = remember;
    notifyListeners();
  }

  toggleObsecurePassword(){
    obsecurePassword = !obsecurePassword;
    notifyListeners();
  }


  init({required BuildContext context}) async {
    this.context = context;
    sendToken = false;
  }
  void loadUserDetails() async {
    rememberMe.value = false;
    bool rememberme = PreferenceUtils.getBool(Strings.rememberMe);
    if (rememberme) {
      String? username = PreferenceUtils.getString(Strings.rememberedEmail);
      String? password = PreferenceUtils.getString(Strings.rememberedPassword);
      debugPrint("password-->$password");
      debugPrint("loginProvider.passwordController.text-->${passwordController.text}");
      emailController.text = username ?? '';
      passwordController.text = password ?? '';
      rememberMe.value = rememberme;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  reset() {
    emailController.clear();
    passwordController.clear();
  }


  Future<void> onLoginTap() async{
    if (emailController.text.trim().isEmpty) {
      Toasts.getErrorToast(text: "Enter your email address");
    } else if (!emailController.text.trim().validateEmail()) {
      Toasts.getErrorToast(text: "Enter valid email address");
    }
    else if(passwordController.text.trim().isEmpty)
      {
        Toasts.getErrorToast(text: "Enter your password");

      }
    // else if (validatePassword(passwordController.text)) {
    //   await loginApi();
    // }
    else {
      debugPrint("email: ${emailController.text}");
      debugPrint("password ${passwordController.text}");
      loginApi();
    }
  }

  Future<void> loginApi() async {
    try {
      loginResponse=LoginResponse();
      _loader.showLoader(context: context);
      // String? fcmToken = await _firebaseMessaging.getToken();
      // await PreferenceUtils.setString("${Strings.fcmToken}${DateTime.now().millisecond}",fcmToken??"");
      // debugPrint("fcmToken : $fcmToken");
      Map<String, dynamic> body = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "rememberMe": rememberMe.value,
      };
      debugPrint("body for login : $body");
      loginResponse = await MyApi.callPostApi(
          url: loginApiUrl,
          body: body,
          modelName: Models.loginModel,
          sendToken: false);

      if (loginResponse.user?.isVerified == true) {
        _loader.hideLoader(context!);
        if (loginResponse.user?.id != "" && loginResponse.user?.id != null) {
          if (rememberMe.value) {
            await PreferenceUtils.setBool(Strings.rememberMe, true);
            await PreferenceUtils.setString(Strings.rememberedEmail, emailController.text.trim().toString() );
            await PreferenceUtils.setString(Strings.rememberedPassword, passwordController.text.trim().toString());
            PreferenceUtils.getString(Strings.rememberedPassword);
          }
          await PreferenceUtils.setLoginResponse(loginResponse);
          reset();
          ///hascompletedquestionaire
          if(loginResponse.user?.questionnaire??false)
          {
            Navigator.pushNamedAndRemoveUntil(
              context!,
              AppRoutes.homeScreen,
                  (route) => false, // Remove all routes in the stack
            );
          }
          else{
            Navigator.pushNamedAndRemoveUntil(
              context!,
              AppRoutes.privacyPolicyScreen,
                  (route) => false, // Remove all routes in the stack
            );
          }
        }
      } else {
        FocusManager.instance.primaryFocus?.unfocus();

        // Toasts.getErrorToast(text: loginResponse.status);
        _loader.hideLoader(context!);
      }
    } catch (err) {
      FocusManager.instance.primaryFocus?.unfocus();

      debugPrint("error during login is : $err");
      _loader.hideLoader(context!);
    }
  }

}
