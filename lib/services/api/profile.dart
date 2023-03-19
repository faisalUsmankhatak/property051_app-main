import 'dart:convert';
import '../../app/model/profile/profilemodel.dart';
import 'network/config.dart';
import 'network/network_utils.dart';

class ProfileService {
  static Future<ProfileModel> getUserProfile() async {
    var response = await getRequest('${ApiURLS.userProfile}');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return ProfileModel.fromJson(properties);
    } else {
      throw Exception('Failed to load projects');
    }
  }

  static Future<ProfileModel> saveUserProfile(dynamic body) async {
    var response = await postRequest(
      '${ApiURLS.updateUser}',
      body: body,
    );
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return ProfileModel.fromJson(properties);
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
