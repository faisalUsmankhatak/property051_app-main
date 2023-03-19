import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_051/app/model/property/favproopertymodel.dart';
import 'package:property_051/services/api/favorite.dart';
import '../../services/localstorage/SessionManager.dart';

class FavoriteViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  SessionManager sessionManager = SessionManager();
  TabController? tabController;
  Rx<FavoritePropertyModel> favoritePropertyModel = FavoritePropertyModel().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(
      () {},
    );
    if (sessionManager.isUserLogin) {
      getFavoriteProperties();
    }
  }

  getFavoriteProperties() async {
    favoritePropertyModel.value = await FavoriteService.getProperties();
  }

  markAsFavorite() async {
    var _ = await FavoriteService.markAsFav(
      customerId: sessionManager.userID,
      propertyId: 1457,
    );
  }
}
