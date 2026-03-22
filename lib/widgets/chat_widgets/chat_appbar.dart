import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';

import '../../utils/color_theme/colors.dart';

class ChatAppbar extends StatelessWidget {
  final String appBarTitle;
  const ChatAppbar({
    required this.appBarTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediaqueryheight(0.21, context),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: AppColors.gradientColors,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft)),
      child: Column(
        children: [
          SizedBox(
            height: mediaqueryheight(0.05, context),
          ),
          Row(
            children: [
              const CustomSizedBoxWidth(0.04),
              GestureDetector(
                onTap: () {
                  PageNavigations().pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.whiteColor,
                  size: mediaquerywidth(0.07, context),
                ),
              ),
              const CustomSizedBoxWidth(0.02),
              Container(
                width: mediaquerywidth(0.09, context),
                height: mediaqueryheight(0.06, context),
                decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                    image:
                        DecorationImage(image: AssetImage(AppImages.busIcon))),
              ),
              const CustomSizedBoxWidth(0.03),
              CustomText(
                  weight: FontWeight.w600,
                  text: appBarTitle,
                  fontFamily: CustomFonts.inter,
                  size: 0.04,
                  color: Colors.white)
            ],
          ),
        ],
      ),
    );
  }
}
