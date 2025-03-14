import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

import '../../utils/navigations/navigations.dart';
import '../../view/chat_list.dart/chat_list.dart';

class GetDetailsButtonInCabRates extends StatelessWidget {
  const GetDetailsButtonInCabRates({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: Material(
            borderRadius: BorderRadius.circular(60),
            child: InkWell(
              borderRadius: BorderRadius.circular(60),
              onTap: () {
                PageNavigations().push(
                  const ChatListScreen(fromBottomNav: false,), // The screen you're navigating to
                  transitionType: TransitionType.normal, // You can change to .fade if needed
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                      color:
                          AppColors.transparentColor),
                  borderRadius:
                      BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mediaquerywidth(
                          0.04, context),
                      vertical: mediaquerywidth(
                          0.03, context)),
                  child: const CustomText(
                    fontFamily: CustomFonts.roboto,
                    text: TextStrings
                        .getDetailsButtonText,
                    size: 0.043,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}