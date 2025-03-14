import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';


class VisaChecklistSubHeading extends StatelessWidget {
  final String countryName;
  const VisaChecklistSubHeading({
  required this.countryName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  CustomText(
      text: "Visa for $countryName",
      fontFamily: CustomFonts.lato,
      size: 0.05,
      color: AppColors.blackColor,
      weight: FontWeight.w500,
    );
  }
}

class VisaRequirementHeading extends StatelessWidget {
  const VisaRequirementHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomText(
        text: TextStrings.visaRequirement,
        fontFamily: CustomFonts.roboto,
        size: 0.06,
        color: AppColors.blackColor);
  }
}
