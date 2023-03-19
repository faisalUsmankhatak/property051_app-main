// ignore_for_file: prefer_collection_literals

class PropertyUnit {
  int? unitId;
  String? unitName;
  String? fullName;
  int? maxSize;
  int? inSqft;
  String? createdAt;
  String? updatedAt;

  PropertyUnit(
      {this.unitId,
      this.unitName,
      this.fullName,
      this.maxSize,
      this.inSqft,
      this.createdAt,
      this.updatedAt});

  PropertyUnit.fromJson(Map<String, dynamic> json) {
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    fullName = json['full_name'];
    maxSize = json['max_size'];
    inSqft = json['in_sqft'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['unit_id'] = unitId;
    data['unit_name'] = unitName;
    data['full_name'] = fullName;
    data['max_size'] = maxSize;
    data['in_sqft'] = inSqft;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
