import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofriendsgo/utils/constants/app_textfields.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';

class LabeledInputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Icon? prefixIcon;
  final String fontFamily;
  final double fontSize;
  final Color textColor;
  final int? maxlngths;
  final Icon? suffix;
  final bool? isEnabled;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? submitFun;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? keyboardType;

  const LabeledInputField(
      {this.keyboardType,
      super.key,
      required this.labelText,
      required this.hintText,
      this.textInputFormatter,
      this.prefixIcon,
      this.fontFamily = 'Poppins',
      this.fontSize = 0.04,
      this.textColor = Colors.black,
      this.maxlngths,
      this.suffix,
      this.controller,
      this.validator,
      this.submitFun,
      this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          fontFamily: fontFamily,
          text: labelText,
          size: fontSize,
          color: textColor,
        ),
        InputField.inputField(
          isEnabled: isEnabled,
          onFieldSubmitted: submitFun,
          keyboardType: keyboardType,
          textInputFormatter: textInputFormatter,
          validator: validator,
          controller: controller,
          icon: suffix,
          hinttext: hintText,
          prefixIcon: prefixIcon,
        ),
      ],
    );
  }
}
