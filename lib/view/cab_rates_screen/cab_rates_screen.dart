import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_bar.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/cab_viewmodel.dart';
import 'package:gofriendsgo/widgets/cab_rates/get_details_button.dart';
import 'package:gofriendsgo/widgets/cab_rates/service_details.dart';
import 'package:gofriendsgo/widgets/cab_rates/title.dart';
import 'package:gofriendsgo/widgets/cab_rates/vehile_and_km_heading.dart';
import 'package:provider/provider.dart';

import '../../widgets/cab_rates/extra_notes.dart';

class CabRatesScreen extends StatefulWidget {
  const CabRatesScreen({super.key});

  @override
  State<CabRatesScreen> createState() => _CabRatesScreenState();
}

class _CabRatesScreenState extends State<CabRatesScreen> {
  late Map<String, List<List<String>>> vehicleMap;

  @override
  void initState() {
    context.read<CabViewModel>().fetchCabs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonGradientAppBar(
        heading: "Cab Rates",
        fromBottomNav: false,
      ),
      body: Consumer<CabViewModel>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!value.isLoading) {
            final datas = value.cabResponse!.data.cabs;
            Map<String, List<List<String>>> tempMap = {};

            for (var element in datas) {
              if (tempMap.containsKey(element.type)) {
                tempMap[element.type]!
                    .add([element.vechile, element.price, element.perKm]);
              } else {
                tempMap[element.type] = [
                  [element.vechile, element.price, element.perKm]
                ];
              }
            }

            vehicleMap = tempMap;

            List<MapEntry<String, List<List<String>>>> entries =
                vehicleMap.entries.toList();

            return ListView.builder(
              itemCount: vehicleMap.length,
              itemBuilder: (context, index) {
                MapEntry<String, List<List<String>>> element = entries[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mediaquerywidth(0.04, context),
                      vertical: mediaqueryheight(0.02, context)),
                  child: Material(
                    elevation: 10,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.all(mediaqueryheight(0.02, context)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomSizedBoxHeight(0.02),
                            CabRatesTitle(
                                title: element.key == 'outofTown'
                                    ? 'Out Of Town'
                                    : 'Local Patna'),
                            const CustomSizedBoxHeight(0.015),
                            const Divider(),
                            const CustomSizedBoxHeight(0.015),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  color: AppColors.whiteColor),
                              child: Column(
                                children: [
                                  const VehicleAndKmHeading(),
                                  VehicleServiceDetails(
                                    serviceDetails: element.value,
                                  ),
                                  ExtraNoteInCabRates(isLocalPatna: element.key == 'LocalPatna',),
                                  const GetDetailsButtonInCabRates()
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
