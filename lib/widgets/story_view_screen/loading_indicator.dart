import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';

class LoadingIndicatorOnStoryViewScreen extends StatelessWidget {
  const LoadingIndicatorOnStoryViewScreen({
    super.key,
    required double progress,
  }) : _progress = progress;

  final double _progress;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: mediaquerywidth(.95, context),
        child: LinearProgressIndicator(
          borderRadius: BorderRadius.circular(30),
          valueColor: const AlwaysStoppedAnimation(Color(0xFF9C0AB6)),
          value: _progress,
        ),
      ),
    ));
  }
}
