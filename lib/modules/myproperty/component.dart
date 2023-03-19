import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import 'mypropertyviewmodel.dart';

const List<String> propertyType = [
  'Approved',
  'Pending',
  'Disapproved',
  'Sold/Rented',
];

propertyTypeList() {
  final myPropertyViewModel = Get.find<MyPropertiesViewModel>();
  return Container(
    height: 40,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppColor.greyColor.withOpacity(0.3),
          width: 0.5,
        ),
      ),
    ),
    child: ListView.separated(
      itemCount: propertyType.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (c, i) {
        return Obx(
          () => propertyTypeItem(
            societyName: propertyType[i],
            onTap: () {
              myPropertyViewModel.page.value = i;
            },
            color: myPropertyViewModel.page.value == i
                ? AppColor.greyColor.withOpacity(0.5)
                : AppColor.whiteColor,
          ),
        );
      },
      separatorBuilder: (c, i) {
        return Container(
          width: 1,
          color: AppColor.greyColor.withOpacity(0.3),
        );
      },
    ),
  );
}

propertyTypeItem({String? societyName, Function()? onTap, Color? color}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      color: color,
      padding: EdgeInsets.only(left: 10, right: 10),
      constraints: BoxConstraints(
        minWidth: Get.width / 4,
      ),
      alignment: Alignment.center,
      child: Text(
        '$societyName',
        style: TextStyle(
          color: AppColor.blackColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
