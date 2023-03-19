// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../app/model/project/project.dart';
import '../../modules/projects/projectviewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../utils/url_launcher_utils.dart';
import '../../utils/utilities.dart';
import '../cachedimage.dart';

class ProjectCard extends StatelessWidget {
  final viewModel = Get.find<ProjectViewModel>();
  Project? project;
  VoidCallback? onTap;
  ProjectCard({this.project, this.onTap});

  @override
  Widget build(BuildContext context) {
    var width = Get.width;

    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: width,
      decoration: const BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: commonCacheImageWidget(
              project!.frontPageImage != null
                  ? '${viewModel.projects.value.data!.projectsImagesPath}/${project!.frontPageImage}'
                  : 'https://www.property051.com/storage/upload/projects/9643c74a-696f-4b55-8938-772d414461ae.jpg',
              width / 3.5,
              fit: BoxFit.cover,
              width: width / 3.5,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '${project!.title}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.mulishFont,
                      height: 1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 0),
                Container(
                  child: Text(
                    '${project!.address}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.mulishFont,
                      height: 1.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'PKR ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.mulishFont,
                        ),
                      ),
                      Text(
                        '${getFriendlyPrice(int.parse(project!.investmentMinAmount!.toString()))} to ${getFriendlyPrice(int.parse(project!.investmentMaxAmount!.toString()))}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.mulishFont,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    button(
                      width: 110,
                      height: 30,
                      title: 'Call',
                      color: AppColor.backgroundColor.withOpacity(0.2),
                      onPressed: () {
                        UrlLauncherUtils.launchPhoneUrl(
                          '${(project!.companyContactno != null && project!.companyContactno != '') ? project!.companyContactno : project!.projectManagerContactno}',
                        );
                      },
                    ),
                    SizedBox(width: 8),
                    button(
                      width: width / 4.5,
                      height: 30,
                      title: 'Email',
                      color: AppColor.backgroundColor,
                      showIcon: false,
                      onPressed: () {
                        if (project!.companyEmail != null &&
                            project!.companyEmail != '') {
                          UrlLauncherUtils.launchEmailUrl(
                            '${project!.companyEmail}',
                          );
                        } else {
                          Get.snackbar(
                            'Sorry',
                            'No email found',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppColor.backgroundColor,
                          );
                        }
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
            showIcon
                ? Icon(
                    CupertinoIcons.phone,
                    size: 20,
                    color: AppColor.blackColor,
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

class ProjectCard2Copy extends StatelessWidget {
  final viewModel = Get.find<ProjectViewModel>();
  VoidCallback? onTap;
  ProjectCard2Copy({this.onTap});

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: width,
      decoration: const BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: commonCacheImageWidget(
              'https://www.property051.com/storage/upload/projects/9643c74a-696f-4b55-8938-772d414461ae.jpg',
              width / 3.5,
              fit: BoxFit.cover,
              width: width / 3.5,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: const Text(
                    'Pine Terraces Murree',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.mulishFont,
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                Container(
                  child: const Text(
                    'Murree Expressway, Murree',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.mulishFont,
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'PKR ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.mulishFont,
                        ),
                      ),
                      Text(
                        '${getFriendlyPrice(2000000)} to ${getFriendlyPrice(6000000)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.mulishFont,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    button(
                      width: 110,
                      height: 30,
                      title: 'Call',
                      color: AppColor.backgroundColor.withOpacity(0.2),
                      onPressed: () {},
                    ),
                    SizedBox(width: 8),
                    button(
                      width: width / 4.5,
                      height: 30,
                      title: 'Email',
                      color: AppColor.backgroundColor,
                      showIcon: false,
                      onPressed: () {},
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
            showIcon
                ? Icon(
                    CupertinoIcons.phone,
                    size: 20,
                    color: AppColor.blackColor,
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
