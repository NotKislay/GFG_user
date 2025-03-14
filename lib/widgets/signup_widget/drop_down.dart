import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/view_model/user_details.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/sizedbox.dart';

// ignore: must_be_immutable
class StaticDropdownField extends StatelessWidget {
  StaticDropdownField({super.key});

  String? selectedOption;

  final List<String> options = [
    'Sales Person',
    'Social Media',
    'Seminar',
    'Friend',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            CustomText(
              color: AppColors.blackColor,
              fontFamily: CustomFonts.poppins,
              size: 0.04,
              text: 'Where Did You Hear About Us',
            ),
          ],
        ),
        const CustomSizedBoxHeight(0.01),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.red),
            ),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.waving_hand_outlined, color: Colors.grey),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    height: 24,
                    width: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 17.0),
          ),
          value: selectedOption,
          onChanged: (String? newValue) {
            Provider.of<UserViewModel>(context, listen: false)
                .sourceController = newValue!;
          },
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
