import 'project.dart';

class ProjectModel {
  bool? success;
  ProjectData? data;
  String? message;

  ProjectModel({this.success, this.data, this.message});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ProjectData.fromJson(json['data']) : null;
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

class ProjectData {
  List<Project>? projects;
  String? projectsImagesPath;

  ProjectData({this.projects, this.projectsImagesPath});

  ProjectData.fromJson(Map<String, dynamic> json) {
    if (json['projects'] != null) {
      projects = <Project>[];
      json['projects'].forEach((v) {
        projects!.add(new Project.fromJson(v));
      });
    }
    projectsImagesPath = json['projects_images_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    data['projects_images_path'] = this.projectsImagesPath;
    return data;
  }
}
