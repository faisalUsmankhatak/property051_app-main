// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'notificationviewmodel.dart';

class NotificationView extends StatelessWidget {
  var notiViewModel = Get.put(NotificationViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            Platform.isAndroid ? AppBar().preferredSize.height : 40),
        child: Obx(
          () => AppBar(
            elevation: notiViewModel.showAppBar.value ? 0.5 : 0.0,
            backgroundColor: AppColor.backgroundColor,
            title: Text('Notifications'),
            actions: [
              // IconButton(
              //   icon: Icon(
              //     CupertinoIcons.settings,
              //     color: AppColor.blackColor,
              //   ),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ),
      body: Container(
        height: Get.height - Get.height * 0.3,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/icons/noNoti1.png',
                // color: AppColor.backgroundColor,
              ),
              // SizedBox(height: 10),
              Text(
                'No Notifications Yet',
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 22,
                  fontFamily: AppFonts.mulishFont,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You will see all your notifications here',
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 14,
                  fontFamily: AppFonts.mulishFont,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      // body: ListView.separated(
      //   controller: notiViewModel.listScrollController,
      //   padding: EdgeInsets.only(
      //       bottom: kToolbarHeight + MediaQuery.of(context).padding.bottom / 2),
      //   itemCount: notiViewModel.notificationList!.length,
      //   shrinkWrap: true,
      //   itemBuilder: (context, index) {
      //     return listViewItem(notiViewModel.notificationList![index], context);
      //   },
      //   separatorBuilder: (c, i) {
      //     return Row(
      //       children: [
      //         Container(
      //           width: 60,
      //           height: 1,
      //           color: Colors.white,
      //         ),
      //         Divider(
      //           height: 1,
      //           color: AppColor.blackColor,
      //         ),
      //       ],
      //     );
      //   },
      // ),
    );
  }

  Widget listViewItem(NotificationModel not, BuildContext context) {
    return Stack(
      children: [
        Material(
          color: (not.notiReadStatus == '0') ? Color(0xffFBE8FF) : Colors.white,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    margin: EdgeInsets.only(right: 2, left: 6, top: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        not.notiType == '2'
                            ? 'images/icons/propertyApproved.png'
                            : not.notiType == '3'
                                ? 'images/icons/propertyDisApproved.png'
                                : not.notiType == '1'
                                    ? 'images/icons/propertyAdded.png'
                                    : not.notiType == '4'
                                        ? 'images/icons/viewProperty.png'
                                        : not.notiType == '5'
                                            ? 'images/icons/lead.png'
                                            : 'images/icons/featuredProperty.png',
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          message(not),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 15,
          right: 12,
          child: Text(
            '${not.notiTme}',
            style: TextStyle(
              fontFamily: AppFonts.mulishFont,
              fontSize: 9.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }

  Widget message(NotificationModel not) {
    return Container(
      child: RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: not.name,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontFamily: AppFonts.mulishFont,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '\n${not.msg}',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.mulishFont,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeAndDate(NotificationModel not) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text(
          //   'And some small print',
          //   // formatDate(new DateFormat("MMM d yyyy h:mm a").parse(not.notiTme),
          //   //     [hh, ':', nn, ' ', am]),
          //   style: TextStyle(
          //     fontFamily: 'Mulish-Light',
          //     fontSize: 10.0,
          //   ),
          // ),
          Text(
            '${not.notiTme}',
            // formatDate(new DateFormat("MMM d yyyy h:mm a").parse(not.notiTme),
            //     [MM, ' ', yyyy]),
            style: TextStyle(
              fontFamily: AppFonts.mulishFont,
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  IconData notificationImages(NotificationModel not) {
    if (not.notiType == "1") {
      return CupertinoIcons.check_mark_circled;
    } else if (not.notiType == "2") {
      return CupertinoIcons.star;
    } else if (not.notiType == "3") {
      return CupertinoIcons.star;
    } else if (not.notiType == "4") {
      return CupertinoIcons.bell;
    } else if (not.notiType == "5") {
      return CupertinoIcons.bell;
    } else if (not.notiType == "6") {
      return CupertinoIcons.clock;
    } else if (not.notiType == "7") {
      return CupertinoIcons.clock;
    } else if (not.notiType == "8") {
      return CupertinoIcons.clock;
    } else if (not.notiType == "9") {
      return CupertinoIcons.clock;
    } else if (not.notiType == "10") {
      return CupertinoIcons.envelope;
    } else if (not.notiType == "15") {
      return CupertinoIcons.clock;
    } else {
      return CupertinoIcons.bell;
    }
  }
}
