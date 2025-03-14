import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/widgets/about_us_widgets/appbar.dart';
import 'package:gofriendsgo/widgets/about_us_widgets/first_content.dart';
import 'package:gofriendsgo/widgets/about_us_widgets/follow_us.dart';
import 'package:gofriendsgo/widgets/about_us_widgets/our_story_image.dart';
import 'package:gofriendsgo/widgets/about_us_widgets/ourstory_texts.dart';
import 'package:gofriendsgo/widgets/about_us_widgets/social_media.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: AppColors.gradientColors,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                height: mediaqueryheight(0.75, context),
                child: Padding(
                  padding: commonScreenPadding(context),
                  child: Column(
                    children: [
                      SizedBox(
                        height: mediaqueryheight(0.02, context),
                      ),
                      const AboutUsAppBarElements(),
                      const AboutUsFirstContent()
                    ],
                  ),
                ),
              ),
              const CustomSizedBoxHeight(0.03),
              Padding(
                padding: commonScreenPadding(context),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OurStoryHeading(),
                    CustomSizedBoxHeight(0.02),
                    OurStoryTexts(TextStrings.ourStorySecondText),
                    CustomSizedBoxHeight(0.02),
                    OurStoryImage(),
                    CustomSizedBoxHeight(0.02),
                    // OurStoryTexts(TextStrings.ourStorySecondText),
                
                    OurStoryTexts(TextStrings.ourStoryThirdText),
                   
                    CustomSizedBoxHeight(0.02),
                    FollowUsHeading(),
                    CustomSizedBoxHeight(0.02),
                    SocialMediaIcons(),
                    CustomSizedBoxHeight(0.03),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
