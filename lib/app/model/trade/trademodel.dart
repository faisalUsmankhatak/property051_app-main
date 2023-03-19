import 'newsfeed.dart';

class TradeModel {
  bool? success;
  TradeModelData? data;
  String? message;

  TradeModel({this.success, this.data, this.message});

  TradeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? new TradeModelData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class TradeModelData {
  GetNewsFeed? getNewsFeed;
  String? defaultImagePath;
  String? imagePath;

  TradeModelData({this.getNewsFeed, this.defaultImagePath, this.imagePath});

  TradeModelData.fromJson(Map<String, dynamic> json) {
    getNewsFeed = json['get_news_feed'] != null
        ? new GetNewsFeed.fromJson(json['get_news_feed'])
        : null;
    defaultImagePath = json['default_image_path'];
    imagePath = json['image_path'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getNewsFeed != null) {
      data['get_news_feed'] = this.getNewsFeed!.toJson();
    }
    data['default_image_path'] = this.defaultImagePath;
    data['image_path'] = this.imagePath;
    return data;
  }
}
