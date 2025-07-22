import 'dart:convert';
/// session : {"id":"d468198b-6295-429a-bd0d-72c2cb241052","userId":"3b9f7df1-92b2-4406-955c-e3b5150810a4","title":"How can I loss weight?","createdAt":"2025-07-20T12:13:17.792Z"}

CreateChatSessionsResponse createChatSessionsResponseFromJson(String str) => CreateChatSessionsResponse.fromJson(json.decode(str));
String createChatSessionsResponseToJson(CreateChatSessionsResponse data) => json.encode(data.toJson());
class CreateChatSessionsResponse {
  CreateChatSessionsResponse({
      Session? session,}){
    _session = session;
}

  CreateChatSessionsResponse.fromJson(dynamic json) {
    _session = json['session'] != null ? Session.fromJson(json['session']) : null;
  }
  Session? _session;
CreateChatSessionsResponse copyWith({  Session? session,
}) => CreateChatSessionsResponse(  session: session ?? _session,
);
  Session? get session => _session;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_session != null) {
      map['session'] = _session?.toJson();
    }
    return map;
  }

}

/// id : "d468198b-6295-429a-bd0d-72c2cb241052"
/// userId : "3b9f7df1-92b2-4406-955c-e3b5150810a4"
/// title : "How can I loss weight?"
/// createdAt : "2025-07-20T12:13:17.792Z"

Session sessionFromJson(String str) => Session.fromJson(json.decode(str));
String sessionToJson(Session data) => json.encode(data.toJson());
class Session {
  Session({
      String? id, 
      String? userId, 
      String? title, 
      String? createdAt,}){
    _id = id;
    _userId = userId;
    _title = title;
    _createdAt = createdAt;
}

  Session.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _title = json['title'];
    _createdAt = json['createdAt'];
  }
  String? _id;
  String? _userId;
  String? _title;
  String? _createdAt;
Session copyWith({  String? id,
  String? userId,
  String? title,
  String? createdAt,
}) => Session(  id: id ?? _id,
  userId: userId ?? _userId,
  title: title ?? _title,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get title => _title;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['title'] = _title;
    map['createdAt'] = _createdAt;
    return map;
  }

}