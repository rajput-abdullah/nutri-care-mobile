import 'dart:convert';

List<GetNutritionPlanResponse> getNutritionPlanResponseFromJson(String str) =>
    List<GetNutritionPlanResponse>.from(
        json.decode(str).map((x) => GetNutritionPlanResponse.fromJson(x))
    );

String getNutritionPlanResponseToJson(List<GetNutritionPlanResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetNutritionPlanResponse {
  String? day;
  String? breakfast;
  String? lunch;
  String? snack;
  String? dinner;

  GetNutritionPlanResponse({
    this.day,
    this.breakfast,
    this.lunch,
    this.snack,
    this.dinner,
  });

  factory GetNutritionPlanResponse.fromJson(Map<String, dynamic> json) =>
      GetNutritionPlanResponse(
        day: json['day'],
        breakfast: json['breakfast'],
        lunch: json['lunch'],
        snack: json['snack'],
        dinner: json['dinner'],
      );

  Map<String, dynamic> toJson() => {
    'day': day,
    'breakfast': breakfast,
    'lunch': lunch,
    'snack': snack,
    'dinner': dinner,
  };
}
