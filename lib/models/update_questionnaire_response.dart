import 'dart:convert';
/// message : "Questionnaire saved successfully"
/// questionnaire : {"id":"05cb13b5-891c-4866-b47c-9d37e3fb4932","userId":"2651a318-1ee1-470e-9aec-d4779fdfdb04","medicalBackground":{"allergies":["Peanuts","Shellfish"],"pastConditions":["Asthma"],"medicationsList":[{"name":"Metformin","dosage":500,"frequency":2}],"supplementsList":[{"name":"Vitamin D","dosage":1000,"frequency":1}],"specificConcerns":"Frequent fatigue and low immunity","medicalConditions":["Type 2 Diabetes"],"takingMedications":true,"takingSupplements":true,"isAnyHealthConcern":true,"isAnyPastCondition":true},"lifestyleHabits":{"waterIntake":"one_to_two_liter","energyLevels":"moderate","substanceConsumption":["caffeine","alcohol"]},"dietPreferences":{"diets":["vegetarian","gluten_free"],"dietaryGoal":"general_wellness","foodDislikes":["Brussels sprouts","Mushrooms"],"mealFrequency":"three_meals","isFoodDislikes":true,"foodInTolerances":["Lactose","Soy"],"isFoodInTolerances":true,"nutrientPreference":"immune_boosting","dietPreferenceReligious":"halal"},"physicalActivity":{"fitnessGoal":"overall_fitness","bodyTypeGoal":"balanced_and_proportional","activityLevel":"moderately_active","exerciseFrequency":"three_to_four_times"},"healthGoals":{"healthMotivation":"long_term_wellness","healthOptimization":"immune_support"},"createdAt":"2025-07-30T18:57:01.013Z","updatedAt":"2025-07-30T18:57:01.013Z"}

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

/// id : "05cb13b5-891c-4866-b47c-9d37e3fb4932"
/// userId : "2651a318-1ee1-470e-9aec-d4779fdfdb04"
/// medicalBackground : {"allergies":["Peanuts","Shellfish"],"pastConditions":["Asthma"],"medicationsList":[{"name":"Metformin","dosage":500,"frequency":2}],"supplementsList":[{"name":"Vitamin D","dosage":1000,"frequency":1}],"specificConcerns":"Frequent fatigue and low immunity","medicalConditions":["Type 2 Diabetes"],"takingMedications":true,"takingSupplements":true,"isAnyHealthConcern":true,"isAnyPastCondition":true}
/// lifestyleHabits : {"waterIntake":"one_to_two_liter","energyLevels":"moderate","substanceConsumption":["caffeine","alcohol"]}
/// dietPreferences : {"diets":["vegetarian","gluten_free"],"dietaryGoal":"general_wellness","foodDislikes":["Brussels sprouts","Mushrooms"],"mealFrequency":"three_meals","isFoodDislikes":true,"foodInTolerances":["Lactose","Soy"],"isFoodInTolerances":true,"nutrientPreference":"immune_boosting","dietPreferenceReligious":"halal"}
/// physicalActivity : {"fitnessGoal":"overall_fitness","bodyTypeGoal":"balanced_and_proportional","activityLevel":"moderately_active","exerciseFrequency":"three_to_four_times"}
/// healthGoals : {"healthMotivation":"long_term_wellness","healthOptimization":"immune_support"}
/// createdAt : "2025-07-30T18:57:01.013Z"
/// updatedAt : "2025-07-30T18:57:01.013Z"

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

/// healthMotivation : "long_term_wellness"
/// healthOptimization : "immune_support"

HealthGoals healthGoalsFromJson(String str) => HealthGoals.fromJson(json.decode(str));
String healthGoalsToJson(HealthGoals data) => json.encode(data.toJson());
class HealthGoals {
  HealthGoals({
      String? healthMotivation, 
      String? healthOptimization,}){
    _healthMotivation = healthMotivation;
    _healthOptimization = healthOptimization;
}

  HealthGoals.fromJson(dynamic json) {
    _healthMotivation = json['healthMotivation'];
    _healthOptimization = json['healthOptimization'];
  }
  String? _healthMotivation;
  String? _healthOptimization;
HealthGoals copyWith({  String? healthMotivation,
  String? healthOptimization,
}) => HealthGoals(  healthMotivation: healthMotivation ?? _healthMotivation,
  healthOptimization: healthOptimization ?? _healthOptimization,
);
  String? get healthMotivation => _healthMotivation;
  String? get healthOptimization => _healthOptimization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['healthMotivation'] = _healthMotivation;
    map['healthOptimization'] = _healthOptimization;
    return map;
  }

}

/// fitnessGoal : "overall_fitness"
/// bodyTypeGoal : "balanced_and_proportional"
/// activityLevel : "moderately_active"
/// exerciseFrequency : "three_to_four_times"

PhysicalActivity physicalActivityFromJson(String str) => PhysicalActivity.fromJson(json.decode(str));
String physicalActivityToJson(PhysicalActivity data) => json.encode(data.toJson());
class PhysicalActivity {
  PhysicalActivity({
      String? fitnessGoal, 
      String? bodyTypeGoal, 
      String? activityLevel, 
      String? exerciseFrequency,}){
    _fitnessGoal = fitnessGoal;
    _bodyTypeGoal = bodyTypeGoal;
    _activityLevel = activityLevel;
    _exerciseFrequency = exerciseFrequency;
}

  PhysicalActivity.fromJson(dynamic json) {
    _fitnessGoal = json['fitnessGoal'];
    _bodyTypeGoal = json['bodyTypeGoal'];
    _activityLevel = json['activityLevel'];
    _exerciseFrequency = json['exerciseFrequency'];
  }
  String? _fitnessGoal;
  String? _bodyTypeGoal;
  String? _activityLevel;
  String? _exerciseFrequency;
PhysicalActivity copyWith({  String? fitnessGoal,
  String? bodyTypeGoal,
  String? activityLevel,
  String? exerciseFrequency,
}) => PhysicalActivity(  fitnessGoal: fitnessGoal ?? _fitnessGoal,
  bodyTypeGoal: bodyTypeGoal ?? _bodyTypeGoal,
  activityLevel: activityLevel ?? _activityLevel,
  exerciseFrequency: exerciseFrequency ?? _exerciseFrequency,
);
  String? get fitnessGoal => _fitnessGoal;
  String? get bodyTypeGoal => _bodyTypeGoal;
  String? get activityLevel => _activityLevel;
  String? get exerciseFrequency => _exerciseFrequency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fitnessGoal'] = _fitnessGoal;
    map['bodyTypeGoal'] = _bodyTypeGoal;
    map['activityLevel'] = _activityLevel;
    map['exerciseFrequency'] = _exerciseFrequency;
    return map;
  }

}

/// diets : ["vegetarian","gluten_free"]
/// dietaryGoal : "general_wellness"
/// foodDislikes : ["Brussels sprouts","Mushrooms"]
/// mealFrequency : "three_meals"
/// isFoodDislikes : true
/// foodInTolerances : ["Lactose","Soy"]
/// isFoodInTolerances : true
/// nutrientPreference : "immune_boosting"
/// dietPreferenceReligious : "halal"

DietPreferences dietPreferencesFromJson(String str) => DietPreferences.fromJson(json.decode(str));
String dietPreferencesToJson(DietPreferences data) => json.encode(data.toJson());
class DietPreferences {
  DietPreferences({
      List<String>? diets, 
      String? dietaryGoal, 
      List<String>? foodDislikes, 
      String? mealFrequency, 
      bool? isFoodDislikes, 
      List<String>? foodInTolerances, 
      bool? isFoodInTolerances, 
      String? nutrientPreference, 
      String? dietPreferenceReligious,}){
    _diets = diets;
    _dietaryGoal = dietaryGoal;
    _foodDislikes = foodDislikes;
    _mealFrequency = mealFrequency;
    _isFoodDislikes = isFoodDislikes;
    _foodInTolerances = foodInTolerances;
    _isFoodInTolerances = isFoodInTolerances;
    _nutrientPreference = nutrientPreference;
    _dietPreferenceReligious = dietPreferenceReligious;
}

  DietPreferences.fromJson(dynamic json) {
    _diets = json['diets'] != null ? json['diets'].cast<String>() : [];
    _dietaryGoal = json['dietaryGoal'];
    _foodDislikes = json['foodDislikes'] != null ? json['foodDislikes'].cast<String>() : [];
    _mealFrequency = json['mealFrequency'];
    _isFoodDislikes = json['isFoodDislikes'];
    _foodInTolerances = json['foodInTolerances'] != null ? json['foodInTolerances'].cast<String>() : [];
    _isFoodInTolerances = json['isFoodInTolerances'];
    _nutrientPreference = json['nutrientPreference'];
    _dietPreferenceReligious = json['dietPreferenceReligious'];
  }
  List<String>? _diets;
  String? _dietaryGoal;
  List<String>? _foodDislikes;
  String? _mealFrequency;
  bool? _isFoodDislikes;
  List<String>? _foodInTolerances;
  bool? _isFoodInTolerances;
  String? _nutrientPreference;
  String? _dietPreferenceReligious;
DietPreferences copyWith({  List<String>? diets,
  String? dietaryGoal,
  List<String>? foodDislikes,
  String? mealFrequency,
  bool? isFoodDislikes,
  List<String>? foodInTolerances,
  bool? isFoodInTolerances,
  String? nutrientPreference,
  String? dietPreferenceReligious,
}) => DietPreferences(  diets: diets ?? _diets,
  dietaryGoal: dietaryGoal ?? _dietaryGoal,
  foodDislikes: foodDislikes ?? _foodDislikes,
  mealFrequency: mealFrequency ?? _mealFrequency,
  isFoodDislikes: isFoodDislikes ?? _isFoodDislikes,
  foodInTolerances: foodInTolerances ?? _foodInTolerances,
  isFoodInTolerances: isFoodInTolerances ?? _isFoodInTolerances,
  nutrientPreference: nutrientPreference ?? _nutrientPreference,
  dietPreferenceReligious: dietPreferenceReligious ?? _dietPreferenceReligious,
);
  List<String>? get diets => _diets;
  String? get dietaryGoal => _dietaryGoal;
  List<String>? get foodDislikes => _foodDislikes;
  String? get mealFrequency => _mealFrequency;
  bool? get isFoodDislikes => _isFoodDislikes;
  List<String>? get foodInTolerances => _foodInTolerances;
  bool? get isFoodInTolerances => _isFoodInTolerances;
  String? get nutrientPreference => _nutrientPreference;
  String? get dietPreferenceReligious => _dietPreferenceReligious;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['diets'] = _diets;
    map['dietaryGoal'] = _dietaryGoal;
    map['foodDislikes'] = _foodDislikes;
    map['mealFrequency'] = _mealFrequency;
    map['isFoodDislikes'] = _isFoodDislikes;
    map['foodInTolerances'] = _foodInTolerances;
    map['isFoodInTolerances'] = _isFoodInTolerances;
    map['nutrientPreference'] = _nutrientPreference;
    map['dietPreferenceReligious'] = _dietPreferenceReligious;
    return map;
  }

}

/// waterIntake : "one_to_two_liter"
/// energyLevels : "moderate"
/// substanceConsumption : ["caffeine","alcohol"]

LifestyleHabits lifestyleHabitsFromJson(String str) => LifestyleHabits.fromJson(json.decode(str));
String lifestyleHabitsToJson(LifestyleHabits data) => json.encode(data.toJson());
class LifestyleHabits {
  LifestyleHabits({
      String? waterIntake, 
      String? energyLevels, 
      List<String>? substanceConsumption,}){
    _waterIntake = waterIntake;
    _energyLevels = energyLevels;
    _substanceConsumption = substanceConsumption;
}

  LifestyleHabits.fromJson(dynamic json) {
    _waterIntake = json['waterIntake'];
    _energyLevels = json['energyLevels'];
    _substanceConsumption = json['substanceConsumption'] != null ? json['substanceConsumption'].cast<String>() : [];
  }
  String? _waterIntake;
  String? _energyLevels;
  List<String>? _substanceConsumption;
LifestyleHabits copyWith({  String? waterIntake,
  String? energyLevels,
  List<String>? substanceConsumption,
}) => LifestyleHabits(  waterIntake: waterIntake ?? _waterIntake,
  energyLevels: energyLevels ?? _energyLevels,
  substanceConsumption: substanceConsumption ?? _substanceConsumption,
);
  String? get waterIntake => _waterIntake;
  String? get energyLevels => _energyLevels;
  List<String>? get substanceConsumption => _substanceConsumption;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['waterIntake'] = _waterIntake;
    map['energyLevels'] = _energyLevels;
    map['substanceConsumption'] = _substanceConsumption;
    return map;
  }

}

/// allergies : ["Peanuts","Shellfish"]
/// pastConditions : ["Asthma"]
/// medicationsList : [{"name":"Metformin","dosage":500,"frequency":2}]
/// supplementsList : [{"name":"Vitamin D","dosage":1000,"frequency":1}]
/// specificConcerns : "Frequent fatigue and low immunity"
/// medicalConditions : ["Type 2 Diabetes"]
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

/// name : "Metformin"
/// dosage : 500
/// frequency : 2

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