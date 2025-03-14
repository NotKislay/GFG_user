import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/sales_exe_viewmodel.dart';
import 'package:gofriendsgo/widgets/sales_executive_widgets/person_details.dart';

class PersonInfo extends StatelessWidget {
  final SalesPersonViewModel value;
  const PersonInfo(
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SalesExecutiveImage(
          value: value,
        ),
        const CustomSizedBoxWidth(0.085),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SalesExecutiveName(value),
                const CustomSizedBoxWidth(0.02),
              ],
            ),
            CustomText(
                text: (value.salesPersonResponse?.data == null ||
                        value.salesPersonResponse?.data.name == null)
                    ? 'Travel Agency'
                    : 'Sales Executive',
                fontFamily: CustomFonts.roboto,
                size: 0.04,
                color: Color.fromRGBO(60, 60, 60, 1)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (value.salesPersonResponse != null)
                    ? CustomText(
                        text:
                            value.salesPersonResponse!.averageRating.toString(),
                        fontFamily: CustomFonts.roboto,
                        size: 0.035,
                        weight: FontWeight.w500,
                        color: AppColors.blackColor)
                    : SizedBox(),
                const CustomSizedBoxWidth(0.02),
                const Icon(
                  Icons.star_rate_rounded,
                  color: AppColors.fixedDeparturesAmberColor,
                ),
              ],
            ),
            const CustomSizedBoxHeight(0.01),
            
            ContactPhoneAndEmailLogo(value)
          ],
        )
      ],
    );
  }
}
