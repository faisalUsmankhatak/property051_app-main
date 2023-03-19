// ignore_for_file: prefer_collection_literals

class SubLocation {
  dynamic id;
  String? name;
  dynamic locationId;
  dynamic cityId;
  dynamic description;
  dynamic latitude;
  dynamic longitude;
  // dynamic mapIframe;
  // String? mapImage;
  // String? mapImageThumbnail;
  // dynamic isDeleted;
  // String? createdAt;
  // String? updatedAt;

  SubLocation({
    this.id,
    this.name,
    this.locationId,
    this.cityId,
    this.description,
    this.latitude,
    this.longitude,
    // this.mapIframe,
    // this.mapImage,
    // this.mapImageThumbnail,
    // this.isDeleted,
    // this.createdAt,
    // this.updatedAt,
  });

  SubLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationId = json['location_id'];
    cityId = json['city_id'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    // mapIframe = json['map_iframe'];
    // mapImage = json['map_image'];
    // mapImageThumbnail = json['map_image_thumbnail'];
    // isDeleted = json['is_deleted'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['location_id'] = locationId;
    data['city_id'] = cityId;
    data['description'] = description;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    // data['map_iframe'] = mapIframe;
    // data['map_image'] = mapImage;
    // data['map_image_thumbnail'] = mapImageThumbnail;
    // data['is_deleted'] = isDeleted;
    // data['created_at'] = createdAt;
    // data['updated_at'] = updatedAt;
    return data;
  }
}
