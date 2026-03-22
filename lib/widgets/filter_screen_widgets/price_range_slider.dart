import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/view_model/filter_passports_viewmodel.dart';
import 'package:provider/provider.dart';

class PriceRangeSlider extends StatelessWidget {
  const PriceRangeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<FilterScreenViewModel>(
                  builder: (context, value, child) => CustomText(
                    text: "₹ ${value.currentRangeValues.start.round()}",
                    fontFamily: CustomFonts.inter,
                    size: 0.04,
                    color: AppColors.blackColor,
                  ),
                ),
                Consumer<FilterScreenViewModel>(
                  builder: (context, value, child) => CustomText(
                    text: "₹ ${value.currentRangeValues.end.round()}",
                    fontFamily: CustomFonts.inter,
                    size: 0.04,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
          RangeSlider(
            values: context.watch<FilterScreenViewModel>().currentRangeValues,
            min: 0,
            max: 500000,
            divisions: 1000,
            labels: RangeLabels(
              context
                  .watch<FilterScreenViewModel>()
                  .currentRangeValues
                  .start
                  .round()
                  .toString(),
              context
                  .watch<FilterScreenViewModel>()
                  .currentRangeValues
                  .end
                  .round()
                  .toString(),
            ),
            onChanged: (RangeValues values) {
              context.read<FilterScreenViewModel>().settingRangeValues(values);
            },
            activeColor: Colors.blue, // Customize as needed
            inactiveColor: Colors.black38, // Customize as needed
          ),
        ],
      ),
    );
  }
}
