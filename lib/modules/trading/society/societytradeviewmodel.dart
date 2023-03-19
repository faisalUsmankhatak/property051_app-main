import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../app/model/trade/trade.dart';
import '../../../app/model/trade/trademodel.dart';
import '../../../services/api/trade.dart';
import '../../../services/localstorage/SessionManager.dart';

class SocietyTradeViewModel extends GetxController
    with GetTickerProviderStateMixin {
  SessionManager sessionManager = SessionManager();
  TabController? buyRentController;
  final PagingController<int, Trade> societyPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Trade> societySellPagingController =
      PagingController(firstPageKey: 1);
  Rx<TradeModel> todayTradeModel = TradeModel().obs;
  static const pageSize = 10;
  RxString filterError = ''.obs;
  RxString societyTradeID = ''.obs;
  RxString societyFilterBlock = ''.obs;
  RxString societyFilterBlockId = ''.obs;
  RxString societyFilterSize = ''.obs;
  RxString societyFilterSizeId = ''.obs;
  RxString societyFilterBooking = ''.obs;
  RxString societyFilterBookingId = ''.obs;
  @override
  void onInit() {
    super.onInit();
    societyPagingController.addPageRequestListener(
      (pageKey) {
        getSocietyTrade(pageKey);
      },
    );
    societySellPagingController.addPageRequestListener(
      (pageKey) {
        getSocietySellTrade(pageKey);
      },
    );
    buyRentController = TabController(vsync: this, length: 2);
    buyRentController!.addListener(() {
      if (buyRentController!.indexIsChanging) {
        if (buyRentController!.index == 0) {
          societyPagingController.refresh();
        } else {
          societySellPagingController.refresh();
        }
      }
    });
  }

  getSocietyTrade(int pageKey) async {
    try {
      print(societyFilterBookingId);
      todayTradeModel.value = await TradeService.getSocietyTrade(
        pageKey,
        '$societyTradeID',
        purposeID: '1',
        sizeID: '$societyFilterSizeId',
        blockID: '$societyFilterBlockId',
        boookingID: '$societyFilterBookingId',
      );
      bool isLastPage =
          todayTradeModel.value.data!.getNewsFeed!.data!.length < pageSize;
      if (isLastPage) {
        societyPagingController
            .appendLastPage(todayTradeModel.value.data!.getNewsFeed!.data!);
      } else {
        final nextPageKey = pageKey + 1;
        societyPagingController.appendPage(
          todayTradeModel.value.data!.getNewsFeed!.data!,
          nextPageKey,
        );
        log(nextPageKey.toString());
      }
    } catch (e) {
      log('error');
      societyPagingController.error = 'Something went wrong';
    }
  }

  getSocietySellTrade(int pageKey) async {
    try {
      todayTradeModel.value = await TradeService.getSocietyTrade(
        pageKey,
        '$societyTradeID',
        purposeID: '2',
        sizeID: '$societyFilterSizeId',
        blockID: '$societyFilterBlockId',
        boookingID: '$societyFilterBookingId',
      );
      bool isLastPage =
          todayTradeModel.value.data!.getNewsFeed!.data!.length < pageSize;
      if (isLastPage) {
        societySellPagingController
            .appendLastPage(todayTradeModel.value.data!.getNewsFeed!.data!);
      } else {
        final nextPageKey = pageKey + 1;
        societySellPagingController.appendPage(
          todayTradeModel.value.data!.getNewsFeed!.data!,
          nextPageKey,
        );
        log(nextPageKey.toString());
      }
    } catch (e) {
      log('error');
      societySellPagingController.error = 'Something went wrong';
    }
  }

  emptyFilterForm() {
    filterError.value = '';
    societyFilterBlock.value = '';
    societyFilterBlockId.value = '';
    societyFilterSize.value = '';
    societyFilterSizeId.value = '';
    societyFilterBooking.value = '';
    societyFilterBookingId.value = '';
  }
}
