import 'agentreview.dart';

class Agent {
  dynamic id;
  dynamic customerId;
  dynamic agencyId;
  String? slug;
  dynamic status;
  dynamic isFeature;
  dynamic featuredDatetime;
  String? dealingArea;
  String? experience;
  String? facebookLink;
  String? twitterLink;
  String? instagramLink;
  String? linkedinLink;
  String? youtubeLink;
  dynamic subStatus;
  String? createdAt;
  String? updatedAt;
  String? agencyName;
  String? firstName;
  String? lastName;
  String? customerAvatar;
  String? address;
  String? contactNumber;
  String? whatsappNumber;
  String? customerEmail;
  String? totalProperties;
  List<Reviews>? reviews;

  Agent({
    this.id,
    this.customerId,
    this.agencyId,
    this.slug,
    this.status,
    this.isFeature,
    this.featuredDatetime,
    this.dealingArea,
    this.experience,
    this.facebookLink,
    this.twitterLink,
    this.instagramLink,
    this.linkedinLink,
    this.youtubeLink,
    this.subStatus,
    this.createdAt,
    this.updatedAt,
    this.agencyName,
    this.firstName,
    this.lastName,
    this.customerAvatar,
    this.address,
    this.contactNumber,
    this.whatsappNumber,
    this.customerEmail,
    this.totalProperties,
    this.reviews,
  });

  Agent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    agencyId = json['agency_id'];
    slug = json['slug'];
    status = json['status'];
    isFeature = json['is_feature'];
    featuredDatetime = json['featured_datetime'];
    dealingArea = json['dealing_area'];
    experience = json['experience'];
    facebookLink = json['facebook_link'];
    twitterLink = json['twitter_link'];
    instagramLink = json['instagram_link'];
    linkedinLink = json['linkedin_link'];
    youtubeLink = json['youtube_link'];
    subStatus = json['sub_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    agencyName = json['agency_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    customerAvatar = json['customer_avatar'];
    address = json['address'];
    contactNumber = json['contact_number'];
    whatsappNumber = json['whatsapp_number'];
    customerEmail = json['customer_email'];
    totalProperties = json['agent_properties_count'].toString();
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['agency_id'] = this.agencyId;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['is_feature'] = this.isFeature;
    data['featured_datetime'] = this.featuredDatetime;
    data['dealing_area'] = this.dealingArea;
    data['experience'] = this.experience;
    data['facebook_link'] = this.facebookLink;
    data['twitter_link'] = this.twitterLink;
    data['instagram_link'] = this.instagramLink;
    data['linkedin_link'] = this.linkedinLink;
    data['youtube_link'] = this.youtubeLink;
    data['sub_status'] = this.subStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['agency_name'] = this.agencyName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['customer_avatar'] = this.customerAvatar;
    data['address'] = this.address;
    data['contact_number'] = this.contactNumber;
    data['whatsapp_number'] = this.whatsappNumber;
    data['customer_email'] = this.customerEmail;
    data['agent_properties_count'] = this.totalProperties;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
