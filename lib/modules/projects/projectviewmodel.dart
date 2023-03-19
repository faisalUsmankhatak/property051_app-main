import 'dart:developer';

import 'package:get/get.dart';
import '../../app/model/project/projectmodel.dart';
import '../../services/api/project.dart';

class ProjectViewModel extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isException = false.obs;
  Rx<ProjectModel> projects = ProjectModel().obs;

  @override
  void onInit() {
    super.onInit();
    getProjects();
  }

  getProjects() async {
    try {
      isException.value = false;
      isLoading.value = true;
      projects.value = await ProjectService.getProjects();
      isException.value = false;
      isLoading.value = false;
    } catch (e) {
      isException.value = true;
      isLoading.value = false;
      log(e.toString());
    }
  }
}
