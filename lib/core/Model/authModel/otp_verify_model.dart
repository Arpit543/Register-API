class OtpVerifyModel {
  OtpVerifyModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory OtpVerifyModel.fromJson(Map<String, dynamic> json){
    return OtpVerifyModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };

}

class Data {
  Data({
    required this.token,
  });

  final String? token;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
    "token": token,
  };

}
