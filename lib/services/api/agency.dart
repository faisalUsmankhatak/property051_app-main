import 'dart:convert';
import '../../app/model/agency/agencymodel.dart';
import 'network/config.dart';
import 'network/network_utils.dart';

class AgencyService {
  static Future<AgencyModel> getAgencies() async {
    var response = await getRequest('${ApiURLS.getAllAgencies}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return AgencyModel.fromJson(properties);
    } else {
      throw Exception('Failed to load agencies');
    }
  }
}
