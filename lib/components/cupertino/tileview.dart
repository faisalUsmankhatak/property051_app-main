// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, sort_child_properties_last, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_051/services/localstorage/SessionManager.dart';
import '../../modules/home/homeviewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/fonts.dart';
import '../segmentedcontrol/src/tab.dart';
import '../segmentedcontrol/src/tab_bar.dart';

section({Widget? child, double? margin}) {
  return Container(
    margin: EdgeInsets.only(left: margin ?? 10, right: margin ?? 10),
    child: Card(
      margin: margin != null ? EdgeInsets.zero : EdgeInsets.all(4),
      shadowColor: Colors.transparent,
      borderOnForeground: false,
      elevation: 0.0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: child,
      ),
    ),
  );
}

divider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 42,
        color: Colors.white,
        height: 0.5,
      ),
      Expanded(
        child: Container(
          color: AppColor.greyColor.withOpacity(0.3),
          height: 0.5,
        ),
      ),
    ],
  );
}

customIcon({IconData? icon, Color? bgColor, Color? iconColor}) {
  return Container(
    height: 25,
    width: 25,
    margin: EdgeInsets.only(right: 10, left: 10),
    padding: EdgeInsets.all(0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: bgColor ?? AppColor.greyColor.withOpacity(0.9),
    ),
    child: Icon(
      icon,
      color: iconColor ?? AppColor.whiteColor,
      size: 20,
    ),
  );
}

cupertinoTile(
    {Widget? icon,
    String? title,
    bool? showIcon,
    bool? centerText,
    Color? backgroundColor,
    Color? textColor,
    VoidCallback? onPressed,
    String? imagePath}) {
  return CupertinoButton(
    padding: const EdgeInsets.all(0),
    onPressed: onPressed,
    child: Container(
      height: 45,
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: centerText != null
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (imagePath != null)
                Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      '$imagePath',
                      height: 25,
                      width: 25,
                    ),
                  ),
                ),
              if (icon != null) icon,
              Text(
                '$title',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? AppColor.blackColor,
                  fontFamily: AppFonts.mulishFont,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          showIcon!
              ? Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                )
              : Container(),
        ],
      ),
    ),
  );
}

cupertinoButton({
  String? title,
  VoidCallback? onPressed,
  Color? color,
  double? padding,
  Color? textColor,
  double? height,
}) {
  return Container(
    height: height ?? 49,
    margin: EdgeInsets.symmetric(horizontal: padding ?? 16, vertical: 15),
    width: double.infinity,
    child: CupertinoButton(
      color: color ?? AppColor.proimaryColor,
      borderRadius: BorderRadius.circular(5),
      child: Text(
        title ?? '',
        style: TextStyle(
          color: textColor ?? AppColor.whiteColor,
          fontSize: 18,
          letterSpacing: 1,
        ),
      ),
      onPressed: onPressed,
    ),
  );
}

textFieldNumber({String? hintText, TextEditingController? controller}) {
  return Row(
    children: [
      Container(
        height: 50,
        width: 50,
        color: Colors.transparent,
        child: Text(
          '+92',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.mulishFont,
          ),
        ),
        alignment: Alignment.center,
      ),
      Container(
        height: 50,
        width: 0.5,
        color: AppColor.greyColor.withOpacity(0.7),
      ),
      Expanded(
        child: TextField(
          controller: controller ?? null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? '',
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.greyColor,
              fontFamily: AppFonts.mulishFont,
            ),
            contentPadding: EdgeInsets.only(left: 15, top: 0, bottom: 3),
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    ],
  );
}

textField({
  String? hintText,
  int? maxLines,
  TextEditingController? controller,
  Function(String)? onChanged,
  TextInputType? keyboardType,
  bool enabled = true,
}) {
  return Row(
    children: [
      Expanded(
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          enabled: enabled,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? '',
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.greyColor,
              fontFamily: AppFonts.mulishFont,
            ),
            contentPadding: EdgeInsets.only(left: 12, top: 4),
          ),
          maxLines: maxLines ?? 1,
          keyboardType: keyboardType ?? TextInputType.text,
        ),
      ),
    ],
  );
}

category({String? imagePath, String? title, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        // color: AppColor.whiteColor,
        // border: Border.all(color: AppColor.greyColor.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.greyColor.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                '$imagePath',
                height: Get.width / 5,
                width: Get.width / 5,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            '$title',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.mulishFont,
            ),
            maxLines: 1,
          ),
        ],
      ),
    ),
  );
}

topInfoDashBoard() {
  return Stack(
    children: [
      // Image.asset('images/gif/testGif.gif'),
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    Constant.appLogo,
                    height: 45,
                    // width: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (SessionManager().getToken() == null) {
                      } else {
                        Get.find<HomeViewModel>().selectedtab.value = 3;
                        Get.find<HomeViewModel>().tabController!.index = 3;
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.whiteColor,
                      ),
                      child: Icon(
                        CupertinoIcons.bell,
                        color: AppColor.proimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.location_solid,
                  color: AppColor.proimaryColor,
                  size: 20,
                ),
                SizedBox(width: 3),
                Text(
                  'Islamabad',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.mulishFont,
                    color: AppColor.blackColor,
                  ),
                ),
                SizedBox(width: 5),
                // Icon(
                //   Icons.keyboard_arrow_down_outlined,
                //   color: AppColor.proimaryColor,
                // ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

topInfoSearch({VoidCallback? onTapMap, VoidCallback? onTapFilter}) {
  // final viewModel = Get.find<SearchViewModel>();
  return Container(
    padding: EdgeInsets.only(
        bottom: 10, right: 10, left: 10, top: Platform.isAndroid ? 10 : 0),
    decoration: BoxDecoration(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 60,
          padding: EdgeInsets.only(left: 5, right: 7, top: 3, bottom: 3),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon(
            //   CupertinoIcons.location_solid,
            //   color: AppColor.proimaryColor,
            //   size: 20,
            // ),
            SizedBox(width: 3),
            Container(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.mulishFont,
                  color: AppColor.blackColor,
                ),
              ),
            ),
            SizedBox(width: 5),
            // Icon(
            //   Icons.keyboard_arrow_down_outlined,
            //   color: AppColor.proimaryColor,
            // ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: onTapFilter,
              child: Container(
                margin: EdgeInsets.only(left: 9),
                padding: EdgeInsets.only(left: 5, right: 7, top: 3, bottom: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // color: AppColor.greyColor.withOpacity(0.2),
                  border: Border.all(
                    color: AppColor.greyColor.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.tune,
                      color: AppColor.proimaryColor,
                    ),
                    SizedBox(width: 3),
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.mulishFont,
                        color: AppColor.proimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: onTapMap,
            //   child: Container(
            //     margin: EdgeInsets.only(left: 9),
            //     padding: EdgeInsets.only(left: 5, right: 7, top: 3, bottom: 3),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(8),
            //       // color: AppColor.greyColor.withOpacity(0.2),
            //       border: Border.all(
            //         color: AppColor.greyColor.withOpacity(0.2),
            //       ),
            //     ),
            //     child: Obx(
            //       () => viewModel.isMap.value
            //           ? Row(
            //               children: [
            //                 Icon(
            //                   Icons.view_list_sharp,
            //                   color: AppColor.proimaryColor,
            //                 ),
            //                 SizedBox(width: 3),
            //                 Text(
            //                   'List',
            //                   style: TextStyle(
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.w500,
            //                     fontFamily: AppFonts.mulishFont,
            //                     color: AppColor.proimaryColor,
            //                   ),
            //                 ),
            //               ],
            //             )
            //           : Row(
            //               children: [
            //                 Icon(
            //                   Icons.location_on_outlined,
            //                   color: AppColor.proimaryColor,
            //                 ),
            //                 SizedBox(width: 3),
            //                 Text(
            //                   'Map',
            //                   style: TextStyle(
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.w500,
            //                     fontFamily: AppFonts.mulishFont,
            //                     color: AppColor.proimaryColor,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    ),
  );
}

segmentControl(
  context,
  TabController? controller, {
  List<SegmentTab>? tabs,
  TextStyle? textStyle,
  double height = 40,
}) {
  return Padding(
    padding:
        const EdgeInsets.only(top: 16, left: 14.5, right: 14.5, bottom: 16),
    child: SegmentedTabControl(
      controller: controller,
      radius: const Radius.circular(8),
      backgroundColor: Colors.grey.shade300,
      indicatorColor: AppColor.proimaryColor,
      // indicatorColor: AppColor.proimaryColor,
      selectedTabTextColor: Colors.white,
      squeezeIntensity: 2,
      height: height,
      tabPadding: const EdgeInsets.symmetric(horizontal: 8),
      textStyle: textStyle ?? Theme.of(context).textTheme.headlineMedium,
      tabs: tabs!,
    ),
  );
}
