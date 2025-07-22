// import 'package:flutter/material.dart';
// import 'package:nutri_care_mobile/network/api_url.dart';
// import '../../../../models/nutrition_plan/get_nutrition_plan_response.dart';
// import '../../../../network/api_service.dart';
// import '../../../../network/models.dart';
// import '../../../../res/loader.dart';
//
// class NutritionProvider extends ChangeNotifier {
//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;
//   BuildContext? buildContext;
//   final Loader _loader = Loader();
//
//   GetNutritionPlanResponse getNutritionPlanResponse = GetNutritionPlanResponse();
//
//   initContext(BuildContext context) {
//     buildContext = context;
//   }
//   Future<void> callGetNutritionPlan() async {
//     try {
//       _loader.showLoader(context: buildContext);
//
//
//       getNutritionPlanResponse = await MyApi.callGetApi(
//         url: getNutritionPlanUrl,
//         modelName: Models.getNutritionPlanResponse,
//       );
//
//       print("GetNutritionPlanResponse Data Response: ${getNutritionPlanResponse.toJson()}");
//
//       _loader.hideLoader(buildContext!);
//       notifyListeners();
//     } catch (e) {
//       _loader.hideLoader(buildContext!);
//       _errorMessage = "Error fetching GetNutritionPlanResponse Data: $e";
//       print("Error: $e"); // Log error
//       notifyListeners();
//     }
//   }
// }
//
// nutrition_plan_model.dart

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../../network/api_url.dart';
import '../../../../res/strings.dart';
import '../../../../res/utils.dart';

class NutritionPlan {
  final String day;
  final String breakfast;
  final String lunch;
  final String snack;
  final String dinner;

  NutritionPlan({
    required this.day,
    required this.breakfast,
    required this.lunch,
    required this.snack,
    required this.dinner,
  });

  factory NutritionPlan.fromJson(Map<String, dynamic> json) {
    return NutritionPlan(
      day: json['day'],
      breakfast: json['breakfast'],
      lunch: json['lunch'],
      snack: json['snack'],
      dinner: json['dinner'],
    );
  }
}

class NutritionProvider extends ChangeNotifier {
  List<NutritionPlan> _plans = [];
  bool _isLoading = false;
  String? _error;

  List<NutritionPlan> get plans => _plans;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final String _baseUrl = "$baseUrl/api/gpt/nutrition-plan";

  Future<void> fetchNutritionPlan() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final Dio dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 45), // connection timeout
        receiveTimeout: const Duration(seconds: 45), // data receive timeout
        sendTimeout: const Duration(seconds: 45), // data send timeout
      ),);
      final String? token = PreferenceUtils.getString(Strings.accessToken);
      print("accessToken-->$token");
      final response = await dio.get(
        _baseUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": token,
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        _plans = data.map((e) => NutritionPlan.fromJson(e)).toList();
      } else {
        _error = "Failed to load nutrition plan: ${response.statusCode}";
      }
    } catch (e) {
      _error = "Error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}