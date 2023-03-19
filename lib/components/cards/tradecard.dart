// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:property_051/app/model/trade/trade.dart';
import 'package:property_051/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../modules/trading/tradeviewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../utils/url_launcher_utils.dart';
import '../cachedimage.dart';

class TradeCard extends StatelessWidget {
  final viewModel = Get.find<TradingViewModel>();
  Trade? trade;
  VoidCallback? onTap;
  Function()? onPressed;
  Function()? onProfileTap;
  Function()? onCommentTap;
  String? noComments;
  TradeCard({
    this.trade,
    this.onTap,
    this.onPressed,
    this.onProfileTap,
    this.onCommentTap,
    this.noComments,
  });

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
                  50,
                  fit: BoxFit.cover,
                  width: 50,
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
                    margin: EdgeInsets.only(top: 0, bottom: 3),
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
                                fontSize: 14,
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
                              fontSize: 11,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        // trade!.contactNo != null
                        //     ? cupertinoButton(trade!.contactNo!)
                        //     : Container(),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          // '${trade!.societyName}\nFiles available : ${trade!.noOfFiles}',
                          '${getTradeTitle()}',
                          style: TextStyle(
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.mulishFont,
                            fontSize: 13,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.justify,
                          // maxLines: 4,
                        ),
                        trade!.description != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 3),
                                  // Divider(color: AppColor.greyColor.withOpacity(0.5)),
                                  Text(
                                    '${trade!.description}',
                                    style: TextStyle(
                                      color: AppColor.greyColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.mulishFont,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(height: 8),
                        // Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (trade!.contactNo != null &&
                                    trade!.contactNo!.isNotEmpty) {
                                  launchUrl(
                                      Uri.parse('tel:${trade!.contactNo}'));
                                } else {
                                  Get.snackbar(
                                    'Whoops',
                                    'Phone number not found',
                                    backgroundColor: AppColor.greenColor,
                                    borderRadius: 0,
                                    // padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                              child: Icon(
                                CupertinoIcons.phone_arrow_up_right,
                                size: 20,
                                color: AppColor.greyColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (trade!.whatsappNumber != null &&
                                    trade!.whatsappNumber!.isNotEmpty) {
                                  // launchUrl(Uri.parse(
                                  //     'https://wa.me/${trade!.whatsappNumber}?text=I want to know more about your trade'));
                                  UrlLauncherUtils.launchWhatsapp(
                                    '${trade!.whatsappNumber}',
                                    text:
                                        'I want to know more about your trade',
                                  );
                                } else {
                                  Get.snackbar(
                                    'Whoops',
                                    'Whatsapp not found',
                                    backgroundColor: AppColor.greenColor,
                                    borderRadius: 0,
                                    // padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                              child: Icon(
                                FontAwesomeIcons.whatsapp,
                                size: 20,
                                color: AppColor.greyColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (trade!.customerEmail != null &&
                                    trade!.customerEmail!.isNotEmpty) {
                                  launchUrl(Uri.parse(
                                      'mailto:${trade!.customerEmail}?subject=I want to know more about your trade'));
                                } else {
                                  Get.snackbar(
                                    'Whoops',
                                    'Email not found',
                                    backgroundColor: AppColor.greenColor,
                                    borderRadius: 0,
                                    // padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                              child: Icon(
                                CupertinoIcons.mail,
                                size: 20,
                                color: AppColor.greyColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: onCommentTap,
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.chat_bubble_text,
                                    size: 18,
                                    color: AppColor.greyColor,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    noComments ?? '${trade!.commentsCount}',
                                    style: TextStyle(
                                      color: AppColor.greyColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.mulishFont,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trade!.status == '1'
                                ? soldedButton()
                                : Container(width: Get.width * 0.23),
                          ],
                        ),
                      ],
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

  String getTradeTitle() {
    var title = '';
    title += '${trade!.societyName}';
    title += '\n${trade!.sizeName} ${trade!.blockName} Plot. ';
    title += '\nBooking Rs. ${trade!.bookingPrice}/-';
    if (trade!.purposeId == 1) {
      title +=
          '\nDemand: ${trade!.demandPrice != null ? trade!.demandPrice : 'Level'}';
    } else if (trade!.demandType == 2) {
      title +=
          '\nDemand: ${trade!.discountPrice}/- Discount (${double.parse(trade!.discountPercent!).toStringAsFixed(2)}%)';
    } else if (trade!.demandType == 3) {
      title +=
          '\nDemand: ${trade!.discountPrice}/- Profit (${double.parse(trade!.discountPercent!).toStringAsFixed(2)}%)';
    } else {
      title += '\nDemand: ${trade!.bookingPrice}/- Level';
    }
    title +=
        '\nFiles ${trade!.purposeId == 2 ? 'Available' : 'Needed'}: ${trade!.noOfFiles}';
    return title;
  }
}

class MyTradeCard extends StatelessWidget {
  final viewModel = Get.find<TradingViewModel>();
  Trade? trade;
  VoidCallback? onTap;
  Function()? onPressed;
  MyTradeCard({this.trade, this.onTap, this.onPressed});

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
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: commonCacheImageWidget(
                (trade!.avatar != null && trade!.avatar!.isNotEmpty)
                    ? '${viewModel.todayTradeModel.value.data!.imagePath}/${trade!.avatar!}'
                    : '${viewModel.todayTradeModel.value.data!.defaultImagePath}',
                50,
                fit: BoxFit.cover,
                width: 50,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 3),
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
                                fontSize: 14,
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
                              fontSize: 11,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        // trade!.contactNo != null
                        //     ? cupertinoButton(trade!.contactNo!)
                        //     : Container(),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          // '${trade!.societyName}\nFiles available : ${trade!.noOfFiles}',
                          '${getTradeTitle()}',
                          style: TextStyle(
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.mulishFont,
                            fontSize: 13,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.justify,
                          // maxLines: 4,
                        ),
                        trade!.description != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 3),
                                  // Divider(color: AppColor.greyColor.withOpacity(0.5)),
                                  Text(
                                    '${trade!.description}',
                                    style: TextStyle(
                                      color: AppColor.greyColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.mulishFont,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(height: 8),
                        // Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (trade!.contactNo != null &&
                                    trade!.contactNo!.isNotEmpty) {
                                  launchUrl(
                                      Uri.parse('tel:${trade!.contactNo}'));
                                } else {
                                  Get.snackbar(
                                    'Whoops',
                                    'Phone number not found',
                                    backgroundColor: AppColor.greenColor,
                                    borderRadius: 0,
                                    // padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                              child: Icon(
                                CupertinoIcons.phone_arrow_up_right,
                                size: 20,
                                color: AppColor.greyColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (trade!.whatsappNumber != null &&
                                    trade!.whatsappNumber!.isNotEmpty) {
                                  // launchUrl(Uri.parse(
                                  //     'https://wa.me/${trade!.whatsappNumber}?text=I want to know more about your trade'));
                                  UrlLauncherUtils.launchWhatsapp(
                                    '${trade!.whatsappNumber}',
                                    text:
                                        'I want to know more about your trade',
                                  );
                                } else {
                                  Get.snackbar(
                                    'Whoops',
                                    'Whatsapp not found',
                                    backgroundColor: AppColor.greenColor,
                                    borderRadius: 0,
                                    // padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                              child: Icon(
                                FontAwesomeIcons.whatsapp,
                                size: 20,
                                color: AppColor.greyColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (trade!.customerEmail != null &&
                                    trade!.customerEmail!.isNotEmpty) {
                                  launchUrl(Uri.parse(
                                      'mailto:${trade!.customerEmail}?subject=I want to know more about your trade'));
                                } else {
                                  Get.snackbar(
                                    'Whoops',
                                    'Email not found',
                                    backgroundColor: AppColor.greenColor,
                                    borderRadius: 0,
                                    // padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                              child: Icon(
                                CupertinoIcons.mail,
                                size: 20,
                                color: AppColor.greyColor,
                              ),
                            ),
                            // Container(),
                            // Container(),
                            trade!.status == '1'
                                ? soldedButton()
                                : cupertinoButton(
                                    onPressed: onPressed,
                                  )
                          ],
                        ),
                      ],
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

  String getTradeTitle() {
    var title = '';
    title += '${trade!.societyName}';
    title += '\n${trade!.sizeName} ${trade!.blockName} Plot. ';
    title += '\nBooking Rs. ${trade!.bookingPrice}/-';
    if (trade!.demandType == 2) {
      title +=
          '\nDemand: ${trade!.discountPrice}/- Discount (${double.parse(trade!.discountPercent!).toStringAsFixed(2)}%)';
    } else if (trade!.demandType == 3) {
      title +=
          '\nDemand: ${trade!.discountPrice}/- Profit (${double.parse(trade!.discountPercent!).toStringAsFixed(2)}%)';
    } else {
      title += '\nDemand: ${trade!.bookingPrice}/- Level';
    }
    title +=
        '\nFiles ${trade!.purposeId == 2 ? 'Available' : 'Needed'}: ${trade!.noOfFiles}';
    return title;
  }
}

cupertinoButton({Function()? onPressed}) {
  return Container(
    height: 20,
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        width: Get.width / 5,
        margin: EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColor.greyColor,
          ),
        ),
        child: Text(
          'Sold',
          style: TextStyle(
            color: AppColor.proimaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.mulishFont,
            fontSize: 12,
          ),
        ),
      ),
    ),
  );
}

soldedButton() {
  return Container(
    height: 20,
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Container(
        width: Get.width / 5,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColor.greyColor, width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 12,
              color: AppColor.proimaryColor,
            ),
            Spacer(),
            Text(
              'Sold Out',
              style: TextStyle(
                color: AppColor.proimaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.mulishFont,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
