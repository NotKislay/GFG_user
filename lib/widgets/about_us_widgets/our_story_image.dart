import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class OurStoryImage extends StatelessWidget {
  const OurStoryImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: mediaqueryheight(0.3, context),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppImages.aboutUsImage))),
    );
  }
}