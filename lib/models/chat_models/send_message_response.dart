import 'dart:convert';
/// reply : "A balanced and healthy diet includes a variety of foods, each providing different nutrients that your body needs. Here are some food groups you should include in your diet:\n\n1. Fruits and Vegetables: These are high in vitamins, minerals, and fiber. Try to include a variety of colors to get a wide range of nutrients.\n\n2. Grains: Aim for whole grains like brown rice, oatmeal, and whole wheat bread. These provide you with energy and are high in fiber.\n\n3. Proteins: Choose lean proteins like chicken, turkey, fish, eggs, tofu, and legumes. These are essential for muscle repair and maintenance.\n\n4. Dairy: Opt for low-fat or non-fat dairy products which provide you with necessary calcium and vitamin D.\n\n5. Healthy Fats: Foods like avocados, olives, nuts, and seeds contain monounsaturated and polyunsaturated fats, which are beneficial for your heart health.\n\nRemember to also drink plenty of water throughout the day, limit your intake of processed foods, sugars and saturated fats, and portion your meals to avoid overeating."

SendMessageResponse sendMessageResponseFromJson(String str) => SendMessageResponse.fromJson(json.decode(str));
String sendMessageResponseToJson(SendMessageResponse data) => json.encode(data.toJson());
class SendMessageResponse {
  SendMessageResponse({
      String? reply,}){
    _reply = reply;
}

  SendMessageResponse.fromJson(dynamic json) {
    _reply = json['reply'];
  }
  String? _reply;
SendMessageResponse copyWith({  String? reply,
}) => SendMessageResponse(  reply: reply ?? _reply,
);
  String? get reply => _reply;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reply'] = _reply;
    return map;
  }

}