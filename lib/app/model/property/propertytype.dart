// ignore_for_file: prefer_collection_literals

class PropertyType {
  dynamic propertyTypeId;
  String? typeName;
  dynamic typeSortBy;
  String? createdAt;
  String? updatedAt;

  PropertyType(
      {this.propertyTypeId,
      this.typeName,
      this.typeSortBy,
      this.createdAt,
      this.updatedAt});

  PropertyType.fromJson(Map<String, dynamic> json) {
    propertyTypeId = json['property_type_id'];
    typeName = json['type_name'];
    typeSortBy = json['type_sort_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['property_type_id'] = propertyTypeId;
    data['type_name'] = typeName;
    data['type_sort_by'] = typeSortBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PropertySubType {
  dynamic subPropertyTypeId;
  String? name;
  dynamic propertyTypeId;
  dynamic subtypeSortBy;
  String? createdAt;
  String? updatedAt;

  PropertySubType({
    this.subPropertyTypeId,
    this.name,
    this.propertyTypeId,
    this.subtypeSortBy,
    this.createdAt,
    this.updatedAt,
  });

  PropertySubType.fromJson(Map<String, dynamic> json) {
    subPropertyTypeId = json['subProperty_type_id'];
    name = json['name'];
    propertyTypeId = json['property_type_id'];
    subtypeSortBy = json['subtype_sort_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subProperty_type_id'] = this.subPropertyTypeId;
    data['name'] = this.name;
    data['property_type_id'] = this.propertyTypeId;
    data['subtype_sort_by'] = this.subtypeSortBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
