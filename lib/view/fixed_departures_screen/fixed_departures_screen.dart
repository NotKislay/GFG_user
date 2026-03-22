import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/departure_viewmodel.dart';
import 'package:gofriendsgo/widgets/fixed_departures/app_bar.dart';
import 'package:gofriendsgo/widgets/fixed_departures/departure.dart';
import 'package:gofriendsgo/widgets/fixed_departures/flight_departure.dart';
import 'package:gofriendsgo/widgets/fixed_departures/get_details_button.dart';
import 'package:gofriendsgo/widgets/fixed_departures/hotel_ratings.dart';
import 'package:gofriendsgo/widgets/fixed_departures/is_booked_container.dart';
import 'package:gofriendsgo/widgets/fixed_departures/package_amount.dart';
import 'package:gofriendsgo/widgets/fixed_departures/package_details.dart';
import 'package:gofriendsgo/widgets/fixed_departures/scheduled_days.dart';
import 'package:provider/provider.dart';

//
class FixedDeparturesScreen extends StatefulWidget {
  const FixedDeparturesScreen({super.key});

  @override
  State<FixedDeparturesScreen> createState() => _FixedDeparturesScreenState();
}

class _FixedDeparturesScreenState extends State<FixedDeparturesScreen> {
  @override
  void initState() {
    context.read<FixedDeparturesViewModel>().fetchFixedDepartures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, mediaqueryheight(0.165, context)),
          child: const FixedDepartureAppBar()),
      body: Padding(
          padding: commonScreenPadding(context),
          child: Consumer<FixedDeparturesViewModel>(
            builder: (context, departureViewModel, child) {
              if (departureViewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (departureViewModel.filteredDepartures == null ||
                  departureViewModel.filteredDepartures!.isEmpty) {
                return const Text('No departures match the selected filters.');

              } else {
                return ListView.builder(
                  itemCount: departureViewModel.filteredDepartures!.length,
                  itemBuilder: (context, index) {
                    final package = departureViewModel.filteredDepartures![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: mediaqueryheight(0.015, context)),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(49, 103, 152, .42),
                              offset: Offset(0, 2),
                              blurRadius: 3,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.whiteColor,
                        ),
                        padding: EdgeInsets.all(
                          mediaquerywidth(0.04, context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (package.tagStatus == 1) // Check if tag_status is 1
                               FixedDepartureWithAirfareContainer(status: package.tag.first.name),
                            const CustomSizedBoxHeight(0.015),
                            FixedDeparturesPackageHeading(title: package.title),
                            const CustomSizedBoxHeight(0.02),
                            HotelRatings(starCount: package.rating),
                            const CustomSizedBoxHeight(0.01),
                            ScheduledDays(
                              startDate: package.from,
                              endDate: package.to,
                            ),
                            const CustomSizedBoxHeight(0.012),
                            FlightDeparture(travelTo: package.travelTo),
                            const CustomSizedBoxHeight(0.01),
                            const Divider(),
                            const CustomSizedBoxHeight(0.01),
                            ...packageDetails(package.description, context),
                            const CustomSizedBoxHeight(0.014),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const GetDetailsButton(),
                                TotalPackageAmount(amount: package.price),
                                const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

              }
            },
          )),
    );
  }
}
