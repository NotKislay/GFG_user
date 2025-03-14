class VisaModel {
  bool status;
  String message;
  List<Visa> visas;

  VisaModel({
    required this.status,
    required this.message,
    required this.visas,
  });

  factory VisaModel.fromJson(Map<String, dynamic> json) {
    return VisaModel(
      status: json['status'],
      message: json['message'],
      visas:
          List<Visa>.from(json['data']['visas'].map((x) => Visa.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': {
        'visas': visas.map((x) => x.toJson()).toList(),
      },
    };
  }
}

class Visa {
  int id;
  String visaFor;
  int price;
  String image;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<VisaDetail> details;

  Visa({
    required this.id,
    required this.visaFor,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    required this.details,
  });

  factory Visa.fromJson(Map<String, dynamic> json) {
    return Visa(
      id: json['id'],
      price: json['price'],
      visaFor: json['visa_for'],
      image: json['image'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      details: List<VisaDetail>.from(
          json['details'].map((x) => VisaDetail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'visa_for': visaFor,
      'image': image,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'details': details.map((x) => x.toJson()).toList(),
    };
  }
}

class VisaDetail {
  int id;
  int visaId;
  String title;
  String description;
  double? price;
  DateTime createdAt;
  DateTime updatedAt;

  VisaDetail({
    required this.id,
    required this.visaId,
    required this.title,
    required this.description,
    this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VisaDetail.fromJson(Map<String, dynamic> json) {
    return VisaDetail(
      id: json['id'],
      visaId: json['visa_id'],
      title: json['title'],
      description: json['description'],
      price: json['price']?.toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'visa_id': visaId,
      'title': title,
      'description': description,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
