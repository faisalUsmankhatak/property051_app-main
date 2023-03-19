// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';

class SoialButton extends StatelessWidget {
  String? imagePath;
  IconData? icon;
  String? title;
  Color? textColor;
  Color? backgroundColor;
  Color? iconColor;
  double? radius;
  double? height;
  double? width;
  bool? showIcon;
  VoidCallback? onPressed;
  SoialButton({
    this.imagePath,
    this.icon,
    this.title,
    this.textColor,
    this.backgroundColor,
    this.iconColor,
    this.height = 48,
    this.width,
    this.radius = 25,
    this.showIcon = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return cupertinoTile(
      icon: icon,
      title: title,
      textColor: textColor,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
    );
  }

  cupertinoTile(
      {IconData? icon,
      String? title,
      Color? backgroundColor,
      Color? textColor,
      Color? iconColor}) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: onPressed,
      child: Container(
        height: height,
        width: width ?? Get.width / 1.3,
        padding: EdgeInsets.only(left: imagePath != null ? 0 : 0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius!),
          border: Border.all(color: AppColor.greyColor, width: 0.3),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: showIcon!
                  ? imagePath != null
                      ? Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Image.asset(
                            imagePath!,
                            height: 28,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Icon(
                            icon,
                            color: iconColor,
                            size: 25,
                          ),
                        )
                  : Container(),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: showIcon! ? 35 : 0),
                alignment: Alignment.center,
                child: Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    fontFamily: AppFonts.mulishFont,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
