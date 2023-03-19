import 'dart:developer';
import 'package:get/get.dart';
import '../../app/model/property/mypropertymodel.dart';
import '../../services/api/property.dart';
import '../../services/localstorage/SessionManager.dart';

class MyPropertiesViewModel extends GetxController
    with GetTickerProviderStateMixin {
  Rx<MyPropertyModel> properties = MyPropertyModel().obs;
  RxBool isLoading = false.obs;
  RxBool isException = false.obs;
  RxInt page = 0.obs;
  SessionManager sessionManager = SessionManager();

  @override
  void onInit() {
    super.onInit();
    initScrolls();
    getMyProperties();
  }

  initScrolls() {}

  getMyProperties() async {
    isLoading.value = true;
    isException.value = false;
    try {
      properties.value = await PropertyService.getMyProperties();
      isException.value = false;
      isLoading.value = false;
    } catch (e) {
      isException.value = true;
      isLoading.value = false;
      log('error');
    }
  }
}
