import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/view_model/passport_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_strings.dart';

class DetailsOfPassportChecklist extends StatelessWidget {
  final PassportViewModel value;
  const DetailsOfPassportChecklist(
      this.value, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: value.passportResponse!.passports.length,
      itemBuilder: (context, index) {
        final section = value.passportResponse!.passports[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.backgroundColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: index == 0
                        ? const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )
                        : const BorderRadius.only(),
                  ),
                  padding: const EdgeInsets.all(6),
                  width: double.infinity,
                  child: CustomText(
                    text: section.title,
                    fontFamily: CustomFonts.roboto,
                    size: 0.05,
                    color: AppColors.blackColor,
                    weight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: mediaquerywidth(0.04, context),
                    vertical: mediaqueryheight(0.008, context),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                      textAlign: TextAlign.start,
                      text: section.description,
                      fontFamily: CustomFonts.roboto,
                      size: 0.036,
                      color: const Color.fromRGBO(0, 0, 0, 0.8),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mediaquerywidth(0.04, context),
                      vertical: mediaqueryheight(0.008, context),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: "Price :",
                          fontFamily: CustomFonts.roboto,
                          size: 0.065,
                          color: Colors.black,
                          weight: FontWeight.w500,
                        ),
                        Column(
                          children: [
                            Consumer<PassportViewModel>(
                              builder: (context, value, child) => CustomText(
                                text: "₹ ${value.passportResponse!.passports[index].price}",
                                fontFamily: CustomFonts.roboto,
                                size: 0.060,
                                weight: FontWeight.w800,
                                color: AppColors.fixedDeparturesAmberColor,
                              ),
                            ),
                            const CustomText(
                              text: TextStrings.perPerson,
                              fontFamily: CustomFonts.roboto,
                              size: 0.04,
                              color: Color.fromRGBO(0, 0, 0, 0.7),
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
