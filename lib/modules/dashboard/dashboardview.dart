// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/cards/propertycard.dart';
import '../../components/cupertino/tileview.dart';
import '../../components/listloader.dart';
import '../../routes/approutes.dart';
import '../../utils/colors.dart';
import '../addproperty/addpropertyviewmodel.dart';
import '../dashboard/dashboardcontroller.dart';
import '../home/homeviewmodel.dart';

class DashboardView extends StatelessWidget {
  var dashBoardViewModel = Get.put(DashBoardViewModel());

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
            body: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5),
              child: ListView(
                shrinkWrap: true,
                children: [
                  topInfoDashBoard(),
                  Divider(),
                  section(
                    margin: 0,
                    child: cupertinoTile(
                      icon: customIcon(
                        icon: CupertinoIcons.search,
                        bgColor: AppColor.whiteColor,
                        iconColor: AppColor.proimaryColor,
                      ),
                      title: 'Search Properties',
                      showIcon: true,
                      onPressed: () {
                        Get.find<HomeViewModel>().selectedtab.value = 1;
                        Get.find<HomeViewModel>().tabController!.index = 1;
                      },
                    ),
                  ),
                  categoryWidget(),
                  Obx(
                    () => dashBoardViewModel.isLoading.value
                        ? shimmerListLoader(
                            count: 3,
                            height: Get.height * 0.6,
                          )
                        : recentlyViewed(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  categoryWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: category(
                  imagePath: 'images/icons/trading1.png',
                  title: 'File Trading',
                  onTap: () async {
                    if (dashBoardViewModel.sessionManager.isUserLogin) {
                      Get.toNamed(AppRoutes.tradeview);
                    } else {
                      await Get.toNamed(AppRoutes.welcome);
                      if (dashBoardViewModel.sessionManager.isUserLogin) {
                        Get.toNamed(AppRoutes.tradeview);
                      }
                    }
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: category(
                  imagePath: 'images/gif/addPropertyGif.gif',
                  title: 'Add Property',
                  onTap: () async {
                    if (dashBoardViewModel.sessionManager.isUserLogin) {
                      Get.find<AddPropertyViewModel>().initScrolls();
                      Get.toNamed(AppRoutes.addProperty);
                    } else {
                      await Get.toNamed(AppRoutes.welcome);
                      if (dashBoardViewModel.sessionManager.isUserLogin) {
                        Get.find<AddPropertyViewModel>().initScrolls();
                        Get.toNamed(AppRoutes.addProperty);
                      }
                    }
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: category(
                  imagePath: 'images/icons/project2.png',
                  title: 'Projects',
                  onTap: () {
                    Get.toNamed(AppRoutes.projects);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: category(
                  imagePath: 'images/gif/agentGig.gif',
                  title: 'Agents',
                  onTap: () async {
                    Get.toNamed(AppRoutes.agent);
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: category(
                  imagePath: 'images/gif/findAgency2.gif',
                  title: 'Agencies',
                  onTap: () {
                    Get.toNamed(AppRoutes.agency);
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: category(
                  imagePath: 'images/gif/areaConvertor.gif',
                  title: 'Area Converter',
                  onTap: () {
                    Get.toNamed(AppRoutes.areaConvertor);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  recentlyViewed() {
    return Obx(
      () => dashBoardViewModel.properties.isNotEmpty
          ? Container(
              // height: 400,
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          dashBoardViewModel.isLocalProperties.value
                              ? 'Recently Viewed'
                              : 'Popular Properties',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          dashBoardViewModel.deleteRecentProperties();
                        },
                        child: Text(
                          'Clear All',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColor.proimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.separated(
                    padding: EdgeInsets.only(top: 10, bottom: 15),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dashBoardViewModel.properties.length,
                    itemBuilder: (context, index) {
                      var item = dashBoardViewModel.properties[index];
                      return PropertyCard2(
                        property: item,
                        isFav: dashBoardViewModel.sessionManager.isUserLogin
                            ? item.favproperty != null
                                ? item.favproperty!.isNotEmpty
                                    ? true
                                    : false
                                : false
                            : false,
                        showFav: false,
                        onTap: () {
                          Get.toNamed(AppRoutes.propertyDetail,
                              arguments: item);
                          // dashBoardViewModel.getProperties();
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12);
                    },
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
