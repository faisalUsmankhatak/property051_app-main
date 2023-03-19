import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_051/services/api/comment.dart';
import 'package:property_051/services/localstorage/SessionManager.dart';

import '../../../app/model/comment/commentmodel.dart';
import '../../../app/model/trade/trade.dart';

class TradeDetailViewModel extends GetxController {
  SessionManager sessionManager = SessionManager();
  RxBool isLoading = false.obs;
  Trade trade = Trade();
  TextEditingController commentController = TextEditingController();
  Rx<CommentModel> commentModel = CommentModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  getComments() async {
    try {
      isLoading.value = true;
      commentModel.value = await CommentService.getComments('${trade.id}');
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('${e.toString()}');
    }
  }

  adddComment() async {
    try {
      isLoading.value = true;
      await CommentService.addComment(
        chatID: '${trade.id}',
        sendBy: '${sessionManager.userID}',
        recBy: '${trade.customerId}',
        comment: '${commentController.text}',
      );
      getComments();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('${e.toString()}');
    }
  }
}
