import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/notifications_screen/notifications_screen.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //leadingWidth: 30,
      flexibleSpace: Container(
          decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: AppColors.gradientColors,
            begin: Alignment.centerRight,
            end: Alignment.centerLeft),
      )),
      leading: GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: const Icon(Icons.menu, color: AppColors.whiteColor)),
      title: Text(
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: CustomFonts.roboto,
            color: AppColors.whiteColor),
        "Home",
      ),
      actions: [
        GestureDetector(
            onTap: () {
              PageNavigations().push(const NotificationScreen());
            },
            child: SvgPicture.asset(AppImages.notificationsUnread)),
        SizedBox(width: 20,)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
