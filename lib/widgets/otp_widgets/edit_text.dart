import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class CustomEditText extends StatelessWidget {
  const CustomEditText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          fontFamily: CustomFonts.poppins,
          text: 'Edit Email address',
          size: 0.04,
          color: Colors.black,
        ),
        CustomSizedBoxWidth(0.02),
        Icon(Icons.edit),
      ],
    );
  }
}
