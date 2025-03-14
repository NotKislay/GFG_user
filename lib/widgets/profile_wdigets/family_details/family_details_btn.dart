import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/family_details/family_details_listing.dart';

import '../../../utils/color_theme/colors.dart';
import '../../../utils/constants/app_button.dart';
import '../../../utils/constants/paths.dart';
import '../../../view_model/profile_viewmodel.dart';

class FamilyDetailsButton extends StatelessWidget {
  final ProfileViewModel value;

  const FamilyDetailsButton({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: value.onEditPressed ? 1 : .5,
      child: CustomButton(
        function: value.onEditPressed
            ? () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FamilyDetailsListing();
                }));
              }
            : () {},
        text: 'Family Details',
        fontSize: 0.04,
        buttonTextColor: AppColors.whiteColor,
        borderColor: AppColors.transparentColor,
        fontFamily: CustomFonts.poppins,
      ),
    );
  }
}
