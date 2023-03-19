import 'agencyreview.dart';
import 'staffmember.dart';

class Agency {
  dynamic id;
  dynamic customerId;
  String? name;
  String? username;
  String? slug;
  String? logo;
  dynamic pageCover;
  String? websiteUrl;
  String? email;
  String? ceoName;
  String? ceoImage;
  String? ceoMessage;
  String? ceoEmail;
  String? ceoContact;
  String? landline;
  String? uan;
  String? mobile1;
  String? mobile2;
  String? locationMap;
  dynamic cityId;
  String? address1;
  String? address2;
  String? facebookLink;
  String? twitterLink;
  String? instagramLink;
  String? linkedinLink;
  String? youtubeLink;
  String? aboutUs;
  String? slogan;
  dynamic status;
  dynamic isFeature;
  dynamic featuredDatetime;
  String? video1Link;
  String? video2Link;
  String? video3Link;
  String? createdAt;
  String? updatedAt;
  String? totalAgents;
  String? totalProperties;
  List<Reviews>? reviews;
  List<StaffMembers>? staffMembers;

  Agency({
    this.id,
    this.customerId,
    this.name,
    this.username,
    this.slug,
    this.logo,
    this.pageCover,
    this.websiteUrl,
    this.email,
    this.ceoName,
    this.ceoImage,
    this.ceoMessage,
    this.ceoEmail,
    this.ceoContact,
    this.landline,
    this.uan,
    this.mobile1,
    this.mobile2,
    this.locationMap,
    this.cityId,
    this.address1,
    this.address2,
    this.facebookLink,
    this.twitterLink,
    this.instagramLink,
    this.linkedinLink,
    this.youtubeLink,
    this.aboutUs,
    this.slogan,
    this.status,
    this.isFeature,
    this.featuredDatetime,
    this.video1Link,
    this.video2Link,
    this.video3Link,
    this.createdAt,
    this.updatedAt,
    this.totalAgents,
    this.totalProperties,
    this.reviews,
    this.staffMembers,
  });

  Agency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    name = json['name'];
    username = json['username'];
    slug = json['slug'];
    logo = json['logo'];
    pageCover = json['page_cover'];
    websiteUrl = json['website_url'];
    email = json['email'];
    ceoName = json['ceo_name'];
    ceoImage = json['ceo_image'];
    ceoMessage = json['ceo_message'];
    ceoEmail = json['ceo_email'];
    ceoContact = json['ceo_contact'];
    landline = json['landline'];
    uan = json['uan'];
    mobile1 = json['mobile1'];
    mobile2 = json['mobile2'];
    locationMap = json['location_map'];
    cityId = json['city_id'];
    address1 = json['address1'];
    address2 = json['address2'];
    facebookLink = json['facebook_link'];
    twitterLink = json['twitter_link'];
    instagramLink = json['instagram_link'];
    linkedinLink = json['linkedin_link'];
    youtubeLink = json['youtube_link'];
    aboutUs = json['about_us'];
    slogan = json['slogan'];
    status = json['status'];
    isFeature = json['is_feature'];
    featuredDatetime = json['featured_datetime'];
    video1Link = json['video1_link'];
    video2Link = json['video2_link'];
    video3Link = json['video3_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalAgents = json['agents_count'].toString();
    totalProperties = json['agency_properties_count'].toString();
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    if (json['staff_members'] != null) {
      staffMembers = <StaffMembers>[];
      json['staff_members'].forEach((v) {
        staffMembers!.add(new StaffMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['slug'] = this.slug;
    data['logo'] = this.logo;
    data['page_cover'] = this.pageCover;
    data['website_url'] = this.websiteUrl;
    data['email'] = this.email;
    data['ceo_name'] = this.ceoName;
    data['ceo_image'] = this.ceoImage;
    data['ceo_message'] = this.ceoMessage;
    data['ceo_email'] = this.ceoEmail;
    data['ceo_contact'] = this.ceoContact;
    data['landline'] = this.landline;
    data['uan'] = this.uan;
    data['mobile1'] = this.mobile1;
    data['mobile2'] = this.mobile2;
    data['location_map'] = this.locationMap;
    data['city_id'] = this.cityId;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['facebook_link'] = this.facebookLink;
    data['twitter_link'] = this.twitterLink;
    data['instagram_link'] = this.instagramLink;
    data['linkedin_link'] = this.linkedinLink;
    data['youtube_link'] = this.youtubeLink;
    data['about_us'] = this.aboutUs;
    data['slogan'] = this.slogan;
    data['status'] = this.status;
    data['is_feature'] = this.isFeature;
    data['featured_datetime'] = this.featuredDatetime;
    data['video1_link'] = this.video1Link;
    data['video2_link'] = this.video2Link;
    data['video3_link'] = this.video3Link;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    if (this.staffMembers != null) {
      data['staff_members'] =
          this.staffMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
