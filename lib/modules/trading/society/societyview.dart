// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:property_051/modules/trading/personal/personview.dart';
import '../../../app/model/trade/trade.dart';
import '../../../components/appbar.dart';
import '../../../components/cards/tradecard.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../../utils/global.dart';
import '../detail/tradedetail.dart';
import '../view/societyfilterview.dart';
import 'component.dart';
import 'societytradeviewmodel.dart';

class SocietyTradeView extends StatelessWidget {
  String? title;
  String? id;
  var tradeViewModel = Get.put(SocietyTradeViewModel());

  SocietyTradeView({required this.title, this.id}) {
    title = title;
    tradeViewModel.societyTradeID.value = id!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: appBar(
        title: '$title',
        previousTitle: 'Trading',
        onTap: () {
          tradeViewModel.emptyFilterForm();
          Get.back();
        },
        actions: [
          Container(
            width: 70,
            child: IconButton(
              onPressed: () {
                Get.to(() => FilterView());
                // Get.toNamed(AppRoutes.addtrade);
                // tradeViewModel.getAllSocieties();
              },
              icon: Text(
                'Filter',
                style: TextStyle(
                  color: AppColor.proimaryColor,
                  fontFamily: AppFonts.mulishFont,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            tabBar(context),
            Expanded(
              child: TabBarView(
                controller: tradeViewModel.buyRentController,
                children: [
                  societyTrade(context),
                  societySellTrade(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  societyTrade(context) {
    return Container(
      child: PagedListView<int, Trade>.separated(
        padding: EdgeInsets.only(top: 0, bottom: 20),
        shrinkWrap: true,
        pagingController: tradeViewModel.societyPagingController,
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
                  tradeViewModel.getSocietyTrade(1);
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

  societySellTrade(context) {
    return Container(
      child: PagedListView<int, Trade>.separated(
        padding: EdgeInsets.only(top: 0, bottom: 20),
        shrinkWrap: true,
        pagingController: tradeViewModel.societySellPagingController,
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
                  tradeViewModel.getSocietyTrade(1);
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
}
