class Reviews {
  dynamic id;
  String? fullName;
  dynamic customerId;
  dynamic agentID;
  dynamic rating;
  String? userReview;
  String? createdAt;
  String? updatedAt;

  Reviews(
      {this.id,
      this.fullName,
      this.customerId,
      this.agentID,
      this.rating,
      this.userReview,
      this.createdAt,
      this.updatedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    customerId = json['customer_id'];
    agentID = json['agentID'];
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
    data['agentID'] = this.agentID;
    data['rating'] = this.rating;
    data['user_review'] = this.userReview;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
