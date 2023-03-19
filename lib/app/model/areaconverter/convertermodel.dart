import 'unit.dart';

class AreaConverterModel {
  bool? success;
  Data? data;
  String? message;

  AreaConverterModel({this.success, this.data, this.message});

  AreaConverterModel.fromJson(Map<String, dynamic> json) {
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
  List<PropertyUnit>? propertySizeUnits;

  Data({this.propertySizeUnits});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['property_size_units'] != null) {
      propertySizeUnits = <PropertyUnit>[];
      json['property_size_units'].forEach((v) {
        propertySizeUnits!.add(new PropertyUnit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.propertySizeUnits != null) {
      data['property_size_units'] =
          this.propertySizeUnits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
