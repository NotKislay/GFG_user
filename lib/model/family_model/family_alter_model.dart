import 'family_member.dart';

class FamilyUpdateResponse {
  String? message;
  List<FamilyMember>? familyMembers;

  FamilyUpdateResponse({this.message, this.familyMembers});

  FamilyUpdateResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['family_members'] != null) {
      familyMembers = <FamilyMember>[];
      json['family_members'].forEach((v) {
        familyMembers!.add(FamilyMember.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (familyMembers != null) {
      data['family_members'] = familyMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
