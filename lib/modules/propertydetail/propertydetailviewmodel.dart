import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../app/model/property/aminities/aminitymodel.dart';
import '../../app/model/property/propertymodel.dart';
import '../../services/api/property.dart';

class PropertyDetailViewModel extends GetxController {
  GoogleMapController? mapController;
  LatLng? latLng;
  Rx<AminitiesModel> aminitiesModel = AminitiesModel().obs;
  Rx<Map<MarkerId, Marker>> markers = RxMap<MarkerId, Marker>().obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  getDetails(id) async {
    isLoading.value = true;
    aminitiesModel.value =
        await PropertyService.getPropertyAminities(propertyId: id);
    isLoading.value = false;
  }

  getPropertyLatLng({PropertiesData? property}) {
    if (property!.subLocation != null) {
      if (property.subLocation!.latitude != null &&
          property.subLocation!.longitude != null) {
        latLng = LatLng(double.parse(property.subLocation!.latitude!),
            double.parse(property.subLocation!.longitude!));
        addMarker();
        return;
      }
    }
    if (property.locations != null) {
      if (property.locations!.latitude != null &&
          property.locations!.longitude != null) {
        latLng = LatLng(double.parse(property.locations!.latitude!),
            double.parse(property.locations!.longitude!));
        addMarker();
        return;
      }
    } else {
      latLng = LatLng(33.6844, 73.0479);
      addMarker();
    }
  }

  void addMarker() {
    var markerIdVal = '${latLng!.latitude}';
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: latLng!,
      onTap: () {},
    );
    markers.value[markerId] = marker;
  }
}
