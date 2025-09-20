import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutri_care_mobile/features/questionare/domain/diet_and_nutrition_provider.dart';
import 'package:nutri_care_mobile/features/questionare/domain/medical_background_provider.dart';
import 'package:nutri_care_mobile/models/health_and_bio_hacking_response.dart';
import 'package:nutri_care_mobile/models/update_questionnaire_response.dart';
import 'package:nutri_care_mobile/network/api_service.dart';
import 'package:nutri_care_mobile/res/loader.dart';
import 'package:nutri_care_mobile/res/toasts.dart';
import 'package:provider/provider.dart';
import '../../../network/api_url.dart';
import '../../../network/models.dart';
import '../presentation/lifestyle_and_daily_habits/domain/lifestyle_provider.dart';
import 'fitness_and_physical_activity_provider.dart';

class HealthAndBioHackingGoalsProvider extends ChangeNotifier {
  HealthAndBioHackingResponse healthAndBioHackingResponse  = HealthAndBioHackingResponse();
  UpdateQuestionnaireResponse updateQuestionnaireResponse  = UpdateQuestionnaireResponse();
  BuildContext ?context;
  int currentStep = 0;
  String? selectedValueForSpecificAreasOfHealth;
  String? selectedValueForAnyBioHackingPractices;
  String? selectedValueForTrackingHealthPractices;
  String ?selectedValuesForImprovingYourHealth;



  initContext({context})
  {
    this.context=context;
  }

  Future<bool> saveBioHackingGoals({
    required String profileId,
  }) async {
    final body = {
      "healthOptimizationCode": [selectedValueForSpecificAreasOfHealth],
      // Allowed Codes:
      // "PE" - Physical Endurance: Improving physical endurance
      // "MC" - Mental Clarity: Enhancing mental clarity
      // "SQ" - Sleep Quality: Improving quality of sleep
      // "IS" - Immune Support: Boosting immune system health
      // "EL" - Energy Levels: Improving overall energy levels

      "biohackingPracticeCode": [selectedValueForAnyBioHackingPractices],
      // Allowed Codes:
      // "IF" - Intermittent Fasting: Fasting for certain periods
      // "CT" - Cold Therapy: Using cold exposure for health benefits
      // "MED" - Meditation: Practice of mindfulness and meditation
      // "NS" - Nutritional Supplements: Using supplements for health optimization
      // "NP" - No Preference: No specific biohacking preference

      "isHealthMetricTracking": selectedValueForTrackingHealthPractices=='yes'?true:false,
      "healthMotivationCode": [selectedValuesForImprovingYourHealth],
      // Allowed Codes:
      // "APG" - Achieving Personal Goals: Focus on personal achievements
      // "IDP" - Improving Daily Performance: Enhancing everyday performance
      // "LTW" - Long-Term Wellness: Focus on long-term health
      // "FPR" - Family or Personal Relationships: Maintaining healthy relationships

      "profileId": profileId
    };
    debugPrint("body: $body");
    try {
      healthAndBioHackingResponse = await MyApi.callPostApi(
          url: healthGoalUrl,
          body: body,
          modelName: Models.healthAndBioHackingResponse);
      if (healthAndBioHackingResponse.statusCode == 201) {
        print("healthAndBioHackingResponse: ${healthAndBioHackingResponse.statusCode}");
        Toasts.getSuccessToast(text: healthAndBioHackingResponse.data?.message);
        return true;
      } else {
        print("healthAndBioHackingResponse: ${healthAndBioHackingResponse.statusCode}");
        return false;

      }
    } catch (e) {
      print("Exception occurred in healthAndBioHackingResponse is: $e");
      return false;
    }
  }
  Future<bool> saveQuestionnaireData() async {
    Loader().showLoader(context: context);

      final medicalBackGroundProvider = Provider.of<MedicalBackGroundProvider>(context!, listen: false);
      final lifestyleAndHabitProvider = Provider.of<LifestyleAndHabitProvider>(context!, listen: false);
      final dietAndNutritionProvider = Provider.of<DietAndNutritionProvider>(context!, listen: false);
      final fitnessAndPhysicalActivityProvider = Provider.of<FitnessAndPhysicalActivityProvider>(context!, listen: false);
    final body = {
      "medicalBackground": {
        "takingMedications":      medicalBackGroundProvider.medications.isNotEmpty?true:false,
        "medicationsList":        medicalBackGroundProvider.medications,
        "takingSupplements":      medicalBackGroundProvider.vitaminsAndSupplements.isNotEmpty?true:false,
        "supplementsList":        medicalBackGroundProvider.vitaminsAndSupplements,
        "allergies":              medicalBackGroundProvider.selectedConditionsForAllergies,
        "pastConditions":         medicalBackGroundProvider.selectedConditionsForPastMedicalConditions,
        "specificConcerns":       medicalBackGroundProvider.selectedOptionForHealthConcern=="Yes"? medicalBackGroundProvider.selectedConditionsForHealthConcern.first.toString():'',
        "medicalConditions":       medicalBackGroundProvider.selectedConditions,
        "isAnyPastCondition":     medicalBackGroundProvider.selectedConditionsForPastMedicalConditions.isNotEmpty?true:false,
        "isAnyHealthConcern":    medicalBackGroundProvider.selectedConditionsForHealthConcern.isNotEmpty?true:false
      },
      "lifestyleHabits": {
        "energyLevels": lifestyleAndHabitProvider.selectedEnergyLevel,
        "waterIntake": lifestyleAndHabitProvider.selectedWaterIntake,
        "substanceConsumption": lifestyleAndHabitProvider.selectedDrugsValues
      },
      "dietPreferences": {
        "diets": dietAndNutritionProvider.selectedValuesForTypeOfDiet,
        "isFoodInTolerances": dietAndNutritionProvider.selectedConditionsForFoodIntolerance.isNotEmpty?true:false,
        "foodInTolerances": dietAndNutritionProvider.selectedConditionsForFoodIntolerance,
        "isFoodDislikes": dietAndNutritionProvider.selectedConditionsForFoodIDislike.isNotEmpty?true:false,
        "foodDislikes": dietAndNutritionProvider.selectedConditionsForFoodIDislike,
        "dietPreferenceReligious": dietAndNutritionProvider.selectedValueForReligiousPreference,
        "dietaryGoal": dietAndNutritionProvider.selectedValueForPrimaryDietaryGoal,
        "mealFrequency": dietAndNutritionProvider.selectedValueForMealFrequencyCode,
        "nutrientPreference": dietAndNutritionProvider.selectedValueForNutrientPreference
      },
      "physicalActivity": {
        "activityLevel": fitnessAndPhysicalActivityProvider.selectedValueForCurrentActivity,
        "exerciseFrequency": fitnessAndPhysicalActivityProvider.selectedValueForExercisePerWeek,
        "fitnessGoal": fitnessAndPhysicalActivityProvider.selectedValueFitnessGoals,
        "bodyTypeGoal": fitnessAndPhysicalActivityProvider.selectedValueForBodyType
      },
      "healthGoals": {
        "healthOptimization": selectedValueForSpecificAreasOfHealth,
        "healthMotivation": selectedValuesForImprovingYourHealth
      }
    };
    debugPrint("body for update questionnaire is-->: $body");
    try {
      updateQuestionnaireResponse = await MyApi.callPostApi(
          url: updateQuestionnaireUrl,
          body: body,
          sendToken: true,
          modelName: Models.updateQuestionnaireResponse);
      if (updateQuestionnaireResponse.message!='') {
        Toasts.getSuccessToast(text: updateQuestionnaireResponse.message);
        Loader().hideLoader(context!);

        return true;
      } else {
        print("updateQuestionnaireResponse: ${updateQuestionnaireResponse.message}");
        Loader().hideLoader(context!);

        return false;

      }
    } catch (e) {
      Loader().hideLoader(context!);

      print("Exception occurred in updateQuestionnaireResponse is: $e");
      return false;
    }
  }
}