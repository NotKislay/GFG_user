import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:flutter/gestures.dart';

class LoginText extends StatelessWidget {
  final VoidCallback onTapSignUp; // Callback for onTap event

  const LoginText({
    super.key,
    required this.onTapSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Don’t have account? ',
        style: TextStyle(
          fontSize:
              mediaquerywidth(0.04, context), // Adjust the font size as needed
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTapSignUp,
          ),
        ],
      ),
    );
  }
}
