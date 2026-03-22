import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/on_boarding_model.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/widgets/on_boarding/next_button.dart';
import 'package:gofriendsgo/widgets/on_boarding/page_view_items.dart';
import 'package:gofriendsgo/widgets/on_boarding/skip_button.dart';

import '../../utils/constants/internet_broadcaster.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  bool isPageViewBuilt = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = onBoardingList;
    return InternetBroadcaster(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, mediaqueryheight(0.07, context)),
        child: Padding(
          padding: EdgeInsets.only(
              top: mediaqueryheight(0.05, context),
              right: mediaquerywidth(0.04, context)),
          child: const SkipButtonOnBoarding(),
        ),
      ),
      body: SafeArea(
        child: pageViewMaterialsOnBoarding(controller, pageController, () {
          setState(() {
            isPageViewBuilt = true;
          });
        }),
      ),
      bottomSheet: NextButtonOnBoarding(
          isPageViewBuilt: isPageViewBuilt, pageController: pageController),
    ));
  }
}
