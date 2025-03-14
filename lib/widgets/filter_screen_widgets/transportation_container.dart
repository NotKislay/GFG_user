import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/view_model/filter_passports_viewmodel.dart';
import 'package:gofriendsgo/widgets/filter_screen_widgets/duration_option.dart';
import 'package:provider/provider.dart';

class TansportationContainer extends StatelessWidget {
  const TansportationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DurationOption(
            text: "Optional",
            isSelected: context
                    .watch<FilterScreenViewModel>()
                    .selectedTransportation ==
                "Optional",
            onTap: () {
              context
                  .read<FilterScreenViewModel>()
                  .settingTransportation("Optional");
            },
          ),
          DurationOption(
            text: "Flight",
            isSelected:
                context.watch<FilterScreenViewModel>().selectedTransportation ==
                    "Flight",
            onTap: () {
              context
                  .read<FilterScreenViewModel>()
                  .settingTransportation("Flight");
            },
          ),
          DurationOption(
            text: "Land Only",
            isSelected:
                context.watch<FilterScreenViewModel>().selectedTransportation ==
                    "Land Only",
            onTap: () {
              context
                  .read<FilterScreenViewModel>()
                  .settingTransportation("Land Only");
            },
          ),
        ],
      ),
    );
  }
}
