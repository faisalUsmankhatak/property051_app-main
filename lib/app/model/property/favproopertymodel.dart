import 'favoriteproperty.dart';

class FavoritePropertyModel {
  bool? success;
  Data? data;
  String? message;

  FavoritePropertyModel({this.success, this.data, this.message});

  FavoritePropertyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<FavProperties>? favProperties;
  String? propertiesImagesPath;
  String? placeImagePath;
  String? locationImagePath;
  String? defaultImagePath;

  Data({
    this.favProperties,
    this.propertiesImagesPath,
    this.placeImagePath,
    this.locationImagePath,
    this.defaultImagePath,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['fav_properties'] != null) {
      favProperties = <FavProperties>[];
      json['fav_properties'].forEach((v) {
        favProperties!.add(new FavProperties.fromJson(v));
      });
    }
    propertiesImagesPath = json['properties_images_path'];
    placeImagePath = json['place_image_path'];
    locationImagePath = json['location_image_path'];
    defaultImagePath = json['default_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favProperties != null) {
      data['fav_properties'] =
          this.favProperties!.map((v) => v.toJson()).toList();
    }
    data['properties_images_path'] = this.propertiesImagesPath;
    data['place_image_path'] = this.placeImagePath;
    data['location_image_path'] = this.locationImagePath;
    data['default_image_path'] = this.defaultImagePath;
    return data;
  }
}
