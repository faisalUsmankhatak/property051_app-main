class Comment {
  dynamic id;
  dynamic sendBy;
  dynamic receivedBy;
  dynamic fileTrendingChatsId;
  String? comments;
  String? createdAt;
  String? updatedAt;
  dynamic purposeId;
  dynamic fileTrendingSocietyId;
  dynamic plotType;
  String? discountPrice;
  String? discountPercent;
  dynamic demandType;
  dynamic trendingSocietySizeId;
  dynamic trendingBookingTypeId;
  dynamic societyBlockId;
  dynamic noOfFiles;
  dynamic customerId;
  dynamic description;
  dynamic status;
  String? firstName;
  String? lastName;
  String? avatar;
  dynamic contactNo;
  dynamic whatsappNumber;
  String? societyName;
  String? sizeName;
  String? bookingPrice;
  String? blockName;

  Comment(
      {this.id,
      this.sendBy,
      this.receivedBy,
      this.fileTrendingChatsId,
      this.comments,
      this.createdAt,
      this.updatedAt,
      this.purposeId,
      this.fileTrendingSocietyId,
      this.plotType,
      this.discountPrice,
      this.discountPercent,
      this.demandType,
      this.trendingSocietySizeId,
      this.trendingBookingTypeId,
      this.societyBlockId,
      this.noOfFiles,
      this.customerId,
      this.description,
      this.status,
      this.firstName,
      this.lastName,
      this.avatar,
      this.contactNo,
      this.whatsappNumber,
      this.societyName,
      this.sizeName,
      this.bookingPrice,
      this.blockName});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sendBy = json['send_by'];
    receivedBy = json['received_by'];
    fileTrendingChatsId = json['file_trending_chats_id'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    purposeId = json['purpose_id'];
    fileTrendingSocietyId = json['file_trending_society_id'];
    plotType = json['plot_type'];
    discountPrice = json['discount_price'];
    discountPercent = json['discount_percent'];
    demandType = json['demand_type'];
    trendingSocietySizeId = json['trending_society_size_id'];
    trendingBookingTypeId = json['trending_booking_type_id'];
    societyBlockId = json['society_block_id'];
    noOfFiles = json['no_of_files'];
    customerId = json['customer_id'];
    description = json['description'];
    status = json['status'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    contactNo = json['contact_no'];
    whatsappNumber = json['whatsapp_number'];
    societyName = json['society_name'];
    sizeName = json['size_name'];
    bookingPrice = json['booking_price'];
    blockName = json['block_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['send_by'] = this.sendBy;
    data['received_by'] = this.receivedBy;
    data['file_trending_chats_id'] = this.fileTrendingChatsId;
    data['comments'] = this.comments;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['purpose_id'] = this.purposeId;
    data['file_trending_society_id'] = this.fileTrendingSocietyId;
    data['plot_type'] = this.plotType;
    data['discount_price'] = this.discountPrice;
    data['discount_percent'] = this.discountPercent;
    data['demand_type'] = this.demandType;
    data['trending_society_size_id'] = this.trendingSocietySizeId;
    data['trending_booking_type_id'] = this.trendingBookingTypeId;
    data['society_block_id'] = this.societyBlockId;
    data['no_of_files'] = this.noOfFiles;
    data['customer_id'] = this.customerId;
    data['description'] = this.description;
    data['status'] = this.status;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    data['contact_no'] = this.contactNo;
    data['whatsapp_number'] = this.whatsappNumber;
    data['society_name'] = this.societyName;
    data['size_name'] = this.sizeName;
    data['booking_price'] = this.bookingPrice;
    data['block_name'] = this.blockName;
    return data;
  }
}
