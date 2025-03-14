import 'package:flutter/material.dart';

class CustomSizedBoxHeight extends StatelessWidget {
  final double height;

  const CustomSizedBoxHeight(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
  }
}

class CustomSizedBoxWidth extends StatelessWidget {
  final double width;

  const CustomSizedBoxWidth(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
    );
  }
}
