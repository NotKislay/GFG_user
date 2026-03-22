import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class VehicleServiceDetails extends StatelessWidget {
  const VehicleServiceDetails({
    super.key,
    required this.serviceDetails,
  });

  final List<List<String>> serviceDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: serviceDetails.map((entry) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: mediaqueryheight(0.015, context),
              horizontal: mediaquerywidth(0.035, context)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: mediaquerywidth(0.4, context),
                child: CustomText(
                  text: entry[0],
                  fontFamily: CustomFonts.roboto,
                  weight: FontWeight.w800,
                  size: 0.040,
                  color: const Color.fromRGBO(0, 0, 0, 0.8),
                ),
              ),
              const CustomSizedBoxWidth(0.06),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: entry[1] +
                        ((entry.last != '0') ? " Rs RENT " : ' Rs/KM'),
                    textAlign: TextAlign.end,
                    weight: FontWeight.w700,
                    fontFamily: CustomFonts.roboto,
                    size: 0.038,
                    color: const Color.fromRGBO(0, 0, 0, 0.8),
                  ),
                  (entry.last != '0')
                      ? CustomText(
                          text: " + FUEL ${entry.last} KM/L \nMileage",
                          fontFamily: CustomFonts.roboto,
                          size: 0.035,
                          color: Colors.grey.shade700,
                        )
                      : SizedBox(),
                  /* CustomText(
                    text: "Mileage",
                    fontFamily: CustomFonts.roboto,
                    size: 0.035,
                    color: Colors.grey.shade700,
                  ), */
                ],
              )
              /* Row(
                children: [
                  CustomText(
                    text: entry[1],
                    textAlign: TextAlign.end,
                    weight: FontWeight.w700,
                    fontFamily: CustomFonts.roboto,
                    size: 0.045,
                    color: const Color.fromRGBO(0, 0, 0, 0.8),
                  ),
                  
                ],
              ) */
            ],
          ),
        );
      }).toList(),
    );
  }
}
