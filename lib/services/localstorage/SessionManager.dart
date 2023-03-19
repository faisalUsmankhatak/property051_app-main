// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';

import '../../app/model/property/propertymodel.dart';

class SessionKeys {
  static String theme = 'theme';
  static String fcmToken = 'fcmToken';
  static String loginUser = 'loginUser';
  static String userID = 'userID';
  static String recentProperties = 'recentlyViewedProperties';
  static String propertyUnits = 'propertyUnits';
}

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  SessionManager._internal();

  read(String key) {
    final data = GetStorage().read(key);
    if (data is List<PropertiesData>) {
      return data;
    } else if (data is String) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  save(String key, value) {
    GetStorage().write(key, value);
  }

  readData(String key) {
    final data = GetStorage().read(key);
    return data != null ? json.decode(data) : null;
  }

  readValues(String key) async {
    final data = await GetStorage().read(key);
    return data != null ? json.decode(data) : null;
  }

  saveData(String key, value) {
    GetStorage().write(key, json.encode(value));
  }

  saveProperty(PropertiesData property) {
    GetStorage().write('test', property);
  }

  readProperty(PropertiesData property) {
    GetStorage().read('test');
  }

  saveProperties(List<PropertiesData> properties) {
    log(properties.toString());
    GetStorage().write(
      SessionKeys.recentProperties,
      properties.map((e) => e.toJson()).toList(),
    );
  }

  List<PropertiesData>? getProperties() {
    final data = GetStorage().read(SessionKeys.recentProperties);
    log(data.toString());
    if (data != null) {
      for (var d in data) {
        log(d.toString());
      }
      return data.map((e) => PropertiesData.fromLocalJson(e)).toList();
    }
    return null;
  }

  remove(String key) {
    GetStorage().remove(key);
  }

  containKey(String key) {
    final allKeys = GetStorage().getKeys();
    return allKeys.contains(key);
  }

  //=======================================================================
  //===================== Save Keys with values ===========================
  //=======================================================================

  saveFCMToken({String? token}) {
    saveData(SessionKeys.fcmToken, token);
  }

  // saveLoginUser({LoginModel loginUser}) =>
  //     save(SessionKeys.loginUser, loginUser);

  saveBusinessId({String? userID}) => saveData(SessionKeys.userID, userID);

  //=======================================================================
  //======================== Get Keys with values =========================
  //=======================================================================

  // ignore: todo
  //TODO: get Value from Session
  String? getToken() {
    if (containKey(SessionKeys.fcmToken)) {
      return readData(SessionKeys.fcmToken);
    }
    return null;
  }

  bool get isUserLogin {
    var isContain = containKey(SessionKeys.userID);
    return isContain;
  }

  String get userID {
    return readData(SessionKeys.userID);
  }

  bool get isLightMode {
    return readData(SessionKeys.theme);
  }

  clearSession() {
    remove(SessionKeys.userID);
    remove(SessionKeys.fcmToken);
  }
}
