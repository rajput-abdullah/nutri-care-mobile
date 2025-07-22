import 'dart:convert';

/// message : "Profile saved"
/// profile : {...}

UpdateUserProfileResponse updateUserProfileResponseFromJson(String str) =>
    UpdateUserProfileResponse.fromJson(json.decode(str));

String updateUserProfileResponseToJson(UpdateUserProfileResponse data) =>
    json.encode(data.toJson());

class UpdateUserProfileResponse {
  UpdateUserProfileResponse({
    String? message,
    Profile? profile,
  }) {
    _message = message;
    _profile = profile;
  }

  UpdateUserProfileResponse.fromJson(dynamic json) {
    _message = json['message'];
    _profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  String? _message;
  Profile? _profile;

  UpdateUserProfileResponse copyWith({
    String? message,
    Profile? profile,
  }) =>
      UpdateUserProfileResponse(
        message: message ?? _message,
        profile: profile ?? _profile,
      );

  String? get message => _message;
  Profile? get profile => _profile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    return map;
  }
}

/// id : ...
Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    String? id,
    String? userId,
    dynamic image,
    int? age,
    String? gender,
    double? height,
    double? weight,
    double? targetWeight,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _image = image;
    _age = age;
    _gender = gender;
    _height = height;
    _weight = weight;
    _targetWeight = targetWeight;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Profile.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _image = json['image'];

    /// ✅ Safe numeric casting
    var ageValue = json['age'];
    if (ageValue is int) {
      _age = ageValue;
    } else if (ageValue is double) {
      _age = ageValue.toInt();
    } else {
      _age = null;
    }

    _gender = json['gender'];
    _height = (json['height'] as num?)?.toDouble();
    _weight = (json['weight'] as num?)?.toDouble();
    _targetWeight = (json['targetWeight'] as num?)?.toDouble();
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _userId;
  dynamic _image;
  int? _age;
  String? _gender;
  double? _height;
  double? _weight;
  double? _targetWeight;
  String? _createdAt;
  String? _updatedAt;

  Profile copyWith({
    String? id,
    String? userId,
    dynamic image,
    int? age,
    String? gender,
    double? height,
    double? weight,
    double? targetWeight,
    String? createdAt,
    String? updatedAt,
  }) =>
      Profile(
        id: id ?? _id,
        userId: userId ?? _userId,
        image: image ?? _image,
        age: age ?? _age,
        gender: gender ?? _gender,
        height: height ?? _height,
        weight: weight ?? _weight,
        targetWeight: targetWeight ?? _targetWeight,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;
  String? get userId => _userId;
  dynamic get image => _image;
  int? get age => _age;
  String? get gender => _gender;
  double? get height => _height;
  double? get weight => _weight;
  double? get targetWeight => _targetWeight;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['image'] = _image;
    map['age'] = _age;
    map['gender'] = _gender;
    map['height'] = _height;
    map['weight'] = _weight;
    map['targetWeight'] = _targetWeight;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
