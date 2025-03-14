import 'package:flutter/material.dart';

Widget buildSelectedFilter(String title, String value) {
  return value.isNotEmpty
      ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            "$title: $value",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        )
      : const SizedBox.shrink();
}