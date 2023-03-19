// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/cupertino/customdropdown.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../viewmodel/setting_viewmodel.dart';

areaWidget({
  String? title,
  void Function(String)? onChanged,
}) {
  final controller = Get.find<SettingViewModel>();
  return GestureDetector(
    onTap: () async {
      var res = await Get.to(
        () => FullScreenDropDown(
          title: 'Marla Size',
          items: ['225', '250', '272'],
          selecedItem: controller.marla.value,
        ),
        fullscreenDialog: true,
      );
      if (res != null) {
        controller.marla.value = res;
        controller.saveSetting();
      }
    },
    child: Container(
      padding: EdgeInsets.only(left: 15),
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        border: Border.all(
          color: AppColor.greyColor.withOpacity(0.7),
          width: 0.2,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: Obx(
                () => Text(
                  controller.marla.value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColor.blackColor,
                    fontFamily: AppFonts.mulishFont,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 0.3,
            color: AppColor.greyColor.withOpacity(0.7),
          ),
          Container(
            height: 50,
            width: Get.width / 4,
            margin: const EdgeInsets.only(right: 10),
            padding: EdgeInsets.only(left: 8),
            color: Colors.transparent,
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: title ?? 'marla',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppFonts.mulishFont,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    ),
  );
}

/*
Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.greyColor,
                fontFamily: AppFonts.mulishFont,
              ),
              contentPadding: EdgeInsets.only(left: 0, top: 5, bottom: 0),
            ),
            onChanged: onChanged,
            onTap: () async {
              var res = await Get.to(
                () => FullScreenDropDown(
                  title: 'Marla Size',
                  items: ['225', '250', '272'],
                  selecedItem: '225',
                ),
                fullscreenDialog: true,
              );
              controller!.text = res;
            },
          ),
        ),
        Container(
          height: 50,
          width: 0.3,
          color: AppColor.greyColor.withOpacity(0.7),
        ),
        GestureDetector(
          onTap: () async {
            var res = await Get.to(
              () => FullScreenDropDown(
                title: 'Marla Size',
                items: ['225', '250', '272'],
                selecedItem: '225',
              ),
              fullscreenDialog: true,
            );
            controller!.text = res;
          },
          child: Container(
            height: 50,
            width: Get.width / 4,
            margin: const EdgeInsets.only(right: 10),
            padding: EdgeInsets.only(left: 8),
            color: Colors.transparent,
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: title ?? 'marla',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppFonts.mulishFont,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    ),
*/