import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';


class VehicleAndKmHeading extends StatelessWidget {
  const VehicleAndKmHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8)),
          border: Border.all(
              color: AppColors.backgroundColor),
          color: AppColors.backgroundColor),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mediaquerywidth(0.045, context),
            vertical: mediaqueryheight(0.015, context)),
        child: const Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: "VEHICLE",
                fontFamily: CustomFonts.roboto,
                size: 0.045,
                weight: FontWeight.w900,
                color: AppColors.blackColor),
            CustomText(
                text: "Rs / KM",
                fontFamily: CustomFonts.roboto,
                size: 0.042,
                weight: FontWeight.w900,
                color: AppColors.blackColor),
          ],
        ),
      ),
    );
  }
}