import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String hinttext;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;  // Use onFieldSubmitted directly
  final List<TextInputFormatter>? textInputFormatter;
  final Icon? icon;
  final Icon? prefixIcon;
  final bool? isEnabled;
  final int? maxLength;  // Correct maxLength usage

  const InputField.inputField({
    this.textInputFormatter,
    this.controller,
    super.key,
    this.label,
    required this.hinttext,
    this.keyboardType,
    this.validator,
    this.icon,
    this.prefixIcon,
    this.onFieldSubmitted,  // Corrected the parameter name
    this.isEnabled,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      textInputAction: TextInputAction.done,  // Sets action to 'done' for the keyboard
      onFieldSubmitted: onFieldSubmitted,     // Trigger the submit function when "Enter" key is pressed
      inputFormatters: textInputFormatter,
      maxLength: maxLength,  // Apply maxLength for character limit
      style: const TextStyle(color: Colors.black),
      autovalidateMode: AutovalidateMode.disabled,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(82, 136, 132, 136)),
            borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(54, 38, 8, 37)),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(54, 62, 5, 61))),
        fillColor: Colors.white,
        filled: true,
        labelText: label,
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade600),
            borderRadius: BorderRadius.circular(12)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade600),
            borderRadius: BorderRadius.circular(12)),
        hintText: hinttext,
        prefixIcon: prefixIcon,
        suffixIcon: icon,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 124, 114, 114)),
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(90)),
      ),
      keyboardType: keyboardType,
    );
  }
}
