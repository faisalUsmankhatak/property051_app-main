// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:property_051/modules/agency/agencyview.dart';
import 'package:property_051/modules/feedback/feedbackview.dart';
import 'package:property_051/modules/myproperty/mypropertyview.dart';
import 'package:property_051/modules/projects/projectview.dart';
import 'package:property_051/modules/search/filterview.dart';
import 'package:property_051/modules/trading/add/addtrade.dart';
import 'package:property_051/modules/trading/view/tradingview.dart';
import '../modules/addproperty/addpropertyview.dart';
import '../modules/agent/agentview.dart';
import '../modules/areacalculator/areacalculatorview.dart';
import '../modules/auth/signinview.dart';
import '../modules/auth/signup.dart';
import '../modules/auth/welcome.dart';
import '../modules/home/homeview.dart';
import '../modules/prefrences/prefrencesview.dart';
import '../modules/propertydetail/propertydetailview.dart';

import '../modules/splash/splashview.dart';
import '../modules/user/profile/profileview.dart';
import '../routes/approutes.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';

class Property051App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Property051',
      debugShowCheckedModeBanner: false,
      enableLog: true,
      theme: ThemeData(
        fontFamily: AppFonts.mulishFont,
        scaffoldBackgroundColor: AppColor.backgroundColor,
        appBarTheme: AppBarTheme(
          color: AppColor.backgroundColor,
          elevation: 1,
          centerTitle: true,
          toolbarHeight: 50,
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColor.blackColor,
            fontFamily: AppFonts.mulishFont,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: AppColor.proimaryColor,
          unselectedLabelColor: AppColor.bottomBarInactivewColor,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColor.proimaryColor,
            fontFamily: AppFonts.mulishFont,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColor.blackColor,
            fontFamily: AppFonts.mulishFont,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: AppColor.proimaryColor,
              width: 1.5,
            ),
          )),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColor.proimaryColor, //  <-- light color
          textTheme:
              ButtonTextTheme.primary, //  <-- dark text for light background
        ),
      ),
      initialRoute: AppRoutes.home,
      getPages: [
        GetPage(name: AppRoutes.splash, page: () => SplashView()),
        GetPage(
          name: AppRoutes.welcome,
          page: () => WelcomePage(),
          fullscreenDialog: true,
          transition: Transition.cupertinoDialog,
        ),
        GetPage(name: AppRoutes.login, page: () => SignInView()),
        GetPage(name: AppRoutes.signup, page: () => SignUpView()),
        GetPage(name: AppRoutes.home, page: () => HomeView()),
        GetPage(
          name: AppRoutes.propertyDetail,
          page: () => PropertyDetailView(property: Get.arguments),
          arguments: Get.arguments,
          // fullscreenDialog: true,
          transition: Transition.cupertinoDialog,
        ),
        GetPage(name: AppRoutes.projects, page: () => ProjectView()),
        GetPage(name: AppRoutes.agent, page: () => AgentView()),
        GetPage(name: AppRoutes.agency, page: () => AgencyView()),
        GetPage(
          name: AppRoutes.addProperty,
          page: () => AddPropertyView(),
          fullscreenDialog: true,
          transition: Transition.cupertino,
        ),
        GetPage(name: AppRoutes.prefrences, page: () => PrefrencesView()),
        GetPage(
            name: AppRoutes.areaConvertor, page: () => AreaCalculatorVeiw()),
        GetPage(name: AppRoutes.feeBack, page: () => FeedBackView()),
        GetPage(
          name: AppRoutes.filter,
          page: () => FilterView(),
          fullscreenDialog: true,
        ),
        GetPage(name: AppRoutes.tradeview, page: () => TradeView()),
        GetPage(
          name: AppRoutes.addtrade,
          page: () => AddTradeView(),
          fullscreenDialog: true,
        ),
        GetPage(
            name: AppRoutes.getMyProperties, page: () => MyPropertiesView()),
        GetPage(
          name: AppRoutes.userProfile,
          page: () => ProfileView(),
          fullscreenDialog: true,
          transition: Transition.cupertino,
        ),
      ],
      builder: EasyLoading.init(),
    );
  }
}
