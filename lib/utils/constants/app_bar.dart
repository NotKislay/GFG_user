
import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';

import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';

class CommonGradientAppBar extends StatelessWidget implements PreferredSizeWidget{
  final bool fromBottomNav;
  final String heading;

  const CommonGradientAppBar({
    required this.fromBottomNav,
    required this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: fromBottomNav ? 0: 56,
      flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.gradientColors,
                begin: Alignment.centerRight,
                end: Alignment.centerLeft),
          )),
      leading: Visibility(
        visible: !fromBottomNav,
        child: IconButton(
          onPressed: () {
            PageNavigations().pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      title: Text(
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: CustomFonts.roboto,
            color: AppColors.whiteColor),
        heading,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}