import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/notification_card_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';


class NotificationTitle extends StatelessWidget {
  const NotificationTitle({
    super.key,
    required this.item,
  });

  final NotificationCardModel item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaquerywidth(0.48, context),
      child: CustomText(
        weight: FontWeight.w600,
        text: item.mainText,
        fontFamily: CustomFonts.roboto,
        size: 0.04,
        color: AppColors.blackColor,
      ),
    );
  }
}