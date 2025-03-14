import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class CabRatesTitle extends StatelessWidget {
  const CabRatesTitle({
    super.key,
    required this.title,
  });

  final String  title;

  @override
  Widget build(BuildContext context) {
    return CustomText(
        text: title.toUpperCase(),
        fontFamily: CustomFonts.roboto,
        size: 0.065,
        color: AppColors.blackColor);
  }
}
