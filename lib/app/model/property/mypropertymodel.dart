import 'propertymodel.dart';

class MyPropertyModel {
  bool? success;
  MyPropertyModelData? data;
  String? message;

  MyPropertyModel({this.success, this.data, this.message});

  MyPropertyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? new MyPropertyModelData.fromJson(json['data'])
        : null;
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

class MyPropertyModelData {
  List<PropertiesData>? myproperties;
  String? propertiesImagesPath;
  String? locationsImagesPath;
  String? defaultImage;

  MyPropertyModelData(
      {this.myproperties,
      this.propertiesImagesPath,
      this.locationsImagesPath,
      this.defaultImage});

  MyPropertyModelData.fromJson(Map<String, dynamic> json) {
    if (json['properties'] != null) {
      myproperties = <PropertiesData>[];
      json['properties'].forEach((v) {
        myproperties!.add(new PropertiesData.fromJson(v));
      });
    }
    propertiesImagesPath = json['properties_images_path'];
    locationsImagesPath = json['locations_images_path'];
    defaultImage = json['default_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myproperties != null) {
      data['properties'] = this.myproperties!.map((v) => v.toJson()).toList();
    }
    data['properties_images_path'] = this.propertiesImagesPath;
    data['locations_images_path'] = this.locationsImagesPath;
    data['default_image'] = this.defaultImage;
    return data;
  }
}
