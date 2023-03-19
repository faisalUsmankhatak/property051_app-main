import 'dart:convert';
import '../../app/model/property/aminities/aminitymodel.dart';
import '../../app/model/property/mypropertymodel.dart';
import '../../app/model/property/propertymodel.dart';
import '../../app/model/property/propertysubtypemodel.dart';
import 'network/config.dart';
import 'network/network_utils.dart';

class PropertyService {
  static Future<PropertyModel> getProperties(
    int pageKey, {
    String? purposeId,
    String? cityId,
    String? locationId,
    String? propertyTypeId,
    String? propertySubTypeId,
    String? noBeds,
    String? noBaths,
  }) async {
    var response = await getRequest(
      '${ApiURLS.getAllProperties}?page=$pageKey&purpose_id=$purposeId&city_id=$cityId&location_id=$locationId&property_type_id=$propertyTypeId&property_sub_type_id=$propertySubTypeId&no_beds=$noBeds&no_baths=$noBaths',
    );
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return PropertyModel.fromJson(properties);
    } else {
      throw Exception('Failed to load properties');
    }
  }

  static Future<MyPropertyModel> getMyProperties() async {
    var response = await getRequest('${ApiURLS.getAllUserProperties}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return MyPropertyModel.fromJson(properties);
    } else {
      throw Exception('Failed to load properties');
    }
  }

  static Future<ProopertySubTypeModel> getPropertySubTypes() async {
    var response = await getRequest('${ApiURLS.propertySubTypes}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return ProopertySubTypeModel.fromJson(properties);
    } else {
      throw Exception('Failed to load types');
    }
  }

  static Future<AminitiesModel> getPropertyAminities(
      {String? propertyId}) async {
    var response =
        await getRequest('${ApiURLS.getPropertyFeatures}/$propertyId');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return AminitiesModel.fromJson(properties);
    } else {
      throw Exception('Failed to load features');
    }
  }
}
