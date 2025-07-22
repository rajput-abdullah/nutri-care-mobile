import 'dart:convert';
/// message : "Email verified successfully"

EmailOtpVerifyResponse emailOtpVerifyResponseFromJson(String str) => EmailOtpVerifyResponse.fromJson(json.decode(str));
String emailOtpVerifyResponseToJson(EmailOtpVerifyResponse data) => json.encode(data.toJson());
class EmailOtpVerifyResponse {
  EmailOtpVerifyResponse({
    String? message,}) {
    _message = message;
  }

  EmailOtpVerifyResponse.fromJson(dynamic json) {
    _message = json['message'];
  }

  String? _message;

  EmailOtpVerifyResponse copyWith({ String? message,
  }) =>
      EmailOtpVerifyResponse(message: message ?? _message,
      );

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }
}
