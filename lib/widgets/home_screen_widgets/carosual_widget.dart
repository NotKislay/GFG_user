import 'dart:async';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/passport_checlist/passport_checklist_screen.dart';
import 'package:gofriendsgo/view/visa_checklist/visa_checlist_screen.dart';
import 'package:gofriendsgo/view_model/carosual_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../view/cab_rates_screen/cab_rates_screen.dart';
import '../../view/fixed_departures_screen/fixed_departures_screen.dart';

class HomeCarosualWidget extends StatefulWidget {
  const HomeCarosualWidget({
    super.key,
    required this.adController,
  });

  final PageController adController;

  @override
  _HomeCarosualWidgetState createState() => _HomeCarosualWidgetState();
}

class _HomeCarosualWidgetState extends State<HomeCarosualWidget> {
  late Timer _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    PageController(
      viewportFraction: 0.8,
      initialPage: 0,
    );
    _autoScrollTimer =
        Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage <
          Provider.of<CarousalViewModel>(context, listen: false)
                  .carouselsModel!
                  .data
                  .length -
              1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      widget.adController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: mediaqueryheight(0.03, context)),
        SizedBox(
          height: mediaqueryheight(0.18, context),
          child: Consumer<CarousalViewModel>(
            builder: (context, carosualViewModel, child) {
              if (carosualViewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final carouselList =
                    carosualViewModel.carouselsModel!.data.reversed.toList();
                return PageView.builder(
                  controller: widget.adController,
                  itemCount: carouselList.length,
                  itemBuilder: (context, index) {
                    final carousel = carouselList[index];
                    return GestureDetector(
                      onTap: () {
                        log("${carousel.id} -> ${carousel.link}");
                        if (carousel.link == TextStrings.linkFixedDepartures) {
                          PageNavigations().push(const FixedDeparturesScreen());
                        } else if (carousel.link ==
                            TextStrings.linkPassportChecklist) {
                          PageNavigations()
                              .push(const PassportChecklistScreen());
                        } else if (carousel.link ==
                            TextStrings.linkVisaChecklist) {
                          PageNavigations().push(const VisaChecklistScreen());
                        } else {
                          PageNavigations().push(const CabRatesScreen());
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl:
                                APIConstants.baseImageUrl + carousel.image,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Image.asset(AppImages.goFriendsGoLogoMini),
                            // progressIndicatorBuilder:
                            //     (context, url, downloadProgress) => SizedBox(
                            //   height: 30,
                            //   width: 30,
                            //   child: CircularProgressIndicator(
                            //       value: downloadProgress.progress),
                            // ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
