import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_051/app/model/agent/agentmodel.dart';
import '../../services/api/agent.dart';

class AgentViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;
  RxInt currIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isException = false.obs;
  RxBool isSearching = false.obs;
  TextEditingController searchController = TextEditingController();
  Rx<AgentModel> agentModel = AgentModel().obs;
  ScrollController scrollController = ScrollController();

  Timer? timer;
  @override
  void onInit() {
    super.onInit();
    init();
    getAgents();
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

  getAgents() async {
    try {
      isException.value = false;
      isLoading.value = true;
      agentModel.value = await AgentService.getAgents();
      isException.value = false;
      isLoading.value = false;
      log(agentModel.value.data!.agents!.length.toString());
    } catch (e) {
      isException.value = true;
      isLoading.value = false;
      log(e.toString());
    }
  }
}
