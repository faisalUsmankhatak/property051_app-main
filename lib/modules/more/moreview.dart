// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_string_interpolations

import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/cupertino/tileview.dart';
import '../../routes/approutes.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../utils/url_launcher_utils.dart';
import '../converter/view/converter_view.dart';
import 'moreviewmodel.dart';

class MoreView extends StatelessWidget {
  var moreViewModel = Get.find<MoreViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            Platform.isAndroid ? AppBar().preferredSize.height : 40),
        child: Obx(
          () => AppBar(
            title: Text('More'),
            elevation: moreViewModel.showAppBar.value ? 0.5 : 0.0,
          ),
        ),
      ),
      body: ListView(
        controller: moreViewModel.listScrollController,
        children: [
          Obx(
            () => !moreViewModel.isLogin.value
                ? Column(
                    children: [
                      SizedBox(height: 15),
                      section(
                        child: Column(
                          children: [
                            cupertinoTile(
                              imagePath: 'images/icons/auth2.png',
                              // icon: customIcon(icon: CupertinoIcons.auth),
                              title: 'Signin / Signup',
                              showIcon: false,
                              onPressed: () {
                                Get.toNamed(
                                  AppRoutes.welcome,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.width / 17),
                    ],
                  )
                : SizedBox(height: 12),
          ),
          Obx(
            () => moreViewModel.isLogin.value
                ? Column(
                    children: [
                      section(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            cupertinoTile(
                              title: 'My Profile',
                              showIcon: true,
                              imagePath: 'images/icons/auth.png',
                              onPressed: () async {
                                Get.toNamed(AppRoutes.userProfile);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 18),
                    ],
                  )
                : Container(),
          ),
          section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                cupertinoTile(
                  title: 'List Your Property',
                  showIcon: true,
                  imagePath: 'images/icons/addProperty.png',
                  onPressed: () async {
                    if (moreViewModel.sessionManager.isUserLogin) {
                      Get.toNamed(AppRoutes.addProperty);
                    } else {
                      await Get.toNamed(AppRoutes.welcome);
                      if (moreViewModel.sessionManager.isUserLogin) {
                        Get.toNamed(AppRoutes.addProperty);
                      }
                    }
                  },
                ),
                divider(),
                cupertinoTile(
                  imagePath: 'images/icons/myProperty.png',
                  title: 'My Properties',
                  showIcon: true,
                  onPressed: () async {
                    if (moreViewModel.sessionManager.isUserLogin) {
                      Get.toNamed(AppRoutes.getMyProperties);
                    } else {
                      await Get.toNamed(AppRoutes.welcome);
                      if (moreViewModel.sessionManager.isUserLogin) {
                        Get.toNamed(AppRoutes.getMyProperties);
                      }
                    }
                  },
                ),
                divider(),
                cupertinoTile(
                  imagePath: 'images/icons/findAgent.png',
                  title: 'Find a Agent',
                  showIcon: true,
                  onPressed: () {
                    Get.toNamed(AppRoutes.agent);
                  },
                ),
                divider(),
                cupertinoTile(
                  imagePath: 'images/icons/findAgency1.png',
                  title: 'Find a Real Estate Agency',
                  showIcon: true,
                  onPressed: () {
                    Get.toNamed(AppRoutes.agency);
                  },
                ),
                divider(),
                cupertinoTile(
                  icon: customIcon(icon: CupertinoIcons.settings_solid),
                  title: 'Prefrences',
                  showIcon: true,
                  onPressed: () {
                    FirebaseMessaging.instance.getToken().then((value) {
                      log(value.toString());
                    });
                    Get.toNamed(AppRoutes.prefrences);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: Get.width / 17),
          section(
            child: Column(
              children: [
                cupertinoTile(
                  imagePath: 'images/icons/calculator1.png',
                  title: 'Area Converter',
                  showIcon: true,
                  onPressed: () {
                    // Get.toNamed(AppRoutes.areaConvertor);
                    Get.to(() => AreaCalculatorVeiw());
                  },
                ),
                divider(),
                cupertinoTile(
                  imagePath: 'images/icons/feedback.png',
                  title: 'Feedback',
                  showIcon: true,
                  onPressed: () {
                    Get.toNamed(AppRoutes.feeBack);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: Get.width / 17),
          section(
            child: Column(
              children: [
                cupertinoTile(
                  icon: customIcon(
                    icon: CupertinoIcons.hand_raised_fill,
                    bgColor: Color.fromRGBO(2, 117, 253, 1),
                  ),
                  title: 'Privacy & Data',
                  showIcon: true,
                  onPressed: () async {
                    UrlLauncherUtils.launchWebUrl(
                      'https://www.property051.com/privacy',
                    );
                  },
                ),
                divider(),
                cupertinoTile(
                  imagePath: 'images/icons/termOfUse.png',
                  title: 'Terms of Use',
                  showIcon: true,
                  onPressed: () async {
                    UrlLauncherUtils.launchWebUrl(
                      'https://www.property051.com/terms',
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: Get.width / 16),
          Obx(
            () => moreViewModel.isLogin.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      section(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cupertinoTile(
                              title: 'Sign out',
                              showIcon: false,
                              centerText: true,
                              textColor: AppColor.redColor,
                              onPressed: () {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (c) {
                                    return CupertinoAlertDialog(
                                      title: Text(
                                        "Sign out",
                                        style: TextStyle(
                                          color: AppColor.blackColor,
                                          fontSize: 16,
                                          fontFamily: AppFonts.mulishFont,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      content: Text(
                                        "Are you sure you want to sign out?",
                                        style: TextStyle(
                                          color: AppColor.blackColor,
                                          fontSize: 14,
                                          fontFamily: AppFonts.mulishFont,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 16,
                                              fontFamily: AppFonts.mulishFont,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                        CupertinoDialogAction(
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontSize: 16,
                                              fontFamily: AppFonts.mulishFont,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          onPressed: () {
                                            moreViewModel.logOut();
                                            Get.back();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                  barrierDismissible: true,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.only(left: 14),
                        child: Text(
                          'Property051.com © 2021 All Rights Reserved\n1.0.1',
                          style: TextStyle(
                            color: AppColor.greyColor,
                            fontSize: 14,
                            fontFamily: AppFonts.mulishFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
          SizedBox(height: Get.width / 4),
        ],
      ),
    );
  }
}
