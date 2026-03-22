import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/profile_screen/profile_editing_screen.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/drawer_widgets/back_button.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/drawer_widgets/circle_avatar_drawer.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/drawer_widgets/drawer_list_items.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/drawer_widgets/personal_detials.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/drawer_widgets/profile_completion.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/drawer_widgets/progress_indicator.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: mediaquerywidth(0.8, context),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(children: [
            SizedBox(
              width: double.infinity,
              height: mediaqueryheight(0.36, context),
            ),
            const BackButtonOnDrawer(),
            Positioned(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 10, right: 10, top: mediaqueryheight(0.13, context)),
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      height: mediaqueryheight(0.2, context),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const DrawerCircleAvatar(),
                                const CustomSizedBoxWidth(0.03),
                                const PersonalDetails(),
                                const Spacer(),
                                GestureDetector(
                                  child: const Icon(Icons.edit),
                                  onTap: () {
                                    PageNavigations().push(const ProfileEditingScreen(pageController: null, onBack: {}, fromBottomNav: false,));
                                  },
                                )
                              ],
                            ),
                            const CustomSizedBoxHeight(0.02),
                            const ProgressIndicatorOnDrawer(),
                            const CustomSizedBoxHeight(0.01),
                            const ProfileCompletionStatus()
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
          ]),
          const DrawerListItems()
        ],
      ),
    );
  }
}