import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioViewModel extends ChangeNotifier {
  final record = AudioRecorder();
  String pathOfRecordedAudio = "";

  Future<void> startRecording() async {
    //check perms
    if (!await checkPermission()) {
      //no permissions
      log("No recoding permission are there");
    } else {
      final savePath = await getSavePath() ?? "/";
      log("Staring recording ......... with path: $savePath");
      await record.start(const RecordConfig(), path: savePath);
    }
  }

  Future<String?> getSavePath() async {
    final dateTime = DateTime.timestamp().millisecondsSinceEpoch;
    final fileName = "AUD_${dateTime.toString()}.mp3";

    final docDir = await getApplicationDocumentsDirectory();

    if (docDir.existsSync()) {
      return "${docDir.path}/$fileName";
    } else {
      return null;
    }
  }

  Future<void> stopRecoding() async {
    if (await record.isRecording()) {
      final path = await record.stop();
      pathOfRecordedAudio = path ?? "";
      notifyListeners();
      log("Audio saved to: $path");
      record.dispose();
    } else {
      log("Not recording");
    }
  }

  Future<void> cancelRecoding() async {
    pathOfRecordedAudio = "";
    await record.cancel();
    record.dispose();
    notifyListeners();
  }

  Future<bool> checkPermission() async {
    return await record.hasPermission();
  }
}
