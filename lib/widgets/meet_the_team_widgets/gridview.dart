import 'dart:collection';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/teams_model/teams_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/widgets/meet_the_team_widgets/headings.dart';
import 'package:marquee/marquee.dart';

class GridViewMeetTheTeam extends StatelessWidget {
  final List<Team> teams;
  const GridViewMeetTheTeam(
    this.teams, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final proper = createTeams();

    return SingleChildScrollView(
      child: Column(
        children: proper.entries.map((section) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSizedBoxHeight(0.02),
              MeetTheTeamHeading(
                heading: section.key,
              ),
              const CustomSizedBoxHeight(0.02),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: mediaqueryheight(0.19, context),
                  mainAxisSpacing: mediaqueryheight(0.025, context),
                  crossAxisSpacing: mediaquerywidth(0.05, context),
                  crossAxisCount: 3,
                ),
                itemCount: section.value.length,
                itemBuilder: (context, index) {
                  final teamMember = section.value[index];
                  return Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: mediaquerywidth(0.24, context),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: CachedNetworkImage(
                              width: mediaqueryheight(0.08, context),
                              height: mediaqueryheight(0.08, context),
                              imageUrl:
                                  APIConstants.baseImageUrl + teamMember.image,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset(AppImages.goFriendsGoLogoMini),
                            ),
                          ),
                          const CustomSizedBoxHeight(0.008),
                          SizedBox(
                            height: mediaqueryheight(0.025, context),
                            width: double.infinity,
                            child: Marquee(
                              text: teamMember.name,
                              style: const TextStyle(
                                fontFamily: CustomFonts.roboto,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(39, 39, 39, 1),
                              ),
                              blankSpace: 20.0,
                              velocity: 30.0,
                              pauseAfterRound: const Duration(seconds: 1),
                            ),
                          ),
                          SizedBox(
                            height: mediaqueryheight(0.02, context),
                            width: double.infinity,
                            child: CustomText(
                              textAlign: TextAlign.center,
                              textOverflow: TextOverflow.ellipsis,
                              text: teamMember.designation,
                              fontFamily: CustomFonts.roboto,
                              size: 0.03,
                              color: const Color.fromRGBO(0, 0, 0, 0.63),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }).toList(), // Converts the iterable to a list of widgets
      ),
    );
  }

  Map<String, List<Team>> createTeams() {
    Map<String, List<Team>> teamssss = {};
    for (final team in teams) {
      final Map<String, Team> internalData = {team.teamTitle: team};
      log("INT: ${internalData.entries}");
      if (teamssss.containsKey(team.teamTitle)) {
        teamssss[team.teamTitle]!.add(team);
      } else {
        teamssss[team.teamTitle] = [team];
      }
      // teamssss[team.team] = internalData;
    }

    teamssss.entries.forEach((t) {
      log('${t.key} -> ${t.value}');
    });

    return teamssss;
  }
}
