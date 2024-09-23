class UserProfileData {
  UserProfileData({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory UserProfileData.fromJson(Map<String, dynamic> json){
    return UserProfileData(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.uuid,
    required this.roleUuid,
    required this.accessToken,
    required this.name,
    required this.username,
    required this.mobile,
    required this.countryCode,
    required this.email,
    required this.researchGate,
    required this.googleScholar,
    required this.linkedin,
    required this.twitter,
    required this.facebook,
    required this.instagram,
    required this.emailVerifiedAt,
    required this.password,
    required this.country,
    required this.state,
    required this.city,
    required this.image,
    required this.verify,
    required this.status,
    required this.loggedIn,
    required this.passwordGenerated,
    required this.collegeName,
    required this.universityName,
    required this.streamUuid,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.fullImagePath,
  });

  final int? id;
  final String? uuid;
  final String? roleUuid;
  final dynamic accessToken;
  final String? name;
  final dynamic username;
  final String? mobile;
  final dynamic countryCode;
  final String? email;
  final dynamic researchGate;
  final dynamic googleScholar;
  final dynamic linkedin;
  final dynamic twitter;
  final dynamic facebook;
  final dynamic instagram;
  final dynamic emailVerifiedAt;
  final String? password;
  final int? country;
  final int? state;
  final int? city;
  final dynamic image;
  final int? verify;
  final int? status;
  final int? loggedIn;
  final int? passwordGenerated;
  final dynamic collegeName;
  final dynamic universityName;
  final String? streamUuid;
  final dynamic rememberToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic fullImagePath;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      uuid: json["uuid"],
      roleUuid: json["role_uuid"],
      accessToken: json["access_token"],
      name: json["name"],
      username: json["username"],
      mobile: json["mobile"],
      countryCode: json["country_code"],
      email: json["email"],
      researchGate: json["research_gate"],
      googleScholar: json["google_scholar"],
      linkedin: json["linkedin"],
      twitter: json["twitter"],
      facebook: json["facebook"],
      instagram: json["instagram"],
      emailVerifiedAt: json["email_verified_at"],
      password: json["password"],
      country: json["country"],
      state: json["state"],
      city: json["city"],
      image: json["image"],
      verify: json["verify"],
      status: json["status"],
      loggedIn: json["logged_in"],
      passwordGenerated: json["password_generated"],
      collegeName: json["college_name"],
      universityName: json["university_name"],
      streamUuid: json["stream_uuid"],
      rememberToken: json["remember_token"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      fullImagePath: json["full_image_path"],
    );
  }

}
