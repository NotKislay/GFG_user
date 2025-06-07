import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/visa_model/visa_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class HeadingAndDetails extends StatelessWidget {
  final VisaDetail visaDetail;
  const HeadingAndDetails(
    this.visaDetail, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.backgroundColor, width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            padding: const EdgeInsets.all(6),
            width: double.infinity,
            child: CustomText(
              text: visaDetail.title,
              fontFamily: CustomFonts.roboto,
              size: 0.05,
              color: AppColors.blackColor,
              weight: FontWeight.w500,
            ),
          ),
          Visibility(
            visible: visaDetail.description != null,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaquerywidth(0.04, context),
                  vertical: mediaqueryheight(0.008, context)),
              child: CustomText(
                  text: visaDetail.description ?? '',
                  fontFamily: CustomFonts.roboto,
                  size: 0.036,
                  color: const Color.fromRGBO(0, 0, 0, 0.8)),
            ),
          )
        ]));
  }
}

// Container(
//       decoration: BoxDecoration(
//           border: Border.all(color: AppColors.backgroundColor, width: 1),
//           borderRadius: BorderRadius.circular(8)),
//       child: ListView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: visaCheckList.length,
//         itemBuilder: (context, index) {
//           final section = visaCheckList[index];
//           return Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     color: AppColors.backgroundColor,
//                     borderRadius: index == 0
//                         ? const BorderRadius.only(
//                             topLeft: Radius.circular(8),
//                             topRight: Radius.circular(8))
//                         : const BorderRadius.only()),
//                 padding: const EdgeInsets.all(6),
//                 width: double.infinity,
//                 child: CustomText(
//                   text: section.heading,
//                   fontFamily: CustomFonts.roboto,
//                   size: 0.05,
//                   color: AppColors.blackColor,
//                   weight: FontWeight.w500,
//                 ),
//               ),
//               ...List.generate(
//                 section.details.length,
//                 (index) {
//                   return Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: mediaquerywidth(0.04, context),
//                             vertical: mediaqueryheight(0.008, context)),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomText(
//                                 text: "${index + 1}.",
//                                 fontFamily: CustomFonts.roboto,
//                                 size: 0.033,
//                                 color: const Color.fromRGBO(0, 0, 0, 0.8)),
//                             SizedBox(
//                                 width: mediaquerywidth(0.68, context),
//                                 child: CustomText(
//                                     text: section.details[index],
//                                     fontFamily: CustomFonts.roboto,
//                                     size: 0.033,
//                                     color: const Color.fromRGBO(0, 0, 0, 0.8)))
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//               const CustomSizedBoxHeight(0.03)
//             ],
//           );
//         },
//       ),
//     );
