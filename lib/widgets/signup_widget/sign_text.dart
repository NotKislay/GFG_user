import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';

class SignUpText extends StatelessWidget {
  final VoidCallback onTapLogin; // Callback for onTap event

  const SignUpText({
    super.key,
    required this.onTapLogin,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Already have an account? ',
        style: TextStyle(
          fontSize:
              mediaquerywidth(0.04, context), // Adjust the font size as needed
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Log in',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTapLogin,
          ),
        ],
      ),
    );
  }
}
