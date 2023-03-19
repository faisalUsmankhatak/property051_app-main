// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/appbar.dart';
import '../../../components/cupertino/customdropdown.dart';
import '../../../components/cupertino/tileview.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../society/societytradeviewmodel.dart';
import '../tradeviewmodel.dart';

class FilterView extends StatelessWidget {
  var tradeViewModel = Get.find<TradingViewModel>();
  var societyViewModel = Get.find<SocietyTradeViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarFiltersSociety(),
      body: body(context),
    );
  }

  body(context) {
    return Obx(
      () => ListView(
        // controller: searchViewModel.filterController,
        children: [
          SizedBox(height: 8),
          Obx(
            () => societyViewModel.filterError.value != ''
                ? Column(
                    children: [
                      Text(
                        '${societyViewModel.filterError.value}',
                        style: TextStyle(
                            color: AppColor.proimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                    ],
                  )
                : Container(),
          ),
          section(
            child: Column(
              children: [
                cupertinoTile(
                  imagePath: 'images/icons/block1.png',
                  title: societyViewModel.societyFilterBlock.value != ''
                      ? societyViewModel.societyFilterBlock.value
                      : 'Select Block',
                  showIcon: true,
                  onPressed: () async {
                    societyViewModel.filterError.value = '';
                    var res = await Get.to(
                      () => FullScreenDropDown(
                        title: 'Select Block',
                        items: tradeViewModel
                            .societyModel.value.data!.fileTrendingSocieties!
                            .firstWhere((society) =>
                                society.id ==
                                int.parse(
                                    societyViewModel.societyTradeID.value))
                            .fileTrendingSocietyBlocks!
                            .map((block) => block.blockName)
                            .toList(),
                        selecedItem: societyViewModel.societyFilterBlock.value,
                      ),
                      fullscreenDialog: true,
                    );
                    if (res != null) {
                      societyViewModel.societyFilterBlock.value = res;
                      societyViewModel.societyFilterBlockId.value =
                          tradeViewModel
                              .societyModel.value.data!.fileTrendingSocieties!
                              .firstWhere((society) =>
                                  society.id ==
                                  int.parse(
                                      tradeViewModel.societyTradeID.value))
                              .fileTrendingSocietyBlocks!
                              .firstWhere((block) => block.blockName == res)
                              .id
                              .toString();
                      societyViewModel.societyFilterSize.value = '';
                      societyViewModel.societyFilterSizeId.value = '';
                      societyViewModel.societyFilterBooking.value = '';
                      societyViewModel.societyFilterBookingId.value = '';
                    }
                  },
                ),
                divider(),
                cupertinoTile(
                  imagePath: 'images/icons/size.png',
                  title: societyViewModel.societyFilterSize.value != ''
                      ? societyViewModel.societyFilterSize.value
                      : 'Select Size',
                  showIcon: true,
                  onPressed: () async {
                    if (societyViewModel.societyFilterBlock.value == '') {
                      societyViewModel.filterError.value =
                          'Please select block';
                    } else {
                      societyViewModel.filterError.value = '';
                      var res = await Get.to(
                        () => FullScreenDropDown(
                          title: 'Select Size',
                          items: tradeViewModel
                              .societyModel.value.data!.fileTrendingSocieties!
                              .firstWhere((society) =>
                                  society.id ==
                                  int.parse(
                                      societyViewModel.societyTradeID.value))
                              .fileTrendingSocietyBlocks!
                              .firstWhere((block) =>
                                  block.blockName ==
                                  societyViewModel.societyFilterBlock.value)
                              .fileTrendingSocietySizes!
                              .map((size) => size.sizeName)
                              .toList(),
                          selecedItem: societyViewModel.societyFilterSize.value,
                        ),
                        fullscreenDialog: true,
                      );
                      if (res != null) {
                        societyViewModel.societyFilterSize.value = res;
                        societyViewModel.societyFilterSizeId.value =
                            tradeViewModel
                                .societyModel.value.data!.fileTrendingSocieties!
                                .firstWhere((society) =>
                                    society.id ==
                                    int.parse(
                                        societyViewModel.societyTradeID.value))
                                .fileTrendingSocietyBlocks!
                                .firstWhere((block) =>
                                    block.blockName ==
                                    societyViewModel.societyFilterBlock.value)
                                .fileTrendingSocietySizes!
                                .firstWhere((size) => size.sizeName == res)
                                .id
                                .toString();
                        societyViewModel.societyFilterBooking.value = '';
                        societyViewModel.societyFilterBookingId.value = '';
                      }
                    }
                  },
                ),
                divider(),
                cupertinoTile(
                  imagePath: 'images/icons/price.png',
                  title: societyViewModel.societyFilterBooking.value != ''
                      ? societyViewModel.societyFilterBooking.value
                      : 'Select Booking Type',
                  showIcon: true,
                  onPressed: () async {
                    if (societyViewModel.societyFilterSize.value == '') {
                      societyViewModel.filterError.value = 'Please select size';
                    } else {
                      societyViewModel.filterError.value = '';
                      var res = await Get.to(
                        () => FullScreenDropDown(
                          title: 'Select Booking Type',
                          items: tradeViewModel
                              .societyModel.value.data!.fileTrendingSocieties!
                              .firstWhere((society) =>
                                  society.id ==
                                  int.parse(
                                      societyViewModel.societyTradeID.value))
                              .fileTrendingSocietyBlocks!
                              .firstWhere((block) =>
                                  block.blockName ==
                                  societyViewModel.societyFilterBlock.value)
                              .fileTrendingSocietySizes!
                              .firstWhere((size) =>
                                  size.sizeName ==
                                  societyViewModel.societyFilterSize.value)
                              .fileTrendingBookingTypes!
                              .map((booking) => booking.bookingPrice)
                              .toList(),
                          selecedItem:
                              societyViewModel.societyFilterBooking.value,
                        ),
                        fullscreenDialog: true,
                      );
                      if (res != null) {
                        societyViewModel.societyFilterBooking.value = res;
                        societyViewModel.societyFilterBookingId.value =
                            tradeViewModel
                                .societyModel.value.data!.fileTrendingSocieties!
                                .firstWhere((society) =>
                                    society.id ==
                                    int.parse(
                                        societyViewModel.societyTradeID.value))
                                .fileTrendingSocietyBlocks!
                                .firstWhere((block) =>
                                    block.blockName ==
                                    societyViewModel.societyFilterBlock.value)
                                .fileTrendingSocietySizes!
                                .firstWhere((size) =>
                                    size.sizeName ==
                                    societyViewModel.societyFilterSize.value)
                                .fileTrendingBookingTypes!
                                .firstWhere(
                                    (booking) => booking.bookingPrice == res)
                                .id
                                .toString();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Row(
              children: [
                Expanded(
                  child: button(
                    title: 'Apply',
                    onPressed: () {
                      Get.back();
                      societyViewModel.societyPagingController.refresh();
                      societyViewModel.societySellPagingController.refresh();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  button({String? title, VoidCallback? onPressed}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.whiteColor,
        border: Border.all(color: AppColor.proimaryColor, width: 0.1),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(5),
        child: Text(
          '$title',
          style: TextStyle(
            color: AppColor.blackColor,
            fontSize: 15,
            letterSpacing: 0.6,
            fontFamily: AppFonts.mulishFont,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
