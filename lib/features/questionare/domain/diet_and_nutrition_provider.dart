import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/models/diet_and_nutrition_response.dart';
import 'package:nutri_care_mobile/network/api_service.dart';
import 'package:nutri_care_mobile/res/toasts.dart';
import '../../../network/api_url.dart';
import '../../../network/models.dart';

class DietAndNutritionProvider extends ChangeNotifier {
  DietAndNutritionResponse dietAndNutritionResponse  = DietAndNutritionResponse();
  BuildContext ?context;
  List<String> selectedValuesForTypeOfDiet = [];
  bool isHighlightedForTypeOfDiet = false;
  int currentStep = 0;
  List<String> selectedConditionsForFoodIntolerance = [];
  TextEditingController foodIDislikeController = TextEditingController();
  bool isHighlightedForFoodIntolerance = false;
  String? selectedOptionForFoodIntolerance;
  List<String> selectedConditionsForFoodIDislike = [];
  bool isHighlightedForFoodIDislike = false;
  String? selectedOptionForFoodIDislike = '';
  String? selectedValueForReligiousPreference;
  String? selectedValueForPrimaryDietaryGoal;
  String? selectedValueForMealFrequencyCode;
  String? selectedValueForNutrientPreference;

  initContext({context})
  {
    this.context=context;
  }

  Future<bool> saveDietPreference({
    required String profileId,
  }) async {

    final body = {
      "diets": selectedValuesForTypeOfDiet,
      "isFoodIntolerances": selectedConditionsForFoodIntolerance.isNotEmpty?true:false,
      "foodIntolerances": selectedConditionsForFoodIntolerance,
      "isFoodDislikes": selectedConditionsForFoodIDislike.isNotEmpty?true:false,
      "foodDislikes": selectedConditionsForFoodIDislike,
      "dietPreferenceCode": selectedValueForReligiousPreference,
      "dietaryGoalCode": [selectedValueForPrimaryDietaryGoal],
      "mealFrequencyCode": selectedValueForMealFrequencyCode,
      "nutrientPreferenceCode": [selectedValueForNutrientPreference],
      "profileId": profileId}
    ;
    print("body: $body");

    try {
      dietAndNutritionResponse = await MyApi.callPostApi(
          url: dietPreferenceUrl,
          body: body,
          modelName: Models.dietAndNutritionResponse);

      if (dietAndNutritionResponse.statusCode == 201) {
        print("dietAndNutritionResponse: ${dietAndNutritionResponse.statusCode}");
        Toasts.getSuccessToast(text: dietAndNutritionResponse.data?.message);
        return true;
      } else {
        print("dietAndNutritionResponse: ${dietAndNutritionResponse.statusCode}");
        return false;

      }
    } catch (e) {
      print("Exception occurred in dietAndNutritionResponse is: $e");
      return false;
    }
  }
}