// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:property_051/modules/search/searchviewmodel.dart';
import 'package:property_051/routes/approutes.dart';
import 'package:property_051/utils/colors.dart';
import 'package:property_051/utils/fonts.dart';
import '../../app/model/property/propertymodel.dart';
import '../../components/cards/propertycard.dart';
import '../../components/cupertino/tileview.dart';
import '../../components/listloader.dart';
import '../../utils/global.dart';

class SearchView extends StatelessWidget {
  var searchViewModel = Get.put(SearchViewModel());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: Column(
            children: [
              topInfoSearch(
                onTapMap: () {
                  // searchViewModel.isMap.value = !searchViewModel.isMap.value;
                },
                onTapFilter: () {
                  searchViewModel.initScrolls();
                  Get.toNamed(AppRoutes.filter);
                },
              ),
              Obx(
                () => Expanded(
                  child: IndexedStack(
                    index: searchViewModel.isMap.value ? 0 : 1,
                    children: [
                      mapWidget(),
                      propertiesList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  mapPropertyList() {
    return Container(
      height: Get.width / 3.5,
      width: Get.width,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: searchViewModel.propertyPageController,
        itemCount: searchViewModel.propertyPagingController.itemList!.length,
        itemBuilder: (c, i) {
          var item = searchViewModel.propertyPagingController.itemList![i];
          return PropertyCard2(
            property: item,
            radius: 0,
            onTap: () {
              // searchViewModel.getCurrentLocation();
              Get.toNamed(AppRoutes.propertyDetail, arguments: item);
              // searchViewModel.savePropertyToLocalDB(item);
              // Get.find<DashBoardViewModel>().getProperties();
            },
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                searchViewModel.isLoading.value = true;
              } else if (details.primaryVelocity! < 0) {
                Get.toNamed(AppRoutes.propertyDetail, arguments: item);
              }
            },
            // onHorizontalDragEnd: (details) {
            //   if (details.primaryVelocity! > 0) {
            //     log('Left Swipe');
            //   } else if (details.primaryVelocity! < 0) {
            //     log('Right Swipe');
            //   }
            // },
          );
        },
        onPageChanged: (index) {
          log(index.toString());
          if (index > 10) {
            index = ((10 / index) * 10).toInt();
          }
          if (index < 1) {
            index = 1;
          }
          log(index.toString());
          searchViewModel.mapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  searchViewModel.markers.value[MarkerId('placeId$index')]!
                      .position.latitude,
                  searchViewModel.markers.value[MarkerId('placeId$index')]!
                      .position.longitude,
                ),
                zoom: 15,
              ),
            ),
          );
        },
      ),
    );
  }

  propertiesList() {
    return Container(
      child: PagedListView<int, PropertiesData>.separated(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        shrinkWrap: true,
        pagingController: searchViewModel.propertyPagingController,
        builderDelegate: PagedChildBuilderDelegate<PropertiesData>(
          itemBuilder: (context, item, index) {
            return PropertyCard2(
              property: item,
              isFav: searchViewModel.sessionManager.isUserLogin
                  ? item.favproperty != null
                      ? item.favproperty!.isNotEmpty
                          ? true
                          : false
                      : false
                  : false,
              onTap: () {
                Get.toNamed(AppRoutes.propertyDetail, arguments: item);
                searchViewModel.savePropertyToLocalDB(item);
                // Get.find<DashBoardViewModel>().getProperties();
              },
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return Center(
              child: GlobalWidet().noInternet(
                message: 'Something went wrong',
                onTap: () {
                  searchViewModel.getProperties(1);
                },
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (context) {
            return shimmerListLoader(count: 5);
          },
          newPageProgressIndicatorBuilder: (context) {
            return const Center(
              child: SpinKitFadingCircle(
                color: AppColor.blackColor,
                size: 50.0,
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return noProperty();
          },
        ),
        separatorBuilder: (context, index) {
          return Container(height: 12);
        },
      ),
    );
  }

  noProperty() {
    return Container(
      height: Get.height - 100 - kToolbarHeight,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/icons/society.png",
              height: 50,
              width: 50,
            ),
            Text(
              'No Properties Found',
              style: TextStyle(
                fontSize: 20,
                color: AppColor.blackColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Try to change your applied search filters.',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                searchViewModel.initScrolls();
                Get.toNamed(AppRoutes.filter);
              },
              child: Container(
                margin: EdgeInsets.only(left: 9),
                padding: EdgeInsets.only(left: 5, right: 7, top: 3, bottom: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // color: AppColor.greyColor.withOpacity(0.2),
                  border: Border.all(
                    color: AppColor.greyColor.withOpacity(0.2),
                  ),
                ),
                child: Container(
                  width: Get.width / 3,
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.tune,
                        color: AppColor.proimaryColor,
                      ),
                      SizedBox(width: 3),
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.mulishFont,
                          color: AppColor.proimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  mapWidget() {
    return Stack(
      children: [
        Obx(
          () => GestureDetector(
            onPanUpdate: (searchViewModel.drawPolygonEnabled.value)
                ? searchViewModel.onPanUpdate
                : null,
            onPanEnd: (searchViewModel.drawPolygonEnabled.value)
                ? searchViewModel.onPanEnd
                : null,
            child: GoogleMap(
              mapType: MapType.hybrid,
              onMapCreated: searchViewModel.onMapCreated,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              // trafficEnabled: true,
              indoorViewEnabled: true,
              initialCameraPosition: CameraPosition(
                target: searchViewModel.center,
                zoom: 12.0,
              ),
              // circles: searchViewModel.circles,
              polygons: searchViewModel.polygons.toSet(),
              polylines: searchViewModel.polyLines.toSet(),
              markers: Set<Marker>.of(searchViewModel.markers.value.values),
              onTap: (latLong) {
                log(latLong.toString());
                searchViewModel.checkLatLong(latLong);
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Obx(
            () => IndexedStack(
              index: searchViewModel.isLoading.value ? 0 : 1,
              children: [
                Container(),
                searchViewModel.isListEmpty.value
                    ? Container()
                    : mapPropertyList(),
              ],
            ),
          ),
        ),
        // child: Obx(
        //   () => !searchViewModel.isLoading.value
        //       ? mapPropertyList()
        //       : Container(),
        // ),

        Positioned(
          bottom: Get.width / 3.2,
          right: 4,
          child: Column(
            children: [
              Container(
                child: FloatingActionButton(
                  heroTag: 'btn1',
                  backgroundColor: AppColor.backgroundColor,
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.location_north,
                        size: 22,
                        color: AppColor.proimaryColor,
                      ),
                      SizedBox(height: 3),
                      Text(
                        'NearBy',
                        style: TextStyle(
                          color: AppColor.proimaryColor,
                          fontSize: 10,
                          fontFamily: AppFonts.mulishFont,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                child: FloatingActionButton(
                  heroTag: 'btn2',
                  backgroundColor: AppColor.backgroundColor,
                  onPressed: searchViewModel.toggleDrawing,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        (searchViewModel.drawPolygonEnabled.value)
                            ? CupertinoIcons.clear_thick
                            : Icons.draw_outlined,
                        color: AppColor.proimaryColor,
                        size: 22,
                      ),
                      SizedBox(height: 3),
                      Text(
                        (!searchViewModel.drawPolygonEnabled.value)
                            ? 'Draw'
                            : 'Cancel',
                        style: TextStyle(
                          color: AppColor.proimaryColor,
                          fontSize: 10,
                          fontFamily: AppFonts.mulishFont,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
