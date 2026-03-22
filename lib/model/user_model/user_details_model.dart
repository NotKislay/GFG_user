class UserDetails {
  final String name;
  final String email;
  final String role;
  final String? referral;
  final String source;
  final String? phone;

  UserDetails({
    required this.phone,
    required this.name,
    required this.email,
    required this.role,
    this.referral,
    required this.source,
  });

  // Method to convert UserDetails instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'referral': referral,
      'source': source,
    };
  }

  // Factory constructor to create a UserDetails instance from JSON
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      referral: json['referral'],
      source: json['source'],
      phone: json['phone'],
    );
  }
}
