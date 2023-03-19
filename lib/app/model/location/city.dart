// ignore_for_file: prefer_collection_literals

class City {
  dynamic cityId;
  String? name;
  dynamic countryId;
  String? createdAt;
  String? updatedAt;

  City(
      {this.cityId, this.name, this.countryId, this.createdAt, this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    name = json['name'];
    countryId = json['country_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['city_id'] = cityId;
    data['name'] = name;
    data['country_id'] = countryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
