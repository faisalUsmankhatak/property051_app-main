import 'dart:convert';
import 'dart:developer';
import 'package:property_051/app/model/auth/authmodel.dart';
import 'network/config.dart';
import 'network/network_utils.dart';

class AuthService {
  static Future<AuthModel?> login({
    bool? isEmail,
    String? email,
    String? phone,
    String? password,
  }) async {
    var params = {};
    if (isEmail!) {
      params = {
        'email': email,
        'password': password,
      };
    } else {
      params = {
        'contact_no': phone,
        'password': password,
      };
    }
    log(params.toString());
    var response = await postRequest('${ApiURLS.login}', body: params);
    if (response.statusCode == 200) {
      return AuthModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<AuthModel?> signUp1({
    String? fName,
    String? lName,
    String? email,
    String? phone,
    String? password,
    String? cPassword,
  }) async {
    var params = {
      'first_name': fName,
      'last_name': lName,
      'email': email,
      'contact_no': phone,
      'password': password,
      'c_password': cPassword,
    };
    var response = await postRequest('${ApiURLS.signup}', body: params);
    if (response.statusCode == 200) {
      return AuthModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<AuthModel?> signUp({
    bool? isEmail,
    String? email,
    String? phone,
  }) async {
    var params = {};
    if (isEmail!) {
      params = {
        'email': email,
      };
    } else {
      params = {
        'contact_no': phone,
      };
    }
    var response = await postRequest('${ApiURLS.signup}', body: params);
    if (response.statusCode == 200) {
      return AuthModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to signup');
    }
  }

  static Future<AuthModel?> socialLogin(
      {String? provider, String? token}) async {
    var response = await getRequest(
        '${ApiURLS.socialLogin}?provider=$provider&token=$token');
    if (response.statusCode == 200) {
      return AuthModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}
