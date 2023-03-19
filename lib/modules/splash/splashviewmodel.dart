import 'dart:async';
import 'package:get/get.dart';

import '../../routes/approutes.dart';

class SplashViewModel extends GetxController {
  bool isUserLogin = false;
  bool isUserRegistered = false;

  @override
  void onReady() {
    startTime();
    super.onReady();
  }

  startTime() async {
    Timer(const Duration(seconds: 3), loadNextScreen);
  }

  loadNextScreen() {
    Get.offAllNamed(AppRoutes.home);
  }
}
