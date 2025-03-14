import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';

class VisaCheckListAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const VisaCheckListAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: AppColors.gradientColors,
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft))),
      title: CustomText(
          weight: FontWeight.bold,
          text: TextStrings.visaChecklist,
          fontFamily: CustomFonts.roboto,
          size: 0.055,
          color: AppColors.whiteColor),
      leading: Visibility(
          visible: true,
          child: IconButton(
              iconSize: mediaquerywidth(0.08, context),
              onPressed: () {
                PageNavigations().pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.whiteColor,
              ))),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
