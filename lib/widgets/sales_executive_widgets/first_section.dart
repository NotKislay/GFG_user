import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/sales_exe_viewmodel.dart';
import 'package:gofriendsgo/widgets/sales_executive_widgets/person_info.dart';

class FirstSectionInSalesExecutiveSection extends StatelessWidget {
  final SalesPersonViewModel value;
  const FirstSectionInSalesExecutiveSection(
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.whiteColor),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PersonInfo(value),
            const CustomSizedBoxHeight(0.035),
            const CustomText(
              text: TextStrings.about,
              fontFamily: CustomFonts.roboto,
              size: 0.04,
              color: Color.fromRGBO(0, 0, 0, 0.8),
              weight: FontWeight.w500,
            ),
            const CustomSizedBoxHeight(0.01),
            CustomText(
              text: (value.salesPersonResponse?.data.about != null)
                  ? value.salesPersonResponse!.data.about!
                  : TextStrings.salesExecutiveAboutDetails,
              fontFamily: CustomFonts.roboto,
              size: 0.04,
              color: Color.fromRGBO(0, 0, 0, 0.6),
            )
          ],
        ),
      ),
    );
  }
}
