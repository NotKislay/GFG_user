
import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/widgets/filter_screen_widgets/appbar.dart';
import 'package:gofriendsgo/widgets/filter_screen_widgets/continue_button.dart';
import 'package:gofriendsgo/widgets/filter_screen_widgets/duration_container.dart';
import 'package:gofriendsgo/widgets/filter_screen_widgets/headings.dart';
import 'package:gofriendsgo/widgets/filter_screen_widgets/hotel_rating.dart';
import 'package:gofriendsgo/widgets/filter_screen_widgets/price_range_slider.dart';



class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, mediaqueryheight(0.08, context)),
        child: const AppBarFilterScreen(),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: mediaquerywidth(0.05, context),
          right: mediaquerywidth(0.05, context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FilterScreenHeadings("PRICE RANGE"),
            SizedBox(height: mediaqueryheight(0.005, context)),
            const PriceRangeSlider(),
            const FilterScreenHeadings("HOTEL RATING"),
            const HotelRatingContainer(),
            const FilterScreenHeadings("DURATION"),
            const DurationContainer(),
            //const FilterScreenHeadings("PACKAGE TYPE"),
            //const PackageTypecontainer(),
            //const FilterScreenHeadings("TRANSPORTATION"),
            SizedBox(height: mediaqueryheight(0.02, context)),
            const Spacer(),
            const ContinueToResultsButton(),
            const CustomSizedBoxHeight(0.04),
          ],
        ),
      ),
    );
  }
}
