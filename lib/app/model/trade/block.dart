import 'societysize.dart';

class SocietyBlock {
  dynamic id;
  String? blockName;
  dynamic trendingSocietyId;
  String? createdAt;
  String? updatedAt;
  List<SocietySize>? fileTrendingSocietySizes;

  SocietyBlock(
      {this.id,
      this.blockName,
      this.trendingSocietyId,
      this.createdAt,
      this.updatedAt,
      this.fileTrendingSocietySizes});

  SocietyBlock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blockName = json['block_name'];
    trendingSocietyId = json['trending_society_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['file_trending_society_sizes'] != null) {
      fileTrendingSocietySizes = <SocietySize>[];
      json['file_trending_society_sizes'].forEach((v) {
        fileTrendingSocietySizes!.add(new SocietySize.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['block_name'] = this.blockName;
    data['trending_society_id'] = this.trendingSocietyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.fileTrendingSocietySizes != null) {
      data['file_trending_society_sizes'] =
          this.fileTrendingSocietySizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
