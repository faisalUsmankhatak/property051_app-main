class Ratings {
  dynamic id;
  String? fullName;
  dynamic customerId;
  dynamic projectID;
  dynamic rating;
  String? userReview;
  String? createdAt;
  String? updatedAt;

  Ratings(
      {this.id,
      this.fullName,
      this.customerId,
      this.projectID,
      this.rating,
      this.userReview,
      this.createdAt,
      this.updatedAt});

  Ratings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    customerId = json['customer_id'];
    projectID = json['projectID'];
    rating = json['rating'];
    userReview = json['user_review'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['customer_id'] = this.customerId;
    data['projectID'] = this.projectID;
    data['rating'] = this.rating;
    data['user_review'] = this.userReview;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
