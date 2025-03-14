import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';

class BackButtonOnDrawer extends StatelessWidget {
  const BackButtonOnDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Column(
      children: [
        Container(
          width: double.infinity,
          height: mediaqueryheight(0.18, context),
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: AppColors.gradientColors)),
          child: Align(
            alignment: const Alignment(-.9, -0.3),
            child: GestureDetector(
              onTap: () {
                PageNavigations().pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.whiteColor,
                size: mediaquerywidth(0.07, context),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: mediaqueryheight(0.18, context),
          decoration: const BoxDecoration(color: AppColors.backgroundColor),
        ),
      ],
    ));
  }
}
