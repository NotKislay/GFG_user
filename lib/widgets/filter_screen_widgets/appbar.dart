import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view_model/filter_passports_viewmodel.dart';
import 'package:provider/provider.dart';

class AppBarFilterScreen extends StatelessWidget {
  const AppBarFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientColors,
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Padding(
        padding: commonScreenPadding(context),
        child: Column(
          children: [
            SizedBox(height: mediaqueryheight(0.05, context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      iconSize: mediaquerywidth(0.08, context),
                      onPressed: () {
                        context.read<FilterScreenViewModel>().resettingSettings();
                        PageNavigations().pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const CustomText(
                      weight: FontWeight.bold,
                      text: "Filter Results",
                      fontFamily: CustomFonts.roboto,
                      size: 0.055,
                      color: AppColors.whiteColor,
                    )
                  ],
                ),
                Padding(
                  padding:
                  EdgeInsets.only(top: mediaqueryheight(0.003, context)),
                  child: GestureDetector(
                    onTap: () {
                      context.read<FilterScreenViewModel>().resettingSettings();
                    },
                    child: const CustomText(
                      text: "RESET",
                      fontFamily: CustomFonts.roboto,
                      size: 0.045,
                      weight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}