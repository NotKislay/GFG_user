// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/user_model/user_details_model.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view_model/user_details.dart';
import 'package:gofriendsgo/widgets/otp_widgets/count_down.dart';
import 'package:gofriendsgo/widgets/otp_widgets/edit_text.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpVerifyScreen extends StatefulWidget {
  final UserDetails? userDetails;
  final String? loginEmail;
  final String? signUpEmail;
  final String? signUpName;

  const OtpVerifyScreen(
      {super.key,
      this.userDetails,
      this.loginEmail,
      this.signUpEmail,
      this.signUpName});

  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  String otpCode = "";
  @override
  void initState() {
    super.initState();
  }

  final defaultPinTheme = PinTheme(
    width: 55,
    height: 65,
    textStyle: const TextStyle(fontSize: 16, color: Colors.black),
    decoration: BoxDecoration(
      color: Colors.white, // Inside box color
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.black), // Border color
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserViewModel>(
        builder: (context, userViewModel, child) {
          return Stack(
            children: [
              Padding(
                padding: commonScreenPadding(context),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomSizedBoxHeight(0.1),
                          GestureDetector(
                            onTap: () {
                              PageNavigations().pop();
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 226, 223, 223),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    mediaquerywidth(0.03, context)),
                                child: const Icon(
                                    Icons.arrow_back_ios_new_outlined),
                              ),
                            ),
                          ),
                          const CustomSizedBoxHeight(0.04),
                          const CustomText(
                            fontFamily: CustomFonts.poppins,
                            text: 'Enter code',
                            size: 0.08,
                            color: Colors.black,
                            weight: FontWeight.w800,
                          ),
                          const CustomSizedBoxHeight(0.02),
                          CustomText(
                            fontFamily: CustomFonts.poppins,
                            text: widget.userDetails == null
                                ? 'We have sent the code to ${widget.loginEmail}'
                                : 'Hey ${widget.signUpName}, we have sent the code to ${widget.signUpEmail}',
                            size: 0.04,
                            color: Colors.black,
                          ),
                          const CustomSizedBoxHeight(0.04),
                          Center(
                            child: Pinput(
                              onChanged: (value) {
                                setState(() {
                                  otpCode = value;
                                });
                              },
                              defaultPinTheme: defaultPinTheme,
                              length: 5,
                              onCompleted: (pin) => log(pin),
                            ),
                          ),
                          const CustomSizedBoxHeight(0.02),
                          GestureDetector(
                              onTap: () {
                                PageNavigations().pop();
                              },
                              child: const CustomEditText()),
                        ],
                      ),
                      const CustomSizedBoxHeight(0.38),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OtpCountDown(
                                email: widget.loginEmail ?? widget.signUpEmail!,
                              ),
                            ],
                          ),
                          CustomButton(
                            function: () async {
                              if (otpCode.length == 5) {
                                int val = int.parse(otpCode);
                                await userViewModel.verifyOtp(
                                  val,
                                  widget.loginEmail ?? widget.signUpEmail!,
                                );
                              }
                            },
                            text: 'Verify OTP',
                            gradientColors: boxColor(otpCode),
                            fontSize: 0.04,
                            buttonTextColor: textColor(otpCode),
                            borderColor: Colors.transparent,
                            fontFamily: CustomFonts.poppins,
                          ),
                          const CustomSizedBoxHeight(0.04),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (userViewModel.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Color textColor(String otpCode) {
    if (otpCode.length == 5) {
      return Colors.white;
    } else {
      return const Color.fromRGBO(163, 163, 163, 1);
    }
  }

  List<Color> boxColor(String otpCode) {
    if (otpCode.length == 5) {
      return [const Color(0xFF3120D8), const Color(0xFF9C0AB6)];
    } else {
      return [
        const Color.fromRGBO(230, 230, 231, 1),
        const Color.fromRGBO(230, 230, 231, 1),
      ];
    }
  }
}
