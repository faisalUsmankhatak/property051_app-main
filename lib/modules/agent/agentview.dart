// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/appbar.dart';
import '../../components/cards/agentcard.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';
import 'agentviewmodel.dart';

class AgentView extends StatelessWidget {
  var agentViewModel = Get.put(AgentViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: appBar(title: 'Trusted Agents', previousTitle: 'Home'),
      body: Container(
        color: AppColor.whiteColor,
        // child: agentList(context),
        child: Obx(
          () => !agentViewModel.isException.value
              ? !agentViewModel.isLoading.value
                  ? agentList(context)
                  : GlobalWidet().loader()
              : GlobalWidet().noInternet(
                  message: 'Something went wrong',
                  onTap: () {
                    agentViewModel.getAgents();
                  },
                ),
        ),
      ),
    );
  }

  agentList(context) {
    return ListView.separated(
      padding: EdgeInsets.only(
          top: 12,
          bottom: kToolbarHeight + MediaQuery.of(context).padding.bottom / 2),
      itemCount: agentViewModel.agentModel.value.data!.agents!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var agent = agentViewModel.agentModel.value.data!.agents![index];
        return AgentCard(
          agent: agent,
          onTap: () {
            // Get.toNamed(Routes.AGENT_DETAIL, arguments: agent);
          },
        );
      },
      separatorBuilder: (c, i) {
        return Divider(
          height: 15,
          color: Colors.grey[400],
        );
      },
    );
  }
}
