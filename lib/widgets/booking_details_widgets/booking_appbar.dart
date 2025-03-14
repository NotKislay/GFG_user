import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class BookingDetailsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final void Function() onBack;
  final bool showBackButton; // Add this parameter

  const BookingDetailsAppbar(
      {super.key, required this.onBack, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: showBackButton ? 56: 0,
      flexibleSpace: Container(
          decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: AppColors.gradientColors,
            begin: Alignment.centerRight,
            end: Alignment.centerLeft),
      )),
      title: Text(
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: CustomFonts.roboto,
            color: AppColors.whiteColor),
        "Bookings",
      ),
      leading: Visibility(
        visible: showBackButton,
        child: IconButton(
          onPressed: () {
            onBack();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
