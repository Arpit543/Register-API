class subjectData {
  bool? success;
  String? message;
  List<Data>? data;

  subjectData({this.success, this.message, this.data});

  subjectData.fromJson(Map<String, dynamic> json) {
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
  String? streamUuid;
  String? title;
  String? slug;
  Null? status;
  Null? isStandard;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? isSelected;

  Data(
      {this.id,
        this.uuid,
        this.streamUuid,
        this.title,
        this.slug,
        this.status,
        this.isStandard,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.isSelected});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    streamUuid = json['stream_uuid'];
    title = json['title'];
    slug = json['slug'];
    status = json['status'];
    isStandard = json['is_standard'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['stream_uuid'] = this.streamUuid;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['is_standard'] = this.isStandard;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_selected'] = this.isSelected;
    return data;
  }
}