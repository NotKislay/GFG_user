import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';

import '../../view/chat_list.dart/chat_list.dart';

class GetDetailsAndAmount extends StatelessWidget {
  final String? amount;
  const GetDetailsAndAmount({
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomSizedBoxWidth(0.04),
        CustomButton(
          function: () {
            PageNavigations().push(
              const ChatListScreen(
                fromBottomNav: false,
              ), // The screen you're navigating to
              transitionType:
                  TransitionType.normal, // You can change to .fade if needed
            );
          },
          text: TextStrings.getDetailsButtonText,
          fontSize: 0.04,
          buttonTextColor: AppColors.whiteColor,
          borderColor: AppColors.transparentColor,
          fontFamily: CustomFonts.roboto,
        ),
        const CustomSizedBoxWidth(0.13),
        Column(
          children: [
            CustomText(
                text: amount == null ? "₹ 0" : "₹ ${amount.toString()}",
                fontFamily: CustomFonts.roboto,
                size: 0.07,
                weight: FontWeight.w800,
                color: AppColors.fixedDeparturesAmberColor),
            const CustomText(
              text: TextStrings.perPerson,
              fontFamily: CustomFonts.roboto,
              size: 0.035,
              color: Color.fromRGBO(0, 0, 0, 0.7),
              weight: FontWeight.w500,
            )
          ],
        ),
        const SizedBox()
      ],
    );
  }
}
