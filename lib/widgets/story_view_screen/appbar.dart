import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/story_display_screen/story_display_screen.dart';

import '../home_screen_widgets/home_utils.dart';

class AppBarOfStoryViewScreen extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarOfStoryViewScreen({
    super.key,
    required this.widget,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final StoryDisplayScreen widget;
  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    final isVideo = widget.allStories[_currentIndex].type == "video";
    return AppBar(
      flexibleSpace: Container(
          decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: AppColors.gradientColors,
            begin: Alignment.centerRight,
            end: Alignment.centerLeft),
      )),
      leading: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: mediaquerywidth(0.12, context),
          height: mediaquerywidth(0.12, context),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color.fromRGBO(236, 147, 255, 1),
              width: 3.0,
            ),
          ),
          child: ClipOval(
            child: isVideo
                ? createVideoThumbnailFromStorage(
                    videoUrl: widget.allStories[_currentIndex].image)
                : createImageThumbnail(
                    imageUrl: widget.allStories[_currentIndex].image),
          ),
        ),
      ),
      title: Text(
        widget.allStories[_currentIndex].title,
        style: TextStyle(
          fontFamily: CustomFonts.roboto,
          fontSize: 20,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            PageNavigations().pop();
          },
          child: Icon(
            size: mediaquerywidth(0.08, context),
            Icons.close,
            color: AppColors.whiteColor,
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
