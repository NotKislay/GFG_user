import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/on_boarding_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


PageView pageViewMaterialsOnBoarding(List<OnBoardingModel> controller,
    PageController pageController, VoidCallback callBack) {
  return PageView.builder(
    itemCount: controller.length,
    controller: pageController,
    itemBuilder: (context, index) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callBack();
      });

      return Padding(
        padding: commonScreenPadding(context),
        child: Column(
          children: [
            const CustomSizedBoxHeight(0.1),
            Image.asset(
              controller[index].imagePath,
              filterQuality: FilterQuality.high,
            ),
            Transform.scale(
              scale: .8,
              child: SmoothPageIndicator(
                controller: pageController,
                count: controller.length,
              ),
            ),
            const CustomSizedBoxHeight(0.06),
            CustomText(
                weight: FontWeight.bold,
                text: controller[index].title,
                fontFamily: CustomFonts.inknut,
                size: 0.07,
                color: AppColors.blackColor),
            const CustomSizedBoxHeight(0.04),
            SizedBox(
              width: mediaquerywidth(0.7, context),
              child: CustomText(
                  text: controller[index].subTitle,
                  fontFamily: CustomFonts.inter,
                  size: 0.037,
                  textAlign: TextAlign.center,
                  color: AppColors.onBoardingSubtitleColor),
            ),
            const CustomSizedBoxHeight(0.05),
          ],
        ),
      );
    },
  );
}