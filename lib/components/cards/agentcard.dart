// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/model/agent/agent.dart';
import '../../modules/agent/agentviewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../utils/url_launcher_utils.dart';
import '../cachedimage.dart';

class AgentCard extends StatelessWidget {
  final Agent? agent;
  final VoidCallback? onTap;
  final viewModel = Get.find<AgentViewModel>();

  AgentCard({Key? key, this.agent, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      width: width,
      decoration: const BoxDecoration(
        color: AppColor.whiteColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: commonCacheImageWidget(
              agent!.customerAvatar != null
                  ? '${viewModel.agentModel.value.data!.avatarPath}/${agent!.customerAvatar!}'
                  : 'https://www.property051.com/storage/upload/customer/profile_picture/95daf014-3efb-440f-8753-ffd5c3d53d58.jpg',
              94,
              fit: BoxFit.cover,
              width: 94,
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
                      '${agent!.firstName!} ${agent!.lastName!}',
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
                    Text(
                      '${agent!.agencyName ?? '----'}',
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
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.max,
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
                      '${agent!.totalProperties ?? '----'}',
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
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  height: 0.5,
                  width: double.infinity,
                  color: AppColor.greyColor.withOpacity(0.3),
                ),
                Row(
                  children: [
                    button(
                      width: width / 2.8,
                      height: 35,
                      title: 'Call Agent',
                      color: AppColor.backgroundColor.withOpacity(0.2),
                      onPressed: () {
                        UrlLauncherUtils.launchPhoneUrl(
                          '${agent!.contactNumber}',
                        );
                      },
                    ),
                    SizedBox(width: 8),
                    button(
                      width: width / 4.5,
                      height: 35,
                      title: 'Email',
                      color: AppColor.backgroundColor,
                      showIcon: false,
                      onPressed: () {
                        UrlLauncherUtils.launchEmailUrl(
                          '${agent!.customerEmail}',
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
            // ? Icon(
            //     CupertinoIcons.phone,
            //     size: 20,
            //     color: AppColor.blackColor,
            //   )
            //     : Container(),
            showIcon
                ? Obx(
                    () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1000),
                      transitionBuilder: (child, anim) => RotationTransition(
                        turns: child.key == ValueKey('icon1')
                            ? Tween<double>(begin: 1, end: 1).animate(anim)
                            : Tween<double>(begin: 1, end: 1).animate(anim),
                        child: FadeTransition(opacity: anim, child: child),
                      ),
                      child: viewModel.currIndex.value == 0
                          ? Icon(
                              CupertinoIcons.phone_arrow_up_right,
                              color: AppColor.blackColor,
                              size: 20,
                              key: const ValueKey('icon1'),
                            )
                          : Icon(
                              CupertinoIcons.phone_arrow_up_right,
                              color: AppColor.greenColor,
                              size: 20,
                              key: const ValueKey('icon1'),
                            ),
                    ),
                  )
                : Container(),

            showIcon ? SizedBox(width: 8) : Container(),
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
