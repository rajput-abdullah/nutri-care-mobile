import 'dart:convert';
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjNiOWY3ZGYxLTkyYjItNDQwNi05NTVjLWUzYjUxNTA4MTBhNCIsImVtYWlsIjoiYXNhZEBnbWFpbC5jb20iLCJpYXQiOjE3NTI5Mjg5NTgsImV4cCI6MTc1MzUzMzc1OH0.IOi6EfbTJv_zvW_05_E1D_x80UHIlQJwdDQBGHtsAvQ"
/// user : {"id":"3b9f7df1-92b2-4406-955c-e3b5150810a4","name":"user123","email":"asad@gmail.com","isVerified":true,"questionnaire":false}

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());
class LoginResponse {
  LoginResponse({
      String? token, 
      User? user,}){
    _token = token;
    _user = user;
}

  LoginResponse.fromJson(dynamic json) {
    _token = json['token'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _token;
  User? _user;
LoginResponse copyWith({  String? token,
  User? user,
}) => LoginResponse(  token: token ?? _token,
  user: user ?? _user,
);
  String? get token => _token;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// id : "3b9f7df1-92b2-4406-955c-e3b5150810a4"
/// name : "user123"
/// email : "asad@gmail.com"
/// isVerified : true
/// questionnaire : false

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? id, 
      String? name, 
      String? email, 
      bool? isVerified, 
      bool? questionnaire,}){
    _id = id;
    _name = name;
    _email = email;
    _isVerified = isVerified;
    _questionnaire = questionnaire;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _isVerified = json['isVerified'];
    _questionnaire = json['questionnaire'];
  }
  String? _id;
  String? _name;
  String? _email;
  bool? _isVerified;
  bool? _questionnaire;
User copyWith({  String? id,
  String? name,
  String? email,
  bool? isVerified,
  bool? questionnaire,
}) => User(  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  isVerified: isVerified ?? _isVerified,
  questionnaire: questionnaire ?? _questionnaire,
);
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  bool? get isVerified => _isVerified;
  bool? get questionnaire => _questionnaire;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['isVerified'] = _isVerified;
    map['questionnaire'] = _questionnaire;
    return map;
  }

}