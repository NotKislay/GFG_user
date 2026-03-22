import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_bar.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/passport_viewmodel.dart';
import 'package:gofriendsgo/widgets/passport_checklist_widgets/detailsbutton_and_amount.dart';
import 'package:gofriendsgo/widgets/passport_checklist_widgets/heading.dart';
import 'package:gofriendsgo/widgets/passport_checklist_widgets/passport_details.dart';
import 'package:provider/provider.dart';

class PassportChecklistScreen extends StatefulWidget {
  const PassportChecklistScreen({super.key});

  @override
  State<PassportChecklistScreen> createState() =>
      _PassportChecklistScreenState();
}

class _PassportChecklistScreenState extends State<PassportChecklistScreen> {
  @override
  void initState() {
    context.read<PassportViewModel>().fetchPassports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CommonGradientAppBar(
          heading: TextStrings.passportChecklist,
          fromBottomNav: false,
        ),
      body: Padding(
        padding: EdgeInsets.only(
            top: mediaqueryheight(0.03, context),
            left: mediaquerywidth(0.05, context),
            right: mediaquerywidth(0.05, context)),
        child: Consumer<PassportViewModel>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            color: AppColors.blackColor),
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
                          const PassportRequirementHeading(),
                          const CustomSizedBoxHeight(0.015),
                          const Divider(),
                          const CustomSizedBoxHeight(0.025),
                          DetailsOfPassportChecklist(value),

                        ],
                      ),
                    ),
                  ),
                  const CustomSizedBoxHeight(0.04),
                  const GetDetailsAndAmountInPassportCheclist(),
                  const CustomSizedBoxHeight(0.04),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}