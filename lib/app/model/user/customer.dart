// ignore_for_file: prefer_collection_literals

class Customer {
  dynamic customerId;
  String? firstName;
  String? lastName;
  String? password;
  String? contactNo;
  String? customerEmail;
  dynamic whatsappNumber;
  dynamic isEmailVerified;
  dynamic emailVerificationToken;
  String? gender;
  dynamic country;
  dynamic city;
  String? address;
  dynamic hash;
  String? reset;
  dynamic active;
  String? providerId;
  String? avatar;
  String? image;
  dynamic customerType;
  dynamic tradingModuleAccess;
  String? token;
  String? createdAt;
  String? updatedAt;

  Customer({
    this.customerId,
    this.firstName,
    this.lastName,
    this.password,
    this.contactNo,
    this.customerEmail,
    this.whatsappNumber,
    this.isEmailVerified,
    this.emailVerificationToken,
    this.gender,
    this.country,
    this.city,
    this.address,
    this.hash,
    this.reset,
    this.active,
    this.providerId,
    this.avatar,
    this.image,
    this.customerType,
    this.tradingModuleAccess,
    this.token,
    this.createdAt,
    this.updatedAt,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    password = json['password'];
    contactNo = json['contact_no'];
    customerEmail = json['customer_email'];
    whatsappNumber = json['whatsapp_number'];
    isEmailVerified = json['is_email_verified'];
    emailVerificationToken = json['email_verification_token'];
    gender = json['gender'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    hash = json['hash'];
    reset = json['reset'];
    active = json['active'];
    providerId = json['provider_id'];
    avatar = json['avatar'];
    image = json['image'];
    customerType = json['customer_type'];
    tradingModuleAccess = json['trading_module_access'];
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['customer_id'] = customerId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['password'] = password;
    data['contact_no'] = contactNo;
    data['customer_email'] = customerEmail;
    data['whatsapp_number'] = whatsappNumber;
    data['is_email_verified'] = isEmailVerified;
    data['email_verification_token'] = emailVerificationToken;
    data['gender'] = gender;
    data['country'] = country;
    data['city'] = city;
    data['address'] = address;
    data['hash'] = hash;
    data['reset'] = reset;
    data['active'] = active;
    data['provider_id'] = providerId;
    data['avatar'] = avatar;
    data['image'] = image;
    data['customer_type'] = customerType;
    data['trading_module_access'] = tradingModuleAccess;
    data['token'] = token;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
