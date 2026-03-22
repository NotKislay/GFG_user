import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/widgets/story_view_screen/loading_indicator.dart';
import 'package:video_player/video_player.dart';

import '../../services/api/app_apis.dart';

class VideoStory extends StatefulWidget {
  final String videoURL;
  final Function onVideoFinished;
  final Function(double) onProgressUpdate;
  final Function onRightSwipe;
  final Function onLeftSwipe;

  const VideoStory({
    super.key,
    required this.videoURL,
    required this.onVideoFinished,
    required this.onProgressUpdate,
    required this.onRightSwipe,
    required this.onLeftSwipe,
  });

  @override
  State<VideoStory> createState() => _VideoStoryState();
}

class _VideoStoryState extends State<VideoStory> {
  late Timer _timer = Timer(const Duration(seconds: 0), () {});
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _initializeVideoController();
  }

  @override
  void dispose() {
    _timer.cancel();
    _videoController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        double progress = _videoController.value.position.inMilliseconds /
            _videoController.value.duration.inMilliseconds;
        widget.onProgressUpdate(progress); // Report progress to parent

        if (progress >= 1.0) {
          dispose();
          widget.onVideoFinished(); // Notify parent that video finished
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details){
        if(details.velocity.pixelsPerSecond.dx > 0){
          widget.onRightSwipe();
        }else if(details.velocity.pixelsPerSecond.dx < 0){
          widget.onLeftSwipe();
        }
      },
      child: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.purple
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        _videoController.value.isInitialized
            ? Center(
                child: AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
        LoadingIndicatorOnStoryViewScreen(
            progress: _videoController.value.isInitialized
                ? _videoController.value.position.inMilliseconds /
                    _videoController.value.duration.inMilliseconds
                : 0),
      ]),
    );
  }

  void _initializeVideoController() {
    log("Initializing video controller....... ${APIConstants.baseImageUrl + widget.videoURL}");
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(APIConstants.baseImageUrl + widget.videoURL),
    )..initialize().then((_) {
        setState(() {
          _startTimer();
          _videoController.play(); // Autoplay video
        });
      }).catchError((error) {
        print("Video player initialization error: $error");
      });
  }
}
