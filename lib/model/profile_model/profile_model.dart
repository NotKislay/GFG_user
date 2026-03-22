class UserProfileModel {
  final bool status;
  final dynamic message;
  final UserData data;

  UserProfileModel(
      {required this.status, required this.message, required this.data});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      status: json['status'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final User user;

  UserData({required this.user});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final dynamic id;
  final dynamic name;
  final dynamic email;
  final dynamic phone;
  final dynamic salesExec;
  final dynamic profilePic;
  final dynamic companyName;
  final dynamic dob;
  final dynamic frequentFlyerNo;
  final dynamic additionalDetails;
  final dynamic marriagAnniversary;
  final dynamic emailVerifiedAt;
  final dynamic referral;
  final dynamic source;
  final dynamic specify;
  final dynamic status;
  final dynamic otp;
  final dynamic otpCreatedAt;
  final dynamic target;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic activeStatus;
  final dynamic avatar;
  final dynamic darkMode;
  final dynamic messengerColor;
  final List<Role> roles;

  User({
    required this.id,
    required this.name,
    required this.salesExec,
    required this.email,
    required this.phone,
    this.profilePic,
    required this.companyName,
    required this.marriagAnniversary,
    required this.dob,
    required this.frequentFlyerNo,
    required this.additionalDetails,
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
    required this.avatar,
    required this.darkMode,
    this.messengerColor,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var rolesFromJson = json['roles'] as List;
    List<Role> roleList =
        rolesFromJson.map((role) => Role.fromJson(role)).toList();

    return User(
      id: json['id'],
      name: json['name'],
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
      status: json['status'],
      otp: json['otp'],
      otpCreatedAt: json['otp_created_at'],
      target: json['target'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      activeStatus: json['active_status'],
      avatar: json['avatar'],
      darkMode: json['dark_mode'],
      messengerColor: json['messenger_color'],
      roles: roleList, marriagAnniversary: json['marriage_anniversary'], salesExec: json['sales_exec'],
    );
  }
}

class Role {
  final dynamic id;
  final dynamic name;
  final dynamic guardName;
  final dynamic createdAt;
  final dynamic updatedAt;

  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      guardName: json['guard_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
