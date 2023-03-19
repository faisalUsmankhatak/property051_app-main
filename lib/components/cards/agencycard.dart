// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:property_051/app/model/agency/agency.dart';
import '../../modules/agency/agencyviewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../utils/url_launcher_utils.dart';
import '../cachedimage.dart';

class AgencyCard extends StatelessWidget {
  Agency? agency;
  VoidCallback? onTap;
  final viewModel = Get.find<AgencyViewModel>();

  AgencyCard({Key? key, this.agency, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12),
        width: width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.greyColor, width: 0.5),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: commonCacheImageWidget(
                      // 'https://www.property051.com/storage/upload/agencies/logo/94bde633-a8f7-4869-a538-2de8e3578caf.jpg',
                      // 'https://www.property051.com/storage/upload/agencies/logo/961231b3-822c-4c12-965d-e453223cfaf8.jpg',
                      agency!.logo != null
                          ? '${viewModel.agencyModel.value.data!.agencyLogoPath}/${agency!.logo!}'
                          : '${viewModel.agencyModel.value.data!.agencyDefaultImage}',
                      60,
                      fit: BoxFit.contain,
                      width: 60,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '${agency!.name!}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.mulishFont,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 3),
                          rating(totalStars: 5),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'CEO : ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.mulishFont,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                              ),
                              Text(
                                agency!.ceoName != null
                                    ? '${agency!.ceoName!}'
                                    : 'N/A',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.mulishFont,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Text(
                      'Total Properties : ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.mulishFont,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '${agency!.totalProperties}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.mulishFont,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 25),
                  child: Row(
                    children: [
                      Text(
                        'Total Agents : ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.mulishFont,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        '${agency!.totalAgents}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.mulishFont,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              height: 0.5,
              width: double.infinity,
              // color: AppColor.greyColor.withOpacity(0.3),
            ),
            Row(
              children: [
                button(
                  width: width / 3,
                  height: 35,
                  title: 'Call ',
                  showIcon: true,
                  icon: CupertinoIcons.phone_arrow_up_right,
                  color: AppColor.backgroundColor.withOpacity(0.2),
                  onPressed: () {
                    if ((agency!.ceoContact != null &&
                            agency!.ceoContact != '') ||
                        (agency!.mobile1 != null && agency!.mobile1 != '')) {
                      UrlLauncherUtils.launchPhoneUrl(
                        '${agency!.mobile1 != null ? agency!.mobile1 : agency!.ceoContact}',
                      );
                    } else {
                      Get.snackbar(
                        'Sorry',
                        'No contact number found',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColor.backgroundColor,
                      );
                    }
                  },
                ),
                SizedBox(width: 8),
                button(
                  width: width / 3,
                  height: 35,
                  title: 'Whatsapp',
                  color: AppColor.backgroundColor,
                  showIcon: true,
                  icon: FontAwesomeIcons.whatsapp,
                  onPressed: () {
                    UrlLauncherUtils.launchWhatsapp(
                      '${agency!.ceoContact}',
                    );
                  },
                ),
                SizedBox(width: 8),
                button(
                  width: 60,
                  height: 35,
                  title: '',
                  color: AppColor.backgroundColor,
                  showIcon: true,
                  icon: CupertinoIcons.mail,
                  onPressed: () {
                    if ((agency!.ceoEmail != null && agency!.ceoEmail != '') ||
                        agency!.email != null && agency!.email != '') {
                      UrlLauncherUtils.launchEmailUrl(
                        '${agency!.email ?? agency!.ceoEmail}',
                      );
                    } else {
                      Get.snackbar(
                        'Sorry',
                        'No email found',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColor.backgroundColor,
                      );
                    }
                    // UrlLauncherUtils.launchEmailUrl(
                    //   '${agency!.ceoEmail}',
                    // );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  rating({totalStars}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
        totalStars,
        (index) {
          return Container(
            padding: EdgeInsets.only(right: index == totalStars - 1 ? 0 : 3),
            child: Icon(
              Icons.star,
              color: AppColor.greenColor,
              size: 16,
            ),
          );
        },
      ),
    );
  }

  button(
      {double? width,
      double? height,
      String? title,
      Color? color,
      bool showIcon = true,
      IconData? icon,
      VoidCallback? onPressed}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.greyColor.withOpacity(0.5),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(5),
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              showIcon ? CrossAxisAlignment.end : CrossAxisAlignment.center,
          children: [
            // showIcon
            //     ? Obx(
            //         () => AnimatedSwitcher(
            //           duration: const Duration(milliseconds: 1000),
            //           transitionBuilder: (child, anim) => RotationTransition(
            //             turns: child.key == ValueKey('icon1')
            //                 ? Tween<double>(begin: 1, end: 1).animate(anim)
            //                 : Tween<double>(begin: 1, end: 1).animate(anim),
            //             child: FadeTransition(opacity: anim, child: child),
            //           ),
            //           child: viewModel.currIndex.value == 0
            //               ? Icon(
            //                   icon,
            //                   color: AppColor.blackColor,
            //                   size: 20,
            //                   key: const ValueKey('icon1'),
            //                 )
            //               : Icon(
            //                   icon,
            //                   color: AppColor.greenColor,
            //                   size: 20,
            //                   key: const ValueKey('icon1'),
            //                 ),
            //         ),
            //       )
            //     : Container(),
            showIcon
                ? Icon(
                    icon,
                    color: AppColor.blackColor,
                    size: 20,
                    key: const ValueKey('icon1'),
                  )
                : Container(),
            showIcon ? SizedBox(width: title != '' ? 8 : 0) : Container(),
            Text(
              '$title',
              style: TextStyle(
                color: AppColor.proimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.mulishFont,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
