class QuickRideLocationModel {
  bool status;
  String message;
  QuickRideLocationData data;

  QuickRideLocationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuickRideLocationModel.fromJson(Map<String, dynamic> json) {
    return QuickRideLocationModel(
      status: json['status'],
      message: json['message'],
      data: QuickRideLocationData.fromJson(json['data']),
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

class QuickRideLocationData {
  List<QuickRideLocation> locations;

  QuickRideLocationData({
    required this.locations,
  });

  factory QuickRideLocationData.fromJson(Map<String, dynamic> json) {
    return QuickRideLocationData(
      locations: (json['locations'] as List)
          .map((e) => QuickRideLocation.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locations': locations.map((e) => e.toJson()).toList(),
    };
  }
}

class QuickRideLocation {
  int id;
  String name;
  int status;
  String createdAt;
  String updatedAt;

  QuickRideLocation({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuickRideLocation.fromJson(Map<String, dynamic> json) {
    return QuickRideLocation(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}