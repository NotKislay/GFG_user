class PassportModel {
  final bool status;
  final String message;
  final List<Passport> passports;

  PassportModel({
    required this.status,
    required this.message,
    required this.passports,
  });

  factory PassportModel.fromJson(Map<String, dynamic> json) {
    return PassportModel(
      status: json['status'],
      message: json['message'],
      passports: List<Passport>.from(
        json['data']['passports'].map((x) => Passport.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': {
        'passports': List<dynamic>.from(passports.map((x) => x.toJson())),
      },
    };
  }
}

class Passport {
  final int id;
  final String title;
  final String description;
  final String price;
  final String createdAt;
  final String updatedAt;

  Passport({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Passport.fromJson(Map<String, dynamic> json) {
    return Passport(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
