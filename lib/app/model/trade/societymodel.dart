import 'plot.dart';
import 'society.dart';

class SocietyModel {
  bool? success;
  Data? data;
  String? message;

  SocietyModel({this.success, this.data, this.message});

  SocietyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<Society>? fileTrendingSocieties;
  List<PlotType>? plotType;

  Data({this.fileTrendingSocieties, this.plotType});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['file_trending_societies'] != null) {
      fileTrendingSocieties = <Society>[];
      json['file_trending_societies'].forEach((v) {
        fileTrendingSocieties!.add(new Society.fromJson(v));
      });
    }
    if (json['plot_type'] != null) {
      plotType = <PlotType>[];
      json['plot_type'].forEach((v) {
        plotType!.add(new PlotType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fileTrendingSocieties != null) {
      data['file_trending_societies'] =
          this.fileTrendingSocieties!.map((v) => v.toJson()).toList();
    }
    if (this.plotType != null) {
      data['plot_type'] = this.plotType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
