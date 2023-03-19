// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/localstorage/SessionManager.dart';
import '../repo/repo.dart';
import '../repo/repoimp.dart';

class AreaCalculatorViewModel extends GetxController {
  SessionManager sessionManager = SessionManager();
  final alarmAudioPath = "sound/ssound.mp3";

  AreaConverter areaConverter = AreaConverterImpl();
  RxInt selectedUnit = 0.obs;
  RxBool loading = false.obs;
  TextEditingController sqFtController = TextEditingController();
  TextEditingController sqMController = TextEditingController();
  TextEditingController sqYController = TextEditingController();
  TextEditingController marrlaController = TextEditingController();
  TextEditingController kanalController = TextEditingController();
  TextEditingController acreController = TextEditingController();

  RxString marla = ''.obs;
  RxString kanal = ''.obs;
  RxString acre = ''.obs;
  RxString sqFt = ''.obs;
  RxString sqM = ''.obs;
  RxString sqY = ''.obs;
  RxString marlaValue = ''.obs;

  setup() async {
    var v = await sessionManager.readValues('marla');
    marlaValue.value = (v != null && v != '') ? v.toString() : '225';
  }

  conversionFunc({double? area = 1.0}) {
    var data = areaConverter.convertUnit(
        selectedUnit.value, area, int.parse(marlaValue.value));
    sqFt.value = data[0].toStringAsFixed(2);
    sqM.value = data[1].toStringAsFixed(2);
    sqY.value = data[2].toStringAsFixed(2);
    marla.value = data[3].toStringAsFixed(2);
    kanal.value = data[4].toStringAsFixed(2);
    acre.value = data[5].toStringAsFixed(2);
    setFields();
  }

  setFields() {
    if (selectedUnit.value == 5) {
      sqFtController.text = sqFt.value;
      sqMController.text = sqM.value;
      sqYController.text = sqY.value;
      marrlaController.text = marla.value;
      acreController.text = acre.value;
    } else if (selectedUnit.value == 6) {
      sqFtController.text = sqFt.value;
      sqMController.text = sqM.value;
      sqYController.text = sqY.value;
      marrlaController.text = marla.value;
      kanalController.text = kanal.value;
    } else if (selectedUnit.value == 4) {
      sqFtController.text = sqFt.value;
      sqMController.text = sqM.value;
      sqYController.text = sqY.value;
      kanalController.text = kanal.value;
      acreController.text = acre.value;
    } else if (selectedUnit.value == 3) {
      sqFtController.text = sqFt.value;
      sqMController.text = sqM.value;
      marrlaController.text = marla.value;
      kanalController.text = kanal.value;
      acreController.text = acre.value;
    } else if (selectedUnit.value == 1) {
      sqMController.text = sqM.value;
      sqYController.text = sqY.value;
      marrlaController.text = marla.value;
      kanalController.text = kanal.value;
      acreController.text = acre.value;
    } else if (selectedUnit.value == 2) {
      sqFtController.text = sqFt.value;
      sqYController.text = sqY.value;
      marrlaController.text = marla.value;
      kanalController.text = kanal.value;
      acreController.text = acre.value;
    }
  }

  reset() {
    sqFtController.text = '';
    sqMController.text = '';
    sqYController.text = '';
    marrlaController.text = '';
    kanalController.text = '';
    acreController.text = '';
  }
}
