// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, must_be_immutable

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../utils/global.dart';

class FullScreenDropDown extends StatelessWidget {
  final controller = Get.find<FullScreeController>();
  final String? title;
  final Function? onPressed;
  final List? items;
  final String? selecedItem;

  FullScreenDropDown({
    this.title,
    this.onPressed,
    this.items,
    this.selecedItem,
  }) {
    controller.selectedValue.value = selecedItem!;
    controller.items.value = items!;
    controller.searchItems.value = items!;
    controller.searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text(title ?? 'Select'),
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        toolbarHeight: Platform.isAndroid ? kToolbarHeight : 43,
      ),
      body: items!.length != 0
          ? Column(
              children: [
                items!.length > 15 ? searchField() : Container(),
                Obx(
                  () =>
                      controller.isSearching.value ? searchList() : fullList(),
                ),
              ],
            )
          : Center(
              child: Text(
                'No Data Available',
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 16,
                  fontFamily: AppFonts.mulishFont,
                ),
              ),
            ),
    );
  }

  dropDownWidget(item) {
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Get.back(result: item);
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15, right: 20),
          decoration: const BoxDecoration(
            color: AppColor.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$item',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontFamily: AppFonts.mulishFont,
                ),
              ),
              item == selecedItem
                  ? const Icon(
                      CupertinoIcons.checkmark_circle_fill,
                      color: Colors.blue,
                      size: 18,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  searchField() {
    return GlobalWidet().searchField(
      controller: controller.searchController,
      onChange: (t) {
        if (t.isNotEmpty) {
          controller.isSearching.value = true;
          controller.searchItems.value = controller.items
              .where((element) =>
                  element.toString().toLowerCase().contains(t.toLowerCase()))
              .toList();
        } else {
          controller.isSearching.value = false;
        }
      },
    );
  }

  fullList() {
    return Expanded(
      child: ListView.separated(
        itemCount: items!.length,
        itemBuilder: (context, index) {
          return dropDownWidget(items![index]);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            color: AppColor.greyColor,
          );
        },
      ),
    );
  }

  searchList() {
    return Expanded(
      child: ListView.separated(
        itemCount: controller.searchItems.length,
        itemBuilder: (context, index) {
          return dropDownWidget(controller.searchItems[index]);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            color: AppColor.greyColor,
          );
        },
      ),
    );
  }
}

class FullScreeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  var selectedValue = ''.obs;
  var items = [].obs;
  var searchItems = [].obs;
  var isSearching = false.obs;
}
