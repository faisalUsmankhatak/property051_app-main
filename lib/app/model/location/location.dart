// ignore_for_file: prefer_collection_literals
class Location {
  dynamic locationId;
  String? locationName;
  String? image;
  dynamic cityId;
  String? description;
  String? latitude;
  String? longitude;
  String? mapIframe;
  dynamic mapImage;
  dynamic mapImageThumbnail;
  dynamic mapPdf;
  String? createdAt;
  String? updatedAt;

  Location(
      {this.locationId,
      this.locationName,
      this.image,
      this.cityId,
      this.description,
      this.latitude,
      this.longitude,
      this.mapIframe,
      this.mapImage,
      this.mapImageThumbnail,
      this.mapPdf,
      this.createdAt,
      this.updatedAt});

  Location.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    locationName = json['location_name'];
    image = json['image'];
    cityId = json['city_id'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    mapIframe = json['map_iframe'];
    mapImage = json['map_image'];
    mapImageThumbnail = json['map_image_thumbnail'];
    mapPdf = json['map_pdf'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['location_id'] = locationId;
    data['location_name'] = locationName;
    data['image'] = image;
    data['city_id'] = cityId;
    data['description'] = description;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['map_iframe'] = mapIframe;
    data['map_image'] = mapImage;
    data['map_image_thumbnail'] = mapImageThumbnail;
    data['map_pdf'] = mapPdf;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
