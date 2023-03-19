import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_051/services/api/agency.dart';

import '../../app/model/agency/agencymodel.dart';

class AgencyViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;
  RxInt currIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isException = false.obs;
  RxBool isSearching = false.obs;
  RxBool showSearch = false.obs;
  TextEditingController searchController = TextEditingController();
  Rx<AgencyModel> agencyModel = AgencyModel().obs;
  Rx<AgencyModel> searchModel = AgencyModel().obs;
  ScrollController scrollController = ScrollController();

  Timer? timer;
  @override
  void onInit() {
    super.onInit();
    init();
    getAgencies();
  }

  init() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 200), //controll animation duration
      vsync: this,
    )..addListener(() {});

    animation = ColorTween(
      begin: Colors.grey,
      end: Colors.red,
    ).animate(controller!);
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) {
        currIndex.value = currIndex.value == 0 ? 1 : 0;
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    controller!.dispose();
    timer?.cancel();
  }

  getAgencies() async {
    try {
      isException.value = false;
      isLoading.value = true;
      agencyModel.value = await AgencyService.getAgencies();
      searchModel.value = agencyModel.value;
      isException.value = false;
      isLoading.value = false;
      log(agencyModel.value.data!.agency!.length.toString());
    } catch (e) {
      isException.value = true;
      isLoading.value = false;
      log(e.toString());
    }
  }
}
