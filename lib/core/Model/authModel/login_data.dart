class LoginModel {
  bool? success;
  String? message;
  Data? data;

  LoginModel({this.success, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? uuid;
  String? roleUuid;
  Null? accessToken;
  String? name;
  Null? username;
  String? mobile;
  Null? countryCode;
  String? email;
  Null? researchGate;
  Null? googleScholar;
  Null? linkedin;
  Null? twitter;
  Null? facebook;
  Null? instagram;
  Null? emailVerifiedAt;
  String? password;
  int? country;
  int? state;
  int? city;
  Null? image;
  int? verify;
  int? status;
  int? loggedIn;
  int? passwordGenerated;
  Null? collegeName;
  Null? universityName;
  String? streamUuid;
  Null? rememberToken;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? fullImagePath;

  Data(
      {this.id,
        this.uuid,
        this.roleUuid,
        this.accessToken,
        this.name,
        this.username,
        this.mobile,
        this.countryCode,
        this.email,
        this.researchGate,
        this.googleScholar,
        this.linkedin,
        this.twitter,
        this.facebook,
        this.instagram,
        this.emailVerifiedAt,
        this.password,
        this.country,
        this.state,
        this.city,
        this.image,
        this.verify,
        this.status,
        this.loggedIn,
        this.passwordGenerated,
        this.collegeName,
        this.universityName,
        this.streamUuid,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.fullImagePath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    roleUuid = json['role_uuid'];
    accessToken = json['access_token'];
    name = json['name'];
    username = json['username'];
    mobile = json['mobile'];
    countryCode = json['country_code'];
    email = json['email'];
    researchGate = json['research_gate'];
    googleScholar = json['google_scholar'];
    linkedin = json['linkedin'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    image = json['image'];
    verify = json['verify'];
    status = json['status'];
    loggedIn = json['logged_in'];
    passwordGenerated = json['password_generated'];
    collegeName = json['college_name'];
    universityName = json['university_name'];
    streamUuid = json['stream_uuid'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    fullImagePath = json['full_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['role_uuid'] = this.roleUuid;
    data['access_token'] = this.accessToken;
    data['name'] = this.name;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['country_code'] = this.countryCode;
    data['email'] = this.email;
    data['research_gate'] = this.researchGate;
    data['google_scholar'] = this.googleScholar;
    data['linkedin'] = this.linkedin;
    data['twitter'] = this.twitter;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['image'] = this.image;
    data['verify'] = this.verify;
    data['status'] = this.status;
    data['logged_in'] = this.loggedIn;
    data['password_generated'] = this.passwordGenerated;
    data['college_name'] = this.collegeName;
    data['university_name'] = this.universityName;
    data['stream_uuid'] = this.streamUuid;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['full_image_path'] = this.fullImagePath;
    return data;
  }
}