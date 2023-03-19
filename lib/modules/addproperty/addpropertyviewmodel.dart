import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../app/model/areaconverter/convertermodel.dart';
import '../../app/model/location/citymodel.dart';
import '../../app/model/location/locationmodel.dart';
import '../../app/model/location/placemodel.dart';
import '../../app/model/location/sublocationmodel.dart';
import '../../app/model/property/propertysubtypemodel.dart';
import '../../services/api/addproperty.dart';
import '../../services/api/areaconverter.dart';
import '../../services/api/location.dart';
import '../../services/api/property.dart';
import '../../services/localstorage/SessionManager.dart';

class AddPropertyViewModel extends GetxController
    with GetTickerProviderStateMixin {
  RxBool showAppBar = false.obs;
  RxBool isLoading = false.obs;
  RxString errorString = ''.obs;
  ScrollController? listScrollController = ScrollController();
  TabController? sellOrRentController;
  TabController? propertyTypeController;
  GoogleMapController? mapController;
  LatLng? latLng;
  Rx<Map<MarkerId, Marker>> markers = RxMap<MarkerId, Marker>().obs;
  CityModel cityModel = CityModel();
  LocationModel locationModel = LocationModel();
  SubLocationModel subLocationModel = SubLocationModel();
  ProopertySubTypeModel proopertySubTypeModel = ProopertySubTypeModel();
  PlaceModel placeModel = PlaceModel();
  SessionManager sessionManager = SessionManager();
  AreaConverterModel areaConverterModel = AreaConverterModel();
  RxString selectedCity = ''.obs;
  RxString selectedCityID = ''.obs;
  RxString selectedLocation = ''.obs;
  RxString selectedLocationID = ''.obs;
  RxBool showSubLocation = false.obs;
  RxString selectedSubLocation = ''.obs;
  RxString selectedSubLocationID = ''.obs;
  RxString selectedPropertyType = ''.obs;
  RxString selectedPropertyTypeID = '1'.obs;
  RxString selectedPropertySubType = ''.obs;
  RxString selectedPropertySubTypeID = ''.obs;
  TextEditingController areaController = TextEditingController();
  RxString selectedSizeUnit = 'Marla'.obs;
  RxString selectedSizeUnitID = '1'.obs;
  TextEditingController priceController = TextEditingController();
  RxBool bedBathCheck = false.obs;
  RxString selectedBedrooms = ''.obs;
  RxString selectedBaths = ''.obs;
  RxBool showInstallment = true.obs;
  RxBool installmentCheck = false.obs;
  RxString installmentPlan = ''.obs;
  RxString installmentDownPay = ''.obs;
  RxBool showRentalComponent = false.obs;
  TextEditingController securityFeeController = TextEditingController();
  RxString minContractDuration = ''.obs;
  RxString advancePaymentDuration = ''.obs;
  RxString maintenanceCharges = ''.obs;
  RxBool showMController = false.obs;
  TextEditingController maintenanceFeeController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController whatssappController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  RxList<XFile> images = <XFile>[].obs;

  @override
  void onInit() {
    super.onInit();
    initScrolls();
    getData();
  }

  initScrolls() {
    sellOrRentController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    propertyTypeController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
    sellOrRentController!.addListener(
      () {
        if (sellOrRentController!.indexIsChanging) {
          if (sellOrRentController!.index == 0) {
            showInstallment.value = true;
            showRentalComponent.value = false;
          } else {
            showInstallment.value = false;
            showRentalComponent.value = true;
          }
        }
      },
    );
    propertyTypeController!.addListener(
      () {
        if (propertyTypeController!.indexIsChanging) {
          if (propertyTypeController!.index == 0) {
            selectedPropertyType.value = 'Commercial';
            selectedPropertyTypeID.value = '1';
            selectedPropertySubType.value = '';
            selectedPropertySubTypeID.value = '';
            bedBathCheck.value = false;
          } else if (propertyTypeController!.index == 1) {
            selectedPropertyType.value = 'Residential';
            selectedPropertyTypeID.value = '2';
            selectedPropertySubType.value = '';
            selectedPropertySubTypeID.value = '';
            bedBathCheck.value = true;
          } else if (propertyTypeController!.index == 2) {
            selectedPropertyType.value = 'Plot';
            selectedPropertyTypeID.value = '4';
            selectedPropertySubType.value = '';
            selectedPropertySubTypeID.value = '';
            bedBathCheck.value = false;
          }
        }
      },
    );
    listScrollController!.addListener(
      () {
        if (listScrollController!.position.userScrollDirection ==
            ScrollDirection.reverse) {
          showAppBar.value = true;
        } else if (listScrollController!.position.userScrollDirection ==
            ScrollDirection.forward) {
          showAppBar.value = false;
        }
      },
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  getData() async {
    try {
      isLoading.value = true;
      await Future.wait(
        [
          getCities(),
          getLocations(),
          getSubLocations(),
          getPlaces(),
          getPropertySubTypes(),
          getUnitsFromSServer(),
          getUnits(),
        ],
      );
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> getCities() async {
    cityModel = await LocationService.getAllCities();
  }

  Future<void> getLocations() async {
    locationModel = await LocationService.getAllLocations();
  }

  Future<void> getSubLocations() async {
    subLocationModel = await LocationService.getAllSubLocations();
  }

  Future<void> getPlaces() async {
    placeModel = await LocationService.getAllPlaces();
  }

  Future<void> getPropertySubTypes() async {
    proopertySubTypeModel = await PropertyService.getPropertySubTypes();
    log('SubType are : ${proopertySubTypeModel.data!.propertySubtypes!.length.toString()}');
  }

  Future<void> getUnitsFromSServer() async {
    areaConverterModel = await AreaConverterService.getAllUnits();
    log(areaConverterModel.data!.propertySizeUnits!.length.toString());
    saveUnits();
  }

  Future<void> getUnits() async {
    var res = sessionManager.readData(SessionKeys.propertyUnits);
    if (res != null) {
      areaConverterModel = AreaConverterModel.fromJson(res);
      log(areaConverterModel.data!.propertySizeUnits!.length.toString());
    } else {
      log('Error');
    }
  }

  saveUnits() {
    sessionManager.saveData(SessionKeys.propertyUnits, areaConverterModel);
  }

  addMarker() {
    var markerIdVal = '0';
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: latLng!,
      onTap: () {},
    );
    markers.value[markerId] = marker;
  }

  getImageFromcamera() {
    ImagePicker().pickImage(source: ImageSource.camera).then(
      (value) {
        if (value != null) {
          images.add(value);
          log(images.length.toString());
        }
      },
    );
  }

  getImageFromGallery() {
    ImagePicker().pickImage(source: ImageSource.gallery).then(
      (value) {
        if (value != null) {
          images.add(value);
          log(images.length.toString());
        }
      },
    );
  }

  bool validateForm() {
    if (selectedCity.value == '') {
      errorString.value = 'Please select city';
      scrollToTop();
      return false;
    }
    if (selectedLocation.value == '') {
      errorString.value = 'Please select location';
      scrollToTop();
      return false;
    }
    if (selectedPropertySubType.value == '') {
      errorString.value = 'Please select property subtype';
      scrollToTop();
      return false;
    }
    if (areaController.text == '') {
      errorString.value = 'Area is required';
      scrollToTop();
      return false;
    }
    if (bedBathCheck.value) {
      if (selectedBedrooms.value == '') {
        errorString.value = 'Please select bedrooms';
        scrollToTop();
        return false;
      } else if (selectedBaths.value == '') {
        errorString.value = 'Please select baths';
        scrollToTop();
        return false;
      }
    }
    if (priceController.text == '') {
      errorString.value = 'Price is required';
      scrollToTop();
      return false;
    }
    if (installmentCheck.value) {
      if (installmentPlan.value == '') {
        errorString.value = 'Please select installment plan';
        scrollToTop();
        return false;
      }
      if (installmentDownPay.value == '') {
        errorString.value = 'Please select installment downpayment';
        scrollToTop();
        return false;
      }
    }
    if (showRentalComponent.value) {
      if (securityFeeController.text == '') {
        errorString.value = 'Security deposit is required';
        scrollToTop();
        return false;
      }
      if (minContractDuration.value == '') {
        errorString.value = 'Min contract duration is required';
        scrollToTop();
        return false;
      }
      if (advancePaymentDuration.value == '') {
        errorString.value = 'Please select advance payment duration';
        scrollToTop();
        return false;
      }
      if (maintenanceCharges.value == '') {
        errorString.value = 'Please select maintenance charges';
        scrollToTop();
        return false;
      }
      if (maintenanceCharges.value == 'Exclude Rent' &&
          maintenanceFeeController.text == '') {
        errorString.value = 'Please enter maintenance fee';
        scrollToTop();
        return false;
      }
    }
    if (contactController.text == '') {
      errorString.value = 'Please enter contact number';
      scrollToTop();
      return false;
    }
    if (whatssappController.text == '') {
      errorString.value = 'Please enter whatsapp number';
      scrollToTop();
      return false;
    }
    if (titleController.text == '') {
      errorString.value = 'Please enter title';
      scrollToTop();
      return false;
    }
    if (descController.text == '') {
      errorString.value = 'Please enter description';
      scrollToTop();
      return false;
    }
    errorString.value = '';
    return true;
  }

  scrollToTop() {
    listScrollController!.animateTo(
      listScrollController!.position.minScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<bool> addProperty() async {
    isLoading.value = true;
    try {
      var params = makeParams();
      List<File> files = [];
      for (var image in images) {
        files.add(File(image.path));
      }
      var res =
          await AddPropertyService.addPropertyUsingDio(params, files: files);
      if (res.success!) {
        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      log(e.toString());
      isLoading.value = false;
      return false;
    }
  }

  makeParams() {
    var params = {
      'purpose_id': showRentalComponent.value ? '1' : '2',
      'city_id': selectedCityID.value,
      'location_id': selectedLocationID.value,
      'sub_location_id': selectedSubLocationID.value,
      'type_id': selectedPropertyTypeID.value,
      'subtype_id': selectedPropertySubTypeID.value,
      'size': areaController.text,
      'size_unit_id': selectedSizeUnitID.value,
      'price': priceController.text,
      'beds':
          selectedPropertyTypeID.value == '2' ? selectedBedrooms.value : '0',
      'baths': selectedPropertyTypeID.value == '2' ? selectedBaths.value : '0',
      'payment_type': installmentCheck.value ? '2' : '1',
      'installment_plan': installmentPlan.value,
      'installment_downpayment': installmentDownPay.value,
      'security_deposit': securityFeeController.text,
      'contract_duration': minContractDuration.value,
      'contract_duration_type': 'Months',
      'advance_rent_duration': advancePaymentDuration.value,
      'maintenance_by': maintenanceCharges.value,
      'maintenance_fee': maintenanceFeeController.text,
      'expiry_days': '3 Months',
      'contact': contactController.text,
      'whatsapp_number': whatssappController.text,
      'title': titleController.text,
      'description': descController.text,
    };
    return params;
  }

  resetForm() {
    selectedCity.value = '';
    selectedCityID.value = '';
    selectedLocation.value = '';
    selectedLocationID.value = '';
    selectedSubLocation.value = '';
    selectedSubLocationID.value = '';
    selectedPropertyType.value = 'Commercial';
    selectedPropertyTypeID.value = '1';
    selectedPropertySubType.value = '';
    selectedPropertySubTypeID.value = '';
    areaController.text = '';
    selectedSizeUnit.value = 'Marla';
    priceController.text = '';
    bedBathCheck.value = false;
    selectedBedrooms.value = '';
    selectedBaths.value = '';
    installmentCheck.value = false;
    installmentPlan.value = '';
    installmentDownPay.value = '';
    securityFeeController.text = '';
    minContractDuration.value = '';
    advancePaymentDuration.value = '';
    maintenanceCharges.value = '';
    showMController.value = false;
    showRentalComponent.value = false;
    maintenanceFeeController.text = '';
    contactController.text = '';
    descController.text = '';
    whatssappController.text = '';
    titleController.text = '';
    images.clear();
    errorString.value = '';
  }
}
