import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:property_051/services/localstorage/SessionManager.dart';

import '../../app/model/property/addpropertymodel.dart';
import 'network/config.dart';
import 'network/network_utils.dart';

class AddPropertyService {
  static Future<AddPropertyModel> addProperty(var params) async {
    var response = await postRequest(
      '${ApiURLS.addProperty}',
      body: params,
    );
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return AddPropertyModel.fromJson(properties);
    } else {
      log(response.statusCode.toString());
      log(response.body.toString());
      throw Exception('Failed to add proerty');
    }
  }

  static Future<AddPropertyModel> addPropertyUsingDio(var params,
      {List<File>? files}) async {
    SessionManager sessionManager = SessionManager();
    String url = "${baseURL}property/add";
    FormData formData = new FormData.fromMap(params);
    for (var file in files!) {
      formData.files.addAll([
        MapEntry("images[]", await MultipartFile.fromFile(file.path)),
      ]);
    }
    final dio = Dio();
    var response = await dio.post(
      url,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer ${sessionManager.getToken()}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return AddPropertyModel.fromJson(response.data);
    } else {
      log(response.statusCode.toString());
      log(response.data.toString());
      throw Exception('Failed to add proerty');
    }
  }
}
