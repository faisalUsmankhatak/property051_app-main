import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class FeedBackViewModel extends GetxController {
  RxBool showAppBar = false.obs;
  ScrollController? listScrollController = ScrollController();

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
  }
}
