import 'family_member.dart';

class FamilyListResponse {
  List<FamilyMember>? familyMembers;

  FamilyListResponse({this.familyMembers});

  FamilyListResponse.fromJson(Map<String, dynamic> json) {
    if (json['family_members'] != null) {
      familyMembers = <FamilyMember>[];
      json['family_members'].forEach((v) {
        familyMembers!.add(FamilyMember.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (familyMembers != null) {
      data['family_members'] = familyMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
