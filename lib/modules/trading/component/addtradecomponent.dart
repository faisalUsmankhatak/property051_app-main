import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/cupertino/customdropdown.dart';
import '../../../components/cupertino/tileview.dart';
import '../../../components/segmentedcontrol/src/tab.dart';
import '../../../components/segmentedcontrol/src/tab_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../tradeviewmodel.dart';

rentSellWidget(context) {
  final tradeViewModel = Get.find<TradingViewModel>();
  return Column(
    children: [
      segmentControlAddTrade(
        context,
        tradeViewModel.addTradeRSController,
        textStyle: TextStyle(
          fontFamily: AppFonts.mulishFont,
          fontSize: 14,
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
      )
    ],
  );
}

topSection() {
  final tradeViewModel = Get.find<TradingViewModel>();
  return section(
    child: Column(
      children: [
        cupertinoTile(
          imagePath: 'images/icons/society.png',
          title: tradeViewModel.selectedSociety.value != ''
              ? tradeViewModel.selectedSociety.value
              : 'Select Society',
          showIcon: true,
          onPressed: () async {
            selectSociety();
          },
        ),
        divider(),
        cupertinoTile(
          imagePath: 'images/icons/block1.png',
          title: tradeViewModel.selectedSocietyBlock.value != ''
              ? tradeViewModel.selectedSocietyBlock.value
              : 'Select Block',
          showIcon: true,
          onPressed: () async {
            selectBlock();
          },
        ),
        divider(),
        cupertinoTile(
          imagePath: 'images/icons/plottype.png',
          title: tradeViewModel.selectedPlotType.value != ''
              ? tradeViewModel.selectedPlotType.value
              : 'Plot Type',
          showIcon: true,
          onPressed: () async {
            selectPlotType();
          },
        ),
        divider(),
        cupertinoTile(
          imagePath: 'images/icons/size.png',
          title: tradeViewModel.selectedSize.value != ''
              ? tradeViewModel.selectedSize.value
              : 'Select Size',
          showIcon: true,
          onPressed: () async {
            selectSize();
          },
        ),
        divider(),
        cupertinoTile(
          imagePath: 'images/icons/price.png',
          title: tradeViewModel.selectedBooking.value != ''
              ? tradeViewModel.selectedBooking.value
              : 'Down Payment',
          showIcon: true,
          onPressed: () async {
            selectBookingType();
          },
        ),
      ],
    ),
  );
}

selectSociety() async {
  final tradeViewModel = Get.find<TradingViewModel>();
  var res = await Get.to(
    () => FullScreenDropDown(
      title: 'Select Society',
      items: tradeViewModel.societyModel.value.data!.fileTrendingSocieties!
          .map((society) => society.societyName)
          .toList(),
      selecedItem: tradeViewModel.selectedSociety.value,
    ),
    fullscreenDialog: true,
  );
  if (res != null) {
    tradeViewModel.selectedSociety.value = res;
    tradeViewModel.selectedSocietyId.value = tradeViewModel
        .societyModel.value.data!.fileTrendingSocieties!
        .firstWhere((society) =>
            society.societyName == tradeViewModel.selectedSociety.value)
        .id
        .toString();
    tradeViewModel.selectedSocietyBlock.value = '';
    tradeViewModel.selectedSocietyBlockId.value = '';
    tradeViewModel.selectedPlotType.value = '';
    tradeViewModel.selectedPlotTypeId.value = '';
    tradeViewModel.selectedSize.value = '';
    tradeViewModel.selectedSizeId.value = '';
    tradeViewModel.selectedBooking.value = '';
    tradeViewModel.selectedBookingId.value = '';
  }
}

selectBlock() async {
  final tradeViewModel = Get.find<TradingViewModel>();
  if (tradeViewModel.selectedSocietyId.value == '') {
    tradeViewModel.errorString.value = 'Please select society';
  } else {
    tradeViewModel.errorString.value = '';
    var res = await Get.to(
      () => FullScreenDropDown(
        title: 'Select Block',
        items: tradeViewModel.societyModel.value.data!.fileTrendingSocieties!
            .firstWhere((society) =>
                society.societyName == tradeViewModel.selectedSociety.value)
            .fileTrendingSocietyBlocks!
            .map((block) => block.blockName)
            .toList(),
        selecedItem: tradeViewModel.selectedSocietyBlock.value,
      ),
      fullscreenDialog: true,
    );
    if (res != null) {
      tradeViewModel.selectedSocietyBlock.value = res;
      tradeViewModel.selectedSocietyBlockId.value = tradeViewModel
          .societyModel.value.data!.fileTrendingSocieties!
          .firstWhere((society) =>
              society.societyName == tradeViewModel.selectedSociety.value)
          .fileTrendingSocietyBlocks!
          .firstWhere((block) =>
              block.blockName == tradeViewModel.selectedSocietyBlock.value)
          .id
          .toString();
      tradeViewModel.selectedPlotType.value = '';
      tradeViewModel.selectedPlotTypeId.value = '';
      tradeViewModel.selectedSize.value = '';
      tradeViewModel.selectedSizeId.value = '';
      tradeViewModel.selectedBooking.value = '';
      tradeViewModel.selectedBookingId.value = '';
    }
  }
}

selectPlotType() async {
  final tradeViewModel = Get.find<TradingViewModel>();
  if (tradeViewModel.selectedSocietyBlockId.value == '') {
    tradeViewModel.errorString.value = 'Please select block';
  } else {
    tradeViewModel.errorString.value = '';
    var res = await Get.to(
      () => FullScreenDropDown(
        title: 'Select Plot Type',
        items: tradeViewModel.societyModel.value.data!.plotType!
            .map((plot) => plot.typeName)
            .toList(),
        selecedItem: tradeViewModel.selectedPlotType.value,
      ),
      fullscreenDialog: true,
    );
    if (res != null) {
      tradeViewModel.selectedPlotType.value = res;
      tradeViewModel.selectedPlotTypeId.value = tradeViewModel
          .societyModel.value.data!.plotType!
          .firstWhere((plot) => plot.typeName == res)
          .plotTypeId
          .toString();
      tradeViewModel.selectedSize.value = '';
      tradeViewModel.selectedSizeId.value = '';
      tradeViewModel.selectedBooking.value = '';
      tradeViewModel.selectedBookingId.value = '';
    }
  }
}

selectSize() async {
  final tradeViewModel = Get.find<TradingViewModel>();
  if (tradeViewModel.selectedPlotTypeId.value == '') {
    tradeViewModel.errorString.value = 'Please select plot type';
  } else {
    tradeViewModel.errorString.value = '';
    var res = await Get.to(
      () => FullScreenDropDown(
        title: 'Select Size',
        items: tradeViewModel.societyModel.value.data!.fileTrendingSocieties!
            .firstWhere((society) =>
                society.societyName == tradeViewModel.selectedSociety.value)
            .fileTrendingSocietyBlocks!
            .firstWhere((block) =>
                block.blockName == tradeViewModel.selectedSocietyBlock.value)
            .fileTrendingSocietySizes!
            .map((size) => size.sizeName)
            .toList(),
        selecedItem: tradeViewModel.selectedSize.value,
      ),
      fullscreenDialog: true,
    );
    if (res != null) {
      tradeViewModel.selectedSize.value = res;
      tradeViewModel.selectedSizeId.value = tradeViewModel
          .societyModel.value.data!.fileTrendingSocieties!
          .firstWhere((society) =>
              society.societyName == tradeViewModel.selectedSociety.value)
          .fileTrendingSocietyBlocks!
          .firstWhere((block) =>
              block.blockName == tradeViewModel.selectedSocietyBlock.value)
          .fileTrendingSocietySizes!
          .firstWhere(
              (size) => size.sizeName == tradeViewModel.selectedSize.value)
          .id
          .toString();
      tradeViewModel.selectedBooking.value = '';
      tradeViewModel.selectedBookingId.value = '';
    }
  }
}

selectBookingType() async {
  final tradeViewModel = Get.find<TradingViewModel>();
  if (tradeViewModel.selectedSizeId.value == '') {
    tradeViewModel.errorString.value = 'Please select size';
  } else {
    tradeViewModel.errorString.value = '';
    var res = await Get.to(
      () => FullScreenDropDown(
        title: 'Select Booking Type',
        items: tradeViewModel.societyModel.value.data!.fileTrendingSocieties!
            .firstWhere((society) =>
                society.societyName == tradeViewModel.selectedSociety.value)
            .fileTrendingSocietyBlocks!
            .firstWhere((block) =>
                block.blockName == tradeViewModel.selectedSocietyBlock.value)
            .fileTrendingSocietySizes!
            .firstWhere(
                (size) => size.sizeName == tradeViewModel.selectedSize.value)
            .fileTrendingBookingTypes!
            .map((booking) => booking.bookingPrice)
            .toList(),
        selecedItem: tradeViewModel.selectedBooking.value,
      ),
      fullscreenDialog: true,
    );
    if (res != null) {
      tradeViewModel.selectedBooking.value = res;
      tradeViewModel.selectedBookingId.value = tradeViewModel
          .societyModel.value.data!.fileTrendingSocieties!
          .firstWhere((society) =>
              society.societyName == tradeViewModel.selectedSociety.value)
          .fileTrendingSocietyBlocks!
          .firstWhere((block) =>
              block.blockName == tradeViewModel.selectedSocietyBlock.value)
          .fileTrendingSocietySizes!
          .firstWhere(
              (size) => size.sizeName == tradeViewModel.selectedSize.value)
          .fileTrendingBookingTypes!
          .firstWhere((booking) =>
              booking.bookingPrice == tradeViewModel.selectedBooking.value)
          .id
          .toString();
      tradeViewModel.selectedPrice.value = tradeViewModel
          .societyModel.value.data!.fileTrendingSocieties!
          .firstWhere((society) =>
              society.societyName == tradeViewModel.selectedSociety.value)
          .fileTrendingSocietyBlocks!
          .firstWhere((block) =>
              block.blockName == tradeViewModel.selectedSocietyBlock.value)
          .fileTrendingSocietySizes!
          .firstWhere(
              (size) => size.sizeName == tradeViewModel.selectedSize.value)
          .fileTrendingBookingTypes!
          .firstWhere((booking) =>
              booking.bookingPrice == tradeViewModel.selectedBooking.value)
          .fullPrice
          .toString();
      tradeViewModel.discPriceController.text = '';
      tradeViewModel.profitPriceController.text = '';
      tradeViewModel.percentageDiscount.value = 0.0;
      tradeViewModel.percentageProfit.value = 0.0;
    }
  }
}

demandWidget(context) {
  final tradeViewModel = Get.find<TradingViewModel>();
  return Column(
    children: [
      segmentControlAddTrade(
        context,
        tradeViewModel.addTradeController,
        textStyle: TextStyle(
          fontFamily: AppFonts.mulishFont,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          SegmentTab(
            label: 'Level',
            selectedTextColor: AppColor.whiteColor,
            textColor: AppColor.blackColor,
          ),
          SegmentTab(
            label: 'Discount',
            selectedTextColor: AppColor.whiteColor,
            textColor: AppColor.blackColor,
          ),
          SegmentTab(
            label: 'Profit',
            selectedTextColor: AppColor.whiteColor,
            textColor: AppColor.blackColor,
          ),
        ],
      )
    ],
  );
}

segmentControlAddTrade(context, TabController? controller,
    {List<SegmentTab>? tabs, TextStyle? textStyle}) {
  return Padding(
    padding: const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
    child: SegmentedTabControl(
      controller: controller,
      radius: const Radius.circular(5),
      backgroundColor: Colors.grey.shade300,
      indicatorColor: AppColor.proimaryColor,
      // indicatorColor: AppColor.proimaryColor,
      selectedTabTextColor: Colors.white,
      squeezeIntensity: 2,
      height: 40,
      tabPadding: const EdgeInsets.symmetric(horizontal: 8),
      textStyle: textStyle ?? Theme.of(context).textTheme.headlineMedium,
      tabs: tabs!,
    ),
  );
}

noOfFiles() {
  final tradeViewModel = Get.find<TradingViewModel>();
  return Container(
    height: 45,
    width: double.infinity,
    margin: EdgeInsets.only(left: 14, right: 15),
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Container(
      padding: EdgeInsets.only(left: 20),
      child: Obx(() => Row(
            children: [
              Text(
                tradeViewModel.noOfFiles.value == 0
                    ? 'Number of Files'
                    : 'Files ${tradeViewModel.isRent.value ? 'Required' : 'Available'} : ${tradeViewModel.noOfFiles.value}',
                style: TextStyle(
                  color: AppColor.blackColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  tradeViewModel.noOfFiles.value++;
                  // if (tradeViewModel.noOfFiles.value > 1) {
                  //   tradeViewModel.noOfFiles.value++;
                  // }
                },
                child: Container(
                  height: double.infinity,
                  width: 45,
                  color: AppColor.greenColor,
                  child: Icon(
                    CupertinoIcons.add,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (tradeViewModel.noOfFiles.value > 0) {
                    tradeViewModel.noOfFiles.value--;
                  }
                },
                child: Container(
                  height: double.infinity,
                  width: 45,
                  decoration: BoxDecoration(
                    color: AppColor.greyColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Icon(
                    CupertinoIcons.minus,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
            ],
          )),
    ),
  );
}

priceField() {
  final tradeViewModel = Get.find<TradingViewModel>();
  return Container(
    height: 50,
    width: double.infinity,
    margin: EdgeInsets.only(left: 14, right: 15),
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: textField(
      maxLines: 1,
      hintText: 'Enter Price',
      controller: tradeViewModel.priceController,
      keyboardType: TextInputType.number,
    ),
  );
}

discountField() {
  final tradeViewModel = Get.find<TradingViewModel>();
  return Container(
    height: 50,
    width: double.infinity,
    margin: EdgeInsets.only(left: 14, right: 15),
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          child: Obx(
            () => textField(
              maxLines: 1,
              hintText: 'Enter Discounted Price',
              controller: tradeViewModel.discPriceController,
              keyboardType: TextInputType.number,
              onChanged: (val) {
                if (val != '') {
                  if (double.parse(val) <
                      double.parse(tradeViewModel.selectedPrice.value)) {
                    tradeViewModel.percentageDiscount.value =
                        (double.parse(val) * 100) /
                            double.parse(tradeViewModel.selectedPrice.value);
                  }
                }
              },
              enabled:
                  tradeViewModel.selectedBooking.value != '' ? true : false,
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: Get.width / 3.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.greyColor.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Obx(
            () => Text(
              '${tradeViewModel.percentageDiscount.value.toStringAsFixed(2)}%',
              style: TextStyle(
                color: AppColor.blackColor,
                fontFamily: AppFonts.mulishFont,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

profitField() {
  final tradeViewModel = Get.find<TradingViewModel>();
  return Container(
    height: 50,
    width: double.infinity,
    margin: EdgeInsets.only(left: 14, right: 15),
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          child: Obx(
            () => textField(
              maxLines: 1,
              hintText: 'Enter Profit Price',
              controller: tradeViewModel.profitPriceController,
              keyboardType: TextInputType.number,
              onChanged: (val) {
                if (val != '') {
                  if (double.parse(val) <
                      double.parse(tradeViewModel.selectedPrice.value)) {
                    tradeViewModel.percentageProfit.value =
                        (double.parse(val) * 100) /
                            double.parse(tradeViewModel.selectedPrice.value);
                  }
                }
              },
              enabled:
                  tradeViewModel.selectedBooking.value != '' ? true : false,
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: Get.width / 3.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.greyColor.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Obx(
            () => Text(
              '${tradeViewModel.percentageProfit.value.toStringAsFixed(2)}%',
              style: TextStyle(
                color: AppColor.blackColor,
                fontFamily: AppFonts.mulishFont,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

demandField() {
  final tradeViewModel = Get.find<TradingViewModel>();
  return Container(
    height: 50,
    width: double.infinity,
    margin: EdgeInsets.only(left: 14, right: 15),
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: textField(
      maxLines: 1,
      hintText: 'Enter Your Demand',
      controller: tradeViewModel.demandController,
      keyboardType: TextInputType.number,
    ),
  );
}

commentField() {
  final tradeViewModel = Get.find<TradingViewModel>();
  return Container(
    height: 100,
    width: double.infinity,
    margin: EdgeInsets.only(left: 14, right: 15),
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: textField(
      maxLines: 4,
      hintText: 'Comments (Optional)',
      controller: tradeViewModel.commentsController,
    ),
  );
}
