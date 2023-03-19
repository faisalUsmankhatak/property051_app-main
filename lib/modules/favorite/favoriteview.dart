// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../components/cards/propertycard.dart';
import '../../utils/colors.dart';
import 'favoriteviewmodel.dart';

class FavoriteView extends StatelessWidget {
  var favoriteViewModel = Get.put(FavoriteViewModel());
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.backgroundColor,
            appBar: AppBar(
              toolbarHeight: Platform.isAndroid ? 6 : 0,
              bottom: TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                tabs: const [
                  Tab(
                    child: Text("Properties"),
                  ),
                  Tab(
                    child: Text("Trading"),
                  ),
                ],
                controller: favoriteViewModel.tabController,
                onTap: (tabIndex) {
                  favoriteViewModel.getFavoriteProperties();
                },
              ),
            ),
            body: TabBarView(
              controller: favoriteViewModel.tabController,
              // physics: const NeverScrollableScrollPhysics(),
              children: [
                Obx(
                  () =>
                      favoriteViewModel.favoritePropertyModel.value.data != null
                          ? favProperties()
                          : loader(),
                ),
                favTrading(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loader() {
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
  }

  favProperties() {
    var favP =
        favoriteViewModel.favoritePropertyModel.value.data!.favProperties;
    if (favP!.length < 1) return noProperty();
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
              itemCount: favP.length,
              shrinkWrap: true,
              itemBuilder: (c, i) {
                return PropertyCard2(
                  property: favoriteViewModel.favoritePropertyModel.value.data!
                      .favProperties![i].property,
                  isFav: true,
                );
              },
              separatorBuilder: (context, index) {
                return Container(height: 16);
              },
            ),
          ),
        ],
      ),
    );
  }

  favTrading() {
    return Center(
      child: noTrade(),
    );
  }

  noProperty() {
    return Container(
      height: Get.height - 100 - kToolbarHeight,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/icons/society.png",
              height: 100,
              width: 200,
            ),
            Text(
              'No Favorite Properties Found',
              style: TextStyle(
                fontSize: 20,
                color: AppColor.blackColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'You have not added any property to your favorites',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  noTrade() {
    return Container(
      height: Get.height - 100 - kToolbarHeight,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/icons/trading1.png",
              height: 100,
              // width: 200,
            ),
            Text(
              'No Favorite Trades Found',
              style: TextStyle(
                fontSize: 20,
                color: AppColor.blackColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'You have not added any trades to your favorites',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
