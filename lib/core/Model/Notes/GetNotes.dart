class GetNotes {
  GetNotes({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory GetNotes.fromJson(Map<String, dynamic> json) {
    return GetNotes(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.data,
    required this.links,
    required this.meta,
  });

  final List<Datum> data;
  final Links? links;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }
}

class Datum {
  Datum({
    required this.uuid,
    required this.slug,
    required this.title,
    required this.date,
    required this.description,
    required this.user,
    required this.stream,
    required this.subject,
    required this.imageFiles,
    required this.pdfFiles,
    required this.audioFiles,
    required this.linkFiles,
    required this.docStatus,
    required this.driveUrl,
  });

  final String? uuid;
  final String? slug;
  final String? title;
  final String? date;
  final String? description;
  final User? user;
  final Stream? stream;
  final Subject? subject;
  final List<ImageFileElement> imageFiles;
  final List<ImageFileElement> pdfFiles;
  final List<dynamic> audioFiles;
  final List<dynamic> linkFiles;
  final DocStatus? docStatus;
  final dynamic driveUrl;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      uuid: json["uuid"],
      slug: json["slug"],
      title: json["title"],
      date: json["date"],
      description: json["description"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      stream: json["stream"] == null ? null : Stream.fromJson(json["stream"]),
      subject:
          json["subject"] == null ? null : Subject.fromJson(json["subject"]),
      imageFiles: json["image_files"] == null
          ? []
          : List<ImageFileElement>.from(
              json["image_files"]!.map((x) => ImageFileElement.fromJson(x))),
      pdfFiles: json["pdf_files"] == null
          ? []
          : List<ImageFileElement>.from(
              json["pdf_files"]!.map((x) => ImageFileElement.fromJson(x))),
      audioFiles: json["audio_files"] == null
          ? []
          : List<dynamic>.from(json["audio_files"]!.map((x) => x)),
      linkFiles: json["link_files"] == null
          ? []
          : List<dynamic>.from(json["link_files"]!.map((x) => x)),
      docStatus: json["doc_status"] == null
          ? null
          : DocStatus.fromJson(json["doc_status"]),
      driveUrl: json["drive_url"],
    );
  }
}

class DocStatus {
  DocStatus({
    required this.uuid,
    required this.isRequest,
    required this.status,
  });

  final String? uuid;
  final bool? isRequest;
  final int? status;

  factory DocStatus.fromJson(Map<String, dynamic> json) {
    return DocStatus(
      uuid: json["uuid"],
      isRequest: json["is_request"],
      status: json["status"],
    );
  }
}

class ImageFileElement {
  ImageFileElement({
    required this.uuid,
    required this.fileName,
    required this.fileType,
    required this.fileMimeType,
    required this.fileSize,
    required this.filePath,
  });

  final String? uuid;
  final String? fileName;
  final String? fileType;
  final String? fileMimeType;
  final String? fileSize;
  final String? filePath;

  factory ImageFileElement.fromJson(Map<String, dynamic> json) {
    return ImageFileElement(
      uuid: json["uuid"],
      fileName: json["file_name"],
      fileType: json["file_type"],
      fileMimeType: json["file_mime_type"],
      fileSize: json["file_size"],
      filePath: json["file_path"],
    );
  }
}

class Stream {
  Stream({
    required this.uuid,
    required this.title,
  });

  final String? uuid;
  final String? title;

  factory Stream.fromJson(Map<String, dynamic> json) {
    return Stream(
      uuid: json["uuid"],
      title: json["title"],
    );
  }
}

class Subject {
  Subject({
    required this.uuid,
    required this.title,
    required this.expiryDate,
    required this.isPurchased,
  });

  final String? uuid;
  final String? title;
  final dynamic expiryDate;
  final int? isPurchased;

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      uuid: json["uuid"],
      title: json["title"],
      expiryDate: json["expiry_date"],
      isPurchased: json["is_purchased"],
    );
  }
}

class User {
  User({
    required this.uuid,
    required this.name,
    required this.role,
    required this.city,
    required this.fullImagePath,
    required this.universityName,
    required this.collegeName,
    required this.preferredLanguage,
    required this.otherInformation,
    required this.achievements,
    required this.researchOfExpertise,
    required this.educationQualification,
    required this.rating,
    required this.isReview,
    required this.totalReviews,
    required this.totalNotes,
    required this.totalQueries,
  });

  final String? uuid;
  final String? name;
  final String? role;
  final String? city;
  final String? fullImagePath;
  final String? universityName;
  final String? collegeName;
  final String? preferredLanguage;
  final String? otherInformation;
  final String? achievements;
  final String? researchOfExpertise;
  final String? educationQualification;
  final int? rating;
  final int? isReview;
  final int? totalReviews;
  final int? totalNotes;
  final int? totalQueries;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json["uuid"],
      name: json["name"],
      role: json["role"],
      city: json["city"],
      fullImagePath: json["full_image_path"],
      universityName: json["university_name"],
      collegeName: json["college_name"],
      preferredLanguage: json["preferred_language"],
      otherInformation: json["other_information"],
      achievements: json["achievements"],
      researchOfExpertise: json["research_of_expertise"],
      educationQualification: json["education_qualification"],
      rating: json["rating"],
      isReview: json["is_review"],
      totalReviews: json["total_reviews"],
      totalNotes: json["total_notes"],
      totalQueries: json["total_queries"],
    );
  }
}

class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  final String? first;
  final String? last;
  final dynamic prev;
  final String? next;

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json["first"],
      last: json["last"],
      prev: json["prev"],
      next: json["next"],
    );
  }
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  final int? currentPage;
  final int? from;
  final int? lastPage;
  final List<Link> links;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json["current_page"],
      from: json["from"],
      lastPage: json["last_page"],
      links: json["links"] == null
          ? []
          : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      path: json["path"],
      perPage: json["per_page"],
      to: json["to"],
      total: json["total"],
    );
  }
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json["url"],
      label: json["label"],
      active: json["active"],
    );
  }
}
