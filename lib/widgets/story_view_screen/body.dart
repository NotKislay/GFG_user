import 'package:flutter/material.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

PageView storyViewArea(
    {required PageController pageController,
    required int storyLength,
    required StoryCallBAck callBack,
    required String currentImagePath, required ValueKey<int> key}) {
  return PageView.builder(
    controller: pageController,
    itemCount: storyLength,
    onPageChanged: (index) {
      callBack(index);
    },
    itemBuilder: (context, index) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.purple
          ],)
        ),
        width: double.infinity,
        height: mediaqueryheight(1, context),
        child: /*isVideo
            ? VideoStory(
                controller: videoController, videoURL: currentImagePath)
            : */Image.network(
                APIConstants.baseImageUrl + currentImagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(AppImages.goFriendsGoLogoMini);
                },
              ),
      );
    },
  );
}

typedef StoryCallBAck = void Function(int index);
