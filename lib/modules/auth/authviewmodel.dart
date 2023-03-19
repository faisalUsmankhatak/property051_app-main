import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/model/phone/parse_result.dart';
import '../../app/model/phone/region.dart';

import '../../app/model/user/customer.dart';
import '../../services/api/auth.dart';
import '../../services/firebase/firebaseauth.dart';
import '../../services/localstorage/SessionManager.dart';
import '../../utils/phoneutil.dart';
import '../../utils/utilities.dart';
import '../favorite/favoriteviewmodel.dart';
import '../more/moreviewmodel.dart';

class AuthViewModel extends GetxController {
  SessionManager sessionManager = SessionManager();
  final PhoneUtil phoneUtil = PhoneUtil();
  final isLogin = false.obs;
  RxBool isLoading = false.obs;
  RxString errorString = ''.obs;
  String? devicesRegionCode = 'PK';

  //Login
  RxBool isEmail = true.obs;
  Rx<Region> region = Region('PK', 92, 'Pakistan').obs;
  ParseResult? result;
  FocusNode emailNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneLController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final isPasswordVisible = false.obs;

  // Sign up
  RxBool isSEmail = true.obs;
  Rx<Region> sRegion = Region('PK', 92, 'Pakistan').obs;
  ParseResult? sResult;
  FocusNode emailSNode = FocusNode();
  FocusNode phoneSNode = FocusNode();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailSController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordSController = TextEditingController();
  TextEditingController cPasswordSController = TextEditingController();
  RxBool isSPassswordVisible = false.obs;
  RxBool iscSPassswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDevicesRegionCode();
    isEmail.listen((p0) {
      if (p0) {
        emailNode.requestFocus();
      } else {
        phoneNode.requestFocus();
      }
    });
  }

  Future<void> fetchDevicesRegionCode() async {
    final code = await phoneUtil.carrierRegionCode();
    region.value = await phoneUtil.getRegion(code!);
    devicesRegionCode = code;
    sRegion.value = region.value;
  }

  Future<void> parse(String text, Region region) async {
    result = null;
    result = await phoneUtil.parse(text, region: region);
    sResult = result;
    // log('Parse Result: $result');
  }

  Future<bool> validatePhone(String text, Region region) async {
    final isValid = await phoneUtil.validate(text, region: region);
    return isValid;
  }

  void toggleLogin() {
    isLogin.value = !isLogin.value;
  }

  onGoogleTap() async {
    var token = await SocialAuthService.handleGoogleSignIn();
    if (token != null) {
      isLoading.value = true;
      try {
        var res =
            await AuthService.socialLogin(provider: 'google', token: token);
        isLoading.value = false;
        saveCustomer(res!.data!);
        return res.success;
      } catch (e) {
        log(e.toString());
        return false;
      } finally {
        isLoading.value = false;
      }
    } else {
      return false;
    }
  }

  onFacebookTap() async {
    var token = await SocialAuthService.handleFacebookSignIn();
    if (token != null) {
      isLoading.value = true;
      try {
        var res =
            await AuthService.socialLogin(provider: 'facebook', token: token);
        isLoading.value = false;
        saveCustomer(res!.data!);
        return res.success;
      } catch (e) {
        log(e.toString());
        return false;
      } finally {
        isLoading.value = false;
      }
    }
  }

  onAppleTap() async {
    var token = await SocialAuthService.handleAppleSignIn();
    if (token != null) {
      isLoading.value = true;
      try {
        var res =
            await AuthService.socialLogin(provider: 'apple', token: token);
        isLoading.value = false;
        saveCustomer(res!.data!);
        return res.success;
      } catch (e) {
        log(e.toString());
        return false;
      } finally {
        isLoading.value = false;
      }
    } else {
      return false;
    }
  }

  Future<bool> validateLogin() async {
    if (isEmail.value) {
      if (emailController.text == '' || !validateEmail(emailController.text)) {
        errorString.value = 'Email is not valid';
        return false;
      }
    }
    if (!isEmail.value) {
      var r = await validatePhone(phoneLController.text, region.value);
      if (phoneLController.text == '' || !r) {
        errorString.value = 'Phone is not valid';
        return false;
      }
    }
    if (passwordController.text == '') {
      errorString.value = 'Please enter password';
      return false;
    } else {
      errorString.value = '';
      return true;
    }
  }

  Future<bool> validateSignUp() async {
    if (isSEmail.value) {
      if (emailSController.text == '' ||
          !validateEmail(emailSController.text)) {
        errorString.value = 'Email is not valid';
        return false;
      }
    }
    if (!isSEmail.value) {
      var r = await validatePhone(phoneController.text, sRegion.value);
      if (phoneController.text == '' || !r) {
        errorString.value = 'Phone is not valid';
        return false;
      }
    }
    errorString.value = '';
    return true;
  }

  login() async {
    isLoading.value = true;
    try {
      var res = await AuthService.login(
        isEmail: isEmail.value,
        email: emailController.text,
        // phone: '+${region.value.prefix} ${phoneLController.text}',
        phone: !isEmail.value ? '${result!.phoneNumber!.e164}' : '',
        password: passwordController.text,
      );
      isLoading.value = false;
      saveCustomer(res!.data!);
      return res.success;
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  signUp() async {
    isLoading.value = true;
    try {
      log(sResult.toString());
      var res = await AuthService.signUp(
        isEmail: isSEmail.value,
        email: emailSController.text,
        phone: !isSEmail.value ? '${sResult!.phoneNumber!.e164}' : '',
      );
      isLoading.value = false;
      saveCustomer(res!.data!);
      return res.success;
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  saveCustomer(Customer user) {
    sessionManager.saveData(SessionKeys.loginUser, user);
    sessionManager.saveBusinessId(userID: user.customerId.toString());
    sessionManager.saveFCMToken(token: user.token);
    Get.find<MoreViewModel>().isLogin.value = true;
    Get.find<FavoriteViewModel>().getFavoriteProperties();
    // log('User = ${sessionManager.readData(SessionKeys.loginUser)}');
    // log('ID = ${sessionManager.readData(SessionKeys.userID)}');
    // log('Token = ${sessionManager.readData(SessionKeys.fcmToken)}');
  }
}
