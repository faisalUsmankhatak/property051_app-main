// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../components/appbar.dart';
import '../../../components/phonefield/phonefield.dart';
import '../../../components/phonefield/regionpicker.dart';
import '../../../utils/colors.dart';
import '../../../utils/fonts.dart';
import '../../../utils/global.dart';
import '../../auth/signup.dart';
import 'profileviewmodel.dart';

class ProfileView extends StatelessWidget {
  final profileViewModel = Get.put(ProfileViewModel());

  Future<void> chooseRegions(context) async {
    dismissKeyboard(context);
    final regions = await profileViewModel.phoneUtil.getRegions();
    final selectedRegion = await Get.to(
      () => RegionPicker(regions: regions),
      fullscreenDialog: true,
    );
    if (selectedRegion != null) {
      log('Region selected: $selectedRegion');
      profileViewModel.region.value = selectedRegion;
    }
  }

  Future<void> format() async {
    final formatted = await profileViewModel.phoneUtil.format(
        profileViewModel.phoneController.text, profileViewModel.region.value);
    if (formatted != null) {
      profileViewModel.phoneController.value =
          profileViewModel.phoneController.value.copyWith(
        text: formatted,
        selection: TextSelection(
            baseOffset: formatted.length, extentOffset: formatted.length),
        composing: TextRange.empty,
      );
    }
  }

  Future<void> chooseRegions1(context) async {
    dismissKeyboard(context);
    final regions = await profileViewModel.phoneUtil.getRegions();
    final selectedRegion = await Get.to(
      () => RegionPicker(regions: regions),
      fullscreenDialog: true,
    );
    if (selectedRegion != null) {
      log('Region selected: $selectedRegion');
      profileViewModel.wRegion.value = selectedRegion;
    }
  }

  Future<void> format1() async {
    final formatted = await profileViewModel.phoneUtil.format(
        profileViewModel.whatsappController.text,
        profileViewModel.wRegion.value);
    if (formatted != null) {
      profileViewModel.whatsappController.value =
          profileViewModel.whatsappController.value.copyWith(
        text: formatted,
        selection: TextSelection(
            baseOffset: formatted.length, extentOffset: formatted.length),
        composing: TextRange.empty,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backgroundColor,
      appBar: appBar(
        title: 'Profile',
        previousTitle: 'Back',
        image: 'images/app/propertyLogo1.png',
      ),
      body: body(context),
    );
  }

  body(context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: SingleChildScrollView(
        child: Container(
          height: Get.height - (kToolbarHeight * 3),
          color: AppColor.backgroundColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.02),
                  Obx(
                    () => ClipRRect(
                      borderRadius:
                          BorderRadius.circular((Get.width * 0.4) / 2),
                      child: Container(
                        height: Get.width * 0.3,
                        width: Get.width * 0.3,
                        decoration: BoxDecoration(
                          color: AppColor.backgroundColor,
                          border:
                              Border.all(color: AppColor.greyColor, width: 0.5),
                          borderRadius:
                              BorderRadius.circular((Get.width * 0.4) / 2),
                        ),
                        child: Center(
                          child: profileViewModel.imagePath.value != ''
                              ? Image.network(
                                  '${profileViewModel.imagePath.value}',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'images/icons/profile.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'USER ID: ',
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontFamily: AppFonts.mulishFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        '${profileViewModel.sessionManager.userID}',
                        style: TextStyle(
                          color: AppColor.proimaryColor,
                          fontFamily: AppFonts.mulishFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  divider(),
                  firstLastName(),
                  divider(),
                  Row(
                    children: [
                      emailField(),
                    ],
                  ),
                  divider(),
                  Row(
                    children: [
                      phoneField(context),
                    ],
                  ),
                  divider(),
                  Row(
                    children: [
                      whatsappField(context),
                    ],
                  ),
                  divider(),
                  SizedBox(height: Get.height * 0.02),
                  Obx(
                    () => profileViewModel.errorString.value != ''
                        ? Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColor.greyColor.withOpacity(0.1),
                            ),
                            margin: EdgeInsets.only(left: 0, right: 0, top: 20),
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
                                  '${profileViewModel.errorString.value}',
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
                  ),
                  SizedBox(height: 30),
                  updateButton(context),
                  SizedBox(height: kToolbarHeight),
                ],
              ),
              Obx(
                () => profileViewModel.isLoading.value
                    ? Positioned(
                        top: Get.height / 2.8,
                        child: Container(
                          child: SpinKitCircle(
                            color: AppColor.proimaryColor,
                            size: 50.0,
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

  firstLastName() {
    return Row(
      children: [
        Expanded(
          child: textField(
            height: 43,
            hintText: 'First Name',
            controller: profileViewModel.fNameController,
            onChange: (t) {},
          ),
        ),
        Container(
          height: 45,
          width: 0.5,
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: textField(
            height: 43,
            hintText: 'Last Name',
            controller: profileViewModel.lNameController,
            onChange: (t) {},
          ),
        ),
      ],
    );
  }

  emailField() {
    return Expanded(
      child: textField(
        height: 45,
        hintText: 'Enter Email / Phone',
        controller: profileViewModel.emailController,
        onChange: (t) {},
      ),
    );
  }

  phoneField(context) {
    return Expanded(
      child: Obx(
        () => IntlPhoneField(
          numberCtrl: profileViewModel.phoneController,
          region: profileViewModel.region.value,
          chooseRegions: () {
            chooseRegions(context);
          },
          onNumberChange: (t) {
            format();
            profileViewModel.parse(profileViewModel.phoneController.text,
                profileViewModel.region.value);
          },
        ),
      ),
    );
  }

  whatsappField(context) {
    return Expanded(
      child: Obx(
        () => IntlPhoneField(
          numberCtrl: profileViewModel.whatsappController,
          region: profileViewModel.wRegion.value,
          hintText: 'Whatsapp Number',
          chooseRegions: () {
            chooseRegions1(context);
          },
          onNumberChange: (t) {
            format1();
            profileViewModel.parse1(profileViewModel.whatsappController.text,
                profileViewModel.wRegion.value);
          },
        ),
      ),
    );
  }

  updateButton(context) {
    return Container(
      height: 43,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.proimaryColor,
        borderRadius: BorderRadius.circular(0),
      ),
      child: TextButton(
        onPressed: () async {
          log(profileViewModel.customer.value.image!);
          // FocusScope.of(context).unfocus();
          // // profileViewModel.getProfile();
          // var r = await profileViewModel.validateProfile();
          // log(r.toString());
          // if (r) {
          //   FocusScope.of(context).unfocus();
          //   var res = await profileViewModel.saveUser();
          //   if (res) {
          //     // Get.back();
          //     GlobalWidet().showSnackBar(
          //       title: 'Success',
          //       message: 'User Profile Updated Successfully',
          //       bgColor: AppColor.greenColor,
          //       textColor: AppColor.whiteColor,
          //     );
          //   } else {
          //     GlobalWidet().showInvalidCupertinoDialog(
          //       message: 'Something went wrong.',
          //     );
          //   }
          // }
        },
        child: Text(
          'Update',
          style: TextStyle(
            color: AppColor.whiteColor,
            fontFamily: AppFonts.mulishFont,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
