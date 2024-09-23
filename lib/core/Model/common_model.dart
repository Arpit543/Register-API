class CommonModel{
  final bool? success;
  final String? message;
  final dynamic data;

  CommonModel({this.success, this.message, this.data});

  factory CommonModel.fromJson(Map<String, dynamic> json){
    return CommonModel(
      success: json["success"],
      message: json["message"],
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}