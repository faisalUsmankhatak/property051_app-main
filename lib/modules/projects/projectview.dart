// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/appbar.dart';
import '../../components/cards/projectcard.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';
import 'projectviewmodel.dart';

class ProjectView extends StatelessWidget {
  var projectViewModel = Get.put(ProjectViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: appBar(title: 'Projects', previousTitle: 'Home'),
      body: Container(
        margin: EdgeInsets.only(left: 0, right: 0, top: 0),
        child: Obx(
          () => !projectViewModel.isException.value
              ? !projectViewModel.isLoading.value
                  ? projectList(context)
                  : GlobalWidet().loader()
              : GlobalWidet().noInternet(
                  message: 'Something went wrong',
                  onTap: () {
                    projectViewModel.getProjects();
                  },
                ),
        ),
      ),
    );
  }

  projectList(context) {
    return ListView.separated(
      padding: EdgeInsets.only(
          top: 0,
          bottom: kToolbarHeight + MediaQuery.of(context).padding.bottom / 2),
      // itemCount: projectViewModel.agentModel.value.data!.agents!.length,
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var project = projectViewModel.projects.value.data!.projects![index];
        return ProjectCard(
          project: project,
          onTap: () {},
        );
      },
      separatorBuilder: (c, i) {
        return Divider(
          height: 12,
          color: Colors.transparent,
        );
        // return Divider(
        //   height: 1,
        //   color: AppColor.greyColor.withOpacity(0.4),
        // );
      },
    );
  }
}
