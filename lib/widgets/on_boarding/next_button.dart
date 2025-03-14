import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/login_screen/login_screen.dart';

class NextButtonOnBoarding extends StatelessWidget {
  const NextButtonOnBoarding({
    super.key,
    required this.isPageViewBuilt,
    required this.pageController,
  });

  final bool isPageViewBuilt;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.whiteColor),
      height: mediaqueryheight(0.1, context),
      child: Column(
        children: [
          SizedBox(
            width: mediaquerywidth(0.9, context),
            child: OnBoardingButton(
                function: () {
                  if (isPageViewBuilt && pageController.page! < 3) {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  } else {
                    PageNavigations().pushAndRemoveUntill( LoginScreen());
                  }
                },
                text: isPageViewBuilt && pageController.page! < 3
                    ? "Next"
                    : "Get Started",
                fontSize: 0.04,
                buttonTextColor: AppColors.whiteColor,
                borderColor: AppColors.transparentColor,
                fontFamily: CustomFonts.poppins),
          ),
        ],
      ),
    );
  }
}

