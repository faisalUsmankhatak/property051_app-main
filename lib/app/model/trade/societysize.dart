import 'bookingtype.dart';

class SocietySize {
  dynamic id;
  String? sizeName;
  dynamic trendingSocietyId;
  String? createdAt;
  String? updatedAt;
  List<BookingType>? fileTrendingBookingTypes;

  SocietySize(
      {this.id,
      this.sizeName,
      this.trendingSocietyId,
      this.createdAt,
      this.updatedAt,
      this.fileTrendingBookingTypes});

  SocietySize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sizeName = json['size_name'];
    trendingSocietyId = json['trending_society_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['file_trending_booking_types'] != null) {
      fileTrendingBookingTypes = <BookingType>[];
      json['file_trending_booking_types'].forEach((v) {
        fileTrendingBookingTypes!.add(new BookingType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size_name'] = this.sizeName;
    data['trending_society_id'] = this.trendingSocietyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.fileTrendingBookingTypes != null) {
      data['file_trending_booking_types'] =
          this.fileTrendingBookingTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
