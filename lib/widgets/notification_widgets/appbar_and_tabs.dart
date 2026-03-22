import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/gradient_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';

class AppBarAndTabItems extends StatelessWidget {
  const AppBarAndTabItems({
    super.key,
    required this.pageController,
    required this.currentPage,
  });

  final PageController pageController;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                      color: AppColors.blackColor,
                    ),
                  ),
                  const CustomSizedBoxWidth(0.02),
                  const CustomText(
                    weight: FontWeight.bold,
                    text: "Notifications",
                    fontFamily: CustomFonts.roboto,
                    size: 0.055,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        const CustomSizedBoxHeight(0.02),
        Row(
          children: [
            const CustomSizedBoxWidth(0.08),
            GestureDetector(
              onTap: () {
                pageController.animateToPage(0,
                    duration: const Duration(milliseconds: 400), curve: Curves.ease);
              },
              child: Container(
                width: mediaquerywidth(0.17, context),
                height: mediaqueryheight(0.04, context),
                decoration: BoxDecoration(
                  color: currentPage == 0
                      ? AppColors.notificationSelectedBarColor
                      : AppColors.notificationUnSelectedBarColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: GradientText(
                    'All',
                    gradient:
                        const LinearGradient(colors: AppColors.gradientColors),
                    style: TextStyle(
                      fontSize: mediaquerywidth(0.04, context),
                    ),
                  ),
                ),
              ),
            ),
            const CustomSizedBoxWidth(0.03),
            GestureDetector(
              onTap: () {
                pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 400), curve: Curves.ease);
              },
              child: Container(
                width: mediaquerywidth(0.27, context),
                height: mediaqueryheight(0.04, context),
                decoration: BoxDecoration(
                  color: currentPage == 1
                      ? AppColors.notificationSelectedBarColor
                      : AppColors.notificationUnSelectedBarColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: CustomText(
                    text: 'Unread',
                    fontFamily: CustomFonts.roboto,
                    size: 0.04,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        const CustomSizedBoxHeight(0.03),
      ],
    );
  }
}