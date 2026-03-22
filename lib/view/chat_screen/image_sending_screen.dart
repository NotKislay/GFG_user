import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class ImageSendingScreen extends StatelessWidget {
  const ImageSendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            color: AppColors.blackColor,
            image: DecorationImage(
              image: AssetImage(AppImages.aboutUsImage),
            )),
        child: const Column(
          children: [],
        ),
      )),
    );
  }
}
