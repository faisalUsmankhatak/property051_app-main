import 'agency.dart';

class AgencyModel {
  bool? success;
  AgencyModelData? data;
  String? message;

  AgencyModel({this.success, this.data, this.message});

  AgencyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? new AgencyModelData.fromJson(json['data'])
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

class AgencyModelData {
  List<Agency>? agency;
  String? agencyLogoPath;
  String? agencyCeoImagePath;
  String? agencyStaffMembersImagePath;
  String? agencyDefaultImage;

  AgencyModelData(
      {this.agency,
      this.agencyLogoPath,
      this.agencyCeoImagePath,
      this.agencyStaffMembersImagePath});

  AgencyModelData.fromJson(Map<String, dynamic> json) {
    if (json['agency'] != null) {
      agency = <Agency>[];
      json['agency'].forEach((v) {
        agency!.add(new Agency.fromJson(v));
      });
    }
    agencyLogoPath = json['agency_logo_path'];
    agencyCeoImagePath = json['agency_ceo_image_path'];
    agencyStaffMembersImagePath = json['agency_staff_members_image_path'];
    agencyDefaultImage = json['agency_default_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agency != null) {
      data['agency'] = this.agency!.map((v) => v.toJson()).toList();
    }
    data['agency_logo_path'] = this.agencyLogoPath;
    data['agency_ceo_image_path'] = this.agencyCeoImagePath;
    data['agency_staff_members_image_path'] = this.agencyStaffMembersImagePath;
    data['agency_default_image'] = this.agencyDefaultImage;
    return data;
  }
}
