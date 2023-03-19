// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/cachedimage.dart';
import '../../components/cards/blogcard.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../blog/blogviewmodel.dart';

class BlogView extends StatelessWidget {
  var blogViewModel = Get.put(BlogViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            Platform.isAndroid ? AppBar().preferredSize.height : 40),
        child: Obx(
          () => AppBar(
            elevation: blogViewModel.showAppBar.value ? 0.5 : 0.0,
            title: const Text('News'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: blogViewModel.listScrollController,
        child: Container(
          color: AppColor.whiteColor,
          padding: EdgeInsets.only(
              bottom:
                  kToolbarHeight + MediaQuery.of(context).padding.bottom / 2),
          // height: Get.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              firstBlog(),
              Flexible(
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 12),
                  itemCount: 7,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const BlogCard();
                  },
                  separatorBuilder: (c, i) {
                    return Divider(
                      height: 15,
                      color: Colors.grey[400],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  firstBlog() {
    var width = Get.width;
    return GestureDetector(
      onTap: () {
        blogViewModel.showString();
      },
      child: Stack(
        children: [
          commonCacheImageWidget(
            'https://na.rdcpix.com/5cd180b8ecd05fda995b12935239e485w-c1955463063rd-w628_h354_r4_q80.jpg',
            width / 1.5,
            fit: BoxFit.cover,
            width: width,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              // Clip it cleanly.
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    stops: const [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      Colors.black.withOpacity(.8),
                      Colors.black.withOpacity(.4),
                      Colors.black.withOpacity(.2),
                      const Color.fromARGB(255, 115, 111, 111).withOpacity(.1),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 30),
                    Text(
                      'Economists Have a Strange New Buzzword for the Housing Market That Will Shock Buyers and Sellers ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.mulishFont,
                        color: AppColor.whiteColor,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Just Now',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: const [
          //     Text(
          //       'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled type and scrambled',
          //       style: TextStyle(
          //         fontSize: 13,
          //         fontWeight: FontWeight.w500,
          //         fontFamily: AppFonts.mulishFont,
          //       ),
          //       maxLines: 5,
          //       overflow: TextOverflow.ellipsis,
          //       textAlign: TextAlign.justify,
          //     ),
          //     SizedBox(height: 6),
          //     Text(
          //       'Just Now',
          //       style: TextStyle(
          //         fontSize: 12,
          //         color: Colors.grey,
          //       ),
          //     ),
          //   ],
          // ),
          // ),
        ],
      ),
    );
  }
}
