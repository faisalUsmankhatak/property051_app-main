// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, must_be_immutable

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../viewmodel/setting_viewmodel.dart';
import 'com.dart';

class SettingView extends StatelessWidget {
  final settingViewModel = Get.put(SettingViewModel());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundColor,
      child: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                Platform.isAndroid ? AppBar().preferredSize.height : 40),
            child: appBar1(
              title: 'Setting',
              bTitle: 'Save',
              elevation: 0.3,
              showButton: false,
              onTap: () {
                settingViewModel.saveSetting();
              },
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(Get.context!).requestFocus(FocusNode());
            },
            child: ListView(
              children: [
                SizedBox(height: 20),
                areaWidget(
                  title: 'marla',
                  onChanged: (t) {},
                ),
                SizedBox(height: 20),
                ConverterButton1(
                  title: 'Save',
                  icon: CupertinoIcons.photo_on_rectangle,
                  onTap: () async {
                    settingViewModel.saveSetting();
                    Get.back();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AppBar appBar1(
    {String? title,
    String? bTitle,
    String? previousTitle,
    double? elevation,
    Function()? onTap,
    bool? showButton = true}) {
  return AppBar(
    elevation: elevation ?? 0.3,
    backgroundColor: AppColor.backgroundColor,
    toolbarHeight: Platform.isAndroid ? AppBar().preferredSize.height - 5 : 43,
    iconTheme: IconThemeData(color: AppColor.blackColor),
    title: Text(
      '$title',
      style: TextStyle(
        color: AppColor.blackColor,
        fontSize: 16,
        fontFamily: AppFonts.mulishFont,
        fontWeight: FontWeight.w600,
      ),
    ),
    actions: [
      showButton!
          ? TextButton(
              onPressed: onTap,
              child: Text(
                bTitle ?? 'Save',
                style: TextStyle(
                  color: AppColor.greenColor,
                  fontSize: 14,
                  fontFamily: AppFonts.mulishFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : Container(),
    ],
  );
}

class ConverterButton extends StatelessWidget {
  String? title;
  Function()? onTap;
  IconData? icon;
  ConverterButton({this.title, this.onTap, this.icon});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: 100,
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: AppColor.greenColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon ?? CupertinoIcons.settings, color: Colors.white),
            const SizedBox(height: 5),
            Text(
              title ?? 'Convert',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.mulishFont,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConverterButton1 extends StatelessWidget {
  String? title;
  Function()? onTap;
  IconData? icon;
  ConverterButton1({this.title, this.onTap, this.icon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 48,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: AppColor.greenColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title ?? 'Convert',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.mulishFont,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
