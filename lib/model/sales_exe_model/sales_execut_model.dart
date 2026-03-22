import 'dart:developer';

class SalesPerson {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? profilePic;
  final String? companyName;
  final String? dob;
  final String? frequentFlyerNo;
  final String? additionalDetails;
  final String? emailVerifiedAt;
  final String? referral;
  final String? source;
  final String? specify;
  final int status;
  final int? otp;
  final DateTime? otpCreatedAt;
  final int target;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int activeStatus;
  final String? avatar;
  final int darkMode;
  final String? messengerColor;
  final String? familyDetails;
  final String? marriageAnniversary;
  final String? salesExec;
  final String? about;

  SalesPerson({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.profilePic,
    this.companyName,
    this.dob,
    this.frequentFlyerNo,
    this.additionalDetails,
    this.emailVerifiedAt,
    this.referral,
    this.source,
    this.specify,
    required this.status,
    this.otp,
    this.otpCreatedAt,
    required this.target,
    required this.createdAt,
    required this.updatedAt,
    required this.activeStatus,
    this.avatar,
    required this.darkMode,
    this.messengerColor,
    this.familyDetails,
    this.marriageAnniversary,
    this.salesExec,
    this.about,
  });

  factory SalesPerson.fromJson(Map<String, dynamic> json) {
    final sales = SalesPerson(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'],
      phone: json['phone'],
      profilePic: json['profile_pic'],
      companyName: json['company_name'],
      dob: json['dob'],
      frequentFlyerNo: json['frequent_flyer_no'],
      additionalDetails: json['additional_details'],
      emailVerifiedAt: json['email_verified_at'],
      referral: json['referral'],
      source: json['source'],
      specify: json['specify'],
      status: json['status'] ?? 0,
      otp: json['otp'],
      otpCreatedAt: json['otp_created_at'] != null
          ? DateTime.tryParse(json['otp_created_at'])
          : null,
      target: json['target'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
      activeStatus: json['active_status'] ?? 0,
      avatar: json['avatar'],
      darkMode: json['dark_mode'] ?? 0,
      messengerColor: json['messenger_color'],
      familyDetails: json['family_details'],
      marriageAnniversary: json['marriage_anniversary'],
      salesExec: json['sales_exec'],
      about: json['about'],
    );
    log("Sales: ${sales.toString()}");
    return sales;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_pic': profilePic,
      'company_name': companyName,
      'dob': dob,
      'frequent_flyer_no': frequentFlyerNo,
      'additional_details': additionalDetails,
      'email_verified_at': emailVerifiedAt,
      'referral': referral,
      'source': source,
      'specify': specify,
      'status': status,
      'otp': otp,
      'otp_created_at': otpCreatedAt?.toIso8601String(),
      'target': target,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'active_status': activeStatus,
      'avatar': avatar,
      'dark_mode': darkMode,
      'messenger_color': messengerColor,
      'family_details': familyDetails,
      'marriage_anniversary': marriageAnniversary,
      'sales_exec': salesExec,
      'about': about,
    };
  }
}

// Response Model
class SalesPersonResponse {
  final bool status;
  final String message;
  final SalesPerson data;
  //final double averageRating;
  final dynamic averageRating;
  final int? userRating;

  SalesPersonResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.averageRating,
    required this.userRating,
  });

  factory SalesPersonResponse.fromJson(Map<String, dynamic> json) {
    return SalesPersonResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: SalesPerson.fromJson(json['data']['sales_person']),
      averageRating: (json['data']['average_rating'] is int)
        ? (json['data']['average_rating'] as int).toDouble()
        : (json['data']['average_rating'] ?? 0.0),
      userRating: json['data']['user_rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': {
        'sales_person': data.toJson(),
        'average_rating': averageRating,
        'user_rating': userRating,
      },
    };
  }
}
