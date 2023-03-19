// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:property_051/components/phonefield/phonefield.dart';
import '../../components/appbar.dart';
import '../../components/phonefield/regionpicker.dart';
import '../../components/socialbutton.dart';
import '../../routes/approutes.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../utils/global.dart';
import 'authviewmodel.dart';

class SignUpView extends StatelessWidget {
  final authViewModel = Get.find<AuthViewModel>();

  Future<void> chooseRegions(context) async {
    dismissKeyboard(context);
    final regions = await authViewModel.phoneUtil.getRegions();
    final selectedRegion = await Get.to(
      () => RegionPicker(regions: regions),
      fullscreenDialog: true,
    );
    if (selectedRegion != null) {
      authViewModel.sRegion.value = selectedRegion;
    }
  }

  Future<void> format() async {
    final formatted = await authViewModel.phoneUtil
        .format(authViewModel.phoneController.text, authViewModel.region.value);
    if (formatted != null) {
      authViewModel.phoneController.value =
          authViewModel.phoneController.value.copyWith(
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
      appBar: appBar1(context),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (() => FocusScope.of(context).unfocus()),
          child: Container(
            height: Get.height - (kToolbarHeight * 3),
            color: AppColor.backgroundColor,
            child: Stack(
              alignment: Alignment.center,
              children: [
                formBody1(context),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  appBar1(context) {
    return appBar(
      title: 'Create Account',
      previousTitle: 'Back',
      image: 'images/app/propertyLogo1.png',
      actions: [
        GestureDetector(
          onTap: () async {
            dismissKeyboard(context);
            var r = await authViewModel.validateSignUp();
            if (r) {
              var res = await authViewModel.signUp();
              if (res) {
                Get.back();
                Get.back();
                GlobalWidet().showSnackBar(
                  title: 'Sign Up',
                  message: 'Signup successfully',
                  bgColor: AppColor.greenColor,
                  textColor: AppColor.whiteColor,
                );
              } else {
                GlobalWidet().showInvalidCupertinoDialog(
                  message:
                      'Whoops, looks like email or phone number is already exists',
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
              'Sign Up',
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
    );
  }

  formBody1(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: Get.height * 0.02),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            'Sign up and make Property051 your compass on the map of real estate world',
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
        SizedBox(height: Get.height * 0.05),
        divider(),
        Obx(
          () => Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Row(
              children: [
                !authViewModel.isSEmail.value
                    ? Expanded(
                        child: IntlPhoneField(
                          numberCtrl: authViewModel.phoneController,
                          region: authViewModel.sRegion.value,
                          focusNode: authViewModel.phoneSNode,
                          autoFocus: true,
                          chooseRegions: () {
                            chooseRegions(context);
                          },
                          onNumberChange: (t) {
                            if (t.length == 0) {
                              authViewModel.isSEmail.value = true;
                              authViewModel.emailSController.text = '';
                            }
                            if (t.length == 1) {
                              try {
                                int _ = int.parse(t);
                              } catch (e) {
                                authViewModel.isSEmail.value = true;
                                authViewModel.emailSController.text = '';
                              }
                            }
                            format();
                            authViewModel.parse(
                                authViewModel.phoneController.text,
                                authViewModel.sRegion.value);
                          },
                        ),
                      )
                    : Expanded(
                        child: textField(
                          height: 45,
                          hintText: 'Enter Email / Phone',
                          controller: authViewModel.emailSController,
                          focusNode: authViewModel.emailSNode,
                          autoFocus: true,
                          onChange: (t) {
                            if (t.length == 1) {
                              try {
                                int _ = int.parse(t);
                                authViewModel.isSEmail.value = false;
                                authViewModel.phoneController.text = t;
                              } catch (e) {}
                            }
                          },
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
      ],
    );
  }

  formBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: Get.height * 0.02),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            'Sign up and make Property051 your compass on the map of real estate world',
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
        SizedBox(height: Get.height * 0.02),
        Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: textField(
                  hintText: 'First Name',
                  controller: authViewModel.firstNameController,
                ),
              ),
              // SizedBox(width: 10),
              Expanded(
                child: textField(
                  hintText: 'Last Name',
                  controller: authViewModel.lastNameController,
                ),
              ),
            ],
          ),
        ),
        divider(),
        Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Row(
            children: [
              Expanded(
                child: textField(
                  hintText: 'Email',
                  controller: authViewModel.emailSController,
                ),
              ),
            ],
          ),
        ),
        divider(),
        Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Row(
            children: [
              Expanded(
                child: IntlPhoneField(
                  numberCtrl: authViewModel.phoneController,
                ),
              )
            ],
          ),
        ),
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
                    controller: authViewModel.passwordSController,
                    isPasswordVisible: !authViewModel.isSPassswordVisible.value,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    authViewModel.isSPassswordVisible.value =
                        !authViewModel.isSPassswordVisible.value;
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 15, right: 10, left: 15),
                    child: Icon(
                      authViewModel.isSPassswordVisible.value
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
        Obx(
          () => Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Row(
              children: [
                Expanded(
                  child: textField(
                    height: 45,
                    hintText: 'Confirm Password',
                    controller: authViewModel.cPasswordSController,
                    isPasswordVisible:
                        !authViewModel.iscSPassswordVisible.value,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    authViewModel.iscSPassswordVisible.value =
                        !authViewModel.iscSPassswordVisible.value;
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 15, right: 10, left: 15),
                    child: Icon(
                      authViewModel.iscSPassswordVisible.value
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
                  GlobalWidet().showSnackBar(
                    title: 'Login',
                    message: 'Login successfully',
                    bgColor: AppColor.greenColor,
                    textColor: AppColor.whiteColor,
                  );
                  Get.offAllNamed(AppRoutes.home);
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
                  GlobalWidet().showSnackBar(
                    title: 'Login',
                    message: 'Login successfully',
                    bgColor: AppColor.greenColor,
                    textColor: AppColor.whiteColor,
                  );
                  Get.offAllNamed(AppRoutes.home);
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
            ),
          ],
        ),
      ],
    );
  }

  Widget welcomeText() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Text(
        'Welcome to Property051',
        style: TextStyle(
          fontSize: 22,
          fontFamily: AppFonts.mulishFont,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

textField({
  String? hintText,
  TextEditingController? controller,
  double? height = 40,
  bool? isPasswordVisible = false,
  FocusNode? focusNode,
  bool autoFocus = false,
  Function(String)? onChange,
}) {
  return Container(
    height: height,
    child: TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autoFocus,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '$hintText',
        contentPadding: EdgeInsets.only(top: 5, left: 5, bottom: 4),
        hintStyle: TextStyle(
          color: AppColor.greyColor,
          fontSize: 14,
          fontFamily: AppFonts.mulishFont,
          letterSpacing: 1,
        ),
      ),
      onChanged: onChange,
      obscureText: isPasswordVisible!,
      style: TextStyle(
        color: AppColor.blackColor,
        fontSize: 14,
        fontFamily: AppFonts.mulishFont,
      ),
    ),
  );
}

divider() {
  return Divider(
    color: AppColor.greyColor,
    thickness: 0.25,
    height: 1,
  );
}
