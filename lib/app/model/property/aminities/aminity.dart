class PropertyFeature {
  int? id;
  String? propertyId;
  String? featureId;
  String? name;
  String? icon;
  String? category;
  String? createdAt;
  String? updatedAt;

  PropertyFeature(
      {this.id,
      this.propertyId,
      this.featureId,
      this.name,
      this.icon,
      this.category,
      this.createdAt,
      this.updatedAt});

  PropertyFeature.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    featureId = json['feature_id'];
    name = json['name'];
    icon = json['icon'];
    category = json['category'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['feature_id'] = this.featureId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['category'] = this.category;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
