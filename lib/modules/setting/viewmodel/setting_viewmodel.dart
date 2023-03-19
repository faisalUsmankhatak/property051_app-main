// ignore_for_file: unnecessary_overrides, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/localstorage/SessionManager.dart';
import '../../converter/viewmodel/con_viewmodel.dart';

class SettingViewModel extends GetxController {
  RxBool loading = false.obs;
  SessionManager sessionManager = SessionManager();

  RxString marla = ''.obs;

  @override
  void onInit() {
    super.onInit();
    readValue();
  }

  readValue() async {
    var v = await sessionManager.readValues('marla');
    marla.value = (v != null && v != '') ? v.toString() : '225';
  }

  saveSetting() {
    sessionManager.save('marla', marla.value);
    Get.find<AreaCalculatorViewModel>().setup();
  }

  showSnack({title, message, color}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color ?? Colors.red,
      colorText: Colors.white,
    );
  }
}
