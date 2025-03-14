import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/app_textfields.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class Testings extends StatelessWidget {
  const Testings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomSizedBoxHeight(0.05),
          const InputField.inputField(
            hinttext: 'adinansayed@gmail.com',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          SizedBox(
            width: mediaquerywidth(0.90, context),
            child: CustomButton(
              fontFamily: CustomFonts.poppins,
              borderColor: Colors.transparent,
              function: () {},
              text: 'Next',
              fontSize: 0.05,
              buttonTextColor: Colors.white,
            ),
          ),
          const CustomSizedBoxHeight(0.05)
        ],
      ),
    );
  }
}
