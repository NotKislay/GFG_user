import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/visa_checklist_screen/visa_checklist_details_screen.dart';
import 'package:gofriendsgo/view_model/visa_viewmodel.dart';
import 'package:provider/provider.dart';

class PackagesListView extends StatelessWidget {
  const PackagesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<VisaViewModel>(builder: (context, value, child) {
      if (value.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
        itemCount: value.visaResponse!.visas.length,
        itemBuilder: (context, index) {
          final country = value.visaResponse!.visas[index];
          //log("PLIMSL $price");
          return Padding(
            padding: EdgeInsets.only(bottom: mediaqueryheight(0.025, context)),
            child: GestureDetector(
              onTap: () => PageNavigations().push(VisaChecklistDetailsScreen(
                visa: country,
              )),
              child: Container(
                width: double.infinity,
                height: mediaqueryheight(0.17, context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6),
                          BlendMode.darken,
                        ),
                        fit: BoxFit.cover,
                        image: country.image.isNotEmpty
                            ? NetworkImage(
                                APIConstants.baseImageUrl + country.image)
                            : Image.asset(AppImages.goFriendsGoLogoMini)
                                as ImageProvider)),
                child: Center(
                  child: CustomText(
                    text: "Visa for ${country.visaFor}",
                    fontFamily: CustomFonts.roboto,
                    size: 0.063,
                    color: AppColors.whiteColor,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
