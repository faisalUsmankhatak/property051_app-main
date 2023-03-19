// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:property_051/utils/fonts.dart';
import 'package:property_051/utils/utilities.dart';
import '../../app/model/property/propertymodel.dart';
import '../../utils/colors.dart';
import '../cachedimage.dart';

class PropertyCard extends StatelessWidget {
  PropertiesData? property;
  VoidCallback? onTap;
  PropertyCard({this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 199, 196, 196),
                      width: 0.6,
                    ),
                  ),
                  child: ImageSlideshow(
                    width: double.infinity,
                    height: 200,
                    initialPage: 0,
                    indicatorColor: AppColor.whiteColor,
                    indicatorBackgroundColor: Colors.grey,
                    indicatorRadius: 4,
                    // ignore: sort_child_properties_last
                    children: property!.propertyImages!.isNotEmpty
                        ? property!.propertyImages!.map((e) {
                            return commonCacheImageWidget(
                              'https://www.property051.com/storage/upload/properties/${e.imagePath!}',
                              width / 2,
                              fit: BoxFit.cover,
                              width: width,
                            );
                          }).toList()
                        : [
                            commonCacheImageWidget(
                              'https://www.property051.com/storage/upload/location/images/E-11_1630476540.png',
                              width / 2,
                              fit: BoxFit.cover,
                              width: width,
                            ),
                          ],
                    // ignore: sort_child_properties_last
                    // children: [
                    //   Image.network(
                    //     'https://na.rdcpix.com/c1b272fee7ef7bf8e4c9e127cbaf910ew-c3877779751rd-w628_h354_r4_q80.jpg',
                    //     fit: BoxFit.cover,
                    //   ),
                    //   Image.network(
                    //     'https://na.rdcpix.com/c1b272fee7ef7bf8e4c9e127cbaf910ew-c3877779751rd-w628_h354_r4_q80.jpg',
                    //     fit: BoxFit.cover,
                    //   ),
                    //   Image.network(
                    //     'https://na.rdcpix.com/c1b272fee7ef7bf8e4c9e127cbaf910ew-c3877779751rd-w628_h354_r4_q80.jpg',
                    //     fit: BoxFit.cover,
                    //   ),
                    // ],
                    onPageChanged: (value) {},
                    autoPlayInterval: null, isLoop: true,
                  ),
                  // child: commonCacheImageWidget(
                  // property!.propertyImages!.isNotEmpty
                  //     ? 'https://www.property051.com/storage/upload/properties/${property!.propertyImages!.first.imagePath!}'
                  //     : 'https://www.property051.com/storage/upload/location/images/E-11_1630476540.png',
                  //   width / 2,
                  // fit: BoxFit.cover,
                  // width: width,
                  // ),
                ),
                const Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    CupertinoIcons.heart,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'PKR ${property!.property!.price}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${property!.property!.noBed} Beds   ${property!.property!.noBath} Baths   ${property!.property!.areaInSqft} sqft',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${property!.property!.address}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyCard1 extends StatelessWidget {
  PropertiesData? property;
  PropertyCard1({this.property});

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return Container(
      width: width,
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              commonCacheImageWidget(
                'https://ap.rdcpix.com/b843fecfcf847b2d46e7ae65f8486876l-m3028414275od-w480_h360_x2.webp',
                width / 2,
                fit: BoxFit.cover,
                width: width,
              ),
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  CupertinoIcons.heart,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              'PKR 70 Lac',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              '4 beds, 2 bath, 1,500 sqft',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              '6495 Broadway, New York, NY 10019',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyCard2 extends StatelessWidget {
  PropertiesData? property;
  VoidCallback? onTap;
  bool? isFav;
  double radius;
  bool? showFav;
  Function(DragUpdateDetails)? onDragUpdateDetails;
  Function(DragEndDetails)? onVerticalDragEnd;
  Function(DragEndDetails)? onHorizontalDragEnd;
  PropertyCard2({
    this.property,
    this.onTap,
    this.isFav,
    this.radius = 6,
    this.showFav = true,
    this.onDragUpdateDetails,
    this.onVerticalDragEnd,
    this.onHorizontalDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          onPanUpdate: onDragUpdateDetails,
          onHorizontalDragEnd: onHorizontalDragEnd,
          onVerticalDragEnd: onVerticalDragEnd,
          child: Container(
            height: width / 3.39,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            width: width,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  // child: Image.asset('images/icons/mapMarker.png'),
                  child: commonCacheImageWidget(
                    '${getPropertyImagePath(property: property!)}',
                    // property!.propertyImages!.isNotEmpty
                    //     ? 'https://www.property051.com/storage/upload/properties/${property!.propertyImages![0].imagePath}'
                    //     : 'https://ap.rdcpix.com/b843fecfcf847b2d46e7ae65f8486876l-m3028414275od-w480_h360_x2.webp',
                    width / 3.5,
                    fit: BoxFit.cover,
                    width: width / 3.5,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 18),
                        child: Text(
                          // '2 Bedroom Apartment',
                          '${getPropertyTitle(property: property!)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.mulishFont,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        child: Text(
                          '${getLoctionName(property: property)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.mulishFont,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.bed_double,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${getNoBeds(property: property)}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Icon(
                            Icons.bathtub_outlined,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${property!.property!.noBath}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Icon(
                            CupertinoIcons.arrow_2_squarepath,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${property!.property!.area} ${property!.unit!.unitName}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'PKR ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.mulishFont,
                              ),
                            ),
                            Text(
                              '${getFriendlyPrice(property!.property!.price!)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.mulishFont,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showFav!)
          if (isFav != null)
            Positioned(
              top: 8,
              right: 8,
              child: Icon(
                !isFav! ? CupertinoIcons.heart : CupertinoIcons.heart_fill,
                color: AppColor.proimaryColor,
                size: 22,
              ),
            ),
        if (showFav!)
          if (isFav == null)
            Positioned(
              top: 8,
              right: 8,
              child: Icon(
                CupertinoIcons.heart,
                color: AppColor.proimaryColor,
                size: 22,
              ),
            )
      ],
    );
  }
}

class MyPropertyCard extends StatelessWidget {
  PropertiesData? property;
  VoidCallback? onTap;
  double radius;
  Function(DragUpdateDetails)? onDragUpdateDetails;
  Function(DragEndDetails)? onVerticalDragEnd;
  Function(DragEndDetails)? onHorizontalDragEnd;
  MyPropertyCard({
    this.property,
    this.onTap,
    this.radius = 6,
    this.onDragUpdateDetails,
    this.onVerticalDragEnd,
    this.onHorizontalDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          onPanUpdate: onDragUpdateDetails,
          onHorizontalDragEnd: onHorizontalDragEnd,
          onVerticalDragEnd: onVerticalDragEnd,
          child: Container(
            height: width / 3.5,
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            width: width,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      // child: Image.asset('images/icons/mapMarker.png'),
                      child: commonCacheImageWidget(
                        '${getPropertyImagePath(property: property!)}',
                        // property!.propertyImages!.isNotEmpty
                        //     ? 'https://www.property051.com/storage/upload/properties/${property!.propertyImages![0].imagePath}'
                        //     : 'https://ap.rdcpix.com/b843fecfcf847b2d46e7ae65f8486876l-m3028414275od-w480_h360_x2.webp',
                        width / 3.5,
                        fit: BoxFit.cover,
                        width: width / 3.5,
                      ),
                    ),
                    if (property!.property!.status == 'Disapproved')
                      Positioned(
                        bottom: 0,
                        child: cupertinoButton(
                          icon: Icons.edit_location_outlined,
                          onTap: () {},
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 18),
                        child: Text(
                          // '2 Bedroom Apartment',
                          '${getPropertyTitle(property: property!)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.mulishFont,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        child: Text(
                          '${getLoctionName(property: property)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.mulishFont,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.bed_double,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${getNoBeds(property: property)}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Icon(
                            Icons.bathtub_outlined,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${property!.property!.noBath}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Icon(
                            CupertinoIcons.arrow_2_squarepath,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${property!.property!.area} ${property!.unit!.unitName}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'PKR ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.mulishFont,
                              ),
                            ),
                            Text(
                              '${getFriendlyPrice(property!.property!.price!)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.mulishFont,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (property!.property!.status != 'Disapproved' &&
            property!.property!.subStatus != 2)
          Container(
            width: width,
            margin: EdgeInsets.only(left: 4, right: 10, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cupertinoButton(
                  icon: Icons.edit_location_outlined,
                  onTap: () {},
                ),
                cupertinoButton(
                  icon: Icons.verified_user_outlined,
                  onTap: () {},
                ),
                cupertinoButton(
                  icon: CupertinoIcons.bolt,
                  onTap: () {},
                ),
                if (property!.property!.status != 'Pending')
                  cupertinoButton(
                    icon: CupertinoIcons.check_mark_circled,
                    onTap: () {},
                  ),
                cupertinoButton(
                  icon: CupertinoIcons.trash,
                  onTap: () {},
                ),
              ],
            ),
          ),
      ],
    );
  }

  cupertinoButton({String? title, IconData? icon, Function()? onTap}) {
    return Container(
      height: 28,
      constraints: BoxConstraints(
        minWidth: 40,
        maxWidth: 50,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: AppColor.greyColor.withOpacity(0.5),
          width: 0.7,
        ),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Center(
          child: Icon(
            icon,
            color: AppColor.proimaryColor,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class PropertyCard2Copy extends StatelessWidget {
  PropertiesData? property;
  VoidCallback? onTap;
  double radius;
  PropertyCard2Copy({this.property, this.onTap, this.radius = 6});

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return Stack(
      children: [
        Container(
          height: width / 3.5,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          width: width,
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: commonCacheImageWidget(
                  'https://ap.rdcpix.com/b843fecfcf847b2d46e7ae65f8486876l-m3028414275od-w480_h360_x2.webp',
                  width / 3.5,
                  fit: BoxFit.cover,
                  width: width / 3.5,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        '2 Bedroom Apartment',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.mulishFont,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      child: const Text(
                        '6495 Broadway, New York, NY 10019',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.mulishFont,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          CupertinoIcons.bed_double,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          '4',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Icon(
                          Icons.bathtub_outlined,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          '4',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Icon(
                          CupertinoIcons.arrow_2_squarepath,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: const Text(
                            '4 sq. Feet',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Container(
                      child: const Text(
                        'PKR 70 Lac',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.mulishFont,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Icon(
            CupertinoIcons.heart,
            color: AppColor.proimaryColor,
            size: 22,
          ),
        )
      ],
    );
  }
}
