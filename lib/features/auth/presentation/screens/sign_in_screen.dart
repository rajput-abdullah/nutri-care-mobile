import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri_care_mobile/core/constants/app_colors.dart';
import 'package:nutri_care_mobile/core/widgets/custom_button.dart';
import 'package:nutri_care_mobile/core/widgets/input_field.dart';
import 'package:provider/provider.dart';
import '../../../../res/res.dart';
import '../../domain/login_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lp = context.read<LoginProvider>();
      lp.init(context: context);
      lp.loadUserDetails();
    });
  }


  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    loginProvider.init(context: context);
    initializeResources(context: context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: true,
      body: Container(
        height: sizes!.height,
        width: sizes!.width,
        color: Colors.grey.shade100,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Center(
                    child: SvgPicture.asset(
                      'assets/svg/logo.svg',
                      height: 30,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sign in to your account",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Please enter your details to continue.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 20),
                        InputField(
                          controller: loginProvider.emailController,
                          label: "Email",
                          keyboardType: TextInputType.emailAddress,
                          fillColor: Colors.transparent,
                        ),
                        SizedBox(height: 16),
                        InputField(
                          controller: loginProvider.passwordController,
                          label: "Password",
                          obscureText: loginProvider.obsecurePassword,
                          fillColor: Colors.transparent,
                          suffixIcon: IconButton(
                            onPressed: () {
                              loginProvider.toggleObsecurePassword();
                            },
                            icon: Icon(
                              loginProvider.obsecurePassword
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: AppColors.darkGreyTextColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       value: loginProvider.rememberMe.value,
                        //       onChanged: (bool? value) {
                        //         print("valuse-->$value");
                        //         loginProvider.callRememberMe(value ?? false);
                        //       },
                        //       activeColor: Color(0xFF1F4E6A),
                        //     ),
                        //     Text(
                        //       "Remember me",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         color: Color(0xFF1F4E6A),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            label: "Sign In",
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              loginProvider.onLoginTap();
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/forgotPasswordEmail');
                            Navigator.pushNamed(context, '/forgotPasswordEmail');
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Color(0xFF1F4E6A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade400,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("OR"),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade400,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/signUp'),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Color(0xFF1F4E6A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}