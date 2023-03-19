class Trade {
  dynamic id;
  dynamic purposeId;
  dynamic fileTrendingSocietyId;
  dynamic plotType;
  dynamic discountPrice;
  String? discountPercent;
  dynamic demandType;
  dynamic demandPrice;
  dynamic trendingSocietySizeId;
  dynamic trendingBookingTypeId;
  dynamic societyBlockId;
  dynamic noOfFiles;
  dynamic customerId;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? avatar;
  String? contactNo;
  String? whatsappNumber;
  String? customerEmail;
  String? societyName;
  dynamic showMobile;
  dynamic showSms;
  dynamic showWhatsapp;
  String? sizeName;
  String? bookingPrice;
  String? blockName;
  dynamic commentsCount;

  Trade({
    this.id,
    this.purposeId,
    this.fileTrendingSocietyId,
    this.plotType,
    this.discountPrice,
    this.discountPercent,
    this.demandType,
    this.demandPrice,
    this.trendingSocietySizeId,
    this.trendingBookingTypeId,
    this.societyBlockId,
    this.noOfFiles,
    this.customerId,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.avatar,
    this.contactNo,
    this.whatsappNumber,
    this.customerEmail,
    this.societyName,
    this.showMobile,
    this.showSms,
    this.showWhatsapp,
    this.sizeName,
    this.bookingPrice,
    this.blockName,
    this.commentsCount,
  });

  Trade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purposeId = json['purpose_id'];
    fileTrendingSocietyId = json['file_trending_society_id'];
    plotType = json['plot_type'];
    discountPrice = json['discount_price'];
    discountPercent = json['discount_percent'];
    demandType = json['demand_type'];
    demandPrice = json['demand_price'];
    trendingSocietySizeId = json['trending_society_size_id'];
    trendingBookingTypeId = json['trending_booking_type_id'];
    societyBlockId = json['society_block_id'];
    noOfFiles = json['no_of_files'];
    customerId = json['customer_id'];
    description = json['description'];
    status = json['status'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    contactNo = json['contact_no'];
    whatsappNumber = json['whatsapp_number'];
    customerEmail = json['customer_email'];
    societyName = json['society_name'];
    showMobile = json['show_mobile'];
    showSms = json['show_sms'];
    showWhatsapp = json['show_whatsapp'];
    sizeName = json['size_name'];
    bookingPrice = json['booking_price'];
    blockName = json['block_name'];
    commentsCount = json['comments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purpose_id'] = this.purposeId;
    data['file_trending_society_id'] = this.fileTrendingSocietyId;
    data['plot_type'] = this.plotType;
    data['discount_price'] = this.discountPrice;
    data['discount_percent'] = this.discountPercent;
    data['demand_type'] = this.demandType;
    data['demand_price'] = this.demandPrice;
    data['trending_society_size_id'] = this.trendingSocietySizeId;
    data['trending_booking_type_id'] = this.trendingBookingTypeId;
    data['society_block_id'] = this.societyBlockId;
    data['no_of_files'] = this.noOfFiles;
    data['customer_id'] = this.customerId;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    data['contact_no'] = this.contactNo;
    data['whatsapp_number'] = this.whatsappNumber;
    data['customer_email'] = this.customerEmail;
    data['society_name'] = this.societyName;
    data['show_mobile'] = this.showMobile;
    data['show_sms'] = this.showSms;
    data['show_whatsapp'] = this.showWhatsapp;
    data['size_name'] = this.sizeName;
    data['booking_price'] = this.bookingPrice;
    data['block_name'] = this.blockName;
    data['comments_count'] = this.commentsCount;
    return data;
  }
}
