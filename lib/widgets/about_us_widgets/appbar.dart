
import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';

class AboutUsAppBarElements extends StatelessWidget {
  const AboutUsAppBarElements({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          iconSize: mediaquerywidth(0.08, context),
          onPressed: () {
            PageNavigations().pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: mediaquerywidth(0.07, context),
            color: AppColors.whiteColor,
          ),
        ),
        const CustomSizedBoxWidth(0.02),
        const CustomText(
          weight: FontWeight.w600,
          text: TextStrings.aboutUs,
          fontFamily: CustomFonts.inter,
          size: 0.055,
          color: AppColors.whiteColor,
        ),
      ],
    );
  }
}