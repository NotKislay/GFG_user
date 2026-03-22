import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/notification_card_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/widgets/notification_widgets/appbar_and_tabs.dart';
import 'package:gofriendsgo/widgets/notification_widgets/leading_image.dart';
import 'package:gofriendsgo/widgets/notification_widgets/subtitle.dart';
import 'package:gofriendsgo/widgets/notification_widgets/time.dart';
import 'package:gofriendsgo/widgets/notification_widgets/title.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, mediaqueryheight(0.17, context)),
        child: AppBarAndTabItems(
            pageController: pageController, currentPage: currentPage),
      ),
      body: PageView.builder(
        itemCount: 2,
        controller: pageController,
        itemBuilder: (context, currentPage) {
          return ListView.builder(
            itemCount: currentPage == 0
                ? notificationCardList.length
                : notificationCardList
                    .where((element) => element.isUnread)
                    .toList()
                    .length,
            itemBuilder: (context, index) {
              final item = currentPage == 0
                  ? notificationCardList[index]
                  : notificationCardList
                      .where((element) => element.isUnread)
                      .toList()[index];
              return Container(
                color: item.isUnread
                    ? AppColors.backgroundColor
                    : AppColors.whiteColor,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: mediaqueryheight(0.02, context),
                  horizontal: mediaquerywidth(0.055, context),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LeadingImageInNotification(),
                        const CustomSizedBoxWidth(0.035),
                        NotificationTitle(item: item),
                        const CustomSizedBoxWidth(0.05),
                        TimeInNotification(item: item),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: mediaquerywidth(0.18, context),
                      ),
                      child: SubTitleInNotification(item: item),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
