class BannersModel {
  final bool status;
  final String message;
  final BannersData data;

  BannersModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      status: json['status'],
      message: json['message'],
      data: BannersData.fromJson(json['data']),
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

class BannersData {
  final List<Banner> banners;

  BannersData({
    required this.banners,
  });

  factory BannersData.fromJson(Map<String, dynamic> json) {
    return BannersData(
      banners: List<Banner>.from(
          json['banners'].map((banner) => Banner.fromJson(banner))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banners': banners.map((banner) => banner.toJson()).toList(),
    };
  }
}

class Banner {
  final int id;
  final String name;
  final String image;

  Banner({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'image $image';
  }
}
