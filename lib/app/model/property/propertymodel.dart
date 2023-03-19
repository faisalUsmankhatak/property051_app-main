// ignore_for_file: prefer_collection_literals

import 'dart:developer';

import '../location/city.dart';
import '../location/location.dart';
import '../location/sublocation.dart';
import '../user/customer.dart';
import 'favoriteproperty.dart';
import 'image.dart';
import 'property.dart';
import 'propertytype.dart';
import 'purpose.dart';
import 'unit.dart';

class PropertyModel {
  bool? success;
  PropertyModelData? data;
  String? message;

  PropertyModel({this.success, this.data, this.message});

  PropertyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? PropertyModelData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class PropertyModelData {
  Properties? properties;
  String? propertiesImagesPath;
  String? placeImagePath;
  String? locationImagePath;
  String? defaultImagePath;
  String? defaultUserAvatar;

  PropertyModelData({
    this.properties,
    this.propertiesImagesPath,
    this.placeImagePath,
    this.locationImagePath,
    this.defaultImagePath,
    this.defaultUserAvatar,
  });

  PropertyModelData.fromJson(Map<String, dynamic> json) {
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
    propertiesImagesPath = json['properties_images_path'];
    placeImagePath = json['place_image_path'];
    locationImagePath = json['location_image_path'];
    defaultImagePath = json['default_image_path'];
    defaultUserAvatar = json['default_user_avatar'];
  }
}

class Properties {
  dynamic currentPage;
  List<PropertiesData>? data;
  String? firstPageUrl;
  dynamic from;
  dynamic lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  Properties({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Properties.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <PropertiesData>[];
      json['data'].forEach(
        (v) {
          data!.add(PropertiesData.fromJson(v));
        },
      );
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class PropertiesData {
  Property? property;
  List<PropertyImage>? propertyImages;
  Purpose? purpose;
  PropertyUnit? unit;
  City? cities;
  Location? locations;
  SubLocation? subLocation;
  PropertyType? propertyType;
  PropertySubType? propertySubType;
  Customer? customer;
  List<FavProperties>? favproperty;

  PropertiesData({
    this.property,
    this.propertyImages,
    this.purpose,
    this.unit,
    this.cities,
    this.locations,
    this.subLocation,
    this.propertyType,
    this.propertySubType,
    this.customer,
    this.favproperty,
  });

  PropertiesData.fromJson(Map<String, dynamic> json) {
    property = json['property_id'] != null ? Property.fromJson(json) : null;
    if (json['property_images'] != null) {
      propertyImages = <PropertyImage>[];
      json['property_images'].forEach((v) {
        propertyImages!.add(PropertyImage.fromJson(v));
      });
    }
    purpose =
        json['purpose'] != null ? Purpose.fromJson(json['purpose']) : null;
    unit = json['unit'] != null ? PropertyUnit.fromJson(json['unit']) : null;
    cities = json['cities'] != null ? City.fromJson(json['cities']) : null;
    locations =
        json['locations'] != null ? Location.fromJson(json['locations']) : null;
    subLocation = json['sublocations'] != null
        ? SubLocation.fromJson(json['sublocations'])
        : null;
    propertyType = json['propertytype'] != null
        ? PropertyType.fromJson(json['propertytype'])
        : null;
    propertySubType = json['propertysubtype'] != null
        ? PropertySubType.fromJson(json['propertysubtype'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['favproperty'] != null) {
      favproperty = <FavProperties>[];
      json['favproperty'].forEach((v) {
        favproperty!.add(new FavProperties.fromJson(v));
      });
    }
    log('da');
  }

  PropertiesData.fromLocalJson(Map<String, dynamic> json) {
    property =
        json['property'] != null ? Property.fromJson(json['property']) : null;
    if (json['property_images'] != null) {
      propertyImages = <PropertyImage>[];
      json['property_images'].forEach((v) {
        propertyImages!.add(PropertyImage.fromJson(v));
      });
    }
    purpose =
        json['purpose'] != null ? Purpose.fromJson(json['purpose']) : null;
    unit = json['unit'] != null ? PropertyUnit.fromJson(json['unit']) : null;
    cities = json['cities'] != null ? City.fromJson(json['cities']) : null;
    locations =
        json['locations'] != null ? Location.fromJson(json['locations']) : null;
    subLocation = json['subLocation'] != null
        ? SubLocation.fromJson(json['subLocation'])
        : null;
    propertyType = json['propertytype'] != null
        ? PropertyType.fromJson(json['propertytype'])
        : null;
    propertySubType = json['propertysubtype'] != null
        ? PropertySubType.fromJson(json['propertysubtype'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['favproperty'] != null) {
      favproperty = <FavProperties>[];
      json['favproperty'].forEach((v) {
        favproperty!.add(new FavProperties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.property != null) {
      data['property'] = this.property!.toJson();
    }
    if (this.propertyImages != null) {
      data['property_images'] =
          this.propertyImages!.map((v) => v.toJson()).toList();
    }
    if (this.purpose != null) {
      data['purpose'] = this.purpose!.toJson();
    }
    if (this.unit != null) {
      data['unit'] = this.unit!.toJson();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.toJson();
    }
    if (this.locations != null) {
      data['locations'] = this.locations!.toJson();
    }
    if (this.subLocation != null) {
      data['subLocation'] = this.subLocation!.toJson();
    }
    if (this.propertyType != null) {
      data['propertytype'] = this.propertyType!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.propertySubType != null) {
      data['propertysubtype'] = this.propertySubType!.toJson();
    }
    if (this.favproperty != null) {
      data['favproperty'] = this.favproperty!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
