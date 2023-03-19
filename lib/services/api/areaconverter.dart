import 'dart:convert';
import '../../app/model/areaconverter/convertermodel.dart';
import 'network/config.dart';
import 'network/network_utils.dart';

class AreaConverterService {
  static Future<AreaConverterModel> getAllUnits() async {
    var response = await getRequest('${ApiURLS.propertySizeUnits}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return AreaConverterModel.fromJson(properties);
    } else {
      throw Exception('Failed to load units');
    }
  }
}
