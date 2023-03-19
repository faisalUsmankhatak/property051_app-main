// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, sort_child_properties_last, prefer_const_constructors, unnecessary_string_interpolations, unused_field, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/cupertino/customdropdown.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../setting/view/setting_view.dart';
import '../../setting/viewmodel/setting_viewmodel.dart';
import '../viewmodel/con_viewmodel.dart';
import 'com.dart';

class AreaCalculatorVeiw extends StatelessWidget {
  var areaViewModel = Get.put(AreaCalculatorViewModel());
  final const_ = Get.put(FullScreeController());
  final __ = Get.put(SettingViewModel());

  AreaCalculatorVeiw() {
    areaViewModel.setup();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundColor,
      child: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Scaffold(
          body: Stack(
            children: [
              body(),
              Obx(
                () => areaViewModel.loading.value
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: Get.height,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                          ),
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  body() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(Get.context!).requestFocus(FocusNode());
      },
      child: ListView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).padding.bottom,
        ),
        children: [
          topDesign(),
          areaWidget1(
            controller: areaViewModel.sqFtController,
            title: 'ft',
            value: 'Square Feet',
            isSquare: true,
            unitId: 1,
          ),
          areaWidget1(
            controller: areaViewModel.sqMController,
            title: 'm',
            value: 'Square Meters',
            isSquare: true,
            unitId: 2,
          ),
          areaWidget1(
            controller: areaViewModel.sqYController,
            title: 'yd',
            value: 'Square Yards',
            isSquare: true,
            unitId: 3,
          ),
          areaWidget1(
            controller: areaViewModel.marrlaController,
            title: 'marla',
            value: 'Marla',
            unitId: 4,
          ),
          areaWidget1(
            controller: areaViewModel.kanalController,
            title: 'kanal',
            value: 'Kanal',
            unitId: 5,
          ),
          areaWidget1(
            controller: areaViewModel.acreController,
            title: 'acre',
            value: 'Acre',
            unitId: 6,
          ),
          buttons(),
          carousalView(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  buttons() {
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.04, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ConverterButton(
              title: 'Clear',
              icon: CupertinoIcons.trash,
              onTap: () {
                FocusScope.of(Get.context!).requestFocus(FocusNode());
                areaViewModel.reset();
                areaViewModel.selectedUnit.value = 0;
              },
            ),
          ),
          Container(
            width: 5,
          ),
          Expanded(
            child: ConverterButton(
              title: 'Screenshot',
              icon: CupertinoIcons.photo_on_rectangle,
              onTap: () {
                FocusScope.of(Get.context!).requestFocus(FocusNode());
                if (!areaViewModel.loading.value) {}
              },
            ),
          ),
          Container(
            width: 5,
          ),
          Expanded(
            child: ConverterButton(
              title: 'Settings',
              icon: CupertinoIcons.settings,
              onTap: () {
                FocusScope.of(Get.context!).requestFocus(FocusNode());
                areaViewModel.reset();
                Get.to(() => SettingView());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ConverterButton extends StatelessWidget {
  String? title;
  Function()? onTap;
  IconData? icon;
  ConverterButton({this.title, this.onTap, this.icon});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: 100,
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: AppColor.greenColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon ?? CupertinoIcons.settings, color: Colors.white),
            const SizedBox(height: 5),
            Text(
              title ?? 'Convert',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.mulishFont,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
