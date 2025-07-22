import 'package:flutter/cupertino.dart';
import 'package:nutri_care_mobile/models/update_age_response.dart';
import 'package:nutri_care_mobile/models/update_gender_response.dart';
import 'package:nutri_care_mobile/models/update_height_response.dart';
import 'package:nutri_care_mobile/models/update_weight_response.dart';
import 'package:nutri_care_mobile/res/toasts.dart';

import '../../../core/routes/app_routes.dart';
import '../../../models/update_user_profile_response.dart';
import '../../../network/api_service.dart';
import '../../../network/api_url.dart';
import '../../../network/models.dart';
import '../../../res/loader.dart';

class OnboardingProvider extends ChangeNotifier{
  UpdateUserProfileResponse updateUserProfileResponse = UpdateUserProfileResponse();
  UpdateAgeResponse updateAgeResponse = UpdateAgeResponse();
  UpdateGenderResponse updateGenderResponse = UpdateGenderResponse();
  UpdateHeightResponse updateHeightResponse = UpdateHeightResponse();
  UpdateWeightResponse updateWeightResponse = UpdateWeightResponse();
  int currentStep = 0;
  double age = 25;
  String selectedGender = "";
  final Loader _loader = Loader();
  bool isDataFetched = false;
  BuildContext ? context;
  TextEditingController genderController = TextEditingController();
  double height = 170;
  bool isFeet = false;
  double weight = 70;
  double targetWeight = 65;
  bool isKilogram = true;


  void initContext(BuildContext ?context) {
    this.context = context;
  }
  Future<bool> updateUserProfile() async {
    try{
      _loader.showLoader(context: context);
      int ageVal = age.toInt();
      Map<String, dynamic> body = {
        "age": ageVal,
        "gender": selectedGender.toLowerCase().toString(),
        "height": height,
        "weight": weight,
        "targetWeight": targetWeight
      };
      debugPrint("body for updating onboarding : $body");
      updateUserProfileResponse = await MyApi.callPostApi(
        url: updateProfileUrl,
        body: body,
        modelName: Models.updateUserProfileResponse,
        sendToken: true
      );
      if(updateUserProfileResponse.message!='')
        {
          Toasts.getSuccessToast(text: updateUserProfileResponse.message);
        }

      _loader.hideLoader(context!);
      notifyListeners();
      return true;
    }
    catch (err) {
      debugPrint("error during onboarding is : $err");
      _loader.hideLoader(context!);
      return false;

    }
  }
  Future<bool> updateAge({
    String? profileId,
     }) async {
    try{
      // _loader.showLoader(context: context);
      print("profileId-->$profileId");
      Map<String, dynamic> body = {
        "age": age,
        "profileId": profileId,
      };
      debugPrint("body for onboarding age : $body");
      updateAgeResponse = await MyApi.callPatchApi(
        url: patchUpdateAgeUrl,
        body: body,
        modelName: Models.updateAgeResponse,
      );
      if(updateAgeResponse.status=='success')
        {
          Toasts.getSuccessToast(text: updateAgeResponse.data?.message);
        }

      // _loader.hideLoader(context!);
      notifyListeners();
      return true;
    }
    catch (err) {
      debugPrint("error during onboarding is : $err");
      // _loader.hideLoader(context!);
      return false;

    }
  }

  Future<bool> updateGender({
    String? profileId,
  }) async {
    try{
      // _loader.showLoader(context: context);
      print("profileId-->$profileId");
      print("patchUpdateGenderUrl-->$patchUpdateGenderUrl");
      Map<String, dynamic> body = {
        "gender": selectedGender.toUpperCase(),
        "profileId": profileId,
      };
      debugPrint("body for onboarding gender : $body");
      updateGenderResponse = await MyApi.callPatchApi(
        url: patchUpdateGenderUrl,
        body: body,
        modelName: Models.updateGenderResponse,
      );
      // _loader.hideLoader(context!);
      if(updateGenderResponse.status=='success')
      {
        Toasts.getSuccessToast(text: updateGenderResponse.data?.message);
      }

      currentStep++;
      Navigator.pushReplacementNamed(
        context!,
        AppRoutes.onboardingHeightScreen,
        arguments: currentStep + 1,
      );
      notifyListeners();
      return true;

    }
    catch (err) {
      debugPrint("error during onboarding is : $err");
      // _loader.hideLoader(context!);
      return false;

    }
  }
  Future<bool> updateHeight({
    String? profileId,
  }) async {
    try{
      // _loader.showLoader(context: context);
      print("profileId-->$profileId");
      print("patchUpdateHeightUrl-->$patchUpdateHeightUrl");
      Map<String, dynamic> body = {
        "height": height,
        "unit": isFeet?"ft/in":"cm",
        "profileId": profileId,
      };
      debugPrint("body for onboarding HEIGHT : $body");
      updateHeightResponse = await MyApi.callPatchApi(
        url: patchUpdateHeightUrl,
        body: body,
        modelName: Models.updateHeightResponse,
      );
      // _loader.hideLoader(context!);
      if(updateHeightResponse.status=='success')
      {
        Toasts.getSuccessToast(text: updateHeightResponse.data?.message);
      }

      currentStep++;
      notifyListeners();
      return true;

    }
    catch (err) {
      debugPrint("error during onboarding is : $err");
      // _loader.hideLoader(context!);
      return false;

    }
  }
  Future<bool> updateWeight({
    String? profileId,
  }) async {
    try{
      // _loader.showLoader(context: context);
      print("profileId-->$profileId");
      print("patchUpdateHeightUrl-->$patchUpdateHeightUrl");
      Map<String, dynamic> body = {
        "weight": weight,
        "unit": isKilogram?"kg":"lbs",
        "profileId": profileId,
      };
      debugPrint("body for onboarding HEIGHT : $body");
      updateWeightResponse = await MyApi.callPatchApi(
        url: patchUpdateWeightUrl,
        body: body,
        modelName: Models.updateWeightResponse,
      );
      // _loader.hideLoader(context!);
      currentStep = currentStep+1;
      if(updateHeightResponse.status=='success')
      {
        Toasts.getSuccessToast(text: updateHeightResponse.data?.message);
      }
      notifyListeners();
      return true;

    }
    catch (err) {
      debugPrint("error during onboarding is : $err");
      // _loader.hideLoader(context!);
      return false;

    }
  }

}
