import 'propertymodel.dart';

class FavProperties {
  dynamic id;
  dynamic propertyId;
  dynamic customerId;
  String? createdAt;
  String? updatedAt;
  PropertiesData? property;

  FavProperties(
      {this.id,
      this.propertyId,
      this.customerId,
      this.createdAt,
      this.updatedAt,
      this.property});

  FavProperties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    property = json['property'] != null
        ? new PropertiesData.fromJson(json['property'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['customer_id'] = this.customerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.property != null) {
      data['property'] = this.property!.toJson();
    }
    return data;
  }
}
