// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/model/property/propertymodel.dart';
import '../../utils/colors.dart';
import 'helper.dart';
import 'propertydetailviewmodel.dart';

class PropertyDetailView extends StatelessWidget {
  PropertiesData? property;
  var propertyDetailViewModel = Get.put(PropertyDetailViewModel());
  PropertyDetailView({this.property}) {
    propertyDetailViewModel.getPropertyLatLng(property: property);
    propertyDetailViewModel
        .getDetails(property!.property!.propertyId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          property!.property!.title.toString(),
          style: TextStyle(
            color: AppColor.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: Platform.isAndroid ? 50 : 40,
        leadingWidth: 40,
        elevation: 0.4,
        iconTheme: IconThemeData(color: AppColor.proimaryColor),
        actions: [
          IconButton(
            onPressed: () {
              // propertyDetailViewModel.getDetails(property!.property!.propertyId.toString());
            },
            icon: Icon(
              property!.favproperty != null
                  ? property!.favproperty!.length > 0
                      ? Icons.favorite
                      : Icons.favorite_border
                  : Icons.favorite_border,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          imageSlider(property: property),
          Divider(height: 1, color: AppColor.blackColor),
          titlePrice(property: property),
          bedBaths(property: property),
          descWidget(property: property),
          propertyDetailViewModel.latLng != null ? viewOnMap() : Container(),
          contactDetails(property: property),
          SizedBox(height: 20),
          Obx(
            () => propertyDetailViewModel.isLoading.value
                ? Container()
                : amenDetails(),
          ),
          SizedBox(height: kToolbarHeight),
        ],
      ),
    );
  }
}
