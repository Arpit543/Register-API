class StreamData {
  bool? success;
  String? message;
  List<Data>? data;

  StreamData({this.success, this.message, this.data});

  StreamData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? uuid;
  String? title;
  String? slug;
  int? status;
  int? isStandard;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.uuid,
        this.title,
        this.slug,
        this.status,
        this.isStandard,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    slug = json['slug'];
    status = json['status'];
    isStandard = json['is_standard'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['is_standard'] = this.isStandard;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}