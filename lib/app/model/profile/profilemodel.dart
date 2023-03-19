import '../user/customer.dart';

class ProfileModel {
  bool? success;
  ProfileModelData? data;
  String? message;

  ProfileModel({this.success, this.data, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? new ProfileModelData.fromJson(json['data'])
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

class ProfileModelData {
  Customer? userDetails;

  ProfileModelData({this.userDetails});

  ProfileModelData.fromJson(Map<String, dynamic> json) {
    userDetails = json['user_details'] != null
        ? new Customer.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}
