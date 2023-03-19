// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_051/components/cards/tradecard.dart';
import 'package:property_051/modules/trading/detail/tradedetailviewmodel.dart';
import '../../../app/model/trade/trade.dart';
import '../../../components/cards/commentcard.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';

class TradeDetail extends StatelessWidget {
  Trade? trade;
  final viewModel = Get.put(TradeDetailViewModel());
  TradeDetail({this.trade}) {
    viewModel.trade = trade!;
    viewModel.getComments();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        appBar: appBar(),
        body: body(),
        // bottomNavigationBar: Container(
        //   height: 50,
        //   alignment: Alignment.bottomCenter,
        //   child: TextFormField(
        //     decoration: InputDecoration(
        //       prefixIcon: Icon(Icons.comment_sharp),
        //       hintText: 'Write a comment',
        //       focusedBorder: OutlineInputBorder(
        //         borderSide: BorderSide(
        //           color: Colors.grey,
        //           width: 1,
        //         ),
        //       ),
        //       enabledBorder: OutlineInputBorder(
        //         borderSide: BorderSide(
        //           color: Colors.grey,
        //           width: 1,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  appBar() {
    return AppBar(
      toolbarHeight:
          Platform.isAndroid ? AppBar().preferredSize.height - 5 : 43,
      elevation: 0.3,
      iconTheme: IconThemeData(color: AppColor.blackColor),
      leadingWidth: 40,
      title: Text(
        'Comments',
        style: TextStyle(
          color: AppColor.blackColor,
          fontFamily: AppFonts.mulishFont,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  body() {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(Get.context!).requestFocus(FocusNode());
            },
            child: ListView(
              children: [
                Obx(
                  () => TradeCard(
                    trade: trade,
                    noComments: viewModel.isLoading.value
                        ? null
                        : viewModel
                            .commentModel.value.data!.getComments!.data!.length
                            .toString(),
                  ),
                ),
                Divider(height: 0.3, thickness: 0.5),
                Obx(
                  () => !viewModel.isLoading.value
                      ? commentList()
                      : Container(
                          height: Get.height / 2,
                          child: CupertinoActivityIndicator(),
                        ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            color: AppColor.whiteColor,
            alignment: Alignment.bottomCenter,
            child: TextFormField(
              controller: viewModel.commentController,
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.comment_sharp),
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (viewModel.commentController.text != '') {
                      viewModel.adddComment();
                      viewModel.commentController.clear();
                    } else {
                      Get.snackbar('Error', 'Please write a comment');
                    }
                  },
                  child: Icon(Icons.send),
                ),
                hintText: 'Write a comment',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.greyColor, width: 0.5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  commentList() {
    return viewModel.commentModel.value.data!.getComments!.data!.length > 0
        ? ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                viewModel.commentModel.value.data!.getComments!.data!.length,
            itemBuilder: (context, index) {
              var c =
                  viewModel.commentModel.value.data!.getComments!.data![index];
              return CommentCard(trade: c);
            },
            separatorBuilder: (context, index) {
              return Divider(height: 0.3, thickness: 0.5);
            },
          )
        : Container(
            height: Get.height / 2,
            child: Center(child: Text('No Comments')),
          );
  }
}
