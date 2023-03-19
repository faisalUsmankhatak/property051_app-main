// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/appbar.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'prefrencesviewmodel.dart';

class PrefrencesView extends StatelessWidget {
  var controller = Get.put(PrefrencesViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            Platform.isAndroid ? AppBar().preferredSize.height : 40),
        child: Obx(
          () => appBar1(
            title: 'Prefrences',
            previousTitle: 'Home',
            elevation: controller.showAppBar.value ? 0.5 : 0.0,
          ),
        ),
      ),
      body: ListView(
        controller: controller.listScrollController,
        children: [
          SizedBox(height: 10),
          tile('Push Notifications'),
          SizedBox(height: Get.height * 0.8),
        ],
      ),
    );
  }

  tile(item) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15, right: 20),
          decoration: const BoxDecoration(
            color: AppColor.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$item',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor,
                  fontFamily: AppFonts.mulishFont,
                ),
              ),
              Obx(
                () => CupertinoSwitch(
                  activeColor: AppColor.proimaryColor,
                  value: controller.showNotifications.value,
                  onChanged: (value) {
                    controller.showNotifications.value = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
