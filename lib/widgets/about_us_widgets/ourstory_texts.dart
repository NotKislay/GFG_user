import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class OurStoryHeading extends StatelessWidget {
  const OurStoryHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomText(
        text: TextStrings.ourStory,
        fontFamily: CustomFonts.roboto,
        size: 0.06,
        weight: FontWeight.bold,
        color: AppColors.blackColor);
  }
}

class OurStoryTexts extends StatelessWidget {
  final String text;
  const OurStoryTexts(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
        text: text,
        fontFamily: CustomFonts.poppins,
        size: 0.036,
        color: const Color.fromRGBO(41, 41, 41, 1));
  }
}