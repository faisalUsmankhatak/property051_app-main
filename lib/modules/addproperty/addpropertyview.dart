// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:property_051/utils/global.dart';
import '../../components/cupertino/tileview.dart';
import '../../utils/colors.dart';
import 'addpropertyviewmodel.dart';
import 'component.dart';

class AddPropertyView extends StatelessWidget {
  // var addPropertyViewModel = Get.put(AddPropertyViewModel());
  var addPropertyViewModel = Get.find<AddPropertyViewModel>();

  AddPropertyView() {
    addPropertyViewModel.getLocations();
    addPropertyViewModel.getPropertySubTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: addPropertyAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              controller: addPropertyViewModel.listScrollController,
              children: [
                topWidget(context),
                areaWidget(),
                bedBathWidget(),
                priceWidget(),
                installmentSection(),
                rentalSection(),
                contactInfo(),
                titleDesc(),
                imageWidget(),
                cupertinoButton(
                  title: 'Save',
                  color: AppColor.proimaryColor,
                  onPressed: () async {
                    if (addPropertyViewModel.validateForm()) {
                      var res = await addPropertyViewModel.addProperty();
                      if (res) {
                        await GlobalWidet().showCupertinoDialog(
                          icon: Icons.done_outline,
                          title: 'Success',
                          message:
                              'Your property has been added successfully. Please wait for admin approval.',
                        );
                        addPropertyViewModel.resetForm();
                        Get.back();
                      } else {
                        await GlobalWidet().showCupertinoDialog(
                          icon: Icons.error_outline,
                          title: 'Whoops',
                          message: 'Something went wrong. Please try again',
                        );
                      }
                    }
                  },
                ),
              ],
            ),
            Obx(
              () => addPropertyViewModel.isLoading.value
                  ? Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: AppColor.greyColor.withOpacity(0.3),
                      ),
                      child: SpinKitCircle(
                        color: AppColor.proimaryColor,
                        size: 50.0,
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
