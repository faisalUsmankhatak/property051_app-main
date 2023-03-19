import '../app/model/property/propertymodel.dart';

//Property Utilities

const int one_k = 1000;
const int one_lac = 100000;
const int one_carore = 10000000;
const double MaxPrice = 1000000000;

String getPropertyImagePath({PropertiesData? property}) {
  var imagePath = '';
  if (property!.propertyImages!.isNotEmpty) {
    imagePath =
        'https://www.property051.com/public/storage/upload/properties/${property.propertyImages!.first.imagePath!}';
  } else if (property.locations!.image != null) {
    imagePath =
        'https://www.property051.com/public/storage/upload/location/images/${property.locations!.image!}';
  } else {
    imagePath =
        'https://www.property051.com/public/storage/upload/default/property_default_image.jpg';
  }
  return imagePath;
}

List<String> getPropertyImagePaths({PropertiesData? property}) {
  List<String> imagePath = [];
  if (property!.propertyImages!.isNotEmpty) {
    property.propertyImages!.forEach((element) {
      imagePath.add(
          'https://www.property051.com/public/storage/upload/properties/${element.imagePath!}');
    });
  } else if (property.locations!.image != null) {
    imagePath.add(
        'https://www.property051.com/public/storage/upload/location/images/${property.locations!.image!}');
  } else {
    imagePath.add(
        'https://www.property051.com/public/storage/upload/default/property_default_image.jpg');
  }
  return imagePath;
}

String getPropertyTitle({PropertiesData? property}) {
  var title = '';
  if (property != null) {
    if (property.propertySubType != null) {
      title = property.propertySubType!.name! +
          ' For ' +
          property.purpose!.purposeTypeName!;
    }
  }
  return title;
}

String getLoctionName({PropertiesData? property, int size = 20}) {
  var location = '';
  if (property!.locations != null && property.cities != null) {
    if (property.locations!.locationName!.length > size) {
      location = property.locations!.locationName!.substring(0, size) + '...';
    } else {
      location = property.locations!.locationName!;
    }
    return '$location, ${property.cities!.name}';
  }
  return property.property!.address!;
}

String getNoBeds({PropertiesData? property}) {
  var noBeds = '';
  noBeds = property!.property!.noBed == null
      ? '0'
      : property.property!.noBed!.toString();
  return noBeds;
}

String getFriendlyPrice(int value, {String unit = '0'}) {
  String friendlyPrice = "";

  if (value == 0) {
    return "--";
  }
  double wholeFigure = 0.0;
  if (value < one_lac) {
    wholeFigure = value / one_k;
    if (unit == '0') {
      friendlyPrice = wholeFigure.toStringAsFixed(2) + " Thousand";
      if (friendlyPrice.split('.')[1].split(' ')[0] == '00') {
        friendlyPrice = wholeFigure.toStringAsFixed(0) + " Thousand";
      }
      return friendlyPrice;
    }
    friendlyPrice = wholeFigure.toStringAsFixed(2) + " K";
    if (friendlyPrice.split('.')[1].split(' ')[0] == '00') {
      friendlyPrice = wholeFigure.toStringAsFixed(0) + " K";
    }
    return friendlyPrice;
  }
  if (value < one_lac * 100) {
    wholeFigure = value / one_lac;
    friendlyPrice = wholeFigure.toStringAsFixed(2) + " Lac";
    if (friendlyPrice.split('.')[1].split(' ')[0] == '00') {
      friendlyPrice = wholeFigure.toStringAsFixed(0) + " Lac";
    }
    return friendlyPrice;
  }
  if (value < one_carore * 100) {
    wholeFigure = value / one_carore;
    friendlyPrice = wholeFigure.toStringAsFixed(2) + " Crore";
    if (friendlyPrice.split('.')[1].split(' ')[0] == '00') {
      friendlyPrice = wholeFigure.toStringAsFixed(0) + " Crore";
    }
    return friendlyPrice;
  }
  return friendlyPrice;
}

bool validateEmail(String email) {
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regex.hasMatch(email);
}

validatePhone(String phone) {
  RegExp regex = new RegExp(r'^((0)?)(3)([0-9]{9})$');
  return regex.hasMatch(phone);
}
