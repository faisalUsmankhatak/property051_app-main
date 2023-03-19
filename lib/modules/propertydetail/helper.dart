import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:property_051/modules/propertydetail/propertydetailviewmodel.dart';
import 'package:property_051/modules/search/searchviewmodel.dart';
import 'package:property_051/utils/extensions.dart';
import 'package:property_051/utils/url_launcher_utils.dart';
import '../../app/model/property/propertymodel.dart';
import '../../components/cachedimage.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import '../../utils/utilities.dart';

imageSlider({PropertiesData? property}) {
  final imageLength = getPropertyImagePaths(property: property).length;
  RxInt counter = 1.obs;
  return Stack(
    children: [
      ImageSlideshow(
        width: double.infinity,
        height: Get.width * 0.6,
        initialPage: 0,
        indicatorColor: AppColor.whiteColor,
        indicatorBackgroundColor: Colors.grey,
        children: getPropertyImagePaths(property: property).map((e) {
          return commonCacheImageWidget(
            e,
            Get.width * 0.6,
            fit: BoxFit.cover,
            width: double.infinity,
          );
        }).toList(),
        onPageChanged: (value) {
          counter.value = value + 1;
        },
        autoPlayInterval: null,
        isLoop: true,
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Obx(
          () => Container(
            height: (Get.width * 0.6) / 5,
            padding: EdgeInsets.only(bottom: 0, right: 10),
            alignment: Alignment.centerRight,
            width: Get.width,
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                end: const Alignment(0.0, -1),
                begin: const Alignment(0.0, 0.6),
                colors: <Color>[
                  const Color(0x8A000000),
                  Colors.black12.withOpacity(0.0)
                ],
              ),
            ),
            child: Text(
              '${counter.value}/$imageLength',
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 3,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

titlePrice({PropertiesData? property}) {
  return Container(
    padding: const EdgeInsets.only(left: 6, right: 10, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(left: 4, right: 10),
              alignment: Alignment.bottomCenter,
              child: Text(
                '${getPropertyTitle(property: property!)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.mulishFont,
                ),
                maxLines: 1,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 1.6),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'PKR',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.mulishFont,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    '${getFriendlyPrice(property.property!.price!, unit: '1')}',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.mulishFont,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 18,
              color: AppColor.proimaryColor,
            ),
            SizedBox(width: 3),
            Expanded(
              child: Text(
                '${getLoctionName(property: property, size: 60)}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.mulishFont,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

bedBaths({PropertiesData? property}) {
  return Container(
    padding: const EdgeInsets.only(left: 9, right: 10, top: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        boxShape(
          title: '${getNoBeds(property: property)} Beds',
          icon: Icons.bed_rounded,
        ),
        SizedBox(width: 6),
        boxShape(
          title: '${property!.property!.noBath} Baths',
          icon: Icons.bathtub_outlined,
        ),
        SizedBox(width: 6),
        boxShape(
          title: '${property.property!.area} ${property.unit!.unitName}',
          icon: Icons.maps_home_work_outlined,
        ),
        SizedBox(width: 6),
        boxShape(
          title:
              '${DateTime.now().convertToAgo(DateTime.parse(property.property!.createdAt!))}',
          icon: Icons.calendar_month_outlined,
        ),
      ],
    ),
  );
}

boxShape({String? title, IconData? icon}) {
  return Container(
    height: 70,
    width: Get.width / 4.5,
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: AppColor.greyColor, width: 0.3),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppColor.proimaryColor.withOpacity(0.7),
          size: 30,
        ),
        SizedBox(height: 5),
        Text(
          '$title',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.mulishFont,
          ),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

descWidget({PropertiesData? property}) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 14, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.mulishFont,
          ),
          maxLines: 1,
        ),
        SizedBox(height: 3),
        Text(
          '${property!.property!.description}',
          // 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.mulishFont,
          ),
          maxLines: 6,
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 6),
        // Divider(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Posted',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.mulishFont,
              ),
              maxLines: 1,
            ),
            SizedBox(width: 6),
            Text(
              '2 days ago',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.mulishFont,
              ),
              maxLines: 6,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ],
    ),
  );
}

viewOnMap({Function()? onTap}) {
  final viewModel = Get.find<PropertyDetailViewModel>();
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: Get.width / 1.7,
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColor.greyColor, width: 0.5),
      ),
      child: GoogleMap(
        mapType: MapType.terrain,
        onMapCreated: viewModel.onMapCreated,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
        indoorViewEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        scrollGesturesEnabled: false,
        initialCameraPosition: CameraPosition(
          target: viewModel.latLng!,
          zoom: 14.0,
        ),
        markers: Set<Marker>.of(viewModel.markers.value.values),
      ),
    ),
  );
}
// viewOnMap({Function()? onTap}) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       height: 48,
//       width: double.infinity,
//       alignment: Alignment.center,
//       margin: EdgeInsets.only(left: 10, right: 10, top: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: AppColor.greyColor, width: 0.5),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.map_outlined,
//             size: 23,
//             color: AppColor.proimaryColor,
//           ),
//           SizedBox(width: 10),
//           Text(
//             'View on Map',
//             style: TextStyle(
//               color: AppColor.proimaryColor,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               fontFamily: AppFonts.mulishFont,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

contactDetails({PropertiesData? property}) {
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
    decoration: BoxDecoration(
        // color: Colors.white,
        // borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColor.greyColor),
        ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Contact Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.mulishFont,
          ),
          maxLines: 1,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: commonCacheImageWidget(
                // property!.customer!.avatar != null
                // ? property.customer!.avatar!
                // :
                Get.find<SearchViewModel>().properties.value.data != null
                    ? Get.find<SearchViewModel>()
                        .properties
                        .value
                        .data!
                        .defaultUserAvatar!
                    : 'https://www.property051.com/images/person123.png',
                60,
                fit: BoxFit.cover,
                width: 60,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${property!.customer!.firstName} ${property.customer!.lastName}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.mulishFont,
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Property Owner',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.mulishFont,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            button(
              width: Get.width / 2,
              height: 40,
              icon: CupertinoIcons.phone_arrow_up_right,
              color: AppColor.greyColor.withOpacity(0.3),
              title: 'Call',
              showIcon: true,
              onPressed: () {
                UrlLauncherUtils.launchPhoneUrl(
                  '${property.property!.contactNo}',
                );
              },
            ),
            SizedBox(width: 10),
            button(
              width: Get.width / 2.45,
              height: 40,
              icon: FontAwesomeIcons.whatsapp,
              color: AppColor.greyColor.withOpacity(0.1),
              title: 'Whatsapp',
              showIcon: true,
              onPressed: () {
                UrlLauncherUtils.launchWhatsapp(
                  '${property.property!.whatsappNumber}',
                  text: 'Hello',
                );
              },
            ),
          ],
        ),
      ],
    ),
  );
}

amenDetails() {
  var vieewModel = Get.find<PropertyDetailViewModel>();
  var utilities = vieewModel.aminitiesModel.value.data!.propertyFeaturesA!
      .map((e) => e.name!)
      .toList();
  var features = vieewModel.aminitiesModel.value.data!.propertyFeaturesB!
      .map((e) => e.name!)
      .toList();
  var facings = vieewModel.aminitiesModel.value.data!.propertyFeaturesC!
      .map((e) => e.name!)
      .toList();
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
    decoration: BoxDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'AMENITIES',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.mulishFont,
          ),
          maxLines: 1,
        ),
        SizedBox(height: 10),
        utilities.length > 0
            ? aminitySection(
                title: 'Utilities',
                aminities: utilities,
              )
            : Container(),
        features.length > 0
            ? aminitySection(
                title: 'Features',
                aminities: features,
              )
            : Container(),
        facings.length > 0
            ? aminitySection(
                title: 'Facing',
                aminities: facings,
              )
            : Container(),
      ],
    ),
  );
}

aminitySection({String? title, List<String>? aminities}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColor.greyColor.withOpacity(0.1),
        ),
        child: Text(
          '$title',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.mulishFont,
          ),
          maxLines: 1,
        ),
      ),
      SizedBox(height: 13),
      Wrap(
        alignment: WrapAlignment.start,
        children: [
          for (var i = 0; i < aminities!.length; i++)
            Container(
              margin: const EdgeInsets.only(right: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: AppColor.greyColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColor.proimaryColor,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '${aminities[i]}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.mulishFont,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
        ],
      ),
    ],
  );
}

button(
    {double? width,
    double? height,
    String? title,
    Color? color,
    bool showIcon = true,
    IconData? icon,
    VoidCallback? onPressed}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColor.greyColor.withOpacity(0.5),
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(5),
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            showIcon ? CrossAxisAlignment.end : CrossAxisAlignment.center,
        children: [
          showIcon
              ? Icon(
                  icon,
                  size: 20,
                  color: AppColor.blackColor,
                )
              : Container(),
          showIcon ? SizedBox(width: 8) : Container(),
          Text(
            '$title',
            style: TextStyle(
              color: AppColor.proimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.mulishFont,
            ),
          ),
        ],
      ),
      onPressed: onPressed,
    ),
  );
}
