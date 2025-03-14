import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../services/api/app_apis.dart';
import '../../utils/constants/paths.dart';

Future<Uint8List?> getVideoThumbnail(String videoUrl) async {
  log("Generating thumbnail for video URL: $videoUrl");

  try {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128, // specify the size of the thumbnail
      quality: 75,
    );
    if (thumbnail == null) {
      log("Thumbnail generation returned null. Check the video URL or format.");
    }
    _saveThumbnail(thumbnail, getFileNameFromUrl(videoUrl));
    return thumbnail;
  } catch (e) {
    log("Error generating thumbnail: $e");
    return null;
  }
}

String getFileNameFromUrl(String url) {
  return (url.split('/').last).split('.')[0];
}

Future<void> _saveThumbnail(Uint8List? thumbnailData, String fileName) async {
  if (thumbnailData == null) {
    return;
  }
  final cacheDir = Directory.systemTemp;
  final String filePath = '${cacheDir.path}/$fileName.jpg';

  final File thumbnailFile = File(filePath);
  await thumbnailFile.writeAsBytes(thumbnailData);

  log("~~~~Thumbnail File saved at $filePath");
}

File? _getSavedThumbnail(String fileName) {
  final cacheDir = Directory.systemTemp;
  final String filePath = '${cacheDir.path}/$fileName.jpg';
  log("~~~~Getting from cache............");
  File file = File(filePath);
  if (file.existsSync()) {
    return file;
  } else {
    return null;
  }
}

Widget createImageThumbnail({required String imageUrl}) {
  return Image.network(
    APIConstants.baseImageUrl + imageUrl,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return Image.asset(AppImages.goFriendsGoLogoMini);
    },
  );
}

Widget createVideoThumbnailFromStorage({required String videoUrl}) {
  final fileName = getFileNameFromUrl(videoUrl);
  var widgetOrNull = _getSavedThumbnail(fileName);

  if (widgetOrNull == null) {
    final x = getVideoThumbnail(videoUrl);
    widgetOrNull = _getSavedThumbnail(fileName);
  }
  return widgetOrNull == null
      ? Image.asset(AppImages.goFriendsGoLogoMini)
      : Image.file(
          width: 20.0,
          height: 20.0,
          widgetOrNull,
          fit: BoxFit.cover,
        );
}
