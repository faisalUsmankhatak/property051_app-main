import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../cachedimage.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 16),
      width: width,
      decoration: const BoxDecoration(
        color: AppColor.whiteColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: commonCacheImageWidget(
              'https://na.rdcpix.com/502be9c9ae1e0cd8a1e7e8351bd939ccw-c2904779839rd-w300_h200_r4_q80.jpg',
              width / 4,
              fit: BoxFit.cover,
              width: width / 3,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled type and scrambled',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.mulishFont,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 6),
                Text(
                  'Just Now',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
