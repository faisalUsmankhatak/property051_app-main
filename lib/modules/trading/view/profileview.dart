// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/appbar.dart';
import '../../../components/cupertino/tileview.dart';
import '../../../utils/colors.dart';
import '../tradeviewmodel.dart';
import 'mytradeview.dart';

class ProfileView extends StatelessWidget {
  String? title;
  var tradeViewModel = Get.find<TradingViewModel>();

  ProfileView({Key? key, required this.title}) : super(key: key);

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
      ),
      body: body(),
    );
  }

  body() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                cupertinoTile(
                  title: 'My Trades',
                  showIcon: true,
                  imagePath: 'images/icons/trading1.png',
                  onPressed: () async {
                    tradeViewModel.myPagingController.refresh();
                    Get.to(() => MyTradeView());
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}
