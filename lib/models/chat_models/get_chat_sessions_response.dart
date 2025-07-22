import 'dart:convert';
/// sessions : [{"id":"d468198b-6295-429a-bd0d-72c2cb241052","userId":"3b9f7df1-92b2-4406-955c-e3b5150810a4","title":"How can I loss weight?","createdAt":"2025-07-20T12:13:17.792Z"}]

GetChatSessionsResponse getChatSessionsResponseFromJson(String str) => GetChatSessionsResponse.fromJson(json.decode(str));
String getChatSessionsResponseToJson(GetChatSessionsResponse data) => json.encode(data.toJson());
class GetChatSessionsResponse {
  GetChatSessionsResponse({
      List<Sessions>? sessions,}){
    _sessions = sessions;
}

  GetChatSessionsResponse.fromJson(dynamic json) {
    if (json['sessions'] != null) {
      _sessions = [];
      json['sessions'].forEach((v) {
        _sessions?.add(Sessions.fromJson(v));
      });
    }
  }
  List<Sessions>? _sessions;
GetChatSessionsResponse copyWith({  List<Sessions>? sessions,
}) => GetChatSessionsResponse(  sessions: sessions ?? _sessions,
);
  List<Sessions>? get sessions => _sessions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_sessions != null) {
      map['sessions'] = _sessions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "d468198b-6295-429a-bd0d-72c2cb241052"
/// userId : "3b9f7df1-92b2-4406-955c-e3b5150810a4"
/// title : "How can I loss weight?"
/// createdAt : "2025-07-20T12:13:17.792Z"

Sessions sessionsFromJson(String str) => Sessions.fromJson(json.decode(str));
String sessionsToJson(Sessions data) => json.encode(data.toJson());
class Sessions {
  Sessions({
      String? id, 
      String? userId, 
      String? title, 
      String? createdAt,}){
    _id = id;
    _userId = userId;
    _title = title;
    _createdAt = createdAt;
}

  Sessions.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _title = json['title'];
    _createdAt = json['createdAt'];
  }
  String? _id;
  String? _userId;
  String? _title;
  String? _createdAt;
Sessions copyWith({  String? id,
  String? userId,
  String? title,
  String? createdAt,
}) => Sessions(  id: id ?? _id,
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