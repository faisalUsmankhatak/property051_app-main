import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/segmentedcontrol/src/tab.dart';
import '../../../components/segmentedcontrol/src/tab_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import 'societytradeviewmodel.dart';

tabBar(context) {
  final tradeViewModel = Get.find<SocietyTradeViewModel>();
  return segmentControl(
    context,
    tradeViewModel.buyRentController,
    textStyle: TextStyle(
      color: AppColor.blackColor,
      fontSize: 15,
      fontFamily: AppFonts.mulishFont,
      fontWeight: FontWeight.w600,
    ),
    tabs: [
      SegmentTab(
        label: 'Buy',
        selectedTextColor: AppColor.whiteColor,
        textColor: AppColor.blackColor,
      ),
      SegmentTab(
        label: 'Sell',
        selectedTextColor: AppColor.whiteColor,
        textColor: AppColor.blackColor,
      ),
    ],
  );
}

segmentControl(context, TabController? controller,
    {List<SegmentTab>? tabs, TextStyle? textStyle}) {
  return Padding(
    padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
    child: SegmentedTabControl(
      controller: controller,
      radius: const Radius.circular(0),
      backgroundColor: Colors.grey.shade300,
      indicatorColor: AppColor.proimaryColor,
      // indicatorColor: AppColor.proimaryColor,
      selectedTabTextColor: Colors.white,
      squeezeIntensity: 2,
      height: 37,
      tabPadding: const EdgeInsets.symmetric(horizontal: 8),
      textStyle: textStyle ?? Theme.of(context).textTheme.headlineMedium,
      tabs: tabs!,
    ),
  );
}
