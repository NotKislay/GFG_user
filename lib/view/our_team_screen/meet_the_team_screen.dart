import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_bar.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/team_viewmodel.dart';
import 'package:gofriendsgo/widgets/meet_the_team_widgets/gridview.dart';
import 'package:gofriendsgo/widgets/meet_the_team_widgets/headings.dart';
import 'package:provider/provider.dart';

class MeetTheTeamScreen extends StatefulWidget {
  const MeetTheTeamScreen({super.key});

  @override
  State<MeetTheTeamScreen> createState() => _MeetTheTeamScreenState();
}

class _MeetTheTeamScreenState extends State<MeetTheTeamScreen> {
  @override
  void initState() {
    context.read<TeamsViewModel>().fetchTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CommonGradientAppBar(
        heading: TextStrings.meetTheTeam,
        fromBottomNav: false,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: mediaquerywidth(0.05, context),
            top: mediaqueryheight(0.015, context),
            right: mediaquerywidth(0.05, context)),
        child: Consumer<TeamsViewModel>(builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MeetTheTeamHeading(
                //   heading: TextStrings.ourDirectors,
                // ),
                // CustomSizedBoxHeight(0.02),
                // GridViewMeetTheTeam(
                //   count: 2,
                // ),
                // CustomSizedBoxHeight(0.03),
                // MeetTheTeamHeading(
                //   heading: TextStrings.departmentHeads,
                // ),
                // CustomSizedBoxHeight(0.02),
                // GridViewMeetTheTeam(
                //   count: 6,
                // ),
                // CustomSizedBoxHeight(0.03),
                
                /* const MeetTheTeamHeading(
                  heading: TextStrings.teamMembers,
                ),
                const CustomSizedBoxHeight(0.02), */
                GridViewMeetTheTeam(
                  value.teamsResponse!.data.teams,
                ),
                const CustomSizedBoxHeight(0.03),
              ],
            ),
          );
        }),
      ),
    );
  }
}
