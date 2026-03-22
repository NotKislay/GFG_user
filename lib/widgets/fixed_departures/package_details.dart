import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

List<Widget> packageDetails(List<dynamic> package, BuildContext context) {
  return List.generate(
    package.length,
    (index) {
      return Column(
        children: [
          Row(
            children: [
              Container(
                width: mediaquerywidth(0.04, context),
                height: mediaqueryheight(0.016, context),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.backgroundColor),
              ),
              const CustomSizedBoxWidth(0.028),
              SizedBox(
                width: mediaquerywidth(0.7, context),
                child: CustomText(
                    text: package[index],
                    fontFamily: CustomFonts.roboto,
                    size: 0.04,
                    color: const Color.fromRGBO(0, 0, 0, 0.8)),
              ),
            ],
          ),
          const CustomSizedBoxHeight(0.014)
        ],
      );
    },
  );
}
