import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:property_051/modules/areacalculator/service.dart';
import 'package:property_051/services/api/areaconverter.dart';
import 'package:property_051/services/localstorage/SessionManager.dart';

import '../../app/model/areaconverter/convertermodel.dart';

class AreaCalculatorViewModel extends GetxController {
  SessionManager sessionManager = SessionManager();
  AreaConverterModel areaConverterModel = AreaConverterModel();
  AreaConverterService1 areaConverterService = AreaConverterService1();
  RxBool showAppBar = false.obs;
  ScrollController? listScrollController = ScrollController();
  RxBool showNotifications = true.obs;
  TextEditingController areaController = TextEditingController();
  RxString selectedUnit = 'Marla'.obs;
  RxString marla = ''.obs;
  RxString kanal = ''.obs;
  RxString acre = ''.obs;
  RxString sqFt = ''.obs;
  RxString sqM = ''.obs;
  RxString sqY = ''.obs;
  RxString marlaValue = ''.obs;

  @override
  void onInit() {
    super.onInit();
    listScrollController!.addListener(() {
      if (listScrollController!.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showAppBar.value = true;
      } else if (listScrollController!.position.userScrollDirection ==
          ScrollDirection.forward) {
        showAppBar.value = false;
      }
    });
    getUnitsFromSServer();
    getUnits();
  }

  void getUnitsFromSServer() async {
    areaConverterModel = await AreaConverterService.getAllUnits();
    log(areaConverterModel.data!.propertySizeUnits!.length.toString());
    saveUnits();
  }

  conversionFunc({double? area = 1.0}) {
    var data = areaConverterService.convertUnit(
        selectedUnit.value, area, int.parse(marla.value));
    sqFt.value = data[0].toStringAsFixed(2);
    sqM.value = data[1].toStringAsFixed(2);
    sqY.value = data[2].toStringAsFixed(2);
    marla.value = data[3].toStringAsFixed(2);
    kanal.value = data[4].toStringAsFixed(2);
    acre.value = data[5].toStringAsFixed(2);
  }

  reset() {
    sqFt.value = '0.00';
    sqM.value = '0.00';
    sqY.value = '0.00';
    marla.value = '0.00';
    kanal.value = '0.00';
    acre.value = '0.00';
  }

  getUnits() async {
    var res = sessionManager.readData(SessionKeys.propertyUnits);
    if (res != null) {
      areaConverterModel = AreaConverterModel.fromJson(res);
      log(areaConverterModel.data!.propertySizeUnits!.length.toString());
    } else {
      log('Error');
    }
  }

  saveUnits() {
    sessionManager.saveData(SessionKeys.propertyUnits, areaConverterModel);
  }
}
