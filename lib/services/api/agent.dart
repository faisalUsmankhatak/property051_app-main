import 'dart:convert';
import '../../app/model/agent/agentmodel.dart';
import 'network/config.dart';
import 'network/network_utils.dart';

class AgentService {
  static Future<AgentModel> getAgents() async {
    var response = await getRequest('${ApiURLS.getAllAgents}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return AgentModel.fromJson(properties);
    } else {
      throw Exception('Failed to load agencies');
    }
  }
}
