class PlotType {
  dynamic plotTypeId;
  String? typeName;

  PlotType({this.plotTypeId, this.typeName});

  PlotType.fromJson(Map<String, dynamic> json) {
    plotTypeId = json['plot_type_id'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plot_type_id'] = this.plotTypeId;
    data['type_name'] = this.typeName;
    return data;
  }
}
