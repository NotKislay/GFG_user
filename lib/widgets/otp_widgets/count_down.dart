import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/services/sign_up_service.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class OtpCountDown extends StatefulWidget {
  final String email;
  final UserService _userService = UserService();

  OtpCountDown({
    super.key,
    required this.email,
  });

  @override
  State<OtpCountDown> createState() => _OtpCountDownState();
}

class _OtpCountDownState extends State<OtpCountDown> {
  int count = 20;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer(); // Start countdown when widget is initialized
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (count > 0) {
        setState(() {
          count--;
        });
      } else {
        timer.cancel(); // Stop timer when countdown reaches zero
      }
    });
  }

  void _handleResend() {
    widget._userService.postEmail(widget.email); // Trigger the resend API
    setState(() {
      count = 20; // Reset the countdown
    });
    startTimer(); // Restart the timer
  }

  @override
  Widget build(BuildContext context) {
    return count == 0
        ? Row(
      children: [
        const CustomText(
          fontFamily: CustomFonts.poppins,
          text: 'I didn\'t receive a code',
          size: 0.04,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: _handleResend,
          child: const CustomText(
            fontFamily: CustomFonts.poppins,
            text: ' Resend',
            weight: FontWeight.w600,
            size: 0.04,
            color: Colors.black,
          ),
        ),
      ],
    )
        : CustomText(
      fontFamily: CustomFonts.poppins,
      text: 'Send code again   00:$count',
      size: 0.04,
      color: Colors.black,
    );
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel timer to prevent memory leaks
    super.dispose();
  }
}
