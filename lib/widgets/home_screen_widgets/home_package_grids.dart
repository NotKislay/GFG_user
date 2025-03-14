import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/home_grid_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class HomePackageOptions extends StatelessWidget {
  const HomePackageOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: mediaquerywidth(0.04, context)),
      child: SizedBox(
        height: mediaqueryheight(0.32, context),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            final item = homeGridItems[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: mediaquerywidth(0.40, context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.whiteColor),
                child: Column(
                  children: [
                    const CustomSizedBoxHeight(0.02),
                    Image.asset(AppImages.tripImage),
                    CustomText(
                      text: item.titleText,
                      fontFamily: CustomFonts.inter,
                      size: 0.03,
                      color: AppColors.blackColor,
                      weight: FontWeight.w700,
                    ),
                    const CustomSizedBoxHeight(0.01),
                    CustomText(
                        textAlign: TextAlign.center,
                        text: item.subText,
                        fontFamily: CustomFonts.inter,
                        size: 0.02,
                        color: AppColors.blackColor),
                    const CustomSizedBoxHeight(0.01),
                    Container(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              end: Alignment.centerLeft,
                              begin: Alignment.centerRight,
                              colors: AppColors.gradientColors),
                          borderRadius: BorderRadius.circular(12)),
                      width: mediaquerywidth(0.23, context),
                      height: mediaqueryheight(0.04, context),
                      child: const Center(
                        child: CustomText(
                            text: 'Get Details',
                            fontFamily: CustomFonts.inter,
                            size: 0.03,
                            color: Colors.white),
                      ),
                    ),
                    const CustomSizedBoxHeight(0.01),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
