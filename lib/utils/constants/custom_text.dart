import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class CustomText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final String fontFamily;

  const CustomText({
    super.key,
    required this.text,
    required this.fontFamily,
    this.textOverflow = TextOverflow.clip,
    required this.size,
    required this.color,
    this.textAlign = TextAlign.start,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: weight,
        overflow: textOverflow,
        fontFamily: fontFamily,
        color: color,
        fontSize: mediaquerywidth(size, context),
      ),
    );
  }
}

class AppdecorText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight? weight;

  const AppdecorText({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: weight,
        fontFamily: CustomFonts.inknut,
        color: color,
        fontSize: mediaquerywidth(size, context),
      ),
    );
  }
}
