import 'aminity.dart';

class AminitiesModel {
  bool? success;
  Data? data;
  String? message;

  AminitiesModel({this.success, this.data, this.message});

  AminitiesModel.fromJson(Map<String, dynamic> json) {
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
  List<PropertyFeature>? propertyFeaturesA;
  List<PropertyFeature>? propertyFeaturesB;
  List<PropertyFeature>? propertyFeaturesC;

  Data(
      {this.propertyFeaturesA, this.propertyFeaturesB, this.propertyFeaturesC});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['property_features_a'] != null) {
      propertyFeaturesA = <PropertyFeature>[];
      json['property_features_a'].forEach((v) {
        propertyFeaturesA!.add(new PropertyFeature.fromJson(v));
      });
    }
    if (json['property_features_b'] != null) {
      propertyFeaturesB = <PropertyFeature>[];
      json['property_features_b'].forEach((v) {
        propertyFeaturesB!.add(new PropertyFeature.fromJson(v));
      });
    }
    if (json['property_features_c'] != null) {
      propertyFeaturesC = <PropertyFeature>[];
      json['property_features_c'].forEach((v) {
        propertyFeaturesC!.add(new PropertyFeature.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.propertyFeaturesA != null) {
      data['property_features_a'] =
          this.propertyFeaturesA!.map((v) => v.toJson()).toList();
    }
    if (this.propertyFeaturesB != null) {
      data['property_features_b'] =
          this.propertyFeaturesB!.map((v) => v.toJson()).toList();
    }
    if (this.propertyFeaturesC != null) {
      data['property_features_c'] =
          this.propertyFeaturesC!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
