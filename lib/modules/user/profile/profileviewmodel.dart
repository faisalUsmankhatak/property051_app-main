import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/model/phone/parse_result.dart';
import '../../../app/model/phone/region.dart';
import '../../../app/model/user/customer.dart';
import '../../../services/api/profile.dart';
import '../../../services/localstorage/SessionManager.dart';
import '../../../utils/phoneutil.dart';
import '../../../utils/utilities.dart';

class ProfileViewModel extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isExeption = false.obs;
  SessionManager sessionManager = SessionManager();
  Rx<Customer> customer = Customer().obs;
  final PhoneUtil phoneUtil = PhoneUtil();
  RxString errorString = ''.obs;
  String? devicesRegionCode = 'PK';
  Rx<Region> region = Region('PK', 92, 'Pakistan').obs;
  Rx<Region> wRegion = Region('PK', 92, 'Pakistan').obs;
  ParseResult? result;
  ParseResult? wResult;
  FocusNode emailNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  RxString imagePath = ''.obs;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchDevicesRegionCode();

    getProfile();
  }

  Future<void> fetchDevicesRegionCode() async {
    final code = await phoneUtil.carrierRegionCode();
    region.value = await phoneUtil.getRegion(code!);
    devicesRegionCode = code;
  }

  Future<void> parse(String text, Region region) async {
    result = null;
    result = await phoneUtil.parse(text, region: region);
  }

  Future<void> parse1(String text, Region region) async {
    wResult = null;
    wResult = await phoneUtil.parse(text, region: region);
  }

  Future<bool> validatePhone(String text, Region region) async {
    final isValid = await phoneUtil.validate(text, region: region);
    return isValid;
  }

  Future<bool> validateProfile() async {
    if (fNameController.text.isEmpty) {
      errorString.value = 'First Name is required';
      return false;
    }
    if (lNameController.text.isEmpty) {
      errorString.value = 'Last Name is required';
      return false;
    }
    if (emailController.text == '' || !validateEmail(emailController.text)) {
      errorString.value = 'Email is not valid';
      return false;
    }
    var r = await validatePhone(phoneController.text, region.value);
    if (phoneController.text == '' || !r) {
      errorString.value = 'Phone is not valid';
      return false;
    }
    if (whatsappController.text != '') {
      var r = await validatePhone(whatsappController.text, wRegion.value);
      if (!r) {
        errorString.value = 'Whatsapp is not valid';
        return false;
      }
    }
    errorString.value = '';
    return true;
  }

  getProfile() async {
    isLoading.value = true;
    isExeption.value = false;
    try {
      var r = await ProfileService.getUserProfile();
      customer.value = r.data!.userDetails!;
      fillData();
      isLoading.value = false;
    } catch (e) {
      isExeption.value = true;
      isLoading.value = false;
    }
  }

  fillData() async {
    if (customer.value.avatar != null && customer.value.avatar != '') {
      imagePath.value = customer.value.image!;
    }
    fNameController.text = customer.value.firstName!;
    lNameController.text = customer.value.lastName!;
    emailController.text = customer.value.customerEmail!;
    if (customer.value.contactNo != null) {
      phoneController.text = customer.value.contactNo!.substring(3);
    }
    if (customer.value.whatsappNumber != null) {
      whatsappController.text = customer.value.whatsappNumber!.substring(3);
    }
    final formatted =
        await phoneUtil.format(phoneController.text, region.value);
    if (formatted != null) {
      phoneController.value = phoneController.value.copyWith(
        text: formatted,
        selection: TextSelection(
            baseOffset: formatted.length, extentOffset: formatted.length),
        composing: TextRange.empty,
      );
    }
    final formatted1 =
        await phoneUtil.format(whatsappController.text, wRegion.value);
    if (formatted1 != null) {
      whatsappController.value = whatsappController.value.copyWith(
        text: formatted,
        selection: TextSelection(
            baseOffset: formatted1.length, extentOffset: formatted1.length),
        composing: TextRange.empty,
      );
    }
  }

  saveUser() async {
    isLoading.value = true;
    isExeption.value = false;
    try {
      var r = await ProfileService.saveUserProfile(makeBody());
      customer.value = r.data!.userDetails!;
      sessionManager.saveData(SessionKeys.loginUser, customer.value);
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      isExeption.value = true;
      log(e.toString());
      return false;
    }
  }

  makeBody() {
    var param = {
      'first_name': fNameController.text,
      'last_name': lNameController.text,
      'customer_email': emailController.text,
      'contact_no': '${result!.phoneNumber!.e164}',
      'whatsapp_number': '${wResult!.phoneNumber!.e164}',
      'image': customer.value.image,
    };
    return param;
  }
}
