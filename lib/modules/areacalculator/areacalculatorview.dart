// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, sort_child_properties_last, prefer_const_constructors, unnecessary_string_interpolations

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/appbar.dart';
import '../../components/cupertino/customdropdown.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'areacalculatorviewmodel.dart';

class AreaCalculatorVeiw extends StatelessWidget {
  var areaViewModel = Get.put(AreaCalculatorViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            Platform.isAndroid ? AppBar().preferredSize.height : 40),
        child: Obx(
          () => appBar1(
            title: 'Area Converter',
            previousTitle: 'Home',
            elevation: areaViewModel.showAppBar.value ? 0.5 : 0.0,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Obx(
          () => ListView(
            controller: areaViewModel.listScrollController,
            children: [
              const SizedBox(height: 0),
              areaWidget(),
              Container(
                margin: EdgeInsets.only(left: 15, right: 18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: conversionWidget(
                            title: 'Sq. Feet',
                            value: double.parse(areaViewModel.sqFt.value),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: conversionWidget(
                            title: 'Sq. Meter',
                            value: double.parse(areaViewModel.sqM.value),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: conversionWidget(
                            title: 'Sq. Yards',
                            value: double.parse(areaViewModel.sqY.value),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: conversionWidget(
                            title: 'Marla',
                            value: double.parse(areaViewModel.marla.value),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: conversionWidget(
                            title: 'Kanal',
                            value: double.parse(areaViewModel.kanal.value),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: conversionWidget(
                            title: 'Acre',
                            value: double.parse(areaViewModel.acre.value),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  areaViewModel.reset();
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15, left: 14, right: 15),
                  decoration: BoxDecoration(
                    color: AppColor.proimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColor.whiteColor,
                      fontFamily: AppFonts.mulishFont,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.5),
            ],
          ),
        ),
      ),
    );
  }

  areaWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      padding: EdgeInsets.only(left: 15),
      height: 45,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        border: Border.all(
          color: AppColor.greyColor.withOpacity(0.7),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: areaViewModel.areaController,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Value',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.greyColor,
                  fontFamily: AppFonts.mulishFont,
                ),
                contentPadding: EdgeInsets.only(left: 0, top: 0, bottom: 6),
              ),
              onChanged: (text) {
                if (text.isNotEmpty) {
                  try {
                    if (double.parse(text) > 0) {
                      // areaViewModel.selectedUnit.value = unitId!;
                      // areaViewModel.convertUnit(
                      //     area: double.parse(controller!.text));
                      areaViewModel.conversionFunc(
                          area:
                              double.parse(areaViewModel.areaController.text));
                    } else {
                      areaViewModel.reset();
                    }
                  } catch (e) {
                    areaViewModel.reset();
                  }
                } else {
                  areaViewModel.reset();
                }
              },
            ),
          ),
          Container(
            height: 50,
            width: 0.5,
            color: AppColor.greyColor.withOpacity(0.7),
          ),
          GestureDetector(
            onTap: () async {
              var res = await Get.to(
                () => FullScreenDropDown(
                  title: 'Unit',
                  items: areaViewModel
                      .areaConverterModel.data!.propertySizeUnits!
                      .map((unit) => unit.fullName)
                      .toList(),
                  selecedItem: areaViewModel.selectedUnit.value,
                ),
                fullscreenDialog: true,
              );
              if (res != null) {
                areaViewModel.selectedUnit.value = res;
                areaViewModel.reset();
              }
            },
            child: Container(
              height: 50,
              width: 120,
              margin: const EdgeInsets.only(right: 10),
              color: Colors.transparent,
              child: Obx(
                () => Text(
                  areaViewModel.selectedUnit.value != ''
                      ? areaViewModel.selectedUnit.value
                      : '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.mulishFont,
                  ),
                ),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }

  conversionWidget({String? title, double? value}) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      height: 70,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        border: Border.all(
          color: AppColor.greyColor.withOpacity(0.7),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$title',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.mulishFont,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${value!.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.mulishFont,
            ),
          ),
        ],
      ),
    );
  }
}
