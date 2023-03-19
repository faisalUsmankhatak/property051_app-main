import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:property_051/modules/trading/society/societyview.dart';
import 'package:property_051/utils/fonts.dart';
import '../../../components/segmentedcontrol/src/tab.dart';
import '../../../components/segmentedcontrol/src/tab_bar.dart';
import '../../../utils/colors.dart';
import '../tradeviewmodel.dart';

// tabBar(context) {
//   final tradeViewModel = Get.find<TradingViewModel>();
//   return segmentControl(
//     context,
//     tradeViewModel.daysController,
//     textStyle: TextStyle(
//       color: AppColor.blackColor,
//       fontSize: 15,
//       fontFamily: 'Mulish',
//       fontWeight: FontWeight.w600,
//     ),
//     tabs: [
//       SegmentTab(
//         label: 'Today',
//         selectedTextColor: AppColor.whiteColor,
//         textColor: AppColor.blackColor,
//       ),
//       SegmentTab(
//         label: 'Yesterday',
//         selectedTextColor: AppColor.whiteColor,
//         textColor: AppColor.blackColor,
//       ),
//       SegmentTab(
//         label: 'My Trade',
//         selectedTextColor: AppColor.whiteColor,
//         textColor: AppColor.blackColor,
//       ),
//     ],
//   );
// }
tabBar(context) {
  final tradeViewModel = Get.find<TradingViewModel>();
  return segmentControl(
    context,
    tradeViewModel.daysController,
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

addTradeAppBar() {
  var tradeViewModel = Get.find<TradingViewModel>();
  return PreferredSize(
    preferredSize: Size.fromHeight(Platform.isAndroid ? 40 : 43),
    child: Obx(
      () => AppBar(
        elevation: tradeViewModel.showAppBar.value ? 0.5 : 0.0,
        leading: InkWell(
          onTap: () {
            tradeViewModel.emptyForm();
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
        leadingWidth: 80,
        title: Text(
          'Add Trade',
          style: TextStyle(
            color: AppColor.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.mulishFont,
          ),
        ),
        actions: [
          tradeViewModel.isAddingTrade.value
              ? Container(
                  margin: EdgeInsets.only(right: 12),
                  child: SpinKitCircle(
                    color: AppColor.blackColor,
                    size: 30.0,
                  ),
                )
              : Container(),
        ],
      ),
    ),
  );
}

societyList() {
  final tradeViewModel = Get.find<TradingViewModel>();
  return Obx(
    () => tradeViewModel.societyModel.value.data != null
        ? Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: AppColor.greyColor.withOpacity(0.3),
                width: 0.5,
              ),
            )),
            child: ListView.separated(
              itemCount: tradeViewModel
                  .societyModel.value.data!.fileTrendingSocieties!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (c, i) {
                var society = tradeViewModel
                    .societyModel.value.data!.fileTrendingSocieties![i];
                return societyItem(
                  societyName: '${society.societyName}',
                  onTap: () async {
                    tradeViewModel.societyTradeID.value = society.id.toString();
                    tradeViewModel.societyTradeController.refresh();
                    await Get.to(
                      () => SocietyTradeView(
                          title: '${society.societyName}',
                          id: society.id.toString()),
                    );
                    tradeViewModel.emptyFilterForm();
                  },
                );
              },
              separatorBuilder: (c, i) {
                return Container(
                  width: 1,
                  color: AppColor.greyColor.withOpacity(0.3),
                );
              },
            ),
          )
        : Container(),
  );
}

societyItem({String? societyName, Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      constraints: BoxConstraints(
        minWidth: Get.width / 5,
      ),
      alignment: Alignment.center,
      child: Text(
        '$societyName',
        style: TextStyle(
          color: AppColor.blackColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
