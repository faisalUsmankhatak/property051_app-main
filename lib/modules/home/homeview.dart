// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/approutes.dart';
import '../../services/localstorage/SessionManager.dart';
import '../../utils/colors.dart';
import '../dashboard/dashboardview.dart';
import '../favorite/favoriteview.dart';
import '../more/moreview.dart';
import '../notification/notificationview.dart';
import '../search/searchveiw.dart';
import 'homeviewmodel.dart';

class HomeView extends StatelessWidget {
  final homeViewModel = Get.put(HomeViewModel());
  SessionManager sessionManager = SessionManager();
  List<Widget> data = [
    DashboardView(),
    SearchView(),
    FavoriteView(),
    NotificationView(),
    MoreView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CupertinoTabScaffold(
        controller: homeViewModel.tabController,
        tabBar: CupertinoTabBar(
          activeColor: AppColor.proimaryColor,
          inactiveColor: AppColor.bottomBarInactivewColor,
          iconSize: 27,
          currentIndex: homeViewModel.selectedtab.value,
          onTap: (index) {
            if (index == 2 && sessionManager.getToken() == null) {
              Get.toNamed(AppRoutes.welcome);
              homeViewModel.tabController!.index =
                  homeViewModel.selectedtab.value;
            } else if (index == 3 && sessionManager.getToken() == null) {
              Get.toNamed(AppRoutes.welcome);
              homeViewModel.tabController!.index =
                  homeViewModel.selectedtab.value;
            } else {
              homeViewModel.selectedtab.value = index;
            }
          },
          border: Border(
            top: BorderSide(
              color: AppColor.greyColor.withOpacity(0.4),
            ),
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
              activeIcon: Icon(CupertinoIcons.house_fill),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: "Search",
              activeIcon: Icon(CupertinoIcons.search),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              label: "Favorites",
              activeIcon: Icon(CupertinoIcons.heart_fill),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bell),
              label: "Notifications",
              activeIcon: Icon(CupertinoIcons.bell_fill),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: "More",
              activeIcon: Icon(Icons.more_outlined),
            )
          ],
        ),
        tabBuilder: (context, index) {
          return data[homeViewModel.selectedtab.value];
        },
      ),
    );
  }
}
