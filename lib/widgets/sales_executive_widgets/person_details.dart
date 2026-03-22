import 'package:flutter/material.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/sales_exe_viewmodel.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

class SalesExecutiveName extends StatelessWidget {
  final SalesPersonViewModel value;
  const SalesExecutiveName(
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /* return SizedBox(
        height: 25,
        width: mediaquerywidth(0.5, context),
        child: Marquee(
            blankSpace: 25,
            text: value.salesPersonResponse?.data.name ??
                "GoFriends Go Pvt. Ltd.",
            style: TextStyle(
                fontFamily: CustomFonts.roboto,
                fontSize: 21,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor))); */
    return SizedBox(
      width: mediaquerywidth(0.5, context),
      child: CustomText(
          text:
              value.salesPersonResponse?.data.name ?? "GoFriends Go Pvt. Ltd.",
          fontFamily: CustomFonts.roboto,
          size: 0.047,
          weight: FontWeight.w500,
          textOverflow: TextOverflow.ellipsis,
          color: AppColors.blackColor),
    );
  }
}

class ContactPhoneAndEmailLogo extends StatelessWidget {
  final SalesPersonViewModel value;
  const ContactPhoneAndEmailLogo(
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            final email = (value.salesPersonResponse != null &&
                    value.salesPersonResponse!.data.email != null)
                ? value.salesPersonResponse!.data.email!
                : TextStrings.emailInfo;

            _sendEmail(email);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.backgroundColor),
                borderRadius: BorderRadius.circular(90)),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.email_outlined,
                size: mediaquerywidth(0.06, context),
              ),
            ),
          ),
        ),
        const CustomSizedBoxWidth(0.02),
        GestureDetector(
          onTap: () {
            final phone = (value.salesPersonResponse != null &&
                    value.salesPersonResponse!.data.phone != null)
                ? value.salesPersonResponse!.data.phone!
                : TextStrings.phoneInfo;
            _launchDialer(phone);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.backgroundColor),
                borderRadius: BorderRadius.circular(90)),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.call,
                size: mediaquerywidth(0.06, context),
              ),
            ),
          ),
        )
      ],
    );
  }

  _sendEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    //if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    //}
  }

  _launchDialer(String phoneNumber) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}

class SalesExecutiveImage extends StatelessWidget {
  final SalesPersonViewModel value;
  const SalesExecutiveImage({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaquerywidth(0.2, context),
      height: mediaqueryheight(0.12, context),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: (value.salesPersonResponse != null &&
                  value.salesPersonResponse!.data.profilePic != null)
              ? NetworkImage(APIConstants.baseImageUrl +
                  value.salesPersonResponse!.data.profilePic!) as ImageProvider
              : AssetImage(AppImages.goFriendsGoLogoMini) as ImageProvider,
        ),
      ),
      // child: Consumer<SalesPersonViewModel>(
      //   builder: (context, value, child) => CachedNetworkImage(
      //     imageUrl:
      //         API.baseImageUrl + value.salesPersonResponse!.data.profilePic!,
      //     progressIndicatorBuilder: (context, url, downloadProgress) => Center(
      //       child: CircularProgressIndicator(value: downloadProgress.progress),
      //     ),
      //     errorWidget: (context, url, error) =>
      //         Image.asset(AppImages.tripImage),
      //   ),
      // ),
    );
  }
}
