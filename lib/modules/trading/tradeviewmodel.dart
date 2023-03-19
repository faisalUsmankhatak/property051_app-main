import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:property_051/app/model/user/customer.dart';
import 'package:property_051/services/localstorage/SessionManager.dart';
import '../../app/model/trade/societymodel.dart';
import '../../app/model/trade/trade.dart';
import '../../app/model/trade/trademodel.dart';
import '../../services/api/trade.dart';

class TradingViewModel extends GetxController with GetTickerProviderStateMixin {
  SessionManager sessionManager = SessionManager();

  Customer customer = Customer();
  TabController? daysController;
  RxBool showAppBar = false.obs;
  ScrollController? addScrollController = ScrollController();
  static const pageSize = 10;
  final PagingController<int, Trade> todayPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Trade> yesPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Trade> myPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Trade> societyTradeController =
      PagingController(firstPageKey: 1);
  Rx<TradeModel> todayTradeModel = TradeModel().obs;
  Rx<TradeModel> yesTradeModel = TradeModel().obs;
  Rx<TradeModel> myTradeModel = TradeModel().obs;
  Rx<TradeModel> societyTradeModel = TradeModel().obs;
  Rx<SocietyModel> societyModel = SocietyModel().obs;
  String todayDate = '';
  String yesDate = '';
  // Add Trade
  late TabController? addTradeController;
  late TabController? addTradeRSController;
  RxBool isRent = true.obs;
  RxBool isAddingTrade = false.obs;
  RxString errorString = ''.obs;
  RxBool showDiscount = false.obs;
  RxBool showProfit = false.obs;
  RxString selectedSociety = ''.obs;
  RxString selectedSocietyId = ''.obs;
  RxString selectedSocietyBlock = ''.obs;
  RxString selectedSocietyBlockId = ''.obs;
  RxString selectedPlotType = ''.obs;
  RxString selectedPlotTypeId = ''.obs;
  RxString selectedSize = ''.obs;
  RxString selectedSizeId = ''.obs;
  RxString selectedBooking = ''.obs;
  RxString selectedBookingId = ''.obs;
  RxString selectedPrice = ''.obs;
  RxDouble percentageDiscount = 0.0.obs;
  RxDouble percentageProfit = 0.0.obs;
  RxInt noOfFiles = 0.obs;
  TextEditingController discPriceController = TextEditingController();
  TextEditingController profitPriceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController demandController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  //SocietyView
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
    initC();
    customer =
        Customer.fromJson(sessionManager.readData(SessionKeys.loginUser));
  }

  initC() async {
    daysController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    initRentSell();
    daysController!.addListener(
      () {
        if (daysController!.indexIsChanging) {
          if (daysController!.index == 0) {
            todayPagingController.refresh();
          } else if (daysController!.index == 1) {
            yesPagingController.refresh();
          }
        }
      },
    );
    addScrollController!.addListener(
      () {
        if (addScrollController!.position.userScrollDirection ==
            ScrollDirection.reverse) {
          showAppBar.value = true;
        } else if (addScrollController!.position.userScrollDirection ==
            ScrollDirection.forward) {
          showAppBar.value = false;
        }
      },
    );
    getAllSocieties();
    getDate();
    todayPagingController.addPageRequestListener(
      (pageKey) {
        getTodayTrade(pageKey);
      },
    );
    yesPagingController.addPageRequestListener(
      (pageKey) {
        getYesterdayTrade(pageKey);
      },
    );
    myPagingController.addPageRequestListener(
      (pageKey) {
        getMyTrade(pageKey);
      },
    );
    initSocietyTrade();
  }

  initSocietyTrade() {
    societyTradeController.addPageRequestListener(
      (pageKey) {
        getocietyTrade(pageKey);
      },
    );
  }

  initAddTrade() {
    addTradeController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
    addTradeController!.addListener(
      () {
        if (addTradeController!.indexIsChanging) {
          if (addTradeController!.index == 0) {
            showDiscount.value = false;
            showProfit.value = false;
          } else if (addTradeController!.index == 1) {
            showDiscount.value = true;
            showProfit.value = false;
          } else if (addTradeController!.index == 2) {
            showDiscount.value = false;
            showProfit.value = true;
          }
        }
      },
    );
  }

  initRentSell() {
    addTradeRSController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    addTradeRSController!.addListener(
      () {
        if (addTradeRSController!.indexIsChanging) {
          emptyForm();
          if (addTradeRSController!.index == 0) {
            isRent.value = true;
          } else if (addTradeRSController!.index == 1) {
            isRent.value = false;
            initAddTrade();
            showProfit.value = false;
            showDiscount.value = false;
          }
        }
      },
    );
    initAddTrade();
  }

  getDate() {
    var now = DateTime.now();
    var formatterDate = DateFormat('20yy-MM-dd');
    todayDate = formatterDate.format(now);
    yesDate = formatterDate.format(now.subtract(Duration(days: 1)));
    // log(todayDate);
    // log(yesDate);
  }

  getAllSocieties() async {
    try {
      societyModel.value = await TradeService.getAllSocieties();
      log(societyModel.value.data!.plotType!.length.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  getTodayTrade(int pageKey) async {
    try {
      todayTradeModel.value = await TradeService.getTodayTrade(
        pageKey,
        todayDate,
      );
      bool isLastPage =
          todayTradeModel.value.data!.getNewsFeed!.data!.length < pageSize;
      if (isLastPage) {
        todayPagingController
            .appendLastPage(todayTradeModel.value.data!.getNewsFeed!.data!);
      } else {
        final nextPageKey = pageKey + 1;
        todayPagingController.appendPage(
          todayTradeModel.value.data!.getNewsFeed!.data!,
          nextPageKey,
        );
        log(nextPageKey.toString());
      }
    } catch (e) {
      log('error');
      todayPagingController.error = 'Something went wrong';
    }
  }

  getYesterdayTrade(int pageKey) async {
    try {
      yesTradeModel.value = await TradeService.getYesterdayTrade(
        pageKey,
        yesDate,
      );
      bool isLastPage =
          yesTradeModel.value.data!.getNewsFeed!.data!.length < pageSize;
      if (isLastPage) {
        yesPagingController
            .appendLastPage(yesTradeModel.value.data!.getNewsFeed!.data!);
      } else {
        final nextPageKey = pageKey + 1;
        yesPagingController.appendPage(
          yesTradeModel.value.data!.getNewsFeed!.data!,
          nextPageKey,
        );
        log(nextPageKey.toString());
      }
    } catch (e) {
      log('error');
      yesPagingController.error = 'Something went wrong';
    }
  }

  getMyTrade(int pageKey) async {
    try {
      myTradeModel.value = await TradeService.getMyTrade(
        pageKey,
      );
      bool isLastPage =
          myTradeModel.value.data!.getNewsFeed!.data!.length < pageSize;
      if (isLastPage) {
        myPagingController
            .appendLastPage(myTradeModel.value.data!.getNewsFeed!.data!);
      } else {
        final nextPageKey = pageKey + 1;
        myPagingController.appendPage(
          myTradeModel.value.data!.getNewsFeed!.data!,
          nextPageKey,
        );
        log(nextPageKey.toString());
      }
    } catch (e) {
      log('error');
      myPagingController.error = 'Something went wrong';
    }
  }

  getocietyTrade(int pageKey) async {
    try {
      societyTradeModel.value = await TradeService.getSocietyTrade(
        pageKey,
        societyTradeID.value,
        blockID: societyFilterBlockId.value,
        sizeID: societyFilterSizeId.value,
        boookingID: societyFilterBookingId.value,
      );
      bool isLastPage =
          societyTradeModel.value.data!.getNewsFeed!.data!.length < pageSize;
      if (isLastPage) {
        societyTradeController
            .appendLastPage(societyTradeModel.value.data!.getNewsFeed!.data!);
      } else {
        final nextPageKey = pageKey + 1;
        societyTradeController.appendPage(
          societyTradeModel.value.data!.getNewsFeed!.data!,
          nextPageKey,
        );
        log(nextPageKey.toString());
      }
    } catch (e) {
      log('error');
      societyTradeController.error = 'Something went wrong';
    }
  }

  Future<bool> postTrade() async {
    try {
      isAddingTrade.value = true;
      var _ = await TradeService.postTrade(
        selectedSocietyId.value,
        selectedSizeId.value,
        selectedBookingId.value,
        noOfFiles.value.toString(),
        priceController.text,
        commentsController.text,
        purposeId: isRent.value ? '1' : '2',
        demandType: (addTradeController!.index + 1).toString(),
        plotType: selectedPlotTypeId.value,
        blockType: selectedSocietyBlockId.value,
        demandPrice: demandController.text,
        discountPrice: addTradeController!.index == 1
            ? discPriceController.text
            : profitPriceController.text,
        discountPercentage: addTradeController!.index == 1
            ? percentageDiscount.value.toStringAsFixed(2)
            : percentageProfit.value.toStringAsFixed(2),
      );
      isAddingTrade.value = false;
      return true;
    } catch (e) {
      log(e.toString());
      isAddingTrade.value = false;
      return false;
    }
  }

  Future<bool> soldTrade(String id) async {
    try {
      var _ = await TradeService.soldTrade('$id');
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  bool validateForm() {
    if (selectedSociety.value.isEmpty) {
      errorString.value = 'Please select society';
      return false;
    } else if (selectedSocietyBlock.value.isEmpty) {
      errorString.value = 'Please select block';
      return false;
    } else if (selectedPlotType.value.isEmpty) {
      errorString.value = 'Please select plot type';
      return false;
    } else if (selectedSize.value.isEmpty) {
      errorString.value = 'Please select size';
      return false;
    } else if (selectedBooking.value.isEmpty) {
      errorString.value = 'Please select booking price';
      return false;
    } else if (addTradeController!.index == 1 &&
        discPriceController.text.isEmpty) {
      errorString.value = 'Please enter discounted price';
      return false;
    } else if (addTradeController!.index == 2 &&
        profitPriceController.text.isEmpty) {
      errorString.value = 'Please enter profit price';
      return false;
    } else if (noOfFiles.value == 0) {
      errorString.value = 'Please select no of files';
      return false;
    } else {
      errorString.value = '';
      return true;
    }
  }

  emptyForm() {
    isRent.value = true;
    selectedSociety.value = '';
    selectedSocietyId.value = '';
    selectedSocietyBlock.value = '';
    selectedSocietyBlockId.value = '';
    selectedPlotType.value = '';
    selectedPlotTypeId.value = '';
    selectedSize.value = '';
    selectedSizeId.value = '';
    selectedBooking.value = '';
    selectedBookingId.value = '';
    priceController.text = '';
    demandController.text = '';
    discPriceController.text = '';
    profitPriceController.text = '';
    percentageDiscount.value = 0;
    percentageProfit.value = 0;
    showDiscount.value = false;
    showProfit.value = false;
    noOfFiles.value = 0;
    commentsController.text = '';
    // addTradeController!.dispose();
    // addTradeRSController!.dispose();
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
