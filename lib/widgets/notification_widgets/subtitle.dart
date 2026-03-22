import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/notification_card_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class SubTitleInNotification extends StatelessWidget {
  const SubTitleInNotification({
    super.key,
    required this.item,
  });

  final NotificationCardModel item;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      textAlign: TextAlign.start,
      weight: FontWeight.w300,
      text: item.subText,
      fontFamily: CustomFonts.roboto,
      size: 0.04,
      color: AppColors.blackColor,
    );
  }
}