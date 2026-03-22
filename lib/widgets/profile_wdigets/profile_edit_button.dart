import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class ProfilepageeEditbutton extends StatelessWidget {
  final Function()? ontap;
  const ProfilepageeEditbutton({
    super.key,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      GestureDetector(
        onTap: 
          ontap
        ,
        child: Container(
          width: mediaquerywidth(0.2, context),
          height: mediaqueryheight(0.035, context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(06),
              gradient: const LinearGradient(colors: AppColors.gradientColors)),
          child: Center(
            child: Row(
              children: [
                const CustomSizedBoxWidth(0.04),
                const CustomText(
                    text: 'edit',
                    fontFamily: CustomFonts.roboto,
                    size: 0.04,
                    color: AppColors.whiteColor),
                const CustomSizedBoxWidth(0.02),
                Icon(Icons.border_color_outlined,
                    color: AppColors.whiteColor,
                    size: mediaquerywidth(0.04, context))
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
