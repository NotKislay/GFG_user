import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class FollowUsHeading extends StatelessWidget {
  const FollowUsHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomText(
        text: TextStrings.followUs,
        fontFamily: CustomFonts.roboto,
        size: 0.05,
        weight: FontWeight.w600,
        color: AppColors.blackColor);
  }
}