class FamilyMember {
  String? id;
  String? name;
  String? dob;
  String? mobile;
  String? email;
  String? relation;

  FamilyMember({this.id, this.name, this.dob, this.mobile, this.email, this.relation});

  FamilyMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dob = json['dob'];
    mobile = json['mobile'];
    email = json['email'];
    relation = json['relation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['dob'] = dob;
    data['mobile'] = mobile;
    data['email'] = email;
    data['relation'] = relation;
    return data;
  }
}
