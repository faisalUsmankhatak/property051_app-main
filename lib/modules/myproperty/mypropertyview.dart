// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_051/utils/colors.dart';
import 'package:property_051/utils/fonts.dart';
import '../../components/appbar.dart';
import '../../components/cards/propertycard.dart';
import '../../routes/approutes.dart';
import '../../utils/global.dart';
import 'component.dart';
import 'mypropertyviewmodel.dart';

class MyPropertiesView extends StatelessWidget {
  var myPropertiesViewModel = Get.put(MyPropertiesViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: appBar(title: 'My Properties', previousTitle: 'Back'),
      body: Container(
          color: AppColor.whiteColor,
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              propertyTypeList(),
              Obx(
                () => !myPropertiesViewModel.isException.value
                    ? !myPropertiesViewModel.isLoading.value
                        ? propertyList(context)
                        : GlobalWidet().loader()
                    : GlobalWidet().noInternet(
                        message: 'Something went wrong',
                        onTap: () {
                          myPropertiesViewModel.getMyProperties();
                        },
                      ),
              ),
            ],
          )),
    );
  }

  propertyList(context) {
    var properties = myPropertiesViewModel.properties.value.data!.myproperties;
    if (properties!.length < 1) return noProopertyFound();
    if (myPropertiesViewModel.page.value == 0) {
      properties = properties
          .where((proerty) =>
              proerty.property!.status == 'Approved' &&
              proerty.property!.subStatus == 1)
          .toList();
    } else if (myPropertiesViewModel.page.value == 1) {
      properties = properties
          .where((proerty) => proerty.property!.status == 'Pending')
          .toList();
    } else if (myPropertiesViewModel.page.value == 2) {
      properties = properties
          .where((proerty) => proerty.property!.status == 'Disapproved')
          .toList();
    } else if (myPropertiesViewModel.page.value == 3) {
      properties = properties
          .where((proerty) => proerty.property!.subStatus == 2)
          .toList();
    } else {
      properties = properties;
    }
    if (properties.length < 1) return noTypeProoperty();
    return Container(
      height: Get.height,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 0, bottom: kToolbarHeight + 100),
        itemCount: properties.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var item = properties![index];
          return MyPropertyCard(
            property: item,
            onTap: () {
              Get.toNamed(AppRoutes.propertyDetail, arguments: item);
            },
          );
        },
        separatorBuilder: (c, i) {
          return Divider(
            height: 5,
            color: Colors.grey[400],
          );
        },
      ),
    );
  }

  noProopertyFound() {
    return Container(
      height: Get.height - 100 - kToolbarHeight,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Properties Found',
              style: TextStyle(
                fontSize: 20,
                color: AppColor.blackColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Please add your property',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.greyColor,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.proimaryColor),
              ),
              onPressed: () async {
                await Get.toNamed(AppRoutes.addProperty);
                myPropertiesViewModel.getMyProperties();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.add_circled,
                    color: AppColor.whiteColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Add Property',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.whiteColor,
                      fontFamily: AppFonts.mulishFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  noTypeProoperty() {
    return Container(
      height: Get.height - 100 - kToolbarHeight,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Properties Found',
              style: TextStyle(
                fontSize: 20,
                color: AppColor.blackColor,
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
