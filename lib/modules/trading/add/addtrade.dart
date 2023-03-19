// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/cupertino/tileview.dart';
import '../../../utils/colors.dart';
import '../component/addtradecomponent.dart';
import '../component/helper.dart';
import '../tradeviewmodel.dart';

class AddTradeView extends StatelessWidget {
  var tradeViewModel = Get.find<TradingViewModel>();

  AddTradeView() {
    tradeViewModel.initAddTrade();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: addTradeAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: body(context),
        ),
      ),
    );
  }

  body(context) {
    return Obx(
      () => ListView(
        controller: tradeViewModel.addScrollController,
        children: [
          SizedBox(height: 8),
          rentSellWidget(context),
          SizedBox(height: 8),
          Obx(
            () => tradeViewModel.errorString.value != ''
                ? Column(
                    children: [
                      Text(
                        '${tradeViewModel.errorString.value}',
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
          topSection(),
          SizedBox(height: 8),
          Obx(
            () => !tradeViewModel.isRent.value
                ? Column(
                    children: [
                      demandWidget(context),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          tradeViewModel.showDiscount.value
                              ? discountField()
                              : Container(),
                          tradeViewModel.showProfit.value
                              ? profitField()
                              : Container(),
                          (tradeViewModel.showDiscount.value ||
                                  tradeViewModel.showProfit.value)
                              ? SizedBox(height: 10)
                              : Container(),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      demandField(),
                      SizedBox(height: 10),
                    ],
                  ),
          ),
          noOfFiles(),
          SizedBox(height: 8),
          commentField(),
          SizedBox(height: 8),
          Obx(
            () => cupertinoButton(
              color: !tradeViewModel.isAddingTrade.value
                  ? AppColor.proimaryColor
                  : AppColor.greyColor,
              title: 'Add Trade',
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (tradeViewModel.validateForm()) {
                  var res = await tradeViewModel.postTrade();
                  if (res) {
                    tradeViewModel.emptyForm();
                    // tradeViewModel.myPagingController.refresh();
                    Get.back();
                  } else {
                    Get.snackbar(
                      'Error',
                      'Something went wrong',
                      backgroundColor: AppColor.proimaryColor,
                      colorText: AppColor.whiteColor,
                    );
                  }
                }
              },
            ),
          ),
          SizedBox(height: Get.height / 5),
        ],
      ),
    );
  }
}
