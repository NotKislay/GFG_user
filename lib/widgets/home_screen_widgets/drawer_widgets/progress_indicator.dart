import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/view_model/profile_viewmodel.dart';
import 'package:provider/provider.dart';

class ProgressIndicatorOnDrawer extends StatelessWidget {
  const ProgressIndicatorOnDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) {
        print(value.profilePercentage);
        return LinearProgressIndicator(
          minHeight: mediaqueryheight(0.01, context),
          value: value.profilePercentage,
          borderRadius: BorderRadius.circular(90),
          valueColor:
              const AlwaysStoppedAnimation(Color.fromRGBO(61, 9, 174, 1)),
        );
      },
    );
  }
}
