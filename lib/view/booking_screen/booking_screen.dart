import 'package:flutter/material.dart';
import 'package:gofriendsgo/view_model/bookings_viewmodel.dart';
import 'package:gofriendsgo/widgets/booking_details_widgets/booking_details_container.dart';
import 'package:gofriendsgo/widgets/booking_details_widgets/booking_details_searchbar.dart';
import 'package:gofriendsgo/widgets/booking_details_widgets/booking_appbar.dart';
import 'package:provider/provider.dart';

import '../../widgets/profile_wdigets/app_bar.dart';

class BookingDetailsScreen extends StatefulWidget {
  final bool fromBottomNav;
  final PageController? pageController;

  const BookingDetailsScreen({super.key, required this.fromBottomNav, this.pageController});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch bookings from the ViewModel when the screen is initialized
    context.read<BookingViewModel>().fetchBookingsfromservice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookingDetailsAppbar(
        onBack: () {
          pageNavigation.pop();
        },
        showBackButton: !widget.fromBottomNav,
      ),
      backgroundColor: const Color.fromARGB(255, 232, 243, 248),
      // Use the custom BookingDetailsAppbar
      body: Column(
        children: [
          const BookingDetailsSearch(),
          Expanded(
            child: Consumer<BookingViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (viewModel.filteredBookings.isEmpty) {
                  return const Center(
                    child: Text('No bookings available'),
                  );
                } else {
                  // Pass the filtered bookings to BookingDetailsContainer
                  return BookingDetailsContainer(viewModel.filteredBookings);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
