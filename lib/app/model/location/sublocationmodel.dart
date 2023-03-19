import 'sublocation.dart';

class SubLocationModel {
  bool? success;
  Data? data;
  String? message;

  SubLocationModel({this.success, this.data, this.message});

  SubLocationModel.fromJson(Map<String, dynamic> json) {
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
  List<SubLocation>? subLocations;

  Data({this.subLocations});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sub_locations'] != null) {
      subLocations = <SubLocation>[];
      json['sub_locations'].forEach((v) {
        subLocations!.add(new SubLocation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subLocations != null) {
      data['sub_locations'] =
          this.subLocations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
