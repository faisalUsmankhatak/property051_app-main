// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:property_051/components/phonefield/phonefield.dart';
import 'package:property_051/modules/auth/signup.dart';
import 'package:property_051/utils/global.dart';
import '../../components/appbar.dart';
import '../../components/phonefield/regionpicker.dart';
import '../../components/socialbutton.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'authviewmodel.dart';

class SignInView extends StatelessWidget {
  final authViewModel = Get.find<AuthViewModel>();

  Future<void> chooseRegions(context) async {
    dismissKeyboard(context);
    final regions = await authViewModel.phoneUtil.getRegions();
    final selectedRegion = await Get.to(
      () => RegionPicker(regions: regions),
      fullscreenDialog: true,
    );
    if (selectedRegion != null) {
      log('Region selected: $selectedRegion');
      authViewModel.region.value = selectedRegion;
    }
  }

  Future<void> format() async {
    final formatted = await authViewModel.phoneUtil.format(
        authViewModel.phoneLController.text, authViewModel.region.value);
    if (formatted != null) {
      authViewModel.phoneLController.value =
          authViewModel.phoneLController.value.copyWith(
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
        title: 'Login',
        previousTitle: 'Back',
        image: 'images/app/propertyLogo1.png',
        actions: [
          GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              var r = await authViewModel.validateLogin();
              log(r.toString());
              if (r) {
                FocusScope.of(context).unfocus();
                var res = await authViewModel.login();
                if (res) {
                  Get.back();
                  Get.back();
                  GlobalWidet().showSnackBar(
                    title: 'Login',
                    message: 'Login successfully',
                    bgColor: AppColor.greenColor,
                    textColor: AppColor.whiteColor,
                  );
                } else {
                  GlobalWidet().showInvalidCupertinoDialog(
                    message:
                        'Whoops, looks like email or password is incorrect.',
                  );
                }
              }
            },
            child: Container(
              // color: AppColor.proimaryColor,
              alignment: Alignment.topRight,
              width: Get.width / 4,
              padding: EdgeInsets.only(right: 15, top: 13),
              child: Text(
                'Login',
                style: TextStyle(
                  color: AppColor.proimaryColor,
                  fontFamily: AppFonts.mulishFont,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
        onTap: () {
          authViewModel.emailController.text = '';
          authViewModel.passwordController.text = '';
          Get.back();
        },
      ),
      body: body(context),
    );
  }

  body(context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Container(
        height: Get.height - (kToolbarHeight * 3),
        color: AppColor.backgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.04),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Login using your email and password to access your account and manage your properties.',
                    style: TextStyle(
                      color: Color.fromARGB(255, 113, 108, 108),
                      fontFamily: AppFonts.mulishFont,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Get.height * 0.06),
                divider(),
                // Container(
                //   padding: EdgeInsets.only(left: 5, right: 5),
                //   child: Row(
                //     children: [
                // Expanded(
                //   child: textField(
                //     height: 45,
                //     hintText: 'Email',
                //     controller: authViewModel.emailController,
                //   ),
                // ),
                //     ],
                //   ),
                // ),
                emailOrPhoneField(context),
                divider(),
                Obx(
                  () => Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: textField(
                            height: 45,
                            hintText: 'Password',
                            controller: authViewModel.passwordController,
                            isPasswordVisible:
                                !authViewModel.isPasswordVisible.value,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            log('message');
                            authViewModel.isPasswordVisible.value =
                                !authViewModel.isPasswordVisible.value;
                          },
                          child: Container(
                            padding:
                                EdgeInsets.only(top: 15, right: 10, left: 15),
                            child: Icon(
                              authViewModel.isPasswordVisible.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                              color: AppColor.proimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                divider(),
                SizedBox(height: Get.height * 0.02),
                Obx(
                  () => authViewModel.errorString.value != ''
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
                                '${authViewModel.errorString.value}',
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
                Expanded(child: Container()),
                Column(
                  children: [
                    SoialButton(
                      imagePath: 'images/app/google.png',
                      icon: Icons.apple_outlined,
                      title: 'Continue with Google',
                      textColor: AppColor.blackColor,
                      backgroundColor: AppColor.backgroundColor,
                      iconColor: AppColor.blackColor,
                      radius: 5,
                      height: 43,
                      width: Get.width / 1.1,
                      onPressed: () async {
                        var res = await authViewModel.onGoogleTap();
                        if (res) {
                          Get.back();
                          Get.back();
                          GlobalWidet().showSnackBar(
                            title: 'Login',
                            message: 'Login successfully',
                            bgColor: AppColor.greenColor,
                            textColor: AppColor.whiteColor,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 12),
                    SoialButton(
                      icon: Icons.facebook,
                      title: 'Continue with Facebook',
                      textColor: AppColor.whiteColor,
                      backgroundColor: AppColor.facebookColor,
                      iconColor: AppColor.whiteColor,
                      radius: 5,
                      height: 43,
                      width: Get.width / 1.1,
                      onPressed: () async {
                        var res = await authViewModel.onFacebookTap();
                        if (res) {
                          Get.back();
                          Get.back();
                          GlobalWidet().showSnackBar(
                            title: 'Login',
                            message: 'Login successfully',
                            bgColor: AppColor.greenColor,
                            textColor: AppColor.whiteColor,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 12),
                    SoialButton(
                      icon: Icons.apple,
                      title: 'Continue with Apple',
                      textColor: AppColor.whiteColor,
                      backgroundColor: AppColor.blackColor,
                      iconColor: AppColor.whiteColor,
                      radius: 5,
                      height: 43,
                      width: Get.width / 1.1,
                      onPressed: () async {
                        var res = await authViewModel.onAppleTap();
                        if (res) {
                          Get.back();
                          Get.back();
                          GlobalWidet().showSnackBar(
                            title: 'Login',
                            message: 'Login successfully',
                            bgColor: AppColor.greenColor,
                            textColor: AppColor.whiteColor,
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
            Obx(
              () => authViewModel.isLoading.value
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
    );
  }

  emailOrPhoneField(context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: [
            !authViewModel.isEmail.value
                ? Expanded(
                    child: IntlPhoneField(
                      numberCtrl: authViewModel.phoneLController,
                      region: authViewModel.region.value,
                      focusNode: authViewModel.phoneNode,
                      autoFocus: true,
                      chooseRegions: () {
                        chooseRegions(context);
                      },
                      onNumberChange: (t) {
                        if (t.length == 0) {
                          authViewModel.isEmail.value = true;
                          authViewModel.emailController.text = '';
                        }
                        if (t.length == 1) {
                          try {
                            int _ = int.parse(t);
                          } catch (e) {
                            authViewModel.isEmail.value = true;
                            authViewModel.emailController.text = '';
                          }
                        }
                        format();
                        authViewModel.parse(authViewModel.phoneLController.text,
                            authViewModel.region.value);
                      },
                    ),
                  )
                : Expanded(
                    child: textField(
                      height: 45,
                      hintText: 'Enter Email / Phone',
                      controller: authViewModel.emailController,
                      focusNode: authViewModel.emailNode,
                      autoFocus: true,
                      onChange: (t) {
                        if (t.length == 1) {
                          try {
                            int _ = int.parse(t);
                            authViewModel.isEmail.value = false;
                            authViewModel.phoneLController.text = t;
                          } catch (e) {
                            log('Email Catch');
                          }
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
