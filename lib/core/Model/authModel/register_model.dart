class RegisterUserData {
  bool? success;
  String? message;
  Data? data;

  RegisterUserData({this.success, this.message, this.data});

  RegisterUserData.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? password;
  String? mobile;
  int? country;
  int? state;
  int? city;
  String? universityName;
  String? collegeName;
  String? preferredLanguage;
  String? otherInformation;
  String? streamUuid;
  String? subjects;
  int? accessToken;

  Data(
      {this.name,
        this.email,
        this.password,
        this.mobile,
        this.country,
        this.state,
        this.city,
        this.universityName,
        this.collegeName,
        this.preferredLanguage,
        this.otherInformation,
        this.streamUuid,
        this.subjects,
        this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    mobile = json['mobile'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    universityName = json['university_name'];
    collegeName = json['college_name'];
    preferredLanguage = json['preferred_language'];
    otherInformation = json['other_information'];
    streamUuid = json['stream_uuid'];
    subjects = json['subjects'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mobile'] = this.mobile;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['university_name'] = this.universityName;
    data['college_name'] = this.collegeName;
    data['preferred_language'] = this.preferredLanguage;
    data['other_information'] = this.otherInformation;
    data['stream_uuid'] = this.streamUuid;
    data['subjects'] = this.subjects;
    data['access_token'] = this.accessToken;
    return data;
  }
}