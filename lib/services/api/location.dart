import 'dart:convert';
import 'network/config.dart';
import 'network/network_utils.dart';
import '../../app/model/location/citymodel.dart';
import '../../app/model/location/locationmodel.dart';
import '../../app/model/location/placemodel.dart';
import '../../app/model/location/sublocationmodel.dart';

class LocationService {
  static Future<CityModel> getAllCities() async {
    var response = await getRequest('${ApiURLS.cities}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return CityModel.fromJson(properties);
    } else {
      throw Exception('Failed to load cities');
    }
  }

  static Future<LocationModel> getAllLocations() async {
    var response = await getRequest('${ApiURLS.locations}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return LocationModel.fromJson(properties);
    } else {
      throw Exception('Failed to load locations');
    }
  }

  static Future<SubLocationModel> getAllSubLocations() async {
    var response = await getRequest('${ApiURLS.subLocations}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return SubLocationModel.fromJson(properties);
    } else {
      throw Exception('Failed to load locations');
    }
  }

  static Future<PlaceModel> getAllPlaces() async {
    var response = await getRequest('${ApiURLS.places}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return PlaceModel.fromJson(properties);
    } else {
      throw Exception('Failed to load locations');
    }
  }
}
