import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/notification_card_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';


class TimeInNotification extends StatelessWidget {
  const TimeInNotification({
    super.key,
    required this.item,
  });

  final NotificationCardModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        item.isUnread
            ? Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: AppColors.gradientColors),
                ),
                height: mediaqueryheight(0.01, context),
                width: mediaqueryheight(0.01, context),
              )
            : const SizedBox(),
        const CustomSizedBoxWidth(0.01),
        CustomText(
          text: item.timeText,
          fontFamily: CustomFonts.poppins,
          size: 0.035,
          color: const Color.fromRGBO(108, 108, 108, 1),
        ),
      ],
    );
  }
}