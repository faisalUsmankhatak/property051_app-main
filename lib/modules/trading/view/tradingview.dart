// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:property_051/modules/trading/detail/tradedetail.dart';
import '../../../app/model/trade/trade.dart';
import '../../../components/appbar.dart';
import '../../../components/cards/tradecard.dart';
import '../../../routes/approutes.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../../utils/global.dart';
import '../component/helper.dart';
import '../personal/personview.dart';
import '../tradeviewmodel.dart';
import 'profileview.dart';

class TradeView extends StatelessWidget {
  var tradeViewModel = Get.put(TradingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: appBar(
        title: 'File Trading',
        previousTitle: 'Home',
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => ProfileView(title: 'My Profile'));
            },
            child: Container(
              margin: EdgeInsets.only(right: 10, bottom: 6, top: 6),
              child: tradeViewModel.customer.image != null
                  ? Container(
                      height: 30,
                      width: 31,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https://www.property051.com/public/storage/upload/customer/profile_picture/${tradeViewModel.customer.image}',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Icon(
                      CupertinoIcons.person_alt_circle_fill,
                      size: 35,
                      color: AppColor.proimaryColor,
                    ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            tabBar(context),
            societyList(),
            Expanded(
              child: TabBarView(
                controller: tradeViewModel.daysController,
                children: [
                  todayTradeList(context),
                  yesterdayList(context),
                  // myTradeList(context),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 43,
        margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),
        decoration: BoxDecoration(
          color: AppColor.proimaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            tradeViewModel.initRentSell();
            Get.toNamed(AppRoutes.addtrade);
          },
          child: Container(
            child: Center(
              child: Text(
                'Start Trading',
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontFamily: AppFonts.mulishFont,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  todayTradeList(context) {
    return Container(
      child: PagedListView<int, Trade>.separated(
        padding: EdgeInsets.only(top: 0, bottom: 10),
        shrinkWrap: true,
        pagingController: tradeViewModel.todayPagingController,
        builderDelegate: PagedChildBuilderDelegate<Trade>(
          itemBuilder: (context, item, index) {
            return TradeCard(
              trade: item,
              onProfileTap: () {
                Get.to(
                  () => PersonTradeView(
                    title: '${item.firstName}',
                    id: item.customerId.toString(),
                  ),
                );
              },
              onCommentTap: () {
                Get.to(
                  () => TradeDetail(trade: item),
                  fullscreenDialog: true,
                  transition: Transition.cupertinoDialog,
                );
              },
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return Center(
              child: GlobalWidet().noInternet(
                message: 'Something went wrong',
                onTap: () {
                  tradeViewModel.getTodayTrade(1);
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
                  kBottomNavigationBarHeight * 4,
              child: const Center(
                child: Text(
                  'No Trades Yet',
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

  yesterdayList(context) {
    return Container(
      child: PagedListView<int, Trade>.separated(
        padding: EdgeInsets.only(top: 0, bottom: 10),
        shrinkWrap: true,
        pagingController: tradeViewModel.yesPagingController,
        builderDelegate: PagedChildBuilderDelegate<Trade>(
          itemBuilder: (context, item, index) {
            return TradeCard(
              trade: item,
              onProfileTap: () {
                Get.to(
                  () => PersonTradeView(
                    title: '${item.firstName}',
                    id: item.customerId.toString(),
                  ),
                );
              },
              onCommentTap: () {
                Get.to(
                  () => TradeDetail(trade: item),
                  fullscreenDialog: true,
                  transition: Transition.cupertinoDialog,
                );
              },
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return Center(
              child: GlobalWidet().noInternet(
                message: 'Something went wrong',
                onTap: () {
                  tradeViewModel.getYesterdayTrade(1);
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
                  kBottomNavigationBarHeight * 3,
              child: const Center(
                child: Text(
                  'No Trades Yet',
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

  myTradeList(context) {
    return Container(
      child: PagedListView<int, Trade>.separated(
        padding: EdgeInsets.only(top: 0, bottom: 10),
        shrinkWrap: true,
        pagingController: tradeViewModel.myPagingController,
        builderDelegate: PagedChildBuilderDelegate<Trade>(
          itemBuilder: (context, item, index) {
            return TradeCard(
              trade: item,
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
