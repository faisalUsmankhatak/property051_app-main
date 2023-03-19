import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:property_051/modules/dashboard/dashboardcontroller.dart';
import 'package:property_051/services/localstorage/SessionManager.dart';

class MoreViewModel extends GetxController {
  SessionManager sessionManager = SessionManager();
  RxBool isLogin = false.obs;
  RxBool showAppBar = false.obs;
  ScrollController? listScrollController;

  @override
  void onInit() {
    super.onInit();
    listScrollController = ScrollController();
    listScrollController!.addListener(
      () {
        if (listScrollController!.positions.last.userScrollDirection ==
            ScrollDirection.reverse) {
          showAppBar.value = true;
        } else if (listScrollController!.positions.last.userScrollDirection ==
            ScrollDirection.forward) {
          showAppBar.value = false;
        }
      },
    );
    sessionManager.isUserLogin ? isLogin.value = true : isLogin.value = false;
    log(isLogin.value.toString());
  }

  logOut() async {
    sessionManager.remove(SessionKeys.fcmToken);
    sessionManager.clearSession();
    Get.find<DashBoardViewModel>().deleteRecentProperties();
    Get.find<DashBoardViewModel>().getProperties();
    isLogin.value = false;
  }
}
