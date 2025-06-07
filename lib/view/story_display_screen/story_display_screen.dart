import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofriendsgo/model/story_model/story_model.dart';
import 'package:gofriendsgo/widgets/story_view_screen/body.dart';
import 'package:gofriendsgo/widgets/story_view_screen/loading_indicator.dart';
import 'package:gofriendsgo/widgets/story_view_screen/story_appbar.dart';
import 'package:gofriendsgo/widgets/story_view_screen/video_story.dart';

class StoryDisplayScreen extends StatefulWidget {
  final List<Story> allStories;
  final int currentIndex;

  const StoryDisplayScreen(
      {super.key, required this.allStories, required this.currentIndex});

  @override
  State<StoryDisplayScreen> createState() => _StoryDisplayScreenState();
}

class _StoryDisplayScreenState extends State<StoryDisplayScreen> {
  late PageController _pageController;
  late Timer? _timer = Timer(const Duration(seconds: 0), () {});
  late int _currentIndex;
  double _progress = 0.0;
  bool completed = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
    if (!_isVideoStory()) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1.0) {
          _progress = 0.0;
          _timer?.cancel();
          _advanceToNextStory();
        }
      });
    });
  }

  void _advanceToNextStory() {
    _currentIndex++;
    _pageController = PageController(initialPage: _currentIndex);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      log("No clients");
    }
    if (_currentIndex >= widget.allStories.length) {
      navigator?.pop(context);
      _currentIndex = 0;
    }

    if (!_isVideoStory()) {
      _startTimer();
    }
  }

  bool _isVideoStory() {
    return widget.allStories[_currentIndex].type == 'video';
  }

  void _onVideoFinished() {
    _progress = 0.0;
    _advanceToNextStory();
  }

  void _onNextStory() {
    setState(() {
      _progress = 0.0;
    });
    _advanceToNextStory();
  }

  void _onPreviousStory() {
    setState(() {
      _currentIndex = _currentIndex -
          2; // because it will again increment in advanceStory funcn
      _progress = 0.0;
    });
    _advanceToNextStory();
  }

  void _onVideoProgress(double progress) {
    setState(() {
      _progress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StoryAppbar(
          widget: widget,
          currentIndex: _currentIndex,
        ),
        body: _isVideoStory()
            ? VideoStory(
                key: ValueKey(_currentIndex),
                videoURL: widget.allStories[_currentIndex].image,
                onVideoFinished: _onVideoFinished,
                onProgressUpdate: _onVideoProgress,
                onRightSwipe: _onPreviousStory,
                onLeftSwipe: _onNextStory,
              )
            : Stack(
                children: [
                  storyViewArea(
                    key: ValueKey(_currentIndex),
                    pageController: _pageController,
                    storyLength: widget.allStories.length,
                    currentImagePath: widget.allStories[_currentIndex].image,
                    callBack: (index) {
                      setState(() {
                        //new issue 12 nov
                        log("New index $index");
                        _currentIndex = index;
                        _progress = 0.0;
                        if (!_isVideoStory()) {
                          _startTimer();
                        }
                      });
                    },
                  ),
                  LoadingIndicatorOnStoryViewScreen(progress: _progress),
                ],
              ));
  }
}
