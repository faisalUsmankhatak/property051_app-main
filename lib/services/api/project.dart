import 'dart:convert';
import '../../app/model/project/projectmodel.dart';
import 'network/config.dart';
import 'network/network_utils.dart';

class ProjectService {
  static Future<ProjectModel> getProjects() async {
    var response = await getRequest('${ApiURLS.getAllProjects}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return ProjectModel.fromJson(properties);
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
