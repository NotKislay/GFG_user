import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/text_controllers.dart';
import 'package:gofriendsgo/view_model/profile_viewmodel.dart';
import 'package:provider/provider.dart';

class SaveButtonProfile extends StatelessWidget {
  final ProfileViewModel value;
  final GlobalKey<FormState> profileFormKey;

  const SaveButtonProfile(this.value,
      {super.key, required this.profileFormKey});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: value.onEditPressed ? 1 : .5,
      child: CustomButton(
        function: value.onEditPressed
            ? () {
                if (profileFormKey.currentState!.validate() &&
                    value.dob != null) {
                  log("PEW: ${value.newMarriageAnniversary}");
                  final File? imageFile = value.newImagePath == null
                      ? null
                      : File(value.newImagePath!);
                  final updatedData = {
                    "name": nameController.text,
                    "company_name": companyNameController.text,
                    "marriage_anniversary": value.newMarriageAnniversary,
                    "email": emailController.text,
                    "dob": value.dob,
                    "sales_exec": salesController.text,
                    "phone": mobileController.text,
                    "frequent_flyer_no": frequentController.text,
                    "additional_details": additionalController.text,
                    "image": imageFile
                  };

                  context.read<ProfileViewModel>().updateProfile(
                      value.profileResponse!.data.user.id, updatedData);

                  // Reset edit state after saving
                  value.resetEditState();
                }
              }
            : () {},
        text: 'Save',
        fontSize: 0.04,
        buttonTextColor: AppColors.whiteColor,
        borderColor: AppColors.transparentColor,
        fontFamily: CustomFonts.poppins,
      ),
    );
  }
}
