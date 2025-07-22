import 'dart:convert';
/// error : "Email already exists"

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));
String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());
class ErrorResponse {
  ErrorResponse({
      String? error,}){
    _error = error;
}

  ErrorResponse.fromJson(dynamic json) {
    _error = json['error'];
  }
  String? _error;
ErrorResponse copyWith({  String? error,
}) => ErrorResponse(  error: error ?? _error,
);
  String? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    return map;
  }

}