import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/gradient_icons.dart';
import 'package:gofriendsgo/utils/constants/gradient_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/fixed_departures_screen/filter_screen/filter_screen.dart';

class FixedDepartureAppBar extends StatelessWidget {
  const FixedDepartureAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: AppColors.gradientColors,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft)),
      child: Padding(
        padding: commonScreenPadding(context),
        child: Column(
          children: [
            SizedBox(
              height: mediaqueryheight(0.05, context),
            ),
            Row(
              children: [
                IconButton(
                    iconSize: mediaquerywidth(0.08, context),
                    onPressed: () {
                      PageNavigations().pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.whiteColor,
                    )),
                const CustomSizedBoxWidth(0.02),
                const CustomText(
                    weight: FontWeight.bold,
                    text: TextStrings.fixedDeparturesHeading,
                    fontFamily: CustomFonts.roboto,
                    size: 0.055,
                    color: AppColors.whiteColor)
              ],
            ),
            const CustomSizedBoxHeight(0.015),
            GestureDetector(
              onTap: () {
                PageNavigations().push(const FilterScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                height: mediaqueryheight(0.055, context),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientIcon(
                        Icons.filter_alt,
                        mediaquerywidth(0.07, context),
                        const LinearGradient(colors: AppColors.gradientColors)),
                    const CustomSizedBoxWidth(0.03),
                    GradientText(TextStrings.filters,
                        gradient: const LinearGradient(
                            colors: AppColors.gradientColors),
                        style: TextStyle(
                            fontSize: mediaquerywidth(0.05, context),
                            fontWeight: FontWeight.w500,
                            fontFamily: CustomFonts.roboto))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
