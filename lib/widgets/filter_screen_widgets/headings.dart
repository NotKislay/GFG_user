import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class FilterScreenHeadings extends StatelessWidget {
  final String heading;
  const FilterScreenHeadings(
    this.heading, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: mediaqueryheight(0.025, context),
      ),
      child: CustomText(
        weight: FontWeight.w500,
        text: heading,
        fontFamily: CustomFonts.inter,
        size: 0.042,
        color: AppColors.blackColor,
      ),
    );
  }
}
