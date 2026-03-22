import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/profile_screen/profile_editing_screen.dart';
import 'package:provider/provider.dart';
import 'package:gofriendsgo/view_model/profile_viewmodel.dart';

class ProfileCompletionStatus extends StatelessWidget {
  const ProfileCompletionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) {
        double profilePercentage = value.profilePercentage ?? 0.0; // Default to 0.0 if null
        String formattedPercentage = '${(profilePercentage * 100).toStringAsFixed(0)}%';

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: '${TextStrings.profileProgress}: $formattedPercentage',
              fontFamily: CustomFonts.poppins,
              size: 0.027,
              color: const Color.fromRGBO(20, 20, 20, .6),
            ),
            GestureDetector(
              onTap: () {
                PageNavigations().push(const ProfileEditingScreen(pageController: null, onBack: null, fromBottomNav: false,));
              },
              child: const CustomText(
                text: TextStrings.addPhoto,
                fontFamily: CustomFonts.poppins,
                size: 0.027,
                color: Color.fromRGBO(21, 1, 154, 1),
              ),
            ),
          ],
        );
      },
    );
  }
}