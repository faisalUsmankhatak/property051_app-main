import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:property_051/components/cupertino/tileview.dart';
import 'package:property_051/utils/fonts.dart';

import 'colors.dart';

class Global {
  static RxInt tabIndex = 0.obs;
}

void dismissKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

class GlobalWidet {
  static final GlobalWidet _instance = GlobalWidet._internal();

  factory GlobalWidet() {
    return _instance;
  }

  GlobalWidet._internal() {
    // init things inside this
  }

  loader() {
    return Container(
      height: Get.height -
          AppBar().preferredSize.height -
          kBottomNavigationBarHeight,
      child: Center(
        child: SpinKitFadingCircle(
          color: AppColor.proimaryColor,
          size: 50.0,
        ),
      ),
    );
  }

  noInternet({String? message, VoidCallback? onTap}) {
    return Container(
      color: AppColor.backgroundColor,
      height: Get.height -
          AppBar().preferredSize.height -
          kBottomNavigationBarHeight,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  'images/gif/noInternet.gif',
                  height: 200,
                  // color: AppColor.proimaryColor,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 60,
                    width: 200,
                    color: AppColor.backgroundColor,
                    child: Center(
                      child: Text(
                        message ?? "No Internet Connection",
                        style: TextStyle(
                          color: AppColor.proimaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: Get.width / 1.5,
              child: cupertinoButton(
                padding: 0,
                title: "Try Again",
                color: AppColor.proimaryColor,
                onPressed: onTap ?? () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  searchField(
      {TextEditingController? controller,
      String? hintText,
      Function(String)? onChange,
      Function(String)? onSubmit}) {
    return CupertinoSearchTextField(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      itemSize: 25,
      suffixIcon: const Icon(CupertinoIcons.xmark_circle),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        // borderRadius: BorderRadius.circular(0),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 0.5,
          ),
        ),
      ),
      controller: controller,
      onChanged: onChange,
      onSubmitted: onSubmit,
      autocorrect: true,
    );
  }

  showDialog() {
    return Get.dialog(
      Center(
        child: Container(
          height: 150,
          width: Get.width / 1.5,
          decoration: BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SpinKitFadingCircle(
            color: AppColor.proimaryColor,
            size: 50.0,
          ),
        ),
      ),
    );
  }

  showSnackBar(
      {String? title, String? message, Color? bgColor, Color? textColor}) {
    return Get.snackbar(
      "$title",
      "$message",
      icon: Icon(CupertinoIcons.check_mark_circled),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: bgColor ?? AppColor.backgroundColor,
      colorText: textColor ?? AppColor.proimaryColor,
      margin: EdgeInsets.all(0),
      borderRadius: 0,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  showInvalidCupertinoDialog({String? title, String? message}) {
    return Get.dialog(
      CupertinoAlertDialog(
        // title: Text("Invalid"),
        content: Text(
          message ?? "Whoops, looks like you entered wrong email or password",
          style: TextStyle(
            color: AppColor.blackColor,
            fontFamily: AppFonts.mulishFont,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  showCupertinoDialog({String? title, String? message, IconData? icon}) {
    return Get.dialog(
      CupertinoAlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error,
              color: AppColor.redColor,
              size: 22,
            ),
            SizedBox(width: 8),
            Text(
              title ?? "",
              style: TextStyle(
                color: AppColor.blackColor,
                fontFamily: AppFonts.mulishFont,
                fontSize: 16,
              ),
            ),
          ],
        ),
        content: Text(
          message ?? "",
          style: TextStyle(
            color: AppColor.blackColor,
            fontFamily: AppFonts.mulishFont,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Ok"),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
