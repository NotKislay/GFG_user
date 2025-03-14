import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class HotelRatings extends StatelessWidget {
  const HotelRatings({
    super.key,
    required this.starCount, 
  });

  final int? starCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(AppImages.hotel),
        const CustomSizedBoxWidth(0.03),
        ...List.generate(
          5,
          (index) {
            return Icon(
              Icons.star_rate_rounded,
              color: starCount == null
                  ? AppColors.backgroundColor
                  : index > starCount! - 1
                      ? AppColors.backgroundColor
                      : AppColors.fixedDeparturesAmberColor,
            );
          },
        )
      ],
    );
  }
}
