// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/search/searchviewmodel.dart';
import '../modules/trading/society/societytradeviewmodel.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';

AppBar appBar({
  String? title,
  String? previousTitle,
  List<Widget>? actions,
  String? image,
  Function()? onTap,
}) {
  return AppBar(
    elevation: 0.3,
    backgroundColor: AppColor.backgroundColor,
    title: image != null
        ? Image.asset('$image', height: 25)
        : Text(
            '$title',
            style: TextStyle(
              color: AppColor.blackColor,
              fontFamily: AppFonts.mulishFont,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
    toolbarHeight: Platform.isAndroid ? AppBar().preferredSize.height - 5 : 43,
    automaticallyImplyLeading: true,
    leadingWidth: 100,
    leading: Platform.isAndroid
        ? GestureDetector(
            onTap: onTap ??
                () {
                  Get.back();
                },
            child: Row(
              children: const [
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_back_ios_new,
                  size: 22,
                  color: AppColor.blackColor,
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: onTap ??
                () {
                  Get.back();
                },
            child: Container(
              margin: EdgeInsets.only(left: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 22,
                    color: AppColor.proimaryColor,
                  ),
                  SizedBox(width: 1),
                  Text(
                    '$previousTitle',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.mulishFont,
                      color: AppColor.proimaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
    actions: actions,
  );
}

AppBar appBar1(
    {String? title,
    String? previousTitle,
    double? elevation,
    Function()? onTap}) {
  return AppBar(
    elevation: elevation ?? 0.3,
    backgroundColor: AppColor.backgroundColor,
    title: Text('$title'),
    toolbarHeight: Platform.isAndroid ? AppBar().preferredSize.height - 5 : 43,
    automaticallyImplyLeading: true,
    leadingWidth: 100,
    leading: Platform.isAndroid
        ? GestureDetector(
            onTap: onTap ??
                () {
                  Get.back();
                },
            child: Row(
              children: const [
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_back_ios_new,
                  size: 22,
                  color: AppColor.blackColor,
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: onTap ??
                () {
                  Get.back();
                },
            child: Container(
              margin: EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: AppColor.proimaryColor,
                  ),
                  SizedBox(width: 2),
                  Text(
                    '$previousTitle',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.mulishFont,
                      color: AppColor.proimaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
  );
}

appBarFilters() {
  var searchViewModel = Get.put(SearchViewModel());
  return PreferredSize(
    preferredSize: Size.fromHeight(Platform.isAndroid ? kToolbarHeight : 43),
    child: Obx(
      () => AppBar(
        elevation: searchViewModel.showAppBar.value ? 0.5 : 0.0,
        leading: InkWell(
          onTap: () {
            searchViewModel.emptyFilterForm();
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.only(left: 15, top: 12),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColor.blackColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        leadingWidth: 65,
        title: Text(
          'Filter Search',
          style: TextStyle(
            color: AppColor.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              searchViewModel.emptyFilterForm();
              searchViewModel.propertyPagingController.refresh();
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.only(right: 18, top: 12),
              child: Text(
                'Reset',
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

appBarFiltersSociety() {
  var tradeViewModel = Get.put(SocietyTradeViewModel());
  return PreferredSize(
    preferredSize: Size.fromHeight(Platform.isAndroid ? kToolbarHeight : 43),
    child: AppBar(
      elevation: 0.1,
      leading: InkWell(
        onTap: () {
          tradeViewModel.emptyFilterForm();
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, top: 12),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: AppColor.blackColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      leadingWidth: 65,
      title: Text(
        'Filter Search',
        style: TextStyle(
          color: AppColor.blackColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            tradeViewModel.emptyFilterForm();
            tradeViewModel.societyPagingController.refresh();
            tradeViewModel.societySellPagingController.refresh();
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.only(right: 18, top: 12),
            child: Text(
              'Reset',
              style: TextStyle(
                color: AppColor.blackColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
