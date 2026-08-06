class QuickRideModel {
  bool status;
  String message;
  QuickRideData data;

  QuickRideModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuickRideModel.fromJson(Map<String, dynamic> json) {
    return QuickRideModel(
      status: json['status'],
      message: json['message'],
      data: QuickRideData.fromJson(json['data']),
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

class QuickRideData {
  List<QuickRide> quickRides;

  QuickRideData({
    required this.quickRides,
  });

  factory QuickRideData.fromJson(Map<String, dynamic> json) {
    return QuickRideData(
      quickRides: (json['quick_rides'] as List)
          .map((e) => QuickRide.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quick_rides': quickRides.map((e) => e.toJson()).toList(),
    };
  }
}

class QuickRide {
  int id;
  int locationId;
  String driverName;
  String rating;
  String phone;
  String whatsapp;
  String vehicle;
  String vehicleNumber;
  String? cardImage;
  String? driverImage;
  int status;
  String createdAt;
  String updatedAt;
  QuickRideLocation location;

  QuickRide({
    required this.id,
    required this.locationId,
    required this.driverName,
    required this.rating,
    required this.phone,
    required this.whatsapp,
    required this.vehicle,
    required this.vehicleNumber,
    this.cardImage,
    this.driverImage,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
  });

  factory QuickRide.fromJson(Map<String, dynamic> json) {
    return QuickRide(
      id: json['id'],
      locationId: json['location_id'],
      driverName: json['driver_name'],
      rating: json['rating'],
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      vehicle: json['vehicle'],
      vehicleNumber: json['vehicle_number'],
      cardImage: json['card_image'],
      driverImage: json['driver_image'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      location: QuickRideLocation.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location_id': locationId,
      'driver_name': driverName,
      'rating': rating,
      'phone': phone,
      'whatsapp': whatsapp,
      'vehicle': vehicle,
      'vehicle_number': vehicleNumber,
      'card_image': cardImage,
      'driver_image': driverImage,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'location': location.toJson(),
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