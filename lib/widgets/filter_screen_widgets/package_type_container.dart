import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/view_model/filter_passports_viewmodel.dart';
import 'package:gofriendsgo/widgets/filter_screen_widgets/duration_option.dart';
import 'package:provider/provider.dart';

class PackageTypecontainer extends StatelessWidget {
  const PackageTypecontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DurationOption(
            text: "Yatra Special",
            isSelected: context.watch<FilterScreenViewModel>().selectedPackageType == "Yatra Special",
            onTap: () {
               context
                  .read<FilterScreenViewModel>()
                  .settingPackageType("Yatra Special");
              
            },
          ),
          DurationOption(
            text: "Group",
            isSelected: context.watch<FilterScreenViewModel>().selectedPackageType == "Group",
            onTap: () {
                context
                  .read<FilterScreenViewModel>()
                  .settingPackageType("Group");
            },
          ),
          DurationOption(
            text: "Customizable",
            isSelected: context.watch<FilterScreenViewModel>().selectedPackageType == "Customizable",
            onTap: () {
                context
                  .read<FilterScreenViewModel>()
                  .settingPackageType("Customizable");
            },
          ),
        ],
      ),
    );
  }
}