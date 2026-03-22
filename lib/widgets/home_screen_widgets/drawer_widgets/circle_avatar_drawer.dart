import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/view_model/profile_viewmodel.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/profile_image.dart';
import 'package:provider/provider.dart';

class DrawerCircleAvatar extends StatelessWidget {
  const DrawerCircleAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: AppColors.gradientColors),
      ),
      child: Consumer<ProfileViewModel>(
        builder: (context, value, child) {
          return value.profilePic == null
              ? CustomText(
            text: value.subString!.toUpperCase(),
            fontFamily: CustomFonts.roboto,
            size: 0.05,
            color: AppColors.whiteColor,
            weight: FontWeight.w600,
          )
              : SizedBox(
            height: 55,
            width: 55,
            child: ImageOfProfile(
              value: value,
            ),
          );
        },
      ),
    );
  }
}