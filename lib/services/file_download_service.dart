import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/constants/permission_helper.dart';

class FileDownloadService {
  /*Future<bool> doesFileExistsInDownloads(String path, String fileName) async {
    final file = File(path+fileName);
  }
  Future<void> downloadAttachment(String savePath) async {
    try {
      if (!await PermissionHelper.checkPermission(
          permission: Permission.manageExternalStorage)) {
        log("No Permission to open files");
        !await PermissionHelper.requestPermission(
            permission: Permission.manageExternalStorage);
        return;
      }

      Dio dio = Dio();
      if (await doesFileExistsInDownloads(savePath, attachment?.oldName ?? ".test")) {
        log("TRUE 12323");
        log("Path sent to open the file: $savePath");
        _openFile(savePath!);
      } else {
        log("SHOULD BE DOWNLOADED");
        await dio.download(
          "${API.baseImageUrl}attachments/${attachment?.newName ?? "no_image"}",
          savePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              print(
                  "Download Progress: ${(received / total * 100).toStringAsFixed(0)}%");
            }
          },
        );

        print("Download completed to $savePath");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("File downloaded to downloads folder"),
              duration: Duration(seconds: 2)),
        );
      }
    } catch (e) {
      print("Download failed: $e");
    }
  }*/
}
