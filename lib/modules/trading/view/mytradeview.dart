// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../app/model/trade/trade.dart';
import '../../../components/appbar.dart';
import '../../../components/cards/tradecard.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../../utils/global.dart';
import '../tradeviewmodel.dart';

class MyTradeView extends StatelessWidget {
  var tradeViewModel = Get.find<TradingViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: appBar(
        title: 'My Trades',
        previousTitle: 'Trading',
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: myTradeList(context),
            )
          ],
        ),
      ),
    );
  }

  myTradeList(context) {
    return Container(
      child: PagedListView<int, Trade>.separated(
        padding: EdgeInsets.only(top: 0, bottom: 10),
        shrinkWrap: true,
        pagingController: tradeViewModel.myPagingController,
        builderDelegate: PagedChildBuilderDelegate<Trade>(
          itemBuilder: (context, item, index) {
            return MyTradeCard(
              trade: item,
              onPressed: () async {
                await tradeViewModel.soldTrade(item.id.toString());
                tradeViewModel.myPagingController.refresh();
              },
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return Center(
              child: GlobalWidet().noInternet(
                message: 'Something went wrong',
                onTap: () {
                  tradeViewModel.getMyTrade(1);
                },
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (context) {
            return Container(
              height: Get.height -
                  AppBar().preferredSize.height -
                  kBottomNavigationBarHeight -
                  40,
              child: const Center(
                child: SpinKitFadingCircle(
                  color: AppColor.blackColor,
                  size: 50.0,
                ),
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return Container(
              height: Get.height -
                  AppBar().preferredSize.height -
                  kBottomNavigationBarHeight -
                  40,
              child: const Center(
                child: Text(
                  'No Trades',
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontFamily: AppFonts.mulishFont,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          newPageProgressIndicatorBuilder: (context) {
            return const Center(
              child: SpinKitFadingCircle(
                color: AppColor.blackColor,
                size: 50.0,
              ),
            );
          },
        ),
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
            color: AppColor.greyColor.withOpacity(0.5),
          );
        },
      ),
    );
  }
}
