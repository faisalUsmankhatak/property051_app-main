class PropertySubtype {
  dynamic subPropertyTypeId;
  dynamic name;
  dynamic propertyTypeId;
  dynamic subtypeSortBy;
  dynamic createdAt;
  dynamic updatedAt;

  PropertySubtype(
      {this.subPropertyTypeId,
      this.name,
      this.propertyTypeId,
      this.subtypeSortBy,
      this.createdAt,
      this.updatedAt});

  PropertySubtype.fromJson(Map<String, dynamic> json) {
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
