import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              _launchURL(TextStrings.instagramUrl);
            },
            child: Image.asset(AppImages.instagram)),
        const CustomSizedBoxWidth(0.06),
        GestureDetector(
            onTap: () {
              _launchURL(TextStrings.facebookUrl);
            },
            child: Image.asset(AppImages.facebook)),
        const CustomSizedBoxWidth(0.06),
        GestureDetector(
            onTap: () {
              _launchURL(TextStrings.linkedInUrl);
            },
            child: Image.asset(AppImages.linkedin)),
        const CustomSizedBoxWidth(0.06),
        GestureDetector(
            onTap: () {
              _launchURL(TextStrings.whatsappUrl);
            },
            child: Image.asset(AppImages.whatsapp)),
      ],
    );
  }

  void _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
