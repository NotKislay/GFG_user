import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class FixedDeparturesPackageHeading extends StatelessWidget {
  const FixedDeparturesPackageHeading({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomText(
        weight: FontWeight.w800,
        text: title,
        fontFamily: CustomFonts.roboto,
        size: 0.07,
        color: const Color.fromRGBO(85, 24, 177, 1));
  }
}