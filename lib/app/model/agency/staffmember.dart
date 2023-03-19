class StaffMembers {
  dynamic id;
  dynamic agencyId;
  String? name;
  String? designation;
  String? contact;
  String? image;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  StaffMembers(
      {this.id,
      this.agencyId,
      this.name,
      this.designation,
      this.contact,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  StaffMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agencyId = json['agency_id'];
    name = json['name'];
    designation = json['designation'];
    contact = json['contact'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agency_id'] = this.agencyId;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['contact'] = this.contact;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
