import 'dart:developer';

import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/sales_exe_viewmodel.dart';
import 'package:provider/provider.dart';

class SecondSection extends StatelessWidget {
  final SalesPersonViewModel salesVM;
  const SecondSection({
    super.key,
    required this.salesVM,
  });

  @override
  Widget build(BuildContext context) {
    log('${salesVM.salesPersonResponse?.userRating != null} and ${salesVM.salesPersonResponse?.userRating != 0} this is he ${salesVM.salesPersonResponse?.userRating}');
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                  text: TextStrings.rateExperience,
                  fontFamily: CustomFonts.roboto,
                  size: 0.035,
                  weight: FontWeight.w500,
                  color: Color.fromRGBO(0, 0, 0, 0.8)),
              const CustomSizedBoxHeight(0.01),
              Column(
                children: [
                  FivePointedStar(
                    disabled: salesVM.salesPersonResponse?.userRating != 0,
                    size: Size(43, 43),
                    selectedColor: Colors.amber,
                    onChange: (count) {
                      salesVM.rating = count;
                    },
                    defaultSelectedCount:
                        salesVM.salesPersonResponse?.userRating ?? 0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /* ...List.generate(
                    5,
                    (index) {
                      return Icon(
                        Icons.star,
                        size: mediaquerywidth(0.14, context),
                        color: const Color.fromRGBO(167, 167, 167, 1),
                      );
                    },
                  ) */
                ],
              ),
              Consumer<SalesPersonViewModel>(
                builder: (context, viewModel, child) {
                  return Visibility(
                    visible: !viewModel.posted,
                    child: Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 140, // Approx height for 3 lines
                          ),
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                maxLength: 100,
                                controller: salesVM.commentController,
                                minLines: 1,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Rounded corners
                                    borderSide: BorderSide(
                                      color: Colors.grey, // Border color
                                      width: 0.5, // Border thickness
                                    ),
                                  ),
                                  hintText: 'Type your review here.',
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomButton(
                          function: () {
                            salesVM.postReview();
                          },
                          text: 'Submit',
                          fontSize: 0.038,
                          buttonTextColor: AppColors.whiteColor,
                          borderColor: AppColors.transparentColor,
                          fontFamily: CustomFonts.poppins,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
