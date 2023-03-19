// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:property_051/utils/extensions.dart';
import '../../app/model/comment/comment.dart';
import '../../modules/trading/tradeviewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../cachedimage.dart';

class CommentCard extends StatelessWidget {
  final viewModel = Get.find<TradingViewModel>();
  Comment? trade;
  VoidCallback? onTap;
  Function()? onPressed;
  Function()? onProfileTap;
  Function()? onCommentTap;
  CommentCard(
      {this.trade,
      this.onTap,
      this.onPressed,
      this.onProfileTap,
      this.onCommentTap});

  @override
  Widget build(BuildContext context) {
    var formatterDate = DateFormat('yy-MM-dd');
    var date = formatterDate.parse(trade!.createdAt!);
    var displayDate = date.convertToAgo(DateTime.parse(trade!.createdAt!));
    var width = Get.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 8, top: 8, bottom: 12),
        width: width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onProfileTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: commonCacheImageWidget(
                  (trade!.avatar != null && trade!.avatar!.isNotEmpty)
                      ? '${viewModel.todayTradeModel.value.data!.imagePath}/${trade!.avatar!}'
                      : '${viewModel.todayTradeModel.value.data!.defaultImagePath}',
                  40,
                  fit: BoxFit.cover,
                  width: 40,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 0),
                            child: Text(
                              trade!.firstName != null
                                  ? '${trade!.firstName} ${trade!.lastName ?? ''}'
                                  : '051 User',
                              style: TextStyle(
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.mulishFont,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 15),
                          child: Text(
                            '$displayDate',
                            style: TextStyle(
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.normal,
                              fontFamily: AppFonts.mulishFont,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 0, right: 8),
                    child: Text(
                      // 'Hey, I am interested in this trade. Trusted agent of P051. Please contact me. Thanks ',
                      '${trade!.comments}',
                      style: TextStyle(
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.mulishFont,
                        fontSize: 12,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.justify,
                      // maxLines: 4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
