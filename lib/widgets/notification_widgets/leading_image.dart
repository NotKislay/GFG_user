import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';


class LeadingImageInNotification extends StatelessWidget {
  const LeadingImageInNotification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(253, 230, 255, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      width: mediaquerywidth(0.15, context),
      height: mediaqueryheight(0.07, context),
      child: Image.asset('assets/images/Hotel icon.png'),
    );
  }
}
