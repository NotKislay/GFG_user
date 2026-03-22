import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/view_model/bookings_viewmodel.dart';
import 'package:provider/provider.dart';

class BookingDetailsSearch extends StatelessWidget {
  const BookingDetailsSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mediaquerywidth(0.06, context),
        vertical: mediaqueryheight(0.04, context),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(25),
          /* boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ], */
        ),
        child: TextField(
          onChanged: (value) {
            context.read<BookingViewModel>().filterBookings(value);
          },
          decoration: InputDecoration(
            hintText: 'Search Your Bookings',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: mediaqueryheight(0.015, context),
            ),
          ),
        ),
      ),
    );
  }
}