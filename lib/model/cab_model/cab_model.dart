class CabModel {
  bool status;
  String message;
  CabData data;

  CabModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CabModel.fromJson(Map<String, dynamic> json) {
    return CabModel(
      status: json['status'],
      message: json['message'],
      data: CabData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CabData {
  List<Cab> cabs;

  CabData({required this.cabs});

  factory CabData.fromJson(Map<String, dynamic> json) {
    return CabData(
      cabs: List<Cab>.from(json['cabs'].map((x) => Cab.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cabs': cabs.map((x) => x.toJson()).toList(),
    };
  }
}

class Cab {
  int id;
  String type;
  String vechile;
  String price;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String perKm;

  Cab({
    required this.id,
    required this.type,
    required this.vechile,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.perKm,
  });

  factory Cab.fromJson(Map<String, dynamic> json) {
    return Cab(
      id: json['id'],
      type: json['type'],
      vechile: json['vechile'],
      price: json['price'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      perKm: json['per_km']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'vechile': vechile,
      'price': price,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'per_km': perKm
    };
  }
}
