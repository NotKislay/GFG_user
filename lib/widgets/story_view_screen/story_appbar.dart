import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view/story_display_screen/story_display_screen.dart';
import 'appbar.dart';

class StoryAppbar extends StatefulWidget implements PreferredSizeWidget {
  final StoryDisplayScreen widget;
  final int currentIndex;

  const StoryAppbar(
      {super.key, required this.widget, required this.currentIndex});

  @override
  State<StoryAppbar> createState() => _StoryAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _StoryAppbarState extends State<StoryAppbar> {
  late int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant StoryAppbar oldWidget) {
    if (widget.currentIndex != oldWidget.currentIndex) {
      // Update state only when index actually changes
      setState(() {
        _currentIndex = widget.currentIndex;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AppBarOfStoryViewScreen(
      widget: widget.widget,
      currentIndex: _currentIndex,
    );
  }
}
