// ignore_for_file: prefer_collection_literals

class Property {
  dynamic propertyId;
  String? slug;
  dynamic addedBy;
  dynamic statusChangedBy;
  dynamic source;
  String? approvedDatetime;
  dynamic featuredDatetime;
  dynamic purposeId;
  dynamic subStatus;
  String? status;
  String? title;
  String? description;
  dynamic price;
  dynamic paymentType;
  dynamic installmentPlan;
  dynamic installmentDownpayment;
  dynamic area;
  dynamic areaInSqft;
  dynamic unitId;
  dynamic cityId;
  dynamic locationId;
  dynamic subLocationId;
  dynamic placeId;
  String? address;
  dynamic propertyTypeId;
  dynamic subPropertyTypeId;
  String? noBed;
  dynamic noBath;
  dynamic contractDuration;
  dynamic securityDeposit;
  dynamic advanceRentDuration;
  dynamic maintenanceBy;
  dynamic maintenanceFee;
  String? contactNo;
  String? whatsappNumber;
  dynamic verified;
  dynamic featured;
  dynamic views;
  dynamic expiryDays;
  dynamic yearBuilt;
  String? createdAt;
  String? updatedAt;

  Property(
      {this.propertyId,
      this.slug,
      this.addedBy,
      this.statusChangedBy,
      this.source,
      this.approvedDatetime,
      this.featuredDatetime,
      this.purposeId,
      this.subStatus,
      this.status,
      this.title,
      this.description,
      this.price,
      this.paymentType,
      this.installmentPlan,
      this.installmentDownpayment,
      this.area,
      this.areaInSqft,
      this.unitId,
      this.cityId,
      this.locationId,
      this.subLocationId,
      this.placeId,
      this.address,
      this.propertyTypeId,
      this.subPropertyTypeId,
      this.noBed,
      this.noBath,
      this.contractDuration,
      this.securityDeposit,
      this.advanceRentDuration,
      this.maintenanceBy,
      this.maintenanceFee,
      this.contactNo,
      this.whatsappNumber,
      this.verified,
      this.featured,
      this.views,
      this.expiryDays,
      this.yearBuilt,
      this.createdAt,
      this.updatedAt});

  Property.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id'];
    slug = json['slug'];
    addedBy = int.parse(json['added_by'].toString());
    statusChangedBy = int.parse(json['status_changed_by'].toString());
    source = int.parse(json['source'].toString());
    approvedDatetime = json['approved_datetime'];
    featuredDatetime = json['featured_datetime'];
    purposeId = int.parse(json['purpose_id'].toString());
    subStatus = int.parse(json['sub_status'].toString());
    status = json['status'];
    title = json['title'];
    description = json['description'];
    price = int.parse(json['price'].toString());
    paymentType = json['payment_type'];
    installmentPlan = json['installment_plan'];
    installmentDownpayment = json['installment_downpayment'];
    area = json['area'];
    areaInSqft = json['area_in_sqft'];
    unitId = json['unit_id'];
    cityId = json['city_id'];
    locationId = json['location_id'];
    subLocationId = json['sub_location_id'];
    placeId = json['place_id'];
    address = json['address'];
    propertyTypeId = json['property_type_id'];
    subPropertyTypeId = json['subProperty_type_id'];
    noBed = json['no_bed'];
    noBath = json['no_bath'];
    contractDuration = json['contract_duration'];
    securityDeposit = json['security_deposit'];
    advanceRentDuration = json['advance_rent_duration'];
    maintenanceBy = json['maintenance_by'];
    maintenanceFee = json['maintenance_fee'];
    contactNo = json['contact_no'];
    whatsappNumber = json['whatsapp_number'];
    verified = json['verified'];
    featured = json['featured'];
    views = json['views'];
    expiryDays = json['expiry_days'];
    yearBuilt = json['year_built'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['property_id'] = propertyId;
    data['slug'] = slug;
    data['added_by'] = addedBy;
    data['status_changed_by'] = statusChangedBy;
    data['source'] = source;
    data['approved_datetime'] = approvedDatetime;
    data['featured_datetime'] = featuredDatetime;
    data['purpose_id'] = purposeId;
    data['sub_status'] = subStatus;
    data['status'] = status;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['payment_type'] = paymentType;
    data['installment_plan'] = installmentPlan;
    data['installment_downpayment'] = installmentDownpayment;
    data['area'] = area;
    data['area_in_sqft'] = areaInSqft;
    data['unit_id'] = unitId;
    data['city_id'] = cityId;
    data['location_id'] = locationId;
    data['sub_location_id'] = subLocationId;
    data['place_id'] = placeId;
    data['address'] = address;
    data['property_type_id'] = propertyTypeId;
    data['subProperty_type_id'] = subPropertyTypeId;
    data['no_bed'] = noBed;
    data['no_bath'] = noBath;
    data['contract_duration'] = contractDuration;
    data['security_deposit'] = securityDeposit;
    data['advance_rent_duration'] = advanceRentDuration;
    data['maintenance_by'] = maintenanceBy;
    data['maintenance_fee'] = maintenanceFee;
    data['contact_no'] = contactNo;
    data['whatsapp_number'] = whatsappNumber;
    data['verified'] = verified;
    data['featured'] = featured;
    data['views'] = views;
    data['expiry_days'] = expiryDays;
    data['year_built'] = yearBuilt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
