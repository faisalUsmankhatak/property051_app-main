// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, unused_local_variable

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../viewmodel/con_viewmodel.dart';

topDesign() {
  return Column(
    children: [
      Container(
        color: AppColor.backgroundColor,
        padding: EdgeInsets.only(left: 5, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/converter/pin92 logo app.png',
              height: 80,
              width: 80,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: AppColor.greyColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Text(
          'Property Area Converter',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: AppFonts.mulishFont,
            color: AppColor.whiteColor,
          ),
        ),
      ),
    ],
  );
}

carousalView() {
  return Container(
    margin: EdgeInsets.only(left: 0, right: 0, top: 30),
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      border: Border.all(color: AppColor.greyColor.withOpacity(0.2)),
      borderRadius: BorderRadius.circular(0),
    ),
    child: ImageSlideshow(
      width: Get.width,
      height: Get.width * 0.35,
      initialPage: 0,
      indicatorColor: AppColor.greyColor,
      indicatorBackgroundColor: Colors.black,
      autoPlayInterval: 3000,
      isLoop: true,
      children: [
        imageFromAsset('images/converter/alsadt.png'),
        imageFromAsset('images/converter/king.png'),
        imageFromAsset('images/converter/051.png'),
        imageFromAsset('images/converter/rudn.png'),
      ],
      onPageChanged: (a) {},
    ),
  );
}

imageFromAsset(path) {
  return Image.asset(
    '$path',
    width: Get.width * 0.2,
    height: 70,
    fit: BoxFit.contain,
  );
}

areaWidget1({
  TextEditingController? controller,
  String? title,
  String? value,
  bool? isSquare = false,
  int? unitId = 0,
}) {
  var areaViewModel = Get.find<AreaCalculatorViewModel>();
  return Container(
    padding: EdgeInsets.only(left: 15),
    height: 50,
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      border: Border.all(
        color: AppColor.greyColor.withOpacity(0.7),
        width: 0.2,
      ),
      borderRadius: BorderRadius.circular(0),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.greyColor,
                fontFamily: AppFonts.mulishFont,
              ),
              contentPadding: EdgeInsets.only(left: 0, top: 5, bottom: 0),
            ),
            onChanged: (text) {
              if (text.isNotEmpty) {
                try {
                  if (double.parse(text) > 0) {
                    areaViewModel.selectedUnit.value = unitId!;
                    // areaViewModel.convertUnit(
                    //     area: double.parse(controller!.text));
                    areaViewModel.conversionFunc(
                        area: double.parse(controller!.text));
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
          width: 0.3,
          color: AppColor.greyColor.withOpacity(0.7),
        ),
        GestureDetector(
          onTap: () async {},
          child: Container(
            height: 50,
            width: Get.width / 4,
            margin: const EdgeInsets.only(right: 10),
            padding: EdgeInsets.only(left: 8),
            color: Colors.transparent,
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: title ?? 'marla',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        letterSpacing: 0.3,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppFonts.mulishFont,
                      ),
                    ),
                    isSquare!
                        ? TextSpan(
                            text: '2',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFonts.mulishFont,
                              fontFeatures: [FontFeature.superscripts()],
                            ),
                          )
                        : TextSpan(
                            text: '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFonts.mulishFont,
                              fontFeatures: [FontFeature.superscripts()],
                            ),
                          )
                  ]),
                ),
                Text(
                  value ?? 'Marla',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.mulishFont,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
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

class MyKeyboardTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
