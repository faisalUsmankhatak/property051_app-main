import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  CupertinoTabController? tabController;
  RxInt selectedtab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = CupertinoTabController(initialIndex: 0);
    init();
  }

  init() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification notification = message.notification!;
        log(notification.body!);
      },
    );
  }
}
