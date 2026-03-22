import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/view_model/filter_passports_viewmodel.dart';
import 'package:gofriendsgo/widgets/filter_screen_widgets/duration_option.dart';
import 'package:provider/provider.dart';

class DurationContainer extends StatelessWidget {
  const DurationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DurationOption(
            text: "Upto 3 Nights",
            isSelected: context.watch<FilterScreenViewModel>().selectedDuration == "Upto 3 Nights",
            onTap: () {
                 context.read<FilterScreenViewModel>().settingDuration("Upto 3 Nights");
            },
          ),
          DurationOption(
            text: "4 Nights",
            isSelected: context.watch<FilterScreenViewModel>().selectedDuration == "4 Nights",
            onTap: () {
              context.read<FilterScreenViewModel>().settingDuration("4 Nights");
            },
          ),
          DurationOption(
            text: "5 Nights+",
            isSelected: context.watch<FilterScreenViewModel>().selectedDuration == "5 Nights+",
            onTap: () {
              context.read<FilterScreenViewModel>().settingDuration("5 Nights+");
            },
          ),
        ],
      ),
    );
  }
}
