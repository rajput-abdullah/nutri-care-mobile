import 'dart:convert';
/// messages : [{"id":"49148c10-0be0-4f60-87d9-3ff7984c0b70","sessionId":"d468198b-6295-429a-bd0d-72c2cb241052","sender":"user","content":"what should i eat?","createdAt":"2025-07-20T12:43:06.093Z"},{"id":"41ec7fea-a095-4b90-8b5c-9e78b940366b","sessionId":"d468198b-6295-429a-bd0d-72c2cb241052","sender":"assistant","content":"A balanced and healthy diet includes a variety of foods, each providing different nutrients that your body needs. Here are some food groups you should include in your diet:\n\n1. Fruits and Vegetables: These are high in vitamins, minerals, and fiber. Try to include a variety of colors to get a wide range of nutrients.\n\n2. Grains: Aim for whole grains like brown rice, oatmeal, and whole wheat bread. These provide you with energy and are high in fiber.\n\n3. Proteins: Choose lean proteins like chicken, turkey, fish, eggs, tofu, and legumes. These are essential for muscle repair and maintenance.\n\n4. Dairy: Opt for low-fat or non-fat dairy products which provide you with necessary calcium and vitamin D.\n\n5. Healthy Fats: Foods like avocados, olives, nuts, and seeds contain monounsaturated and polyunsaturated fats, which are beneficial for your heart health.\n\nRemember to also drink plenty of water throughout the day, limit your intake of processed foods, sugars and saturated fats, and portion your meals to avoid overeating.","createdAt":"2025-07-20T12:43:15.107Z"}]

GetAllMessagesResponse getAllMessagesResponseFromJson(String str) => GetAllMessagesResponse.fromJson(json.decode(str));
String getAllMessagesResponseToJson(GetAllMessagesResponse data) => json.encode(data.toJson());
class GetAllMessagesResponse {
  GetAllMessagesResponse({
      List<Messages>? messages,}){
    _messages = messages;
}

  GetAllMessagesResponse.fromJson(dynamic json) {
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        _messages?.add(Messages.fromJson(v));
      });
    }
  }
  List<Messages>? _messages;
GetAllMessagesResponse copyWith({  List<Messages>? messages,
}) => GetAllMessagesResponse(  messages: messages ?? _messages,
);
  List<Messages>? get messages => _messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "49148c10-0be0-4f60-87d9-3ff7984c0b70"
/// sessionId : "d468198b-6295-429a-bd0d-72c2cb241052"
/// sender : "user"
/// content : "what should i eat?"
/// createdAt : "2025-07-20T12:43:06.093Z"

Messages messagesFromJson(String str) => Messages.fromJson(json.decode(str));
String messagesToJson(Messages data) => json.encode(data.toJson());
class Messages {
  Messages({
      String? id, 
      String? sessionId, 
      String? sender, 
      String? content, 
      String? createdAt,}){
    _id = id;
    _sessionId = sessionId;
    _sender = sender;
    _content = content;
    _createdAt = createdAt;
}

  Messages.fromJson(dynamic json) {
    _id = json['id'];
    _sessionId = json['sessionId'];
    _sender = json['sender'];
    _content = json['content'];
    _createdAt = json['createdAt'];
  }
  String? _id;
  String? _sessionId;
  String? _sender;
  String? _content;
  String? _createdAt;
Messages copyWith({  String? id,
  String? sessionId,
  String? sender,
  String? content,
  String? createdAt,
}) => Messages(  id: id ?? _id,
  sessionId: sessionId ?? _sessionId,
  sender: sender ?? _sender,
  content: content ?? _content,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get sessionId => _sessionId;
  String? get sender => _sender;
  String? get content => _content;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sessionId'] = _sessionId;
    map['sender'] = _sender;
    map['content'] = _content;
    map['createdAt'] = _createdAt;
    return map;
  }

}