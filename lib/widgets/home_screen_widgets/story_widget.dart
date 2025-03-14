import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/custom_list.dart';
import 'package:gofriendsgo/view_model/stories_viewmodel.dart';
import 'package:provider/provider.dart';

class StoryViewWidget extends StatelessWidget {
  const StoryViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mediaqueryheight(0.14, context),
      child: Consumer<StoriesViewModel>(
        builder: (context, storiesViewModel, child) {
          if (storiesViewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final reversedStories = storiesViewModel.storiesResponse!.data.stories.reversed.toList();
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: reversedStories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(9, 9, 9, 0),
                  child: StoryItem(
                    currentIndex: index,
                    allStories: reversedStories,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
