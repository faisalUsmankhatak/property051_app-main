// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import '../../app/model/property/propertymodel.dart';
// import '../../services/api/property.dart';

// class DashBoardViewModel extends GetxController
//     with GetSingleTickerProviderStateMixin {
  // static const pageSize = 10;
  // final PagingController<int, PropertiesData> propertyPagingController =
  //     PagingController(firstPageKey: 0);
  // Rx<PropertyModel> properties = PropertyModel().obs;
//   TabController? tabController;

//   @override
//   void onInit() {
//     super.onInit();
//     tabController = TabController(length: 2, vsync: this);
//     tabController!.addListener(
//       () {},
//     );
    // propertyPagingController.addPageRequestListener(
    //   (pageKey) {
    //     getProperties(pageKey);
    //   },
    // );
//   }

  // getProperties(int pageKey) async {
  //   try {
  //     properties.value = await PropertyService.getProperties();
  //     log(properties.value.data!.properties!.currentPage.toString());
  //     propertyPagingController.appendPage(
  //         properties.value.data!.properties!.data!, pageKey + 1);
  //   } catch (e) {
  //     log('error');
  //   }
  // }
// }
