import 'location.dart';

class LocationModel {
  bool? success;
  Data? data;
  String? message;

  LocationModel({this.success, this.data, this.message});

  LocationModel.fromJson(Map<String, dynamic> json) {
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
  List<Location>? locations;

  Data({this.locations});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['locations'] != null) {
      locations = <Location>[];
      json['locations'].forEach((v) {
        locations!.add(new Location.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
