import 'dart:convert';
/// message : "Signup successful. OTP sent to email."
/// userId : "ad0ca969-32f0-4428-87a3-4bbbc7e81f0c"

SignupResponse signupResponseFromJson(String str) => SignupResponse.fromJson(json.decode(str));
String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());
class SignupResponse {
  SignupResponse({
      String? message, 
      String? userId,}){
    _message = message;
    _userId = userId;
}

  SignupResponse.fromJson(dynamic json) {
    _message = json['message'];
    _userId = json['userId'];
  }
  String? _message;
  String? _userId;
SignupResponse copyWith({  String? message,
  String? userId,
}) => SignupResponse(  message: message ?? _message,
  userId: userId ?? _userId,
);
  String? get message => _message;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['userId'] = _userId;
    return map;
  }

}