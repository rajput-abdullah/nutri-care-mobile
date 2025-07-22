class AgentModelResponse {
  String? status;
  int? statusCode;
  List<Data>? data;

  AgentModelResponse({this.status, this.statusCode, this.data});

  AgentModelResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? agentId;
  String? agentName;
  String? agentRole;
  String? agentSystemPrompt;
  String? agentProfilePictureObjectKey;
  int? agentLlmModelId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.agentId,
        this.agentName,
        this.agentRole,
        this.agentSystemPrompt,
        this.agentProfilePictureObjectKey,
        this.agentLlmModelId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    agentId = json['agentId'];
    agentName = json['agentName'];
    agentRole = json['agentRole'];
    agentSystemPrompt = json['agentSystemPrompt'];
    agentProfilePictureObjectKey = json['agentProfilePictureObjectKey'];
    agentLlmModelId = json['agentLlmModelId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['agentId'] = agentId;
    data['agentName'] = agentName;
    data['agentRole'] = agentRole;
    data['agentSystemPrompt'] = agentSystemPrompt;
    data['agentProfilePictureObjectKey'] = agentProfilePictureObjectKey;
    data['agentLlmModelId'] = agentLlmModelId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
