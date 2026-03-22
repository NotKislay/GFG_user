import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/login_screen/login_screen.dart';
import 'package:gofriendsgo/widgets/on_boarding/gradient_border_painter.dart';

class SkipButtonOnBoarding extends StatelessWidget {
  const SkipButtonOnBoarding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: CustomPaint(
        painter: GradientBorderPainter(),
        child: InkWell(
          onTap: () {
            PageNavigations().pushAndRemoveUntill( LoginScreen());
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: mediaqueryheight(0.01, context),
                horizontal: mediaquerywidth(0.06, context),
              ),
              child: const CustomText(
                weight: FontWeight.w500,
                fontFamily: CustomFonts.poppins,
                text: "Skip",
                size: 0.045,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
