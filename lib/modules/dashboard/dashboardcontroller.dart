import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../app/model/property/propertymodel.dart';
import '../../services/api/property.dart';
import '../../services/localstorage/SessionManager.dart';

class DashBoardViewModel extends GetxController {
  SessionManager sessionManager = SessionManager();
  static const pageSize = 10;
  RxList<PropertiesData> properties = <PropertiesData>[].obs;
  RxBool isLocalProperties = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProperties();
  }

  getLocation() async {
    var location = await determinePosition();
    log(location.toString());
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location!.longitude, location.latitude);
    log(placemarks.first.toString());
  }

  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getLastKnownPosition(
        // desiredAccuracy: LocationAccuracy.high,
        // forceAndroidLocationManager: true,
        );
  }

  getProperties() async {
    try {
      SessionManager sessionManager = SessionManager();
      var data = sessionManager.read(SessionKeys.recentProperties);
      if (data != null) {
        isLocalProperties.value = true;
        properties.clear();
        for (var d in data) {
          properties.add(PropertiesData.fromLocalJson(d));
        }
        properties.value = properties.reversed.toList();
        // inspect(properties.value);
      } else {
        isLocalProperties.value = false;
        getPopularProperties();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getPopularProperties() async {
    try {
      isLoading.value = true;
      var res = await PropertyService.getProperties(
        1,
        purposeId: '',
        cityId: '',
        locationId: '',
        propertyTypeId: '',
        propertySubTypeId: '',
        noBeds: '',
        noBaths: '',
      );
      properties.value = res.data!.properties!.data!;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  deleteRecentProperties() {
    SessionManager sessionManager = SessionManager();
    sessionManager.remove(SessionKeys.recentProperties);
    getProperties();
    properties.clear();
  }
}
