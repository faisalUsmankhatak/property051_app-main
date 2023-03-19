import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'colors.dart';

class Loader {
  static showLoading() async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 50.0
      ..radius = 20.0
      ..progressColor = AppColor.blackColor
      ..backgroundColor = AppColor.backgroundColor
      ..indicatorColor = AppColor.blackColor
      ..textColor = AppColor.blackColor
      ..maskColor = AppColor.backgroundColor
      ..userInteractions = true
      ..dismissOnTap = true;
    EasyLoading.show();
  }

  static hideLoading() async {
    EasyLoading.dismiss();
  }
}
