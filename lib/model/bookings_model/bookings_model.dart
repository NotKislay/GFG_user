// Model class for Booking
class BookingModel {
  final int id;
  final int chatId;
  final String userName;
  final String amount;
  final String sector;
  final String services;
  final String ticket;
  final DateTime createdAt;
  final String date;
  final DateTime updatedAt;

  BookingModel({
    required this.date,
    required this.id,
    required this.chatId,
    required this.userName,
    required this.amount,
    required this.sector,
    required this.services,
    required this.ticket,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      date: json['date'],
      chatId: json['chat_id'],
      userName: json['user_name'],
      amount: json['amount'],
      sector: json['sector'],
      services: json['services'],
      ticket: json['ticket'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'date': date,
      'user_name': userName,
      'amount': amount,
      'sector': sector,
      'services': services,
      'ticket': ticket,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

// Model class for the response
class BookingResponse {
  final bool status;
  final String message;
  final BookingData data;

  BookingResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      status: json['status'],
      message: json['message'],
      data: BookingData.fromJson(json['data']),
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

class BookingData {
  final List<BookingModel> bookings;

  BookingData({required this.bookings});

  factory BookingData.fromJson(Map<String, dynamic> json) {
    var list = json['bookings'] as List;
    List<BookingModel> bookingsList =
        list.map((i) => BookingModel.fromJson(i)).toList();

    return BookingData(bookings: bookingsList);
  }

  Map<String, dynamic> toJson() {
    return {
      'bookings': bookings.map((booking) => booking.toJson()).toList(),
    };
  }
}
