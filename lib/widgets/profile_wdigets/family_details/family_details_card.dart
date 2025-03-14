import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/family_model/family_member.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/family_details/family_member_add_edit_screen.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/family_details/form_type.dart';

class FamilyDetailsCard extends StatelessWidget {
  final FamilyMember member;
  final VoidCallback onDeleteTapped;

  const FamilyDetailsCard(this.member,
      {required this.onDeleteTapped, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    '${calculateAge(member.dob!)} yrs, ${member.mobile}',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                  ),
                  Text(
                    member.email!,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    member.relation!,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                        color: AppColors.gradientColors[1]),
                  ),
                ],
              ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FamilyMemberAddEditScreen(
                          formType: FormType.editForm,
                          memberData: member,
                        );
                      }));
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                          color: AppColors.gradientColors[1], fontSize: 16),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      onDeleteTapped();
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.grey.shade300,
          height: 1,
        ),
        SizedBox(
          height: 2,
        )
      ],
    );
  }

  String calculateAge(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateTime currentTime = DateTime.timestamp();
    return (currentTime.year - dateTime.year).toString();
  }
}
