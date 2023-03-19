// ignore_for_file: prefer_collection_literals

class Purpose {
  int? purposeTypeId;
  String? purposeTypeName;
  String? createdAt;
  String? updatedAt;

  Purpose(
      {this.purposeTypeId,
      this.purposeTypeName,
      this.createdAt,
      this.updatedAt});

  Purpose.fromJson(Map<String, dynamic> json) {
    purposeTypeId = json['purpose_type_id'];
    purposeTypeName = json['purpose_type_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['purpose_type_id'] = purposeTypeId;
    data['purpose_type_name'] = purposeTypeName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
