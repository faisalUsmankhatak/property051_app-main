// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_051/components/appbar.dart';

import '../../components/cupertino/tileview.dart';
import '../../utils/colors.dart';
import 'feedbackviewmodel.dart';

class FeedBackView extends StatelessWidget {
  var controller = Get.put(FeedBackViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            Platform.isAndroid ? AppBar().preferredSize.height : 43),
        child: Obx(
          () => appBar1(
            title: 'Feedback',
            previousTitle: 'Home',
            elevation: controller.showAppBar.value ? 0.5 : 0,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          controller: controller.listScrollController,
          children: [
            SizedBox(height: 10),
            titleDesc(),
            cupertinoButton(
              title: 'Submit',
              onPressed: () {},
            ),
            SizedBox(height: Get.height * 0.45),
          ],
        ),
      ),
    );
  }

  titleDesc() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      // padding: EdgeInsets.only(left: 15),
      height: 254,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        border: Border.all(
          color: AppColor.greyColor.withOpacity(0.7),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          textField(hintText: 'Full Name'),
          Divider(height: 1, color: AppColor.greyColor.withOpacity(0.7)),
          textField(hintText: 'Email'),
          Divider(height: 1, color: AppColor.greyColor.withOpacity(0.7)),
          textFieldNumber(hintText: 'Phone Number'),
          Divider(height: 1, color: AppColor.greyColor.withOpacity(0.7)),
          textField(
            hintText:
                'Contact us if you need any assistance or have any query related to Real Estate.',
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
