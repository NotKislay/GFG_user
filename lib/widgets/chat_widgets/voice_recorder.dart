import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/view_model/chats/audio_view_model.dart';
import 'package:gofriendsgo/widgets/chat_widgets/utils.dart';
import 'package:provider/provider.dart';

import '../../utils/color_theme/colors.dart';
import '../../utils/constants/mediaquery.dart';

class VoiceRecorder extends StatefulWidget {
  final void Function(String) onSendAudio;

  const VoiceRecorder({super.key, required this.onSendAudio});

  @override
  State<VoiceRecorder> createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder> {
  late final AudioViewModel audioVM;
  bool isMicTapped = false;

  Timer? timer;
  int currentTime = 0;

  @override
  void initState() {
    audioVM = Provider.of<AudioViewModel>(context, listen: false);
    super.initState();
  }

  void startTimer() {
    if (timer?.isActive ?? false) {
      return;
    }
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        currentTime++;
      });
    });
  }

  void stopTimer() {
    if (timer?.isActive ?? false) {
      timer?.cancel();
      setState(() {
        currentTime = 0;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        width: mediaquerywidth(1, context),
        height: mediaqueryheight(0.2, context),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300]),
                child: isMicTapped
                    ? Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 10,
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  currentTime.toTime(),
                                  style: TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    : Consumer<AudioViewModel>(
                        builder: (context, audioVm, child) {
                        return audioVm.pathOfRecordedAudio.isNotEmpty
                            ? Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey,
                                        shape: BoxShape.rectangle),
                                    padding: EdgeInsets.all(10.0),
                                    child: Flexible(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Voice note ${audioVm.pathOfRecordedAudio.split('/').last} attached!"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Tap to record your voice",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                ),
                              );
                      }),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Color(0xffe0ecef),
                      onPressed: () {
                        if (isMicTapped) {
                          audioVM.cancelRecoding();
                        } else {
                          audioVM.cancelRecoding();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              isMicTapped
                                  ? Icons.restart_alt_rounded
                                  : Icons.close,
                              color: AppColors.gradientColors.first,
                            ),
                            Text(isMicTapped ? "Restart" : "Cancel")
                          ],
                        ),
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: isMicTapped
                          ? Colors.redAccent
                          : AppColors.gradientColors.last,
                      onPressed: audioVM.pathOfRecordedAudio.isNotEmpty
                          ? null
                          : () async {
                              setState(() {
                                isMicTapped = !isMicTapped;
                                if (isMicTapped) {
                                  audioVM.startRecording();
                                  startTimer();
                                } else {
                                  log("Should cancel timer");
                                  audioVM.stopRecoding();
                                  stopTimer();
                                }
                              });
                              log("New val: $isMicTapped");
                            },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                isMicTapped
                                    ? Icons.stop
                                    : Icons.mic_none_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Color(0xffe0ecef),
                      onPressed: () {
                        widget.onSendAudio(audioVM.pathOfRecordedAudio);
                        audioVM.pathOfRecordedAudio = "";
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.send,
                              color: AppColors.gradientColors.first,
                            ),
                            Text("Send")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
