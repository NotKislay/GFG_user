import 'dart:convert';

class FixedDeparturesModel {
  bool status;
  String message;
  Data data;

  FixedDeparturesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FixedDeparturesModel.fromJson(String str) =>
      FixedDeparturesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FixedDeparturesModel.fromMap(Map<String, dynamic> json) =>
      FixedDeparturesModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  List<FixedDeparture> fixedDepartures;

  Data({
    required this.fixedDepartures,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        fixedDepartures: List<FixedDeparture>.from(
            json["fixed_departures"].map((x) => FixedDeparture.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "fixed_departures":
            List<dynamic>.from(fixedDepartures.map((x) => x.toMap())),
      };
}

class Tag {
  final String name;
  final String status;

  Tag({
    required this.name,
    required this.status,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
    };
  }
}

class FixedDeparture {
  int id;
  String title;
  String from;
  String to;
  String travelTo;
  String price;
  int? rating;
  List<String> description;
  List<Tag> tag;
  int status;
  int tagStatus;
  DateTime createdAt;
  DateTime updatedAt;

  FixedDeparture({
    required this.id,
    required this.title,
    required this.from,
    required this.to,
    required this.travelTo,
    required this.price,
    this.rating,
    required this.description,
    required this.tag,
    required this.status,
    required this.tagStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FixedDeparture.fromJson(String str) =>
      FixedDeparture.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FixedDeparture.fromMap(Map<String, dynamic> json) => FixedDeparture(
        id: json["id"],
        title: json["title"] ?? '',
        from: json["from"] ?? '',
        to: json["to"] ?? '',
        travelTo: json["travel_to"] ?? '',
        price: json["price"] ?? '',
        rating: json["rating"] ?? 0,
        description: List<String>.from(json["description"].map((x) => x)),
        tag: List<Tag>.from(json["tag"].map((x) => Tag.fromJson(x))),
        status: json["status"],
        tagStatus: json["tag_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "from": from,
        "to": to,
        "travel_to": travelTo,
        "price": price,
        "rating": rating,
        "description": List<dynamic>.from(description.map((x) => x)),
        "tag": List<dynamic>.from(tag.map((x) => x.toJson())),
        "status": status,
        "tag_status": tagStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
