import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';


class PassportRequirementHeading extends StatelessWidget {
  const PassportRequirementHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomText(
        text: TextStrings.passportRequirement,
        fontFamily: CustomFonts.roboto,
        size: 0.06,
        color: AppColors.blackColor);
  }
}
