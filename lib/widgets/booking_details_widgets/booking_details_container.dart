import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../../model/bookings_model/bookings_model.dart';
import '../../utils/color_theme/colors.dart';
import '../../utils/constants/custom_text.dart';
import '../../utils/constants/gradient_icons.dart';
import '../../utils/constants/mediaquery.dart';
import '../../utils/constants/paths.dart';
import '../../utils/constants/sizedbox.dart';

class BookingDetailsContainer extends StatelessWidget {
  final List<BookingModel> value;

  const BookingDetailsContainer(
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      height: mediaqueryheight(0.7, context),
      width: mediaquerywidth(0.94, context),
      child: ListView.builder(
        itemCount: value.length,
        itemBuilder: (context, index) {
          final bookingList = value[index];
          if (value.isEmpty) {
            return const Center(
              child: CustomText(
                  text: 'No Data Fount',
                  fontFamily: CustomFonts.lato,
                  size: 0.05,
                  color: AppColors.blackColor),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.whiteColor,
                ),
                width: mediaquerywidth(0.33, context),
                height: mediaqueryheight(0.15, context),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: mediaquerywidth(0.03, context),
                        right: mediaquerywidth(0.03, context),
                        top: mediaquerywidth(0.02, context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              weight: FontWeight.w800,
                              text: bookingList.sector,
                              fontFamily: CustomFonts.roboto,
                              size: 0.04,
                              color: AppColors.blackColor),
                          CustomText(
                              weight: FontWeight.w800,
                              text: bookingList.amount == ''
                                  ? ''
                                  : '₹ ${bookingList.amount}',
                              fontFamily: CustomFonts.roboto,
                              size: 0.04,
                              color: AppColors.blackColor),
                        ],
                      ),
                    ),
                    const CustomSizedBoxHeight(0.01),
                    Padding(
                      padding: EdgeInsets.only(
                        left: mediaquerywidth(0.03, context),
                        right: mediaquerywidth(0.03, context),
                        top: mediaquerywidth(0.02, context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              text: bookingList.userName,
                              fontFamily: CustomFonts.roboto,
                              size: 0.037,
                              color: AppColors.blackColor),
                          CustomText(
                              text: bookingList.date,
                              fontFamily: CustomFonts.roboto,
                              size: 0.037,
                              color: AppColors.blackColor),
                        ],
                      ),
                    ),
                    const Divider(endIndent: 20, indent: 20),
                    Padding(
                      padding: EdgeInsets.only(
                        left: mediaquerywidth(0.03, context),
                        right: mediaquerywidth(0.03, context),
                        bottom: mediaquerywidth(0.01, context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              weight: FontWeight.w600,
                              text: bookingList.services,
                              fontFamily: CustomFonts.roboto,
                              size: 0.04,
                              color: AppColors.blackColor),
                          DownloadPDFIcon(
                            pdfUrl:
                                '${APIConstants.baseImageUrl}${bookingList.ticket}',
                          )
                          // GradientIcon(
                          //     Icons.file_download_outlined,
                          //     mediaquerywidth(0.07, context),
                          //     const LinearGradient(https://gofriendsgo.certumventures.in/storage/
                          //         colors: AppColors.gradientColors)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  String _formatDateString(String dateTimeString) {
    // Parse the input string to a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the DateTime object to the desired string format
    String formattedDate = DateFormat('dd-MMM-yyyy').format(dateTime);

    return formattedDate;
  }
}

class DownloadPDFIcon extends StatelessWidget {
  final String pdfUrl;

  const DownloadPDFIcon({super.key, required this.pdfUrl});

  Future<void> downloadAndOpenPdf(BuildContext context) async {
    try {
      final dio = Dio();
      final directory = Directory(
          '/storage/emulated/0/Download/'); // Get app-specific directory
      final filePath =
          '${directory.path}/${pdfUrl.split('/').last.split('.').first}.${pdfUrl.split('.').last}';
      // Show a loading indicator while downloading
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Downloading the file
      log("pdfUrl------->$pdfUrl");
      final response = await dio.download(pdfUrl, filePath);

      // Dismiss the loading indicator
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        // Open the file using OpenFile package
        await OpenFilex.open(filePath);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to download the file')),
        );
      }
    } catch (e) {
      Navigator.of(context)
          .pop(); // Dismiss the loading indicator in case of error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => downloadAndOpenPdf(context), // Trigger download on tap
      child: GradientIcon(
        Icons.file_download_outlined,
        mediaquerywidth(0.07, context),
        const LinearGradient(
          colors: AppColors.gradientColors,
        ),
      ),
    );
  }
}
