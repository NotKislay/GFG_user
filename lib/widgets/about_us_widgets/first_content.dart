import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class AboutUsFirstContent extends StatelessWidget {
  const AboutUsFirstContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomSizedBoxHeight(0.15),
          Image.asset(
            AppImages.goFriendsGoLogoMini,
            filterQuality: FilterQuality.high,
          ),
          const CustomSizedBoxHeight(0.05),
          SizedBox(
            height: mediaqueryheight(0.13, context),
            child: const CustomText(
              textAlign: TextAlign.center,
              text: TextStrings.ourMission,
              fontFamily: CustomFonts.roboto,
              size: 0.06,
              color: AppColors.whiteColor,
              weight: FontWeight.bold,
            ),
          ),
          const CustomSizedBoxHeight(0.015),
          SizedBox(
            height: mediaqueryheight(0.1, context),
            child: const CustomText(
              textAlign: TextAlign.center,
              text: TextStrings.ourStoryFirstText,
              fontFamily: CustomFonts.roboto,
              size: 0.03,
              color: Color.fromRGBO(255, 255, 255, 0.57),
              weight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}