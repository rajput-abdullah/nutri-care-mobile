import 'dart:convert';
/// message : "Questionnaire saved successfully"
/// questionnaire : {"id":"0ebdc14e-315e-4e47-886d-17da16b00ad4","userId":"3b9f7df1-92b2-4406-955c-e3b5150810a4","medicalBackground":{"allergies":["Peanuts","Shellfish"],"pastConditions":["Asthma"],"medicationsList":[{"name":"Aspirin","dosage":75,"frequency":1},{"name":"Metformin","dosage":500,"frequency":2}],"supplementsList":[{"name":"Vitamin D","dosage":1000,"frequency":1},{"name":"Omega-3","dosage":1000,"frequency":2}],"specificConcerns":"Recurring headaches and fatigue","medicalConditions":["Hypertension"],"takingMedications":true,"takingSupplements":true,"isAnyHealthConcern":true,"isAnyPastCondition":true},"lifestyleHabits":{"waterIntake":"12L","energyLevels":"MOD","substanceConsumptionCode":["CAF","ALC"]},"dietPreferences":{"diets":["VEG","GLF"],"foodDislikes":["Mushrooms","Broccoli"],"isFoodDislikes":true,"dietaryGoalCode":"WL","foodInTolerances":["Lactose","Gluten"],"mealFrequencyCode":"THREE","isFoodInTolerances":true,"nutrientPreferenceCode":"HP","dietPreferenceReligiousCode":"HAL"},"physicalActivity":{"fitnessGoalCode":"MG","bodyTypeGoalCode":"MUS","activityLevelCode":"MOD","exerciseFrequencyCode":"3-4"},"healthGoals":{"healthMotivationCode":"LTW","healthOptimizationCode":"EL"},"createdAt":"2025-07-21T21:03:02.336Z","updatedAt":"2025-07-21T21:03:02.336Z"}

UpdateQuestionnaireResponse updateQuestionnaireResponseFromJson(String str) => UpdateQuestionnaireResponse.fromJson(json.decode(str));
String updateQuestionnaireResponseToJson(UpdateQuestionnaireResponse data) => json.encode(data.toJson());
class UpdateQuestionnaireResponse {
  UpdateQuestionnaireResponse({
      String? message, 
      Questionnaire? questionnaire,}){
    _message = message;
    _questionnaire = questionnaire;
}

  UpdateQuestionnaireResponse.fromJson(dynamic json) {
    _message = json['message'];
    _questionnaire = json['questionnaire'] != null ? Questionnaire.fromJson(json['questionnaire']) : null;
  }
  String? _message;
  Questionnaire? _questionnaire;
UpdateQuestionnaireResponse copyWith({  String? message,
  Questionnaire? questionnaire,
}) => UpdateQuestionnaireResponse(  message: message ?? _message,
  questionnaire: questionnaire ?? _questionnaire,
);
  String? get message => _message;
  Questionnaire? get questionnaire => _questionnaire;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_questionnaire != null) {
      map['questionnaire'] = _questionnaire?.toJson();
    }
    return map;
  }

}

/// id : "0ebdc14e-315e-4e47-886d-17da16b00ad4"
/// userId : "3b9f7df1-92b2-4406-955c-e3b5150810a4"
/// medicalBackground : {"allergies":["Peanuts","Shellfish"],"pastConditions":["Asthma"],"medicationsList":[{"name":"Aspirin","dosage":75,"frequency":1},{"name":"Metformin","dosage":500,"frequency":2}],"supplementsList":[{"name":"Vitamin D","dosage":1000,"frequency":1},{"name":"Omega-3","dosage":1000,"frequency":2}],"specificConcerns":"Recurring headaches and fatigue","medicalConditions":["Hypertension"],"takingMedications":true,"takingSupplements":true,"isAnyHealthConcern":true,"isAnyPastCondition":true}
/// lifestyleHabits : {"waterIntake":"12L","energyLevels":"MOD","substanceConsumptionCode":["CAF","ALC"]}
/// dietPreferences : {"diets":["VEG","GLF"],"foodDislikes":["Mushrooms","Broccoli"],"isFoodDislikes":true,"dietaryGoalCode":"WL","foodInTolerances":["Lactose","Gluten"],"mealFrequencyCode":"THREE","isFoodInTolerances":true,"nutrientPreferenceCode":"HP","dietPreferenceReligiousCode":"HAL"}
/// physicalActivity : {"fitnessGoalCode":"MG","bodyTypeGoalCode":"MUS","activityLevelCode":"MOD","exerciseFrequencyCode":"3-4"}
/// healthGoals : {"healthMotivationCode":"LTW","healthOptimizationCode":"EL"}
/// createdAt : "2025-07-21T21:03:02.336Z"
/// updatedAt : "2025-07-21T21:03:02.336Z"

Questionnaire questionnaireFromJson(String str) => Questionnaire.fromJson(json.decode(str));
String questionnaireToJson(Questionnaire data) => json.encode(data.toJson());
class Questionnaire {
  Questionnaire({
      String? id, 
      String? userId, 
      MedicalBackground? medicalBackground, 
      LifestyleHabits? lifestyleHabits, 
      DietPreferences? dietPreferences, 
      PhysicalActivity? physicalActivity, 
      HealthGoals? healthGoals, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _medicalBackground = medicalBackground;
    _lifestyleHabits = lifestyleHabits;
    _dietPreferences = dietPreferences;
    _physicalActivity = physicalActivity;
    _healthGoals = healthGoals;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Questionnaire.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _medicalBackground = json['medicalBackground'] != null ? MedicalBackground.fromJson(json['medicalBackground']) : null;
    _lifestyleHabits = json['lifestyleHabits'] != null ? LifestyleHabits.fromJson(json['lifestyleHabits']) : null;
    _dietPreferences = json['dietPreferences'] != null ? DietPreferences.fromJson(json['dietPreferences']) : null;
    _physicalActivity = json['physicalActivity'] != null ? PhysicalActivity.fromJson(json['physicalActivity']) : null;
    _healthGoals = json['healthGoals'] != null ? HealthGoals.fromJson(json['healthGoals']) : null;
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _userId;
  MedicalBackground? _medicalBackground;
  LifestyleHabits? _lifestyleHabits;
  DietPreferences? _dietPreferences;
  PhysicalActivity? _physicalActivity;
  HealthGoals? _healthGoals;
  String? _createdAt;
  String? _updatedAt;
Questionnaire copyWith({  String? id,
  String? userId,
  MedicalBackground? medicalBackground,
  LifestyleHabits? lifestyleHabits,
  DietPreferences? dietPreferences,
  PhysicalActivity? physicalActivity,
  HealthGoals? healthGoals,
  String? createdAt,
  String? updatedAt,
}) => Questionnaire(  id: id ?? _id,
  userId: userId ?? _userId,
  medicalBackground: medicalBackground ?? _medicalBackground,
  lifestyleHabits: lifestyleHabits ?? _lifestyleHabits,
  dietPreferences: dietPreferences ?? _dietPreferences,
  physicalActivity: physicalActivity ?? _physicalActivity,
  healthGoals: healthGoals ?? _healthGoals,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get userId => _userId;
  MedicalBackground? get medicalBackground => _medicalBackground;
  LifestyleHabits? get lifestyleHabits => _lifestyleHabits;
  DietPreferences? get dietPreferences => _dietPreferences;
  PhysicalActivity? get physicalActivity => _physicalActivity;
  HealthGoals? get healthGoals => _healthGoals;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    if (_medicalBackground != null) {
      map['medicalBackground'] = _medicalBackground?.toJson();
    }
    if (_lifestyleHabits != null) {
      map['lifestyleHabits'] = _lifestyleHabits?.toJson();
    }
    if (_dietPreferences != null) {
      map['dietPreferences'] = _dietPreferences?.toJson();
    }
    if (_physicalActivity != null) {
      map['physicalActivity'] = _physicalActivity?.toJson();
    }
    if (_healthGoals != null) {
      map['healthGoals'] = _healthGoals?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}

/// healthMotivationCode : "LTW"
/// healthOptimizationCode : "EL"

HealthGoals healthGoalsFromJson(String str) => HealthGoals.fromJson(json.decode(str));
String healthGoalsToJson(HealthGoals data) => json.encode(data.toJson());
class HealthGoals {
  HealthGoals({
      String? healthMotivationCode, 
      String? healthOptimizationCode,}){
    _healthMotivationCode = healthMotivationCode;
    _healthOptimizationCode = healthOptimizationCode;
}

  HealthGoals.fromJson(dynamic json) {
    _healthMotivationCode = json['healthMotivationCode'];
    _healthOptimizationCode = json['healthOptimizationCode'];
  }
  String? _healthMotivationCode;
  String? _healthOptimizationCode;
HealthGoals copyWith({  String? healthMotivationCode,
  String? healthOptimizationCode,
}) => HealthGoals(  healthMotivationCode: healthMotivationCode ?? _healthMotivationCode,
  healthOptimizationCode: healthOptimizationCode ?? _healthOptimizationCode,
);
  String? get healthMotivationCode => _healthMotivationCode;
  String? get healthOptimizationCode => _healthOptimizationCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['healthMotivationCode'] = _healthMotivationCode;
    map['healthOptimizationCode'] = _healthOptimizationCode;
    return map;
  }

}

/// fitnessGoalCode : "MG"
/// bodyTypeGoalCode : "MUS"
/// activityLevelCode : "MOD"
/// exerciseFrequencyCode : "3-4"

PhysicalActivity physicalActivityFromJson(String str) => PhysicalActivity.fromJson(json.decode(str));
String physicalActivityToJson(PhysicalActivity data) => json.encode(data.toJson());
class PhysicalActivity {
  PhysicalActivity({
      String? fitnessGoalCode, 
      String? bodyTypeGoalCode, 
      String? activityLevelCode, 
      String? exerciseFrequencyCode,}){
    _fitnessGoalCode = fitnessGoalCode;
    _bodyTypeGoalCode = bodyTypeGoalCode;
    _activityLevelCode = activityLevelCode;
    _exerciseFrequencyCode = exerciseFrequencyCode;
}

  PhysicalActivity.fromJson(dynamic json) {
    _fitnessGoalCode = json['fitnessGoalCode'];
    _bodyTypeGoalCode = json['bodyTypeGoalCode'];
    _activityLevelCode = json['activityLevelCode'];
    _exerciseFrequencyCode = json['exerciseFrequencyCode'];
  }
  String? _fitnessGoalCode;
  String? _bodyTypeGoalCode;
  String? _activityLevelCode;
  String? _exerciseFrequencyCode;
PhysicalActivity copyWith({  String? fitnessGoalCode,
  String? bodyTypeGoalCode,
  String? activityLevelCode,
  String? exerciseFrequencyCode,
}) => PhysicalActivity(  fitnessGoalCode: fitnessGoalCode ?? _fitnessGoalCode,
  bodyTypeGoalCode: bodyTypeGoalCode ?? _bodyTypeGoalCode,
  activityLevelCode: activityLevelCode ?? _activityLevelCode,
  exerciseFrequencyCode: exerciseFrequencyCode ?? _exerciseFrequencyCode,
);
  String? get fitnessGoalCode => _fitnessGoalCode;
  String? get bodyTypeGoalCode => _bodyTypeGoalCode;
  String? get activityLevelCode => _activityLevelCode;
  String? get exerciseFrequencyCode => _exerciseFrequencyCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fitnessGoalCode'] = _fitnessGoalCode;
    map['bodyTypeGoalCode'] = _bodyTypeGoalCode;
    map['activityLevelCode'] = _activityLevelCode;
    map['exerciseFrequencyCode'] = _exerciseFrequencyCode;
    return map;
  }

}

/// diets : ["VEG","GLF"]
/// foodDislikes : ["Mushrooms","Broccoli"]
/// isFoodDislikes : true
/// dietaryGoalCode : "WL"
/// foodInTolerances : ["Lactose","Gluten"]
/// mealFrequencyCode : "THREE"
/// isFoodInTolerances : true
/// nutrientPreferenceCode : "HP"
/// dietPreferenceReligiousCode : "HAL"

DietPreferences dietPreferencesFromJson(String str) => DietPreferences.fromJson(json.decode(str));
String dietPreferencesToJson(DietPreferences data) => json.encode(data.toJson());
class DietPreferences {
  DietPreferences({
      List<String>? diets, 
      List<String>? foodDislikes, 
      bool? isFoodDislikes, 
      String? dietaryGoalCode, 
      List<String>? foodInTolerances, 
      String? mealFrequencyCode, 
      bool? isFoodInTolerances, 
      String? nutrientPreferenceCode, 
      String? dietPreferenceReligiousCode,}){
    _diets = diets;
    _foodDislikes = foodDislikes;
    _isFoodDislikes = isFoodDislikes;
    _dietaryGoalCode = dietaryGoalCode;
    _foodInTolerances = foodInTolerances;
    _mealFrequencyCode = mealFrequencyCode;
    _isFoodInTolerances = isFoodInTolerances;
    _nutrientPreferenceCode = nutrientPreferenceCode;
    _dietPreferenceReligiousCode = dietPreferenceReligiousCode;
}

  DietPreferences.fromJson(dynamic json) {
    _diets = json['diets'] != null ? json['diets'].cast<String>() : [];
    _foodDislikes = json['foodDislikes'] != null ? json['foodDislikes'].cast<String>() : [];
    _isFoodDislikes = json['isFoodDislikes'];
    _dietaryGoalCode = json['dietaryGoalCode'];
    _foodInTolerances = json['foodInTolerances'] != null ? json['foodInTolerances'].cast<String>() : [];
    _mealFrequencyCode = json['mealFrequencyCode'];
    _isFoodInTolerances = json['isFoodInTolerances'];
    _nutrientPreferenceCode = json['nutrientPreferenceCode'];
    _dietPreferenceReligiousCode = json['dietPreferenceReligiousCode'];
  }
  List<String>? _diets;
  List<String>? _foodDislikes;
  bool? _isFoodDislikes;
  String? _dietaryGoalCode;
  List<String>? _foodInTolerances;
  String? _mealFrequencyCode;
  bool? _isFoodInTolerances;
  String? _nutrientPreferenceCode;
  String? _dietPreferenceReligiousCode;
DietPreferences copyWith({  List<String>? diets,
  List<String>? foodDislikes,
  bool? isFoodDislikes,
  String? dietaryGoalCode,
  List<String>? foodInTolerances,
  String? mealFrequencyCode,
  bool? isFoodInTolerances,
  String? nutrientPreferenceCode,
  String? dietPreferenceReligiousCode,
}) => DietPreferences(  diets: diets ?? _diets,
  foodDislikes: foodDislikes ?? _foodDislikes,
  isFoodDislikes: isFoodDislikes ?? _isFoodDislikes,
  dietaryGoalCode: dietaryGoalCode ?? _dietaryGoalCode,
  foodInTolerances: foodInTolerances ?? _foodInTolerances,
  mealFrequencyCode: mealFrequencyCode ?? _mealFrequencyCode,
  isFoodInTolerances: isFoodInTolerances ?? _isFoodInTolerances,
  nutrientPreferenceCode: nutrientPreferenceCode ?? _nutrientPreferenceCode,
  dietPreferenceReligiousCode: dietPreferenceReligiousCode ?? _dietPreferenceReligiousCode,
);
  List<String>? get diets => _diets;
  List<String>? get foodDislikes => _foodDislikes;
  bool? get isFoodDislikes => _isFoodDislikes;
  String? get dietaryGoalCode => _dietaryGoalCode;
  List<String>? get foodInTolerances => _foodInTolerances;
  String? get mealFrequencyCode => _mealFrequencyCode;
  bool? get isFoodInTolerances => _isFoodInTolerances;
  String? get nutrientPreferenceCode => _nutrientPreferenceCode;
  String? get dietPreferenceReligiousCode => _dietPreferenceReligiousCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['diets'] = _diets;
    map['foodDislikes'] = _foodDislikes;
    map['isFoodDislikes'] = _isFoodDislikes;
    map['dietaryGoalCode'] = _dietaryGoalCode;
    map['foodInTolerances'] = _foodInTolerances;
    map['mealFrequencyCode'] = _mealFrequencyCode;
    map['isFoodInTolerances'] = _isFoodInTolerances;
    map['nutrientPreferenceCode'] = _nutrientPreferenceCode;
    map['dietPreferenceReligiousCode'] = _dietPreferenceReligiousCode;
    return map;
  }

}

/// waterIntake : "12L"
/// energyLevels : "MOD"
/// substanceConsumptionCode : ["CAF","ALC"]

LifestyleHabits lifestyleHabitsFromJson(String str) => LifestyleHabits.fromJson(json.decode(str));
String lifestyleHabitsToJson(LifestyleHabits data) => json.encode(data.toJson());
class LifestyleHabits {
  LifestyleHabits({
      String? waterIntake, 
      String? energyLevels, 
      List<String>? substanceConsumptionCode,}){
    _waterIntake = waterIntake;
    _energyLevels = energyLevels;
    _substanceConsumptionCode = substanceConsumptionCode;
}

  LifestyleHabits.fromJson(dynamic json) {
    _waterIntake = json['waterIntake'];
    _energyLevels = json['energyLevels'];
    _substanceConsumptionCode = json['substanceConsumptionCode'] != null ? json['substanceConsumptionCode'].cast<String>() : [];
  }
  String? _waterIntake;
  String? _energyLevels;
  List<String>? _substanceConsumptionCode;
LifestyleHabits copyWith({  String? waterIntake,
  String? energyLevels,
  List<String>? substanceConsumptionCode,
}) => LifestyleHabits(  waterIntake: waterIntake ?? _waterIntake,
  energyLevels: energyLevels ?? _energyLevels,
  substanceConsumptionCode: substanceConsumptionCode ?? _substanceConsumptionCode,
);
  String? get waterIntake => _waterIntake;
  String? get energyLevels => _energyLevels;
  List<String>? get substanceConsumptionCode => _substanceConsumptionCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['waterIntake'] = _waterIntake;
    map['energyLevels'] = _energyLevels;
    map['substanceConsumptionCode'] = _substanceConsumptionCode;
    return map;
  }

}

/// allergies : ["Peanuts","Shellfish"]
/// pastConditions : ["Asthma"]
/// medicationsList : [{"name":"Aspirin","dosage":75,"frequency":1},{"name":"Metformin","dosage":500,"frequency":2}]
/// supplementsList : [{"name":"Vitamin D","dosage":1000,"frequency":1},{"name":"Omega-3","dosage":1000,"frequency":2}]
/// specificConcerns : "Recurring headaches and fatigue"
/// medicalConditions : ["Hypertension"]
/// takingMedications : true
/// takingSupplements : true
/// isAnyHealthConcern : true
/// isAnyPastCondition : true

MedicalBackground medicalBackgroundFromJson(String str) => MedicalBackground.fromJson(json.decode(str));
String medicalBackgroundToJson(MedicalBackground data) => json.encode(data.toJson());
class MedicalBackground {
  MedicalBackground({
      List<String>? allergies, 
      List<String>? pastConditions, 
      List<MedicationsList>? medicationsList, 
      List<SupplementsList>? supplementsList, 
      String? specificConcerns, 
      List<String>? medicalConditions, 
      bool? takingMedications, 
      bool? takingSupplements, 
      bool? isAnyHealthConcern, 
      bool? isAnyPastCondition,}){
    _allergies = allergies;
    _pastConditions = pastConditions;
    _medicationsList = medicationsList;
    _supplementsList = supplementsList;
    _specificConcerns = specificConcerns;
    _medicalConditions = medicalConditions;
    _takingMedications = takingMedications;
    _takingSupplements = takingSupplements;
    _isAnyHealthConcern = isAnyHealthConcern;
    _isAnyPastCondition = isAnyPastCondition;
}

  MedicalBackground.fromJson(dynamic json) {
    _allergies = json['allergies'] != null ? json['allergies'].cast<String>() : [];
    _pastConditions = json['pastConditions'] != null ? json['pastConditions'].cast<String>() : [];
    if (json['medicationsList'] != null) {
      _medicationsList = [];
      json['medicationsList'].forEach((v) {
        _medicationsList?.add(MedicationsList.fromJson(v));
      });
    }
    if (json['supplementsList'] != null) {
      _supplementsList = [];
      json['supplementsList'].forEach((v) {
        _supplementsList?.add(SupplementsList.fromJson(v));
      });
    }
    _specificConcerns = json['specificConcerns'];
    _medicalConditions = json['medicalConditions'] != null ? json['medicalConditions'].cast<String>() : [];
    _takingMedications = json['takingMedications'];
    _takingSupplements = json['takingSupplements'];
    _isAnyHealthConcern = json['isAnyHealthConcern'];
    _isAnyPastCondition = json['isAnyPastCondition'];
  }
  List<String>? _allergies;
  List<String>? _pastConditions;
  List<MedicationsList>? _medicationsList;
  List<SupplementsList>? _supplementsList;
  String? _specificConcerns;
  List<String>? _medicalConditions;
  bool? _takingMedications;
  bool? _takingSupplements;
  bool? _isAnyHealthConcern;
  bool? _isAnyPastCondition;
MedicalBackground copyWith({  List<String>? allergies,
  List<String>? pastConditions,
  List<MedicationsList>? medicationsList,
  List<SupplementsList>? supplementsList,
  String? specificConcerns,
  List<String>? medicalConditions,
  bool? takingMedications,
  bool? takingSupplements,
  bool? isAnyHealthConcern,
  bool? isAnyPastCondition,
}) => MedicalBackground(  allergies: allergies ?? _allergies,
  pastConditions: pastConditions ?? _pastConditions,
  medicationsList: medicationsList ?? _medicationsList,
  supplementsList: supplementsList ?? _supplementsList,
  specificConcerns: specificConcerns ?? _specificConcerns,
  medicalConditions: medicalConditions ?? _medicalConditions,
  takingMedications: takingMedications ?? _takingMedications,
  takingSupplements: takingSupplements ?? _takingSupplements,
  isAnyHealthConcern: isAnyHealthConcern ?? _isAnyHealthConcern,
  isAnyPastCondition: isAnyPastCondition ?? _isAnyPastCondition,
);
  List<String>? get allergies => _allergies;
  List<String>? get pastConditions => _pastConditions;
  List<MedicationsList>? get medicationsList => _medicationsList;
  List<SupplementsList>? get supplementsList => _supplementsList;
  String? get specificConcerns => _specificConcerns;
  List<String>? get medicalConditions => _medicalConditions;
  bool? get takingMedications => _takingMedications;
  bool? get takingSupplements => _takingSupplements;
  bool? get isAnyHealthConcern => _isAnyHealthConcern;
  bool? get isAnyPastCondition => _isAnyPastCondition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allergies'] = _allergies;
    map['pastConditions'] = _pastConditions;
    if (_medicationsList != null) {
      map['medicationsList'] = _medicationsList?.map((v) => v.toJson()).toList();
    }
    if (_supplementsList != null) {
      map['supplementsList'] = _supplementsList?.map((v) => v.toJson()).toList();
    }
    map['specificConcerns'] = _specificConcerns;
    map['medicalConditions'] = _medicalConditions;
    map['takingMedications'] = _takingMedications;
    map['takingSupplements'] = _takingSupplements;
    map['isAnyHealthConcern'] = _isAnyHealthConcern;
    map['isAnyPastCondition'] = _isAnyPastCondition;
    return map;
  }

}

/// name : "Vitamin D"
/// dosage : 1000
/// frequency : 1

SupplementsList supplementsListFromJson(String str) => SupplementsList.fromJson(json.decode(str));
String supplementsListToJson(SupplementsList data) => json.encode(data.toJson());
class SupplementsList {
  SupplementsList({
      String? name, 
      int? dosage, 
      int? frequency,}){
    _name = name;
    _dosage = dosage;
    _frequency = frequency;
}

  SupplementsList.fromJson(dynamic json) {
    _name = json['name'];
    _dosage = json['dosage'];
    _frequency = json['frequency'];
  }
  String? _name;
  int? _dosage;
  int? _frequency;
SupplementsList copyWith({  String? name,
  int? dosage,
  int? frequency,
}) => SupplementsList(  name: name ?? _name,
  dosage: dosage ?? _dosage,
  frequency: frequency ?? _frequency,
);
  String? get name => _name;
  int? get dosage => _dosage;
  int? get frequency => _frequency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['dosage'] = _dosage;
    map['frequency'] = _frequency;
    return map;
  }

}

/// name : "Aspirin"
/// dosage : 75
/// frequency : 1

MedicationsList medicationsListFromJson(String str) => MedicationsList.fromJson(json.decode(str));
String medicationsListToJson(MedicationsList data) => json.encode(data.toJson());
class MedicationsList {
  MedicationsList({
      String? name, 
      int? dosage, 
      int? frequency,}){
    _name = name;
    _dosage = dosage;
    _frequency = frequency;
}

  MedicationsList.fromJson(dynamic json) {
    _name = json['name'];
    _dosage = json['dosage'];
    _frequency = json['frequency'];
  }
  String? _name;
  int? _dosage;
  int? _frequency;
MedicationsList copyWith({  String? name,
  int? dosage,
  int? frequency,
}) => MedicationsList(  name: name ?? _name,
  dosage: dosage ?? _dosage,
  frequency: frequency ?? _frequency,
);
  String? get name => _name;
  int? get dosage => _dosage;
  int? get frequency => _frequency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['dosage'] = _dosage;
    map['frequency'] = _frequency;
    return map;
  }

}