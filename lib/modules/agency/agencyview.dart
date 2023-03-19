// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_051/components/cards/agencycard.dart';
import '../../components/appbar.dart';
import '../../utils/colors.dart';
import '../../utils/global.dart';
import 'agencyviewmodel.dart';

class AgencyView extends StatelessWidget {
  var agencyViewModel = Get.put(AgencyViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: appBar(title: 'Agencies', previousTitle: 'Home', actions: [
        // IconButton(
        //   onPressed: () {
        //     agencyViewModel.showSearch.value =
        //         !agencyViewModel.showSearch.value;
        //   },
        //   icon: const Icon(
        //     CupertinoIcons.search,
        //     color: AppColor.blackColor,
        //   ),
        // ),
      ]),
      body: Container(
        color: AppColor.whiteColor,
        child: Obx(
          () => !agencyViewModel.isException.value
              ? !agencyViewModel.isLoading.value
                  ? body(context)
                  : GlobalWidet().loader()
              : GlobalWidet().noInternet(
                  message: 'Something went wrong',
                  onTap: () {
                    agencyViewModel.getAgencies();
                  },
                ),
        ),
      ),
    );
  }

  body(context) {
    return Column(
      children: [
        // Obx(
        //   () => agencyViewModel.showSearch.value ? searchField() : Container(),
        // ),
        agencyList(context),
      ],
    );
  }

  searchField() {
    return GlobalWidet().searchField(
      controller: agencyViewModel.searchController,
      onChange: (t) {
        if (t != '') {
          log('In search');
          agencyViewModel.isSearching.value = true;
          agencyViewModel.searchModel.value.data!.agency =
              agencyViewModel.agencyModel.value.data!.agency!.where(
            (agency) {
              if (agency.name!.toLowerCase().contains(t.toLowerCase())) {
                log('Yes');
                return true;
              } else {
                return false;
              }
            },
          ).toList();
        } else {
          log('Exit');
          agencyViewModel.isSearching.value = false;
          agencyViewModel.searchModel.value = agencyViewModel.agencyModel.value;
        }
        agencyViewModel.agencyModel.refresh();
        agencyViewModel.searchModel.refresh();
      },
      onSubmit: (t) {
        log(t);
      },
    );
  }

  agencyList(context) {
    return Expanded(
      child: Obx(
        () => !agencyViewModel.isSearching.value
            ? ListView.separated(
                controller: agencyViewModel.scrollController,
                padding: EdgeInsets.only(
                    top: 12,
                    bottom: kToolbarHeight +
                        MediaQuery.of(context).padding.bottom / 2),
                itemCount:
                    agencyViewModel.agencyModel.value.data!.agency!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item =
                      agencyViewModel.agencyModel.value.data!.agency![index];
                  return AgencyCard(
                    agency: item,
                    onTap: () {},
                  );
                },
                separatorBuilder: (c, i) {
                  return Divider(
                    height: 18,
                    color: Colors.grey[400],
                  );
                },
              )
            : ListView.separated(
                controller: agencyViewModel.scrollController,
                padding: EdgeInsets.only(
                    top: 12,
                    bottom: kToolbarHeight +
                        MediaQuery.of(context).padding.bottom / 2),
                itemCount:
                    agencyViewModel.searchModel.value.data!.agency!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item =
                      agencyViewModel.searchModel.value.data!.agency![index];
                  return AgencyCard(
                    agency: item,
                    onTap: () {},
                  );
                },
                separatorBuilder: (c, i) {
                  return Divider(
                    height: 18,
                    color: Colors.grey[400],
                  );
                },
              ),
      ),
    );
  }
}
