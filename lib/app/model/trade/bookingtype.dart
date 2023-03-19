class BookingType {
  dynamic id;
  String? bookingPrice;
  String? fullPrice;
  dynamic trendingSocietySizeId;
  dynamic trendingSocietyId;
  String? createdAt;
  String? updatedAt;

  BookingType({
    this.id,
    this.bookingPrice,
    this.fullPrice,
    this.trendingSocietySizeId,
    this.trendingSocietyId,
    this.createdAt,
    this.updatedAt,
  });

  BookingType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingPrice = json['booking_price'];
    fullPrice = json['full_price'];
    trendingSocietySizeId = json['trending_society_size_id'];
    trendingSocietyId = json['trending_society_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_price'] = this.bookingPrice;
    data['full_price'] = this.fullPrice;
    data['trending_society_size_id'] = this.trendingSocietySizeId;
    data['trending_society_id'] = this.trendingSocietyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
