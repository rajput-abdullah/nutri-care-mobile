import 'dart:convert';
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImYyZGQ5NWE1LTNhMjMtNGJhNi05NmYwLTYzN2IwMGMxNTA4MSIsImVtYWlsIjoiYWJjZGFAZ21haWwuY29tIiwiaWF0IjoxNzU3NTk1MDA1LCJleHAiOjE3NTgxOTk4MDV9.p9iiEg6I1k5Ssi_juTFSIImcSqFbA0WI6SqTCoaYDts"
/// user : {"id":"f2dd95a5-3a23-4ba6-96f0-637b00c15081","email":"abcda@gmail.com","isVerified":false,"questionnaire":false}

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

/// id : "f2dd95a5-3a23-4ba6-96f0-637b00c15081"
/// email : "abcda@gmail.com"
/// isVerified : false
/// questionnaire : false

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? id, 
      String? email, 
      bool? isVerified, 
      bool? questionnaire,}){
    _id = id;
    _email = email;
    _isVerified = isVerified;
    _questionnaire = questionnaire;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _isVerified = json['isVerified'];
    _questionnaire = json['questionnaire'];
  }
  String? _id;
  String? _email;
  bool? _isVerified;
  bool? _questionnaire;
User copyWith({  String? id,
  String? email,
  bool? isVerified,
  bool? questionnaire,
}) => User(  id: id ?? _id,
  email: email ?? _email,
  isVerified: isVerified ?? _isVerified,
  questionnaire: questionnaire ?? _questionnaire,
);
  String? get id => _id;
  String? get email => _email;
  bool? get isVerified => _isVerified;
  bool? get questionnaire => _questionnaire;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['isVerified'] = _isVerified;
    map['questionnaire'] = _questionnaire;
    return map;
  }

}