// ignore_for_file: prefer_collection_literals

class Place {
  dynamic id;
  String? name;
  String? description;
  String? image;
  String? latitude;
  String? longitude;
  dynamic locationId;
  dynamic subLocationId;
  dynamic cityId;
  String? type;
  String? createdAt;
  String? updatedAt;

  Place(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.latitude,
      this.longitude,
      this.locationId,
      this.subLocationId,
      this.cityId,
      this.type,
      this.createdAt,
      this.updatedAt});

  Place.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationId = json['location_id'];
    subLocationId = json['sub_location_id'];
    cityId = json['city_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location_id'] = locationId;
    data['sub_location_id'] = subLocationId;
    data['city_id'] = cityId;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
