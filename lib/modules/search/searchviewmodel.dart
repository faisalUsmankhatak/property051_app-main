import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:property_051/modules/dashboard/dashboardcontroller.dart';
import 'package:property_051/services/localstorage/SessionManager.dart';
import 'package:property_051/utils/colors.dart';
import 'package:property_051/utils/maputils.dart';
import '../../app/model/property/propertymodel.dart';
import '../../services/api/property.dart';

class SearchViewModel extends GetxController with GetTickerProviderStateMixin {
  SessionManager sessionManager = SessionManager();
  BitmapDescriptor? customIcon;
  GoogleMapController? mapController;
  final LatLng center = const LatLng(33.7224469449211, 73.05978406803035);
  RxBool isMap = false.obs;
  RxBool showAppBar = false.obs;
  RxBool showSearchAppBar = false.obs;
  TabController? sellOrRentController;
  TabController? propertyTypeController;
  PageController? propertyPageController =
      PageController(viewportFraction: 1, keepPage: true);
  ScrollController? filterController = ScrollController();
  ScrollController? searchController = ScrollController();
  static const pageSize = 10;
  final PagingController<int, PropertiesData> propertyPagingController =
      PagingController(firstPageKey: 1);
  Rx<PropertyModel> properties = PropertyModel().obs;
  RxBool isLoading = true.obs;
  RxBool isListEmpty = true.obs;
  RxBool isFilterLoading = true.obs;
  final RxSet<Polygon> polygons = Set<Polygon>().obs;
  final RxSet<Polyline> polyLines = Set<Polyline>().obs;
  RxBool drawPolygonEnabled = false.obs;
  List<LatLng> userPolyLinesLatLngList = <LatLng>[];
  List<LatLng> userPolyLinesLatLngList1 = <LatLng>[];
  RxBool clearDrawing = false.obs;
  int? lastXCoordinate, lastYCoordinate;
  Rx<Map<MarkerId, Marker>> markers = RxMap<MarkerId, Marker>().obs;
  //Filter
  RxBool isFilter = false.obs;
  RxString filterErrorString = ''.obs;
  RxString purposeID = '2'.obs;
  RxString selectedCity = ''.obs;
  RxString selectedCityID = ''.obs;
  RxString selectedLocation = ''.obs;
  RxString selectedLocationID = ''.obs;
  RxString selectedPropertyType = ''.obs;
  RxString selectedPropertyTypeID = ''.obs;
  RxString selectedPropertySubType = ''.obs;
  RxString selectedPropertySubTypeID = ''.obs;
  RxString noBeds = ''.obs;
  RxString noBaths = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initScrolls();
    propertyPagingController.addPageRequestListener(
      (pageKey) {
        getProperties(pageKey);
      },
    );
  }

  initScrolls() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(20, 20)),
      'images/icons/mapMarker.png',
    ).then((d) {
      customIcon = d;
      addMarkers();
    });
    sellOrRentController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    sellOrRentController!.addListener(
      () {
        if (sellOrRentController!.indexIsChanging) {
          if (sellOrRentController!.index == 0) {
            purposeID.value = '2';
          } else {
            purposeID.value = '1';
          }
        }
      },
    );
    propertyTypeController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
    filterController!.addListener(
      () {
        if (filterController!.position.userScrollDirection ==
            ScrollDirection.reverse) {
          showAppBar.value = true;
        } else if (filterController!.position.userScrollDirection ==
            ScrollDirection.forward) {
          showAppBar.value = false;
        }
      },
    );
    searchController!.addListener(
      () {
        if (searchController!.position.userScrollDirection ==
            ScrollDirection.reverse) {
          showSearchAppBar.value = true;
        } else if (searchController!.position.userScrollDirection ==
            ScrollDirection.forward) {
          showSearchAppBar.value = false;
        }
      },
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  addMarkers() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'images/icons/mapMarker.png',
    );
    addMarker(id: 1);
    addMarker(id: 2);
    addMarker(id: 3);
    addMarker(id: 4);
    addMarker(id: 5);
    addMarker(id: 6);
    addMarker(id: 7);
    addMarker(id: 8);
    addMarker(id: 9);
    addMarker(id: 10);
    addMarker(id: 11);
    addMarker(id: 12);
    addMarker(id: 13);
  }

  void addMarker({int id = 1}) {
    var markerIdVal = 'placeId$id';
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        center.latitude + math.sin(id * math.pi / 6.0) / 20.0,
        center.longitude + math.cos(id * math.pi / 6.0) / 20.0,
      ),
      // icon: id % 2 == 0 ? customIcon! : BitmapDescriptor.defaultMarker,
      icon: customIcon!,
      // infoWindow: InfoWindow(title: 'House For Sale', snippet: '*'),
      onTap: () {
        if (isLoading.value) {
          isLoading.value = false;
          // sleep(const Duration(seconds: 1));
          moveToPropertyPage(id);
        } else {
          moveToPropertyPage(id);
        }
      },
    );
    markers.value[markerId] = marker;
  }

  moveToPropertyPage(int index) {
    if (propertyPageController!.hasClients) {
      propertyPageController!.jumpToPage(index);
    }
    // propertyPageController!.animateToPage(
    //   index,
    //   duration: Duration(milliseconds: 1000),
    //   curve: Curves.ease,
    // );
  }

  getProperties(int pageKey) async {
    try {
      properties.value = await PropertyService.getProperties(
        pageKey,
        purposeId: isFilter.value ? purposeID.value : '',
        cityId: selectedCityID.value,
        locationId: selectedLocationID.value,
        propertyTypeId: selectedPropertyTypeID.value,
        propertySubTypeId: selectedPropertySubTypeID.value,
        noBeds: noBeds.value,
        noBaths: noBaths.value,
      );
      bool isLastPage =
          properties.value.data!.properties!.data!.length < pageSize;
      isLoading.value = false;
      isListEmpty.value = properties.value.data!.properties!.data!.isEmpty;
      if (isLastPage) {
        propertyPagingController
            .appendLastPage(properties.value.data!.properties!.data!);
      } else {
        final nextPageKey = pageKey + 1;
        propertyPagingController.appendPage(
          properties.value.data!.properties!.data!,
          nextPageKey,
        );
        log(nextPageKey.toString());
      }
    } catch (e) {
      propertyPagingController.error = e;
      log('error');
    }
  }

  savePropertyToLocalDB(PropertiesData property) {
    var data = sessionManager.read(SessionKeys.recentProperties);
    if (data != null) {
      List<PropertiesData> properties = [];
      if (data is List<PropertiesData>) {
        properties = data;
      } else {
        properties = data.map<PropertiesData>((json) {
          return PropertiesData.fromLocalJson(json);
        }).toList();
      }
      if (properties
              .where((element) =>
                  element.property!.propertyId == property.property!.propertyId)
              .length ==
          0) {
        if (properties.length >= 10) {
          properties.removeAt(0);
        }
        properties.add(property);
        var propertyAsJson = properties.map((e) => e.toJson()).toList();
        String jsonString = jsonEncode(propertyAsJson);
        sessionManager.save(SessionKeys.recentProperties, jsonString);
        Get.find<DashBoardViewModel>().getProperties();
        inspect(properties);
      } else {}
    } else {
      List<PropertiesData> properties = [];
      properties.add(property);
      var propertyAsJson = properties.map((e) => e.toJson()).toList();
      String jsonString = jsonEncode(propertyAsJson);
      sessionManager.save(SessionKeys.recentProperties, jsonString);
      Get.find<DashBoardViewModel>().getProperties();
    }
    //delete
    // sessionManager.remove(SessionKeys.recentProperties);
  }

  getCurrentLocation() async {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((value) {
      log(value.latitude.toString());
      log(value.longitude.toString());
      // var myLocationPoints = LatLng(value.latitude, value.longitude);
      getAddressFromLatLong(value);
    });
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    var adress = '${place.name}, ${place.locality}, ${place.country}';
    log(adress);
  }

  toggleDrawing() {
    clearPolygons();
    drawPolygonEnabled.value = !drawPolygonEnabled.value;
  }

  onPanUpdate(DragUpdateDetails details) async {
    // To start draw new polygon every time.
    if (clearDrawing.value) {
      clearDrawing.value = false;
      clearPolygons();
    }

    if (drawPolygonEnabled.value) {
      double x = 0.0, y = 0.0;
      if (Platform.isAndroid) {
        // It times in 3 without any meaning,
        // We think it's an issue with GoogleMaps package.
        x = details.globalPosition.dx * 3;
        y = details.globalPosition.dy * 3;
      } else if (Platform.isIOS) {
        x = details.globalPosition.dx;
        y = details.globalPosition.dy;
      }

      // Round the x and y.
      int xCoordinate = x.round();
      int yCoordinate = y.round();

      // Check if the distance between last point is not too far.
      // to prevent two fingers drawing.
      if (lastXCoordinate != null && lastYCoordinate != null) {
        var distance = math.sqrt(math.pow(xCoordinate - lastXCoordinate!, 2) +
            math.pow(yCoordinate - lastYCoordinate!, 2));
        // Check if the distance of point and point is large.
        if (distance > 80.0) return;
      }

      // Cached the coordinate.
      lastXCoordinate = xCoordinate;
      lastYCoordinate = yCoordinate;

      ScreenCoordinate screenCoordinate = ScreenCoordinate(
          x: xCoordinate,
          y: !Platform.isAndroid
              ? (yCoordinate - kToolbarHeight.toInt())
              : yCoordinate - (kToolbarHeight * 5).toInt());

      final GoogleMapController controller = mapController!;
      LatLng latLng = await controller.getLatLng(screenCoordinate);

      try {
        // Add new point to list.
        userPolyLinesLatLngList.add(latLng);

        polyLines.removeWhere(
            (polyline) => polyline.polylineId.value == 'user_polyline');
        polyLines.add(
          Polyline(
            polylineId: PolylineId('user_polyline'),
            points: userPolyLinesLatLngList,
            width: 2,
            color: AppColor.whiteColor,
          ),
        );
      } catch (e) {
        print(" error painting $e");
      }
    }
  }

  onPanEnd(DragEndDetails details) async {
    lastXCoordinate = null;
    lastYCoordinate = null;

    if (drawPolygonEnabled.value) {
      polygons
          .removeWhere((polygon) => polygon.polygonId.value == 'user_polygon');
      polygons.add(
        Polygon(
          polygonId: PolygonId('user_polygon'),
          points: userPolyLinesLatLngList,
          strokeWidth: 2,
          strokeColor: AppColor.proimaryColor,
          fillColor: AppColor.proimaryColor.withOpacity(0.4),
        ),
      );
      log(userPolyLinesLatLngList.length.toString());
      userPolyLinesLatLngList1 = userPolyLinesLatLngList;
      // for (var ll in userPolyLinesLatLngList) {
      // var markerId = MarkerId('${ll.latitude}');
      // final Marker marker = Marker(
      //   markerId: markerId,
      //   position: LatLng(ll.latitude, ll.longitude),
      //   // icon: id % 2 == 0 ? customIcon! : BitmapDescriptor.defaultMarker,
      //   icon: customIcon!,
      //   // infoWindow: InfoWindow(title: 'House For Sale', snippet: '*'),
      //   onTap: () {
      //     if (isLoading.value) {
      //       isLoading.value = false;
      //       // sleep(const Duration(seconds: 1));
      //       moveToPropertyPage(1);
      //     } else {
      //       moveToPropertyPage(1);
      //     }
      //   },
      // );
      // markers.value[markerId] = marker;
      // }
      clearDrawing.value = true;
    }
  }

  clearPolygons() {
    polyLines.clear();
    polygons.clear();
    userPolyLinesLatLngList.clear();
  }

  checkLatLong(latLong) {
    log(userPolyLinesLatLngList1.length.toString());
    log(checkIfValidMarker(latLong, userPolyLinesLatLngList1).toString());
  }

  emptyFilterForm() {
    isFilter.value = false;
    filterErrorString.value = '';
    purposeID.value = '';
    selectedCity.value = '';
    selectedCityID.value = '';
    selectedLocation.value = '';
    selectedLocationID.value = '';
    selectedPropertyType.value = '';
    selectedPropertyTypeID.value = '';
    selectedPropertySubType.value = '';
    selectedPropertySubTypeID.value = '';
    noBeds = ''.obs;
    noBaths = ''.obs;
  }
}
