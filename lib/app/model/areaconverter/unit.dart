class PropertyUnit {
  dynamic unitId;
  String? unitName;
  String? fullName;
  dynamic maxSize;
  double? inSqft;
  String? createdAt;
  String? updatedAt;

  PropertyUnit({
    this.unitId,
    this.unitName,
    this.fullName,
    this.maxSize,
    this.inSqft,
    this.createdAt,
    this.updatedAt,
  });

  PropertyUnit.fromJson(Map<String, dynamic> json) {
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    fullName = json['full_name'];
    maxSize = json['max_size'];
    inSqft = double.parse(json['in_sqft'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit_id'] = this.unitId;
    data['unit_name'] = this.unitName;
    data['full_name'] = this.fullName;
    data['max_size'] = this.maxSize;
    data['in_sqft'] = this.inSqft;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
