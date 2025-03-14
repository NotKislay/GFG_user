import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view_model/departure_viewmodel.dart';
import 'package:gofriendsgo/view_model/filter_passports_viewmodel.dart';
import 'package:provider/provider.dart';

class ContinueToResultsButton extends StatelessWidget {
  const ContinueToResultsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomButton(
        function: () {
          final FixedDeparturesViewModel departuresViewModel =
              context.read<FixedDeparturesViewModel>();
          departuresViewModel
              .applyFilters(context.read<FilterScreenViewModel>());
          PageNavigations().pop();
        },
        text: "CONTINUE TO RESULTS",
        fontSize: 0.045,
        buttonTextColor: AppColors.whiteColor,
        borderColor: AppColors.transparentColor,
        fontFamily: CustomFonts.roboto,
      ),
    );
  }
}
