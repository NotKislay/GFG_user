import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/view_model/filter_passports_viewmodel.dart';
import 'package:provider/provider.dart';

class HotelRatingContainer extends StatelessWidget {
  const HotelRatingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          int rating = index + 1;
          return GestureDetector(
            onTap: () {
              // Update the selected rating in the ViewModel.
              context.read<FilterScreenViewModel>().settingHotelRating(rating);
            },
            child: Column(
              children: [
                Icon(
                  Icons.star,
                  size: 32, // Adjust star size for better visibility.
                  color: context.watch<FilterScreenViewModel>().selectedHotelRating.isNotEmpty &&
                      int.parse(context.watch<FilterScreenViewModel>().selectedHotelRating) >= rating
                      ? AppColors.fixedDeparturesAmberColor // Yellow for selected stars.
                      : Colors.grey, // Grey for unselected stars.
                ),
                const SizedBox(height: 4),
                Text(
                  '$rating',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: context.watch<FilterScreenViewModel>().selectedHotelRating.isNotEmpty &&
                        int.parse(context.watch<FilterScreenViewModel>().selectedHotelRating) >= rating
                        ? AppColors.fixedDeparturesAmberColor // Same color as selected star.
                        : AppColors.blackColor,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
