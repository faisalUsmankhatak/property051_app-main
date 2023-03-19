// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_051/components/appbar.dart';
import 'package:property_051/modules/addproperty/addpropertyviewmodel.dart';
import 'package:property_051/utils/fonts.dart';
import '../../app/model/location/city.dart';
import '../../app/model/location/location.dart';
import '../../components/cupertino/customdropdown.dart';
import '../../components/cupertino/tileview.dart';
import '../../components/segmentedcontrol/src/tab.dart';
import '../../utils/colors.dart';
import 'searchviewmodel.dart';

class FilterView extends StatelessWidget {
  var searchViewModel = Get.find<SearchViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarFilters(),
      body: body(context),
    );
  }

  body(context) {
    return Container(
      height: Get.height,
      child: ListView(
        controller: searchViewModel.filterController,
        shrinkWrap: true,
        children: [
          segmentControl(
            context,
            searchViewModel.sellOrRentController,
            tabs: [
              SegmentTab(
                label: 'Buy',
                selectedTextColor: AppColor.whiteColor,
                textColor: AppColor.blackColor,
              ),
              SegmentTab(
                label: 'Rent',
                selectedTextColor: AppColor.whiteColor,
                textColor: AppColor.blackColor,
              ),
            ],
          ),
          Obx(
            () => searchViewModel.filterErrorString.value != ''
                ? Column(
                    children: [
                      Text(
                        '${searchViewModel.filterErrorString.value}',
                        style: TextStyle(
                            color: AppColor.proimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                    ],
                  )
                : Container(),
          ),
          Obx(
            () => section(
              child: Column(
                children: [
                  cupertinoTile(
                    icon: customIcon(
                      icon: CupertinoIcons.location_solid,
                      bgColor: AppColor.whiteColor,
                      iconColor: AppColor.facebookColor,
                    ),
                    title: searchViewModel.selectedCity.value != ''
                        ? searchViewModel.selectedCity.value
                        : 'Select City',
                    showIcon: true,
                    onPressed: () async {
                      List<City>? cities = Get.find<AddPropertyViewModel>()
                          .cityModel
                          .data!
                          .cities;

                      var res = await Get.to(
                        () => FullScreenDropDown(
                          title: 'Select City',
                          items: cities!.map((city) => city.name).toList(),
                          selecedItem: searchViewModel.selectedCity.value,
                        ),
                        fullscreenDialog: true,
                      );
                      if (res != null) {
                        searchViewModel.filterErrorString.value = '';
                        searchViewModel.selectedCity.value = res;
                        searchViewModel.selectedCityID.value = cities!
                            .firstWhere((element) => element.name == res)
                            .cityId
                            .toString();
                        searchViewModel.selectedLocation.value = '';
                        searchViewModel.selectedLocationID.value = '';
                      }
                    },
                  ),
                  divider(),
                  cupertinoTile(
                    icon: customIcon(
                      icon: CupertinoIcons.location_solid,
                      bgColor: AppColor.whiteColor,
                      iconColor: AppColor.facebookColor,
                    ),
                    title: searchViewModel.selectedLocation.value != ''
                        ? searchViewModel.selectedLocation.value
                        : 'Select Location',
                    showIcon: true,
                    onPressed: () async {
                      List<Location>? locations =
                          Get.find<AddPropertyViewModel>()
                              .locationModel
                              .data!
                              .locations;
                      if (searchViewModel.selectedCityID.value == '') {
                        searchViewModel.filterErrorString.value =
                            'Please select city first';
                      } else {
                        searchViewModel.filterErrorString.value = '';
                        var res = await Get.to(
                          () => FullScreenDropDown(
                            title: 'Select Location',
                            items: locations!
                                .where((l) =>
                                    l.cityId ==
                                    searchViewModel.selectedCityID.value)
                                .map((location) => location.locationName)
                                .toList(),
                            selecedItem: searchViewModel.selectedCity.value,
                          ),
                          fullscreenDialog: true,
                        );
                        if (res != null) {
                          searchViewModel.selectedLocation.value = res;
                          searchViewModel.selectedLocationID.value = locations!
                              .firstWhere(
                                  (location) => location.locationName == res)
                              .locationId
                              .toString();
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          segmentControl(
            context,
            searchViewModel.propertyTypeController,
            height: 35,
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.blackColor,
            ),
            tabs: [
              SegmentTab(
                label: 'Commercial',
                selectedTextColor: AppColor.whiteColor,
                textColor: AppColor.blackColor,
              ),
              SegmentTab(
                label: 'Residential',
                selectedTextColor: AppColor.whiteColor,
                textColor: AppColor.blackColor,
              ),
              SegmentTab(
                label: 'Plot',
                selectedTextColor: AppColor.whiteColor,
                textColor: AppColor.blackColor,
              ),
            ],
          ),
          section(
            child: Column(
              children: [
                cupertinoTile(
                  icon: customIcon(
                    icon: CupertinoIcons.line_horizontal_3_decrease,
                    bgColor: AppColor.whiteColor,
                    iconColor: AppColor.facebookColor,
                  ),
                  title: 'Property Type',
                  showIcon: true,
                  onPressed: () {
                    Get.to(
                      () => FullScreenDropDown(
                        title: 'Property Type',
                        items: const [
                          'Office',
                          'Shop',
                          'Hotel',
                          'Residential',
                          'Commercial',
                          'Plot',
                        ],
                        selecedItem: 'Hotel',
                      ),
                      fullscreenDialog: true,
                    );
                  },
                ),
              ],
            ),
          ),
          // Get.width < 374 ? Container() : beds(),
          // Get.width < 374 ? Container() : baths(),
          // Container(height: 40),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Row(
              children: [
                Expanded(
                  child: button(title: 'Save Search', onPressed: () {}),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: button(
                    title: 'Apply',
                    onPressed: () {
                      searchViewModel.isFilter.value = true;
                      searchViewModel.propertyPagingController.refresh();
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height / 3),
        ],
      ),
    );
  }

  button({String? title, VoidCallback? onPressed}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.greyColor.withOpacity(0.1),
        border: Border.all(color: AppColor.proimaryColor, width: 0.5),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(5),
        child: Text(
          '$title',
          style: TextStyle(
            color: AppColor.blackColor,
            fontSize: 15,
            letterSpacing: 0.6,
            fontFamily: AppFonts.mulishFont,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  beds() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bedrooms',
            style: TextStyle(
              color: AppColor.blackColor,
              fontSize: 16,
              fontFamily: AppFonts.mulishFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              bedOrBathWidget(title: 'Any'),
              SizedBox(width: 8),
              bedOrBathWidget(title: 'Studio'),
              SizedBox(width: 8),
              bedOrBathWidget(title: '1'),
              SizedBox(width: 8),
              bedOrBathWidget(title: '2'),
              SizedBox(width: 8),
              bedOrBathWidget(title: '3'),
              SizedBox(width: 8),
              bedOrBathWidget(title: '4+'),
            ],
          ),
        ],
      ),
    );
  }

  baths() {
    // log((Get.width * 0.134).toString());
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Batrooms',
            style: TextStyle(
              color: AppColor.blackColor,
              fontSize: 16,
              fontFamily: AppFonts.mulishFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              bedOrBathWidget(title: '1+'),
              SizedBox(width: 8),
              bedOrBathWidget(title: '2+'),
              SizedBox(width: 8),
              bedOrBathWidget(title: '3+'),
              SizedBox(width: 8),
              bedOrBathWidget(title: '4+'),
            ],
          ),
        ],
      ),
    );
  }

  bedOrBathWidget({String? title, VoidCallback? onPressed}) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(5),
        shape: BoxShape.circle,
        color: AppColor.greyColor.withOpacity(0.1),
        border: Border.all(color: AppColor.proimaryColor, width: 0.5),
      ),
      child: Text(
        '$title',
        style: TextStyle(
          color: AppColor.blackColor,
          fontSize: 11,
        ),
      ),
    );
  }
}
