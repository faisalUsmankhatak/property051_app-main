import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/cupertino/customdropdown.dart';
import '../../components/cupertino/tileview.dart';
import '../../components/segmentedcontrol/src/tab.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'addpropertyviewmodel.dart';

addPropertyAppBar() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return PreferredSize(
    preferredSize: Size.fromHeight(Platform.isAndroid ? 40 : 43),
    child: Obx(
      () => AppBar(
        backgroundColor: addPropertyViewModel.showAppBar.value
            ? Colors.white70.withOpacity(0.9)
            : AppColor.backgroundColor,
        elevation: addPropertyViewModel.showAppBar.value ? 0.5 : 0.0,
        leading: InkWell(
          onTap: () {
            addPropertyViewModel.resetForm();
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.only(left: 15, top: 12),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColor.blackColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        leadingWidth: 80,
        title: Text(
          'List Your Property',
          style: TextStyle(
            color: AppColor.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.mulishFont,
          ),
        ),
      ),
    ),
  );
}

topWidget(context) {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Obx(
    () => Column(
      children: [
        errorWidget(),
        segmentControl(
          context,
          addPropertyViewModel.sellOrRentController,
          tabs: [
            SegmentTab(
              label: 'Sell',
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
        section(
          child: Column(
            children: [
              cupertinoTile(
                icon: customIcon(
                  icon: CupertinoIcons.location_solid,
                  bgColor: AppColor.whiteColor,
                  iconColor: AppColor.facebookColor,
                ),
                title: addPropertyViewModel.selectedCity.value != ''
                    ? addPropertyViewModel.selectedCity.value
                    : 'Select City',
                showIcon: true,
                onPressed: () async {
                  if (addPropertyViewModel.cityModel.data == null) {
                    addPropertyViewModel.errorString.value =
                        'Please wait while we are fetching data';
                  } else {
                    addPropertyViewModel.errorString.value = '';
                    var res = await Get.to(
                      () => FullScreenDropDown(
                        title: 'Select City',
                        items: addPropertyViewModel.cityModel.data!.cities!
                            .map((city) => city.name)
                            .toList(),
                        selecedItem: addPropertyViewModel.selectedCity.value,
                      ),
                      fullscreenDialog: true,
                    );
                    if (res != null) {
                      addPropertyViewModel.selectedCity.value = res;
                      addPropertyViewModel.selectedCityID.value =
                          addPropertyViewModel.cityModel.data!.cities!
                              .firstWhere((city) => city.name == res)
                              .cityId
                              .toString();
                      addPropertyViewModel.selectedLocation.value = '';
                      addPropertyViewModel.selectedLocationID.value = '';
                      addPropertyViewModel.selectedSubLocation.value = '';
                      addPropertyViewModel.selectedSubLocationID.value = '';
                      addPropertyViewModel.showSubLocation.value = false;
                    }
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
                title: addPropertyViewModel.selectedLocation.value != ''
                    ? addPropertyViewModel.selectedLocation.value
                    : 'Select Location',
                showIcon: true,
                onPressed: () async {
                  if (addPropertyViewModel.selectedCity.value == '') {
                    addPropertyViewModel.errorString.value =
                        'Please select city first';
                  } else {
                    print(addPropertyViewModel.locationModel.data!.locations!
                        .where((location) =>
                            location.cityId ==
                            addPropertyViewModel.selectedCityID.value)
                        .map((l) => l.locationName)
                        .toList()
                        .length);
                    var res = await Get.to(
                      () => FullScreenDropDown(
                        title: 'Select Location',
                        items: addPropertyViewModel
                            .locationModel.data!.locations!
                            .where((location) =>
                                location.cityId ==
                                addPropertyViewModel.selectedCityID.value)
                            .map((l) => l.locationName)
                            .toList(),
                        selecedItem:
                            addPropertyViewModel.selectedLocation.value,
                      ),
                      fullscreenDialog: true,
                    );
                    if (res != null) {
                      var location = addPropertyViewModel
                          .locationModel.data!.locations!
                          .firstWhere((l) => l.locationName == res);
                      addPropertyViewModel.selectedLocation.value = res;
                      // addPropertyViewModel.latLng = LatLng(
                      //   double.parse(location.latitude.toString()),
                      //   double.parse(location.longitude.toString()),
                      // );
                      // addPropertyViewModel.addMarker();
                      // addPropertyViewModel.mapController!.animateCamera(
                      //   CameraUpdate.newLatLng(addPropertyViewModel.latLng!),
                      // );
                      addPropertyViewModel.selectedLocationID.value =
                          location.locationId.toString();
                      addPropertyViewModel.selectedSubLocation.value = '';
                      addPropertyViewModel.selectedSubLocationID.value = '';
                      for (var s in addPropertyViewModel
                          .subLocationModel.data!.subLocations!) {
                        if (s.locationId ==
                            int.parse(addPropertyViewModel
                                .selectedLocationID.value)) {
                          addPropertyViewModel.showSubLocation.value = true;
                          break;
                        } else {
                          addPropertyViewModel.showSubLocation.value = false;
                        }
                      }
                    }
                  }
                },
              ),
              addPropertyViewModel.showSubLocation.value
                  ? Column(
                      children: [
                        divider(),
                        cupertinoTile(
                          icon: customIcon(
                            icon: CupertinoIcons.location_solid,
                            bgColor: AppColor.whiteColor,
                            iconColor: AppColor.facebookColor,
                          ),
                          title: addPropertyViewModel
                                      .selectedSubLocation.value !=
                                  ''
                              ? addPropertyViewModel.selectedSubLocation.value
                              : 'Select Sub Location / Place',
                          showIcon: true,
                          onPressed: () async {
                            if (addPropertyViewModel.selectedLocation.value ==
                                '') {
                              addPropertyViewModel.errorString.value =
                                  'Please select location first';
                            } else {
                              var res = await Get.to(
                                () => FullScreenDropDown(
                                  title: 'Select Sub Location',
                                  items: addPropertyViewModel
                                      .subLocationModel.data!.subLocations!
                                      .where((subLocation) =>
                                          subLocation.locationId ==
                                          int.parse(addPropertyViewModel
                                              .selectedLocationID.value))
                                      .map((l) => l.name)
                                      .toList(),
                                  selecedItem: addPropertyViewModel
                                      .selectedSubLocation.value,
                                ),
                                fullscreenDialog: true,
                              );
                              if (res != null) {
                                addPropertyViewModel.selectedSubLocation.value =
                                    res;
                                addPropertyViewModel
                                        .selectedSubLocationID.value =
                                    addPropertyViewModel
                                        .subLocationModel.data!.subLocations!
                                        .firstWhere((subLocation) =>
                                            subLocation.name == res)
                                        .id
                                        .toString();
                              }
                            }
                          },
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        segmentControl(
          context,
          addPropertyViewModel.propertyTypeController,
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.blackColor,
            fontFamily: AppFonts.mulishFont,
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
                title: addPropertyViewModel.selectedPropertySubType.value != ''
                    ? addPropertyViewModel.selectedPropertySubType.value
                    : 'Property Subtype',
                showIcon: true,
                onPressed: () async {
                  if (addPropertyViewModel.proopertySubTypeModel.data == null) {
                    addPropertyViewModel.errorString.value =
                        'Please wait while we are fetching data';
                  } else {
                    addPropertyViewModel.errorString.value = '';
                    var res = await Get.to(
                      () => FullScreenDropDown(
                        title: 'Property Subtype',
                        items: addPropertyViewModel
                            .proopertySubTypeModel.data!.propertySubtypes!
                            .where((p) =>
                                p.propertyTypeId ==
                                addPropertyViewModel
                                    .selectedPropertyTypeID.value)
                            .map((type) => type.name)
                            .toList(),
                        selecedItem:
                            addPropertyViewModel.selectedPropertySubType.value,
                      ),
                      fullscreenDialog: true,
                    );
                    if (res != null) {
                      addPropertyViewModel.selectedPropertySubType.value = res;
                      addPropertyViewModel.selectedPropertySubTypeID.value =
                          addPropertyViewModel
                              .proopertySubTypeModel.data!.propertySubtypes!
                              .firstWhere((type) => type.name == res)
                              .subPropertyTypeId
                              .toString();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

mapView() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Container(
    margin: EdgeInsets.only(left: 14, right: 17, top: 8),
    height: 150,
    width: Get.width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Obx(
        () => (addPropertyViewModel.latLng != null &&
                addPropertyViewModel.markers.value.length > 0)
            ? GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: addPropertyViewModel.latLng!,
                  zoom: 15,
                ),
                onMapCreated: addPropertyViewModel.onMapCreated,
                markers:
                    Set<Marker>.of(addPropertyViewModel.markers.value.values),
              )
            : Container(),
      ),
    ),
  );
}

areaWidget() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Container(
    margin: EdgeInsets.only(left: 14, right: 14, top: 16),
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
            keyboardType: TextInputType.number,
            controller: addPropertyViewModel.areaController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Area size',
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.greyColor,
                fontFamily: AppFonts.mulishFont,
              ),
              contentPadding: EdgeInsets.only(left: 0, top: 0, bottom: 6),
            ),
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
                items: addPropertyViewModel
                    .areaConverterModel.data!.propertySizeUnits!
                    .map((unit) => unit.fullName)
                    .toList(),
                selecedItem: addPropertyViewModel.selectedSizeUnit.value,
              ),
              fullscreenDialog: true,
            );
            if (res != null) {
              addPropertyViewModel.selectedSizeUnit.value = res;
              addPropertyViewModel.selectedSizeUnitID.value =
                  addPropertyViewModel
                      .areaConverterModel.data!.propertySizeUnits!
                      .firstWhere((unit) => unit.fullName == res)
                      .unitId
                      .toString();
            }
          },
          child: Container(
            height: 50,
            width: 120,
            margin: EdgeInsets.only(right: 10),
            color: Colors.transparent,
            child: Obx(
              () => Text(
                addPropertyViewModel.selectedSizeUnit.value != ''
                    ? addPropertyViewModel.selectedSizeUnit.value
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

priceWidget() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Container(
    margin: EdgeInsets.only(left: 14, right: 14, top: 16),
    // padding: EdgeInsets.only(left: 15),
    height: 51,
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      border: Border.all(
        color: AppColor.greyColor.withOpacity(0.7),
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        textField(
          controller: addPropertyViewModel.priceController,
          hintText: 'Total Price in (PKR)*',
          maxLines: 1,
          keyboardType: TextInputType.number,
        ),
      ],
    ),
  );
}

bedBathWidget() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Obx(
    () => addPropertyViewModel.bedBathCheck.value
        ? Container(
            margin: EdgeInsets.only(top: 12),
            child: Column(
              children: [
                section(
                  child: Column(
                    children: [
                      cupertinoTile(
                        icon: customIcon(
                          icon: CupertinoIcons.bed_double,
                          bgColor: AppColor.whiteColor,
                          iconColor: AppColor.facebookColor,
                        ),
                        title: addPropertyViewModel.selectedBedrooms.value != ''
                            ? 'Bedrooms - ${addPropertyViewModel.selectedBedrooms.value}'
                            : 'Bedrooms',
                        showIcon: true,
                        onPressed: () async {
                          var res = await Get.to(
                            () => FullScreenDropDown(
                              title: 'Select Bedrooms',
                              items: const [
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6',
                                '7',
                                '8',
                                '9',
                                '10',
                              ],
                              selecedItem:
                                  addPropertyViewModel.selectedBedrooms.value,
                            ),
                            fullscreenDialog: true,
                          );
                          if (res != null) {
                            addPropertyViewModel.selectedBedrooms.value = res;
                          }
                        },
                      ),
                      divider(),
                      cupertinoTile(
                        icon: customIcon(
                          icon: Icons.bathtub_outlined,
                          bgColor: AppColor.whiteColor,
                          iconColor: AppColor.facebookColor,
                        ),
                        title: addPropertyViewModel.selectedBaths.value != ''
                            ? 'Baths - ${addPropertyViewModel.selectedBaths.value}'
                            : 'Baths',
                        showIcon: true,
                        onPressed: () async {
                          var res = await Get.to(
                            () => FullScreenDropDown(
                              title: 'Select Baths',
                              items: const [
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                              ],
                              selecedItem:
                                  addPropertyViewModel.selectedBaths.value,
                            ),
                            fullscreenDialog: true,
                          );
                          if (res != null) {
                            addPropertyViewModel.selectedBaths.value = res;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(),
  );
}

tile(item) {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 14, right: 14, top: 0),
        padding: const EdgeInsets.only(left: 8, right: 8),
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$item',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.blackColor,
                fontFamily: AppFonts.mulishFont,
              ),
            ),
            Obx(
              () => CupertinoSwitch(
                activeColor: AppColor.proimaryColor,
                value: addPropertyViewModel.installmentCheck.value,
                onChanged: (value) {
                  addPropertyViewModel.installmentCheck.value = value;
                  if (!value) {
                    addPropertyViewModel.installmentPlan.value = '';
                    addPropertyViewModel.installmentDownPay.value = '';
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

installmentSection() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Obx(
    () => addPropertyViewModel.showInstallment.value
        ? Container(
            margin: EdgeInsets.only(top: 12),
            child: Column(
              children: [
                tile('Installment available'),
                addPropertyViewModel.installmentCheck.value
                    ? section(
                        child: Column(
                          children: [
                            cupertinoTile(
                              icon: customIcon(
                                icon: CupertinoIcons.calendar,
                                bgColor: AppColor.whiteColor,
                                iconColor: AppColor.facebookColor,
                              ),
                              title: addPropertyViewModel
                                          .installmentPlan.value !=
                                      ''
                                  ? 'Plan - ${addPropertyViewModel.installmentPlan.value}'
                                  : 'Installment Plan',
                              showIcon: true,
                              onPressed: () async {
                                var res = await Get.to(
                                  () => FullScreenDropDown(
                                    title: 'Select Plan',
                                    items: const [
                                      '1 Year',
                                      '2 Years',
                                      '3 Years',
                                      '4 Years',
                                      '5 Years',
                                    ],
                                    selecedItem: addPropertyViewModel
                                        .installmentPlan.value,
                                  ),
                                  fullscreenDialog: true,
                                );
                                if (res != null) {
                                  addPropertyViewModel.installmentPlan.value =
                                      res;
                                }
                              },
                            ),
                            divider(),
                            cupertinoTile(
                              icon: customIcon(
                                icon: CupertinoIcons.money_dollar_circle,
                                bgColor: AppColor.whiteColor,
                                iconColor: AppColor.facebookColor,
                              ),
                              title: addPropertyViewModel
                                          .installmentDownPay.value !=
                                      ''
                                  ? 'Downpayment - ${addPropertyViewModel.installmentDownPay.value}'
                                  : 'Installment Downpayment',
                              showIcon: true,
                              onPressed: () async {
                                var res = await Get.to(
                                  () => FullScreenDropDown(
                                    title: 'Select Plan',
                                    items: const [
                                      '10%',
                                      '15%',
                                      '20%',
                                      '25%',
                                      '30%',
                                      '35%',
                                      '50%',
                                    ],
                                    selecedItem: addPropertyViewModel
                                        .installmentDownPay.value,
                                  ),
                                  fullscreenDialog: true,
                                );
                                if (res != null) {
                                  addPropertyViewModel
                                      .installmentDownPay.value = res;
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          )
        : Container(),
  );
}

rentalSection() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Obx(
    () => addPropertyViewModel.showRentalComponent.value
        ? Container(
            margin: EdgeInsets.only(top: 12),
            child: Column(
              children: [
                securityDepositField(),
                section(
                  child: Column(
                    children: [
                      cupertinoTile(
                        icon: customIcon(
                          icon: CupertinoIcons.calendar,
                          bgColor: AppColor.whiteColor,
                          iconColor: AppColor.facebookColor,
                        ),
                        title: addPropertyViewModel.minContractDuration.value !=
                                ''
                            ? 'Min Contract - ${addPropertyViewModel.minContractDuration.value}'
                            : 'Min Contract Duration*',
                        showIcon: true,
                        onPressed: () async {
                          var res = await Get.to(
                            () => FullScreenDropDown(
                              title: 'Select Contract Duration',
                              items: const [
                                '3 months',
                                '6 months',
                                '12 months',
                                '24 months',
                                '36 months',
                              ],
                              selecedItem: addPropertyViewModel
                                  .minContractDuration.value,
                            ),
                            fullscreenDialog: true,
                          );
                          if (res != null) {
                            addPropertyViewModel.minContractDuration.value =
                                res;
                          }
                        },
                      ),
                      divider(),
                      cupertinoTile(
                        icon: customIcon(
                          icon: CupertinoIcons.calendar,
                          bgColor: AppColor.whiteColor,
                          iconColor: AppColor.facebookColor,
                        ),
                        title: addPropertyViewModel
                                    .advancePaymentDuration.value !=
                                ''
                            ? 'Advance Payment - ${addPropertyViewModel.advancePaymentDuration.value}'
                            : 'Advance Payment Duration*',
                        showIcon: true,
                        onPressed: () async {
                          var res = await Get.to(
                            () => FullScreenDropDown(
                              title: 'Select Advance Payment',
                              items: const [
                                '1 month',
                                '2 months',
                                '3 months',
                                '4 months',
                                '5 months',
                                '6 months',
                                '7 months',
                                '8 months',
                                '9 months',
                                '10 months',
                                '11 months',
                                '12 months',
                              ],
                              selecedItem: addPropertyViewModel
                                  .advancePaymentDuration.value,
                            ),
                            fullscreenDialog: true,
                          );
                          if (res != null) {
                            addPropertyViewModel.advancePaymentDuration.value =
                                res;
                          }
                        },
                      ),
                      divider(),
                      cupertinoTile(
                        icon: customIcon(
                          icon: CupertinoIcons.money_dollar_circle,
                          bgColor: AppColor.whiteColor,
                          iconColor: AppColor.facebookColor,
                        ),
                        title: addPropertyViewModel.maintenanceCharges.value !=
                                ''
                            ? 'Charges - ${addPropertyViewModel.maintenanceCharges.value}'
                            : 'Maintenance Charges*',
                        showIcon: true,
                        onPressed: () async {
                          var res = await Get.to(
                            () => FullScreenDropDown(
                              title: 'Select Maintenance Charges',
                              items: const [
                                'Include in Rent',
                                'Exclude Rent',
                                'No Fee'
                              ],
                              selecedItem:
                                  addPropertyViewModel.maintenanceCharges.value,
                            ),
                            fullscreenDialog: true,
                          );
                          if (res != null) {
                            addPropertyViewModel.maintenanceCharges.value = res;
                            if (res == 'Exclude Rent') {
                              addPropertyViewModel.showMController.value = true;
                            } else {
                              addPropertyViewModel.showMController.value =
                                  false;
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                addPropertyViewModel.showMController.value
                    ? maintenanceFeeTextField()
                    : Container(),
              ],
            ),
          )
        : Container(),
  );
}

securityDepositField() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Container(
    margin: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 8),
    height: 51,
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      border: Border.all(
        color: AppColor.greyColor.withOpacity(0.7),
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        textField(
          controller: addPropertyViewModel.securityFeeController,
          hintText: 'Security Deposit Amount (PKR)*',
          maxLines: 1,
          keyboardType: TextInputType.number,
        ),
      ],
    ),
  );
}

maintenanceFeeTextField() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Container(
    margin: EdgeInsets.only(left: 14, right: 14, top: 8),
    height: 51,
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      border: Border.all(
        color: AppColor.greyColor.withOpacity(0.7),
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        textField(
          controller: addPropertyViewModel.maintenanceFeeController,
          hintText: 'Maintenance Fee',
          maxLines: 1,
          keyboardType: TextInputType.number,
        ),
      ],
    ),
  );
}

contactInfo() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Container(
    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
    // padding: EdgeInsets.only(left: 15),
    height: 102,
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      border: Border.all(
        color: AppColor.greyColor.withOpacity(0.7),
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        textFieldNumber(
          hintText: 'Contact Number',
          controller: addPropertyViewModel.contactController,
        ),
        Divider(height: 1, color: AppColor.greyColor.withOpacity(0.7)),
        textFieldNumber(
          hintText: 'Whatsapp Number',
          controller: addPropertyViewModel.whatssappController,
        ),
      ],
    ),
  );
}

titleDesc() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Container(
    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
    height: 155,
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      border: Border.all(
        color: AppColor.greyColor.withOpacity(0.7),
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        textField(
          hintText: 'Property Title*',
          controller: addPropertyViewModel.titleController,
          maxLines: 1,
        ),
        Divider(height: 10, color: AppColor.greyColor.withOpacity(0.7)),
        textField(
          hintText: 'Property Description*',
          maxLines: 4,
          controller: addPropertyViewModel.descController,
        ),
      ],
    ),
  );
}

errorWidget() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Obx(
    () => addPropertyViewModel.errorString.value != ''
        ? Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColor.greyColor.withOpacity(0.1),
            ),
            margin: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: AppColor.proimaryColor,
                  size: 19,
                ),
                SizedBox(width: 8),
                Text(
                  '${addPropertyViewModel.errorString.value}',
                  style: TextStyle(
                    color: AppColor.redColor,
                    fontFamily: AppFonts.mulishFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            ),
          )
        : Container(),
  );
}

imageWidget() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Text(
          'Property Images',
          style: TextStyle(
            color: AppColor.blackColor,
            fontFamily: AppFonts.mulishFont,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
          textAlign: TextAlign.left,
          maxLines: 1,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 8),
        height: 48,
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
              child: getImageButton(
                text: 'Camera',
                icon: CupertinoIcons.camera,
                onTap: () {
                  addPropertyViewModel.getImageFromcamera();
                },
              ),
            ),
            Container(
              color: AppColor.greyColor.withOpacity(0.5),
              width: 1,
              height: 48,
            ),
            Expanded(
              child: getImageButton(
                text: 'Gallery',
                icon: CupertinoIcons.photo,
                onTap: () {
                  addPropertyViewModel.getImageFromGallery();
                },
              ),
            ),
          ],
        ),
      ),
      imageGridView(),
    ],
  );
}

getImageButton({Function()? onTap, String? text, IconData? icon}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            size: 18,
          ),
          SizedBox(width: 8),
          Text(
            '$text',
            style: TextStyle(
              color: AppColor.blackColor,
              fontFamily: AppFonts.mulishFont,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
            textAlign: TextAlign.left,
            maxLines: 1,
          ),
        ],
      ),
    ),
  );
}

imageGridView() {
  final addPropertyViewModel = Get.find<AddPropertyViewModel>();
  return Obx(
    () => Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 10),
      child: Wrap(
        children: addPropertyViewModel.images
            .map(
              (image1) => image(
                image: File(image1.path),
                onCancel: () {
                  addPropertyViewModel.images.remove(image1);
                },
              ),
            )
            .toList(),
      ),
    ),
  );
}

Widget image({Function()? onCancel, File? image}) {
  return Container(
    margin: EdgeInsets.only(right: 8, top: 8),
    child: Stack(
      children: [
        Container(
          height: Get.width / 3.6,
          width: Get.width / 3.55,
          decoration: BoxDecoration(
            color: AppColor.greyColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              image!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: onCancel,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: AppColor.redColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.close,
                color: AppColor.whiteColor,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
