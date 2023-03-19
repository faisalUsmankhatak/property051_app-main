// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../components/socialbutton.dart';
import '../../routes/approutes.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../utils/global.dart';
import 'authviewmodel.dart';

class WelcomePage extends StatelessWidget {
  var authViewModel = Get.put(AuthViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: appBar(),
      ),
      body: SizedBox(
        height: Get.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.05),
                welcomeImage(),
                Expanded(child: Container()),
                privacyPolicyText(),
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
                        if (Platform.isIOS) {
                          var res = await authViewModel.onAppleTap();
                          if (res) {
                            Get.back();
                            GlobalWidet().showSnackBar(
                              title: 'Login',
                              message: 'Login successfully',
                              bgColor: AppColor.greenColor,
                              textColor: AppColor.whiteColor,
                            );
                          }
                        } else {
                          GlobalWidet().showCupertinoDialog(
                            icon: CupertinoIcons.exclamationmark_circle,
                            title: 'Whoops',
                            message: 'Apple login is only available on iOS',
                          );
                        }
                      },
                    ),
                  ],
                ),
                // SizedBox(height: 20),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(
                      left: 15, right: 20, bottom: kToolbarHeight),
                  child: Row(
                    children: [
                      Expanded(
                        child: SoialButton(
                          icon: Icons.apple,
                          title: 'Login',
                          textColor: AppColor.blackColor,
                          backgroundColor: AppColor.whiteColor,
                          iconColor: AppColor.whiteColor,
                          showIcon: false,
                          radius: 4,
                          height: 38,
                          width: double.infinity,
                          onPressed: () async {
                            authViewModel.errorString.value = '';
                            await Get.toNamed(AppRoutes.login);
                            authViewModel.emailController.text = '';
                            authViewModel.passwordController.text = '';
                            authViewModel.isPasswordVisible.value = false;
                          },
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: SoialButton(
                          icon: Icons.apple,
                          title: 'Sign up',
                          textColor: AppColor.whiteColor,
                          backgroundColor: AppColor.proimaryColor,
                          iconColor: AppColor.proimaryColor,
                          showIcon: false,
                          radius: 4,
                          height: 38,
                          width: double.infinity,
                          onPressed: () async {
                            authViewModel.errorString.value = '';
                            await Get.toNamed(AppRoutes.signup);
                            authViewModel.firstNameController.text = '';
                            authViewModel.lastNameController.text = '';
                            authViewModel.phoneController.text = '';
                            authViewModel.emailSController.text = '';
                            authViewModel.passwordSController.text = '';
                            authViewModel.cPasswordSController.text = '';
                            authViewModel.isSPassswordVisible.value = false;
                            authViewModel.iscSPassswordVisible.value = false;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
            )
          ],
        ),
      ),
    );
  }

  appBar() {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      elevation: 0.5,
      leadingWidth: 80,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.only(left: 10, top: 10),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: AppColor.proimaryColor,
              fontSize: 16,
              fontFamily: AppFonts.mulishFont,
            ),
          ),
        ),
      ),
      title: Image.asset(
        'images/app/propertyLogo1.png',
        height: 25,
      ),
      iconTheme: IconThemeData(color: AppColor.proimaryColor),
    );
  }

  Widget welcomeText() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Text(
        'Login using your email and password',
        style: TextStyle(
          fontSize: 15,
          fontFamily: AppFonts.mulishFont,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget privacyPolicyText() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Text(
        'By continiuing, you agree to our Terms of Service and Privacy Policy',
        style: TextStyle(
          color: AppColor.greyColor,
          fontSize: 15,
          fontFamily: AppFonts.mulishFont,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget welcomeImage() {
    return Container(
      // color: AppColor.proimaryColor,
      margin: EdgeInsets.only(top: Get.height * 0.08, left: 20, right: 20),
      child: Image.asset(
        'images/app/welcome5.png',
        height: Get.height / 4,
        width: Get.width - 60,
        fit: BoxFit.fill,
      ),
    );
  }
}
