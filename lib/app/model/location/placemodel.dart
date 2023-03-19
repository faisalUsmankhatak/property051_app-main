import 'place.dart';

class PlaceModel {
  bool? success;
  Data? data;
  String? message;

  PlaceModel({this.success, this.data, this.message});

  PlaceModel.fromJson(Map<String, dynamic> json) {
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
  List<Place>? places;

  Data({this.places});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['places'] != null) {
      places = <Place>[];
      json['places'].forEach((v) {
        places!.add(new Place.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.places != null) {
      data['places'] = this.places!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
