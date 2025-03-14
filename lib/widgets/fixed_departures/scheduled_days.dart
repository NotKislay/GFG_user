import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class ScheduledDays extends StatelessWidget {
  const ScheduledDays({
    super.key,
    required this.startDate,
    required this.endDate
  });

  final String startDate;
  final String endDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomSizedBoxWidth(0.005),
        Image.asset(AppImages.date),
        const CustomSizedBoxWidth(0.045),
        CustomText(
            text:'$startDate - $endDate',
            fontFamily: CustomFonts.roboto,
            size: 0.04,
            color: const Color.fromRGBO(0, 0, 0, 0.9))
      ],
    );
  }
}