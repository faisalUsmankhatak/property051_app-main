import 'agent.dart';

class AgentModel {
  bool? success;
  Data? data;
  String? message;

  AgentModel({this.success, this.data, this.message});

  AgentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<Agent>? agents;
  String? avatarPath;

  Data({this.agents, this.avatarPath});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['agents'] != null) {
      agents = <Agent>[];
      json['agents'].forEach((v) {
        agents!.add(new Agent.fromJson(v));
      });
    }
    avatarPath = json['avatar_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agents != null) {
      data['agents'] = this.agents!.map((v) => v.toJson()).toList();
    }
    data['avatar_path'] = this.avatarPath;
    return data;
  }
}
