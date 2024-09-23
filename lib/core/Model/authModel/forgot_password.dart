class ForgotPasswordModel {
  ForgotPasswordModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
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
    required this.email,
  });

  final String? email;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
