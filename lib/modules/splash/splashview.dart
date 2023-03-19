// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splashviewmodel.dart';

class SplashView extends StatelessWidget {
  final SplashViewModel splashViewModel = Get.put(SplashViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          width: Get.width * 0.80,
          image: AssetImage('images/app/logo.png'),
        ),
      ),
    );
  }
}
