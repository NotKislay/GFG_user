
import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';


//AppBar appBarProfile(BuildContext context) {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final PageNavigations pageNavigation = PageNavigations(); // Create instance
  final PageController pageController = PageController();
AppBar appBarProfile(BuildContext context, {required void Function() onBack, required bool fromBottomNav}) {
  return AppBar(
    backgroundColor: AppColors.transparentColor,
    leading: fromBottomNav
        ? const SizedBox()
        : BackButton(
      onPressed: onBack,
    ),
    title: const CustomText(
      text: "Profile",
      fontFamily: CustomFonts.inter,
      size: 0.065,
      color: AppColors.blackColor,
      weight: FontWeight.w600,
    ),
  );
}


