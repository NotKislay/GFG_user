import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:gofriendsgo/model/chat_models/fetch_messages_model.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../services/api/app_apis.dart';

class DisplayImageAttachment extends StatelessWidget {
  final MessageAttachment file;
  final String? dateTime;
  final String? senderName;
  final String? message;

  const DisplayImageAttachment(
      {super.key,
      required this.file,
      required this.dateTime,
      required this.senderName,
      this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (senderName != null)
                Text(
                  senderName!,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              Row(
                children: [
                  if (dateTime != null)
                    Text(
                      formatDate(dateTime!),
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                ],
              ),
            ],
          ),
          actions: [
            !fileExits(file.oldName!.split('/').last)
                ? IconButton(
                    alignment: Alignment.bottomCenter,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Downloading Image..."),
                        duration: Duration(seconds: 1),
                      ));
                      downloadImage(file, onDownloaded: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "Image has been downloaded to downloads folder!"),
                          duration: Duration(seconds: 1),
                        ));
                        navigator?.pop();
                      });
                    },
                    icon: SvgPicture.asset(
                      height: 35,
                      width: 35,
                      AppImages.iconDownloadFlat,
                      color: Colors.white,
                    ),
                  )
                : SizedBox(),
          ],
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                navigator?.pop();
              },
              icon: const Icon(
                size: 25,
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Stack(children: [
              Image.network(
                width: double.infinity,
                height: double.infinity,
                "${APIConstants.baseImageUrl}${senderName == null ? "" : "attachments/"}${file.newName ?? "no_image"}",
                fit: BoxFit.contain,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  //log("Tried to load ");
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, e, r) {
                  return Image.asset(
                    AppImages.goFriendsGoLogoMax,
                    fit: BoxFit.cover,
                  );
                },
              ),
              (message != null && message!.isNotEmpty)
                  ? Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        // Add padding for better appearance
                        color: Color(0xff93272121),
                        child: Text(
                          message!,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center, // Center-align the text
                        ),
                      ),
                    )
                  : SizedBox()
            ])));
  }

  String formatDate(String inputDate) {
    final now = DateTime.now();
    final inputDateTime = DateFormat('dd-MM-yyyy hh:mm a').parse(inputDate);

    final inputDateOnly =
        DateTime(inputDateTime.year, inputDateTime.month, inputDateTime.day);
    final todayDateOnly = DateTime(now.year, now.month, now.day);
    final yesterdayDateOnly = todayDateOnly.subtract(Duration(days: 1));

    if (inputDateOnly == todayDateOnly) {
      return "Today, ${DateFormat('hh:mm a').format(inputDateTime)}";
    } else if (inputDateOnly == yesterdayDateOnly) {
      return "Yesterday, ${DateFormat('hh:mm a').format(inputDateTime)}";
    } else if (inputDateOnly.year == now.year) {
      return "${DateFormat('d MMMM').format(inputDateTime)}, ${DateFormat('hh:mm a').format(inputDateTime)}";
    } else {
      return "${DateFormat('dd/MM/yy').format(inputDateTime)}, ${DateFormat('hh:mm a').format(inputDateTime)}";
    }
  }

  bool fileExits(String fileName) {
    final file = File('/storage/emulated/0/Download/$fileName');
    return file.existsSync();
  }

  downloadImage(MessageAttachment attachment,
      {required void Function() onDownloaded}) async {
    final dio = Dio();
    final savePath =
        '/storage/emulated/0/Download/${file.oldName?.split('/').last}';
    await dio.download(
      "${APIConstants.baseImageUrl}${senderName == null ? "" : "attachments/"}${file.newName ?? "no_image"}",
      savePath,
      onReceiveProgress: (received, total) async {
        if (total != -1) {
          print(
              "Download Progress: ${(received / total * 100).toStringAsFixed(0)}%");
        }
        if (total != -1 && (received == total)) {
          onDownloaded();
        }
      },
    );
  }
}
