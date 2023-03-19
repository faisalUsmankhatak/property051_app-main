import 'block.dart';

class Society {
  dynamic id;
  String? societyName;
  String? createdAt;
  String? updatedAt;
  List<SocietyBlock>? fileTrendingSocietyBlocks;

  Society(
      {this.id,
      this.societyName,
      this.createdAt,
      this.updatedAt,
      this.fileTrendingSocietyBlocks});

  Society.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    societyName = json['society_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['file_trending_society_block'] != null) {
      fileTrendingSocietyBlocks = <SocietyBlock>[];
      json['file_trending_society_block'].forEach((v) {
        fileTrendingSocietyBlocks!.add(new SocietyBlock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['society_name'] = this.societyName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.fileTrendingSocietyBlocks != null) {
      data['file_trending_society_block'] =
          this.fileTrendingSocietyBlocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
