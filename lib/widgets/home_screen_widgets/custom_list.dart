import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/home_utils.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../model/story_model/story_model.dart';
import '../../services/api/app_apis.dart';
import '../../utils/constants/custom_text.dart';
import '../../utils/constants/mediaquery.dart';
import '../../utils/constants/paths.dart';
import '../../utils/navigations/navigations.dart';
import '../../view/story_display_screen/story_display_screen.dart';

class StoryItem extends StatelessWidget {
  final List<Story> allStories;
  final int currentIndex;

  const StoryItem({
    super.key,
    required this.allStories,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isVideo = allStories[currentIndex].type == "video";

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            PageNavigations().push(StoryDisplayScreen(
              currentIndex: currentIndex,
              allStories: allStories,
            ));
          },
          child: Container(
            width: mediaquerywidth(0.19, context),
            height: mediaquerywidth(0.19, context),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromRGBO(236, 147, 255, 1),
                width: 3.0,
              ),
            ),
            child: ClipOval(
              child: isVideo
                  ? FutureBuilder<Uint8List?>(
                future: getVideoThumbnail(APIConstants.baseImageUrl + allStories[currentIndex].image),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return Image.asset(
                      AppImages.goFriendsGoLogoMini,
                      fit: BoxFit.cover,
                    );
                  }
                  return Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  );
                },
              )
                  : createImageThumbnail(
                      imageUrl: allStories[currentIndex].image),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Container(
          alignment: Alignment.center,
          width: mediaquerywidth(0.19, context),
          child: Text(
            allStories[currentIndex].title,
            style: TextStyle(
              fontFamily: CustomFonts.poppins,
              fontSize: 13,
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
