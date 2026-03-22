import 'dart:convert';

class GalleryResponse {
  bool status;
  String message;
  GalleryData data;

  GalleryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GalleryResponse.fromJson(String str) =>
      GalleryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GalleryResponse.fromMap(Map<String, dynamic> json) => GalleryResponse(
        status: json["status"],
        message: json["message"],
        data: GalleryData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data.toMap(),
      };
}

class GalleryData {
  List<Gallery> galleries;

  GalleryData({
    required this.galleries,
  });

  factory GalleryData.fromJson(String str) => GalleryData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GalleryData.fromMap(Map<String, dynamic> json) => GalleryData(
        galleries: List<Gallery>.from(
            json["galleries"].map((x) => Gallery.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "galleries": List<dynamic>.from(galleries.map((x) => x.toMap())),
      };
}

class Gallery {
  int id;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  Gallery({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Gallery.fromJson(String str) => Gallery.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gallery.fromMap(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
