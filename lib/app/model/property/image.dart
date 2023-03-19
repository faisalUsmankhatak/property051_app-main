// ignore_for_file: prefer_collection_literals

class PropertyImage {
  dynamic propertyImagesId;
  String? imagePath;
  dynamic propertyId;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  PropertyImage(
      {this.propertyImagesId,
      this.imagePath,
      this.propertyId,
      this.status,
      this.createdAt,
      this.updatedAt});

  PropertyImage.fromJson(Map<String, dynamic> json) {
    propertyImagesId = json['property_images_id'];
    imagePath = json['imagePath'];
    propertyId = json['property_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['property_images_id'] = propertyImagesId;
    data['imagePath'] = imagePath;
    data['property_id'] = propertyId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
