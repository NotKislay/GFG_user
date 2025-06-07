import 'dart:io';
import 'dart:math';

import 'package:gofriendsgo/model/chat_models/fetch_messages_model.dart';
import 'package:gofriendsgo/utils/constants/chats/downloads_path.dart';
import 'package:path_provider/path_provider.dart';

import '../app_strings.dart';

extension MessageFilter on List<MessageData> {
  List<MessageData> distinct() {
    final seenIds = <String>{};
    return where((message) {
      if (message.type == TextStrings.fakeDate) return true;
      if (seenIds.contains(message.id)) {
        return false;
      } else {
        if (message.id != null) seenIds.add(message.id!);
        return true;
      }
    }).toList();
  }
}

extension CheckFileExistsOrNot on String {
  bool doesFileExistsInDownloads() {
    final downloadsPath = DownloadsPath.path;
    if (downloadsPath == null) return false;
    final path = downloadsPath + this;
    final file = File(path);
    final exists = file.existsSync();
    return exists;
  }
}

extension TimeConvertor on int {
  String toTime() {
    final minutes = this / 60;
    final seconds = this % 60;
    final minString = (minutes >= 0 && minutes <= 9)
        ? "0${minutes.toStringAsFixed(0)}"
        : minutes.toStringAsFixed(0);
    String secString = "";
    if (seconds >= 0 && seconds <= 9) {
      secString = "0${seconds.toStringAsFixed(0)}";
    } else {
      secString = seconds.toString();
    }
    return "$minString:$secString";
  }
}

extension FileOperations on File {
  String getFileSize() {
    int bytes = this.lengthSync();

    if (bytes <= 0) return "0 B";
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = (log(bytes) / log(1024)).floor();

    return '${((bytes / pow(1024, i))).toStringAsFixed(1)} ${suffixes[i]}';
  }
}

const supportedFiles = [
  'pdf',
  /*'doc',*/
  'docx',
  'zip',
  'rar',
  /*'txt',*/
  'xls',
  'ppt',
  'pptx',
  'xlsx',
  'csv'
];

extension FileExtensionValidator on String {
  bool isFileAllowed() {
    final ext = this.split('.').last;
    return supportedFiles.contains(ext);
  }
}

const fileOpenerAllowedExtensions = {
  ".pdf": "application/pdf",
  ".doc": "application/msword",
  ".docx":
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
  ".txt": "text/plain",
  ".xls": "com.microsoft.excel.xls",
  ".ppt": "com.microsoft.powerpoint.ppt",
  ".pptx":
      "application/vnd.openxmlformats-officedocument.presentationml.presentation",
  ".xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  ".csv": "application/vnd.ms-excel"
};
