import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';

Widget buildOTPField(BuildContext context, List<FocusNode> focusNodes,
    List<TextEditingController> controllers, int index) {
  return Container(
    width: mediaquerywidth(0.14, context),
    height: mediaqueryheight(0.12, context),
    margin: EdgeInsets.symmetric(horizontal: mediaquerywidth(0.02, context)),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return validateOTP(value);
      },
      focusNode: focusNodes[index],
      controller: controllers[index],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(19),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(19),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(19),
        ),
        counterText: '',
      ),
      onChanged: (value) {
        if (value.length == 1) {
          if (index < 4) {
            focusNodes[index].unfocus();
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          } else {
            focusNodes[index].unfocus();
          }
        }
        if (value.isEmpty) {
          if (index > 0) {
            focusNodes[index].unfocus();
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          }
        }
      },
    ),
  );
}

String? validateOTP(String? value) {
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
    return "Invalid OTP: Please enter only numeric values";
  } else {
    return null;
  }
}
