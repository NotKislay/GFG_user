import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/home_screen/home_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: commonScreenPadding(context),
        child: Column(
          children: [
            const CustomSizedBoxHeight(0.33),
            SizedBox(
              width: mediaquerywidth(0.9, context),
              height: mediaqueryheight(0.28, context),
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: [
                    const CustomSizedBoxHeight(0.03),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.successIconColor),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Icon(
                          Icons.check,
                          size: mediaquerywidth(0.12, context),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const CustomSizedBoxHeight(0.02),
                    const CustomText(
                      fontFamily: CustomFonts.poppins,
                      text: TextStrings.successText,
                      size: 0.04,
                      color: Colors.black,
                      weight: FontWeight.w600,
                    ),
                    const CustomSizedBoxHeight(0.01),
                    const CustomText(
                      fontFamily: CustomFonts.poppins,
                      text: TextStrings.successLongText,
                      size: 0.04,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            const CustomSizedBoxHeight(0.3),
            CustomButton(
                fontFamily: CustomFonts.poppins,
                function: () {
                  PageNavigations().push(const HomeScreen());
                },
                text: 'Get Started',
                fontSize: 0.04,
                buttonTextColor: AppColors.whiteColor,
                borderColor: AppColors.transparentColor)
          ],
        ),
      ),
    );
  }
}
