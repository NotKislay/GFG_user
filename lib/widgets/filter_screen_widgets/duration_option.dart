import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';

class DurationOption extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const DurationOption({
    required this.text,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  State<DurationOption> createState() => _DurationOptionState();
}

class _DurationOptionState extends State<DurationOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Text(
            widget.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.isSelected ? Colors.blue : AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
