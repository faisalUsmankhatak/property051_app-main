import 'projectrating.dart';

class Project {
  dynamic id;
  String? title;
  String? projectSlug;
  String? city;
  String? area;
  dynamic subArea;
  String? address;
  String? googleMapPin;
  String? mapIframe;
  String? landArea;
  String? unit;
  String? projectType;
  String? youtubeVideoLink;
  String? completionPlan;
  String? projectExpiry;
  dynamic investmentMinAmount;
  dynamic investmentMaxAmount;
  String? shortDescription;
  String? description;
  String? otherFeatures;
  String? projectManagerName;
  String? projectManagerContactno;
  String? frontPageImage;
  String? pdfFile;
  String? paymentPlanFile;
  dynamic isFeature;
  String? featuredDatetime;
  dynamic marketingBy;
  String? companyName;
  String? companyContactno;
  String? companyEmail;
  String? companyWebsite;
  String? companyLogo;
  dynamic projectStatus;
  String? projectProcessStatus;
  dynamic customerId;
  dynamic developerId;
  String? createdAt;
  String? updatedAt;
  List<Ratings>? ratings;

  Project(
      {this.id,
      this.title,
      this.projectSlug,
      this.city,
      this.area,
      this.subArea,
      this.address,
      this.googleMapPin,
      this.mapIframe,
      this.landArea,
      this.unit,
      this.projectType,
      this.youtubeVideoLink,
      this.completionPlan,
      this.projectExpiry,
      this.investmentMinAmount,
      this.investmentMaxAmount,
      this.shortDescription,
      this.description,
      this.otherFeatures,
      this.projectManagerName,
      this.projectManagerContactno,
      this.frontPageImage,
      this.pdfFile,
      this.paymentPlanFile,
      this.isFeature,
      this.featuredDatetime,
      this.marketingBy,
      this.companyName,
      this.companyContactno,
      this.companyEmail,
      this.companyWebsite,
      this.companyLogo,
      this.projectStatus,
      this.projectProcessStatus,
      this.customerId,
      this.developerId,
      this.createdAt,
      this.updatedAt,
      this.ratings});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    projectSlug = json['project_slug'];
    city = json['city'];
    area = json['area'];
    subArea = json['sub_area'];
    address = json['address'];
    googleMapPin = json['google_map_pin'];
    mapIframe = json['map_iframe'];
    landArea = json['land_area'];
    unit = json['unit'];
    projectType = json['project_type'];
    youtubeVideoLink = json['youtube_video_link'];
    completionPlan = json['completion_plan'];
    projectExpiry = json['project_expiry'];
    investmentMinAmount = json['investment_min_amount'];
    investmentMaxAmount = json['investment_max_amount'];
    shortDescription = json['short_description'];
    description = json['description'];
    otherFeatures = json['other_features'];
    projectManagerName = json['project_manager_name'];
    projectManagerContactno = json['project_manager_contactno'];
    frontPageImage = json['front_page_image'];
    pdfFile = json['pdf_file'];
    paymentPlanFile = json['payment_plan_file'];
    isFeature = json['is_feature'];
    featuredDatetime = json['featured_datetime'];
    marketingBy = json['marketing_by'];
    companyName = json['company_name'];
    companyContactno = json['company_contactno'];
    companyEmail = json['company_email'];
    companyWebsite = json['company_website'];
    companyLogo = json['company_logo'];
    projectStatus = json['project_status'];
    projectProcessStatus = json['project_process_status'];
    customerId = json['customer_id'];
    developerId = json['developer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['project_slug'] = this.projectSlug;
    data['city'] = this.city;
    data['area'] = this.area;
    data['sub_area'] = this.subArea;
    data['address'] = this.address;
    data['google_map_pin'] = this.googleMapPin;
    data['map_iframe'] = this.mapIframe;
    data['land_area'] = this.landArea;
    data['unit'] = this.unit;
    data['project_type'] = this.projectType;
    data['youtube_video_link'] = this.youtubeVideoLink;
    data['completion_plan'] = this.completionPlan;
    data['project_expiry'] = this.projectExpiry;
    data['investment_min_amount'] = this.investmentMinAmount;
    data['investment_max_amount'] = this.investmentMaxAmount;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['other_features'] = this.otherFeatures;
    data['project_manager_name'] = this.projectManagerName;
    data['project_manager_contactno'] = this.projectManagerContactno;
    data['front_page_image'] = this.frontPageImage;
    data['pdf_file'] = this.pdfFile;
    data['payment_plan_file'] = this.paymentPlanFile;
    data['is_feature'] = this.isFeature;
    data['featured_datetime'] = this.featuredDatetime;
    data['marketing_by'] = this.marketingBy;
    data['company_name'] = this.companyName;
    data['company_contactno'] = this.companyContactno;
    data['company_email'] = this.companyEmail;
    data['company_website'] = this.companyWebsite;
    data['company_logo'] = this.companyLogo;
    data['project_status'] = this.projectStatus;
    data['project_process_status'] = this.projectProcessStatus;
    data['customer_id'] = this.customerId;
    data['developer_id'] = this.developerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
