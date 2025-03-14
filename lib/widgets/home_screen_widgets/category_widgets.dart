import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/home_grid_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/cab_rates_screen/cab_rates_screen.dart';
import 'package:gofriendsgo/view/fixed_departures_screen/fixed_departures_screen.dart';
import 'package:gofriendsgo/view/passport_checlist/passport_checklist_screen.dart';
import 'package:gofriendsgo/view/visa_checklist/visa_checlist_screen.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: mediaquerywidth(0.04, context)),
      child: SizedBox(
        height: mediaqueryheight(0.34, context),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            final item = homeGridItems[index];
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  PageNavigations().push(const FixedDeparturesScreen());
                } else if (index == 1) {
                  PageNavigations().push(const PassportChecklistScreen());
                } else if (index == 2) {
                  PageNavigations().push(const VisaChecklistScreen());
                } else {
                  PageNavigations().push(const CabRatesScreen());
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: mediaquerywidth(0.40, context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.whiteColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomSizedBoxHeight(0.01),
                      SizedBox(
                          //height: mediaqueryheight(0.2, context),
                          child: Image.asset(
                        item.imagePath,
                        width: mediaquerywidth(0.3, context),
                        height: mediaqueryheight(0.18, context),
                      )),
                      Column(
                        children: [
                          CustomText(
                            text: item.titleText,
                            fontFamily: CustomFonts.inter,
                            size: 0.04,
                            color: AppColors.blackColor,
                            weight: FontWeight.w700,
                          ),
                          const CustomSizedBoxHeight(0.02),
                          /*SizedBox(
                            height: mediaqueryheight(0.075, context),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: CustomText(
                                  textAlign: TextAlign.center,
                                  text: item.subText,
                                  fontFamily: CustomFonts.inter,
                                  size: 0.022,
                                  color: AppColors.blackColor),
                            ),
                          ), */
                          const CustomSizedBoxHeight(0.01),
                          Container(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    end: Alignment.centerLeft,
                                    begin: Alignment.centerRight,
                                    colors: AppColors.gradientColors),
                                borderRadius: BorderRadius.circular(12)),
                            width: mediaquerywidth(0.23, context),
                            height: mediaqueryheight(0.04, context),
                            child: const Center(
                              child: CustomText(
                                  text: 'Get Details',
                                  fontFamily: CustomFonts.inter,
                                  size: 0.03,
                                  color: Colors.white),
                            ),
                          ),
                          const CustomSizedBoxHeight(0.02),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
