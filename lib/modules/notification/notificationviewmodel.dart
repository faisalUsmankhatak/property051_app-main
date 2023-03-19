import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class NotificationViewModel extends GetxController {
  RxBool showAppBar = false.obs;
  ScrollController? listScrollController = ScrollController();
  List<NotificationModel>? notificationList;
  @override
  void onInit() {
    super.onInit();
    listScrollController!.addListener(() {
      if (listScrollController!.positions.last.userScrollDirection ==
          ScrollDirection.reverse) {
        showAppBar.value = true;
      } else if (listScrollController!.positions.last.userScrollDirection ==
          ScrollDirection.forward) {
        showAppBar.value = false;
      }
    });
    notificationList = getNotificationList();
  }

  List<NotificationModel> getNotificationList() {
    List<NotificationModel> notificationList = [];
    notificationList.add(
      NotificationModel(
        id: '1',
        notiTme: 'Just Now',
        name: 'Property Added Successfully',
        msg: 'Your property has been added successfully',
        status: 'Just Now',
        notiType: '1',
      ),
    );
    notificationList.add(
      NotificationModel(
        id: '1',
        notiTme: '3 minutes ago',
        name: 'Property Approved',
        msg: 'Your Property has been approved',
        status: 'Just Now',
        notiType: '2',
      ),
    );
    notificationList.add(
      NotificationModel(
        id: '1',
        name: 'Property Disapproved',
        msg: 'Your property has been disapproved',
        notiTme: '1 month ago',
        status: 'Just Now',
        notiType: '3',
      ),
    );
    notificationList.add(
      NotificationModel(
        id: '1',
        name: 'Property Featured',
        msg: 'Your property has been featured',
        notiTme: '1 month ago',
        status: 'Just Now',
        notiType: '6',
      ),
    );
    notificationList.add(
      NotificationModel(
        id: '1',
        notiTme: 'Just Now',
        name: 'Property ID - 12345',
        msg: 'Jawad Abbasi viewed your property',
        status: 'Just Now',
        notiType: '4',
      ),
    );
    notificationList.add(
      NotificationModel(
        id: '1',
        notiTme: '5 days ago',
        name: 'Property ID - 12345',
        msg: 'Jawad Abbasi wants to buy your property',
        status: 'Just Now',
        notiType: '5',
      ),
    );
    notificationList.add(
      NotificationModel(
        id: '1',
        notiTme: 'Just Now',
        name: 'Property Added Successfully',
        msg: 'Your property has been added successfully',
        status: 'Just Now',
        notiType: '1',
      ),
    );
    notificationList.add(
      NotificationModel(
        id: '1',
        notiTme: '3 minutes ago',
        name: 'Property Approved',
        msg: 'Your Property has been approved',
        status: 'Just Now',
        notiType: '2',
      ),
    );
    notificationList.add(
      NotificationModel(
        id: '1',
        name: 'Property Disapproved',
        msg: 'Your property has been disapproved',
        notiTme: '1 month ago',
        status: 'Just Now',
        notiType: '3',
      ),
    );
    notificationList.add(
      NotificationModel(
        id: '1',
        name: 'Property Featured',
        msg: 'Your property has been featured',
        notiTme: '1 month ago',
        status: 'Just Now',
        notiType: '6',
      ),
    );
    notificationList.add(
      NotificationModel(
        id: '1',
        notiTme: 'Just Now',
        name: 'Property ID - 12345',
        msg: 'Jawad Abbasi viewed your property',
        status: 'Just Now',
        notiType: '4',
      ),
    );
    notificationList.add(
      NotificationModel(
        id: '1',
        notiTme: '5 days ago',
        name: 'Property ID - 12345',
        msg: 'Jawad Abbasi wants to buy your property',
        status: 'Just Now',
        notiType: '5',
      ),
    );
    return notificationList;
  }
}

class NotificationModel {
  String? id;
  String? img;
  String? name;
  String? msg;
  String? status;
  String? callInfo;
  String? notiTme;
  String? notiType;
  String? notiReadStatus;

  NotificationModel({
    this.id,
    this.img,
    this.name,
    this.msg,
    this.status,
    this.callInfo,
    this.notiTme,
    this.notiType,
    this.notiReadStatus,
  });
}
