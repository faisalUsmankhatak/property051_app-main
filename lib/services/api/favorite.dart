import 'dart:convert';
import 'dart:developer';
import 'package:property_051/app/model/property/favproopertymodel.dart';

import 'network/config.dart';
import 'network/network_utils.dart';

class FavoriteService {
  static Future<FavoritePropertyModel> getProperties() async {
    var response = await getRequest('${ApiURLS.getAllFavProperties}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return FavoritePropertyModel.fromJson(properties);
    } else {
      throw Exception('Failed to load properties');
    }
  }

  static markAsFav({customerId, propertyId}) async {
    var response = await postRequest('${ApiURLS.markAsFavorite}', body: {
      'customer_id': customerId,
      'property_id': propertyId,
    });
    if (response.statusCode == 200) {
      log('Done');
    } else {
      throw Exception('Failed to load properties');
    }
  }
}
