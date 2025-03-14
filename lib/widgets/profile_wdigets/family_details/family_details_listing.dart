import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/view_model/family_viewmodel.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/family_details/family_details_card.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/family_details/family_member_add_edit_screen.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/family_details/form_type.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_theme/colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/custom_text.dart';
import '../../../utils/constants/mediaquery.dart';
import '../../../utils/constants/paths.dart';
import '../../../utils/constants/sizedbox.dart';

class FamilyDetailsListing extends StatefulWidget {
  const FamilyDetailsListing({super.key});

  @override
  State<FamilyDetailsListing> createState() => _FamilyDetailsListingState();
}

class _FamilyDetailsListingState extends State<FamilyDetailsListing> {
  late FamilyViewModel _familyViewModel;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _familyViewModel = Provider.of<FamilyViewModel>(context, listen: false);
      _familyViewModel.fetchFamilyMembers();
      _familyViewModel.onErrorCallback = _showErrorSnackBar;
      _familyViewModel.onSuccessCallback = _showSuccessSnackBar;
    });
    super.initState();
  }

  void _showSuccessSnackBar(String message) {
    log("POM");
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 10,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7))),
        backgroundColor: AppColors.gradientColors[0].withOpacity(0.4),
        content: Text(
          message,
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        duration: Duration(milliseconds: 1500),
      ));
    } else {
      log("SOM");
      return;
    }
  }

  void _showErrorSnackBar(String error) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 10,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7))),
        backgroundColor: AppColors.gradientColors[0].withOpacity(0.5),
        content: Text(error, style: TextStyle(fontSize: 17, color: Colors.red)),
        duration: Duration(milliseconds: 1500),
      ));
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded)),
          title: CustomText(
              weight: FontWeight.bold,
              text: TextStrings.familyMembers,
              fontFamily: CustomFonts.roboto,
              size: 0.055,
              color: AppColors.blackColor),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FamilyMemberAddEditScreen(
                    formType: FormType.createForm,
                  );
                }));
              },
              child: Container(
                width: mediaquerywidth(0.2, context),
                height: mediaqueryheight(0.035, context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(06),
                    gradient:
                        const LinearGradient(colors: AppColors.gradientColors)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomSizedBoxWidth(0.04),
                      const CustomText(
                          text: 'Add',
                          fontFamily: CustomFonts.roboto,
                          size: 0.04,
                          color: AppColors.whiteColor),
                      const CustomSizedBoxWidth(0.04),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Consumer<FamilyViewModel>(builder: (context, value, child) {
          return (value.familyList?.familyMembers == null ||
                  value.familyList!.familyMembers!.isEmpty)
              ? Center(
                  child: Text(
                    "No family details!",
                    style: TextStyle(
                        color: AppColors.gradientColors[1], fontSize: 20),
                  ),
                )
              : ListView.builder(
                  itemCount: value.familyList!.familyMembers?.length ?? 0,
                  padding: EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    final member = value.familyList!.familyMembers?[index];
                    return FamilyDetailsCard(member!, onDeleteTapped: () {
                      value.deleteFamilyMember(id: member.id!);
                    });
                  });
        }));
  }
}
