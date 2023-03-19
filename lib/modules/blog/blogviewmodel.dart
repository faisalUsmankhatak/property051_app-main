// ignore_for_file: unnecessary_string_escapes

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class BlogViewModel extends GetxController {
  RxBool showAppBar = false.obs;
  ScrollController? listScrollController = ScrollController();
  List<BlogModel>? blogList;
  @override
  void onInit() {
    super.onInit();
    listScrollController!.addListener(() {
      if (listScrollController!.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showAppBar.value = true;
      } else if (listScrollController!.position.userScrollDirection ==
          ScrollDirection.forward) {
        showAppBar.value = false;
      }
    });
    blogList = getBlogs();
  }

  List<BlogModel> getBlogs() {
    List<BlogModel> notificationList = [];
    notificationList.add(
      BlogModel(
        time: 'Just Now',
        title: 'Sherman Shop',
      ),
    );
    notificationList.add(
      BlogModel(
        time: 'Just Now',
        title: 'Sherman Shop',
      ),
    );
    notificationList.add(
      BlogModel(
        time: 'Just Now',
        title: 'Sherman Shop',
      ),
    );
    notificationList.add(
      BlogModel(
        time: 'Just Now',
        title: 'Sherman Shop',
      ),
    );
    notificationList.add(
      BlogModel(
        time: 'Just Now',
        title: 'Sherman Shop',
      ),
    );
    return notificationList;
  }

  showString() {
    var html =
        """<p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size:12pt;font-family:'Times New Roman';color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;\">Different areas have their own importance. Every place has unique living styles and standards, it has environment, facilities, locality, surrounding/ neighborhood, social-economic, social cultural and social psychology. And all these are the essentials for a lifestyle of a century. The place where these things are available and has met the standard of our income would be the best place to invest to build our house or to plan our future now. Find that correct place. In big cities like Islamabad. We did some research and came to know that&nbsp; there are many housing societies offering different facilities to living under different facilities. To live under different ranges you can choose the most favorable for you, according to your budget and choice.</span></p><p><span id=\"docs-internal-guid-470c9dd9-7fff-c5cf-7505-2f3480fd8ef3\"></span></p><p dir=\"ltr\" style=\"line-height:1.38;margin-top:0pt;margin-bottom:0pt;\"><span style=\"font-size:12pt;font-family:'Times New Roman';color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Housing societies are the best places to build your home because it offers quality of living standards regarding the needs of the age. We can find all the basic and advanced facilities under one umbrella very often. Living in a housing society has the benefits of a structured system of brotherhood and its face severity system that ensures your safety on a better&nbsp; scale, peaceful and basic life facilities which you are looking for.&nbsp;</span></p>\"""";
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String parsedstring1 = html.replaceAll(exp, '');
    log(parsedstring1);

    String parsedstring2 = html.replaceAll(exp, ' ');
    log(parsedstring2);
  }
}

class BlogModel {
  String? title;
  String? time;
  BlogModel({this.time, this.title});
}
