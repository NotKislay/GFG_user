import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/visa_model/visa_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/widgets/visa_checklist_details/appbar.dart';
import 'package:gofriendsgo/widgets/visa_checklist_details/button_and_amount.dart';
import 'package:gofriendsgo/widgets/visa_checklist_details/heading_and_subheading.dart';
import 'package:gofriendsgo/widgets/visa_checklist_details/package_details.dart';
//import 'package:gofriendsgo/widgets/visa_checklist_details/heading_and_details.dart';

class VisaChecklistDetailsScreen extends StatelessWidget {
  final Visa visa; // Displaying details for a single Visa
  final int price;
  const VisaChecklistDetailsScreen(
      {required this.visa, super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    log("PEWWWWW: ${visa?.price}");
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const VisaCheckListAppbar(),
      body: Padding(
        padding: EdgeInsets.only(
          top: mediaqueryheight(0.03, context),
          left: mediaquerywidth(0.05, context),
          right: mediaquerywidth(0.05, context),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Visa details container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      color: AppColors.blackColor,
                    ),
                  ],
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(mediaqueryheight(0.02, context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomSizedBoxHeight(0.02),
                      const VisaRequirementHeading(),
                      const CustomSizedBoxHeight(0.015),
                      const Divider(),
                      const CustomSizedBoxHeight(0.025),
                      VisaChecklistSubHeading(
                        countryName: visa.visaFor,
                      ),
                      const Divider(),
                      const CustomSizedBoxHeight(0.03),
                      // List of Visa Details
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: visa.details.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: HeadingAndDetails(visa.details[index]),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const CustomSizedBoxHeight(0.04),
              // Display the amount from the first detail if available
              GetDetailsAndAmount(
                amount: visa.details.isNotEmpty ? price.toString() : null,
              ),
              const CustomSizedBoxHeight(0.04),
            ],
          ),
        ),
      ),
    );
  }
}
