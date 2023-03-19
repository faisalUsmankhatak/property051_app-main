import 'propertysubtype.dart';

class ProopertySubTypeModel {
  bool? success;
  Data? data;
  String? message;

  ProopertySubTypeModel({this.success, this.data, this.message});

  ProopertySubTypeModel.fromJson(Map<String, dynamic> json) {
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
  List<PropertySubtype>? propertySubtypes;

  Data({this.propertySubtypes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['property_subtypes'] != null) {
      propertySubtypes = <PropertySubtype>[];
      json['property_subtypes'].forEach((v) {
        propertySubtypes!.add(new PropertySubtype.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.propertySubtypes != null) {
      data['property_subtypes'] =
          this.propertySubtypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
