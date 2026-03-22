import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:url_launcher/url_launcher.dart';

class ThirdSection extends StatelessWidget {
  const ThirdSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: TextStrings.twentyFourSupport,
                fontFamily: CustomFonts.roboto,
                size: 0.035,
                weight: FontWeight.w500,
                color: Color.fromRGBO(0, 0, 0, 0.8)),
            CustomSizedBoxHeight(0.01),
            Divider(),
            CustomSizedBoxHeight(0.01),
            Row(
              children: [
                CustomText(
                    text: TextStrings.email,
                    fontFamily: CustomFonts.roboto,
                    size: 0.041,
                    weight: FontWeight.w500,
                    color: Color.fromRGBO(0, 0, 0, 0.8)),
                GestureDetector(
                  onTap: () async {
                    final Uri uri =
                        Uri(scheme: 'mailto', path: TextStrings.emailInfo);

                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  child: CustomText(
                      text: TextStrings.emailInfo,
                      fontFamily: CustomFonts.roboto,
                      size: 0.041,
                      color: Color.fromRGBO(0, 116, 217, 1)),
                ),
              ],
            ),
            CustomSizedBoxHeight(0.01),
            Row(
              children: [
                CustomText(
                    text: TextStrings.phone,
                    fontFamily: CustomFonts.roboto,
                    size: 0.041,
                    weight: FontWeight.w500,
                    color: Color.fromRGBO(0, 0, 0, 0.8)),
                GestureDetector(
                  onTap: () async {
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: TextStrings.phoneInfo,
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  child: CustomText(
                      text: TextStrings.phoneInfo,
                      fontFamily: CustomFonts.roboto,
                      size: 0.041,
                      color: Color.fromRGBO(0, 116, 217, 1)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
