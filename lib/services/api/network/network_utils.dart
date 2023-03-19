// ignore_for_file: missing_return, unused_local_variable, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import '../../localstorage/SessionManager.dart';
import 'config.dart';

Map buildHeader() {
  return {'Content-Type': 'application/json', 'accept': 'application/json'};
}

Future<Response> postRequest(String endPoint, {dynamic body}) async {
  try {
    String url = "$baseURL$endPoint";
    log('Calling API URL: $url  $body');
    Response response = await post(Uri.parse(url),
            headers: <String, String>{
              'Authorization': 'Bearer ${SessionManager().getToken()}',
              'Content-Type': 'application/json; charset=UTF-8',
              "Accept": "application/json",
            },
            body: jsonEncode(body))
        .timeout(const Duration(seconds: timeoutDuration),
            onTimeout: (() => throw "Please try again"));

    log('Response: ${response.statusCode} $url');

    return response;
  } catch (e) {
    log(e.toString());
    throw "Please try again";
  }
}

Future<StreamedResponse?> postMultipartRequest(
    String endPoint, body, List<File> files) async {
  try {
    // if (!await isNetworkAvailable()) throw noInternetMsg;

    String url = "$baseURL$endPoint";

    log('URL: $url');
    log('Request: $body');
    // String accessToken = appStore.accessToken;
    var request = MultipartRequest("POST", Uri.parse(url));

    request.headers.addAll(
      <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        // 'Authorization': 'Bearer $accessToken'
      },
    );

    var length = await files.first.length();

    request.files.add(MultipartFile.fromBytes(
      'images[0]',
      await File.fromUri(Uri.parse(files.first.path)).readAsBytes(),
      contentType: MediaType('image', 'jpg'),
    ));

    StreamedResponse response = await request.send();
    log(response.statusCode.toString());

    return response;
  } catch (e) {
    log(e.toString());
    return null;
  }
}

Future<Response> getRequest(String endPoint) async {
  SessionManager _s = SessionManager();
  try {
    String url = '$baseURL$endPoint';
    log(url);

    Response response = await get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      'Authorization': 'Bearer ${_s.getToken()}'
    }).timeout(const Duration(seconds: timeoutDuration),
        onTimeout: (() => throw "Please try again"));

    log('Code: ${response.statusCode} $url');

    return response;
  } catch (e) {
    log('$baseURL$endPoint');
    log(e.toString());
    throw "Please try again";
  }
}

Future handleResponse(Response response) async {
  switch (response.statusCode) {
    case 200:
      return jsonDecode(response.body);
    case 400:
      throw "Bad Request";
    case 401:
      throw "Unauthorized";
    case 403:
      throw "Forbidden";
    case 404:
      throw "Not Found";
    case 500:
      throw "Internal Server Error";
    default:
      throw "Something went wrong";
  }
}
