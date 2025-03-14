import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/api_level.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/permission_helper.dart';
import 'package:gofriendsgo/widgets/chat_widgets/gradient_icon.dart';
import 'package:gofriendsgo/widgets/chat_widgets/utils.dart';
import 'package:gofriendsgo/widgets/chat_widgets/voice_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../view/chat_screen/utils/preview_attachment.dart';

class ChatField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Icon? icon;
  final Icon? prefixIcon;
  final void Function(String, String?)? onFileReceived;
  final void Function()? onTextChange;
  final void Function()? onMicTapped;

  const ChatField(
      {this.controller,
      super.key,
      this.label,
      required this.hintText,
      this.keyboardType,
      this.validator,
      this.icon,
      this.prefixIcon,
      this.onFileReceived,
      this.onMicTapped,
      this.onTextChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(52),
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(54, 38, 8, 37)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: (_) {
                onTextChange!();
              },
              style: const TextStyle(color: Colors.black),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              validator: validator,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(52)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(52),
                    borderSide: BorderSide.none),
                labelText: label,
                hintText: hintText,
                prefixIcon: prefixIcon,
                suffixIcon: icon,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 183, 177, 177)),
                labelStyle: const TextStyle(color: Colors.black),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(52)),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              minLines: 1,
              scrollController: ScrollController(),
            ),
          ),
          IconButton(
            icon: GradientIcon(
              icon: Icons.attach_file,
              size: mediaquerywidth(0.06, context),
              gradient: const LinearGradient(
                  colors: AppColors.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            onPressed: () {
              showAttachmentOptions(context, (data, message) {
                onFileReceived!(data, message);
              });
              // Handle attach file action
            },
          ),
          IconButton(
            icon: GradientIcon(
              icon: Icons.mic_none_rounded,
              size: mediaquerywidth(0.06, context),
              gradient: const LinearGradient(
                  colors: AppColors.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            onPressed: () {
              showMicDialog(context, (filePath) {
                onFileReceived!(filePath, "");
              });
              //onMicTapped!();
            },
          )
        ],
      ),
    );
  }
}

void showMicDialog(
    BuildContext context, void Function(String) audioFileAttached) {
  showDialog(
      context: context,
      builder: (context) {
        return VoiceRecorder(
          onSendAudio: (audioPath) {
            audioFileAttached(audioPath);
          },
        );
      });
}

void showAttachmentOptions(
    BuildContext context, Function(String, String?) onFilePicked) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.only(bottom: mediaqueryheight(0.13, context)),
        alignment: Alignment.bottomCenter,
        backgroundColor: AppColors.blackColor,
        contentPadding: EdgeInsets.zero,
        content: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: mediaqueryheight(0.07, context)),
              child: SizedBox(
                width: mediaquerywidth(0.9, context),
                height: mediaqueryheight(0.14, context),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    _buildGridOption(
                      context,
                      CupertinoIcons.doc_text_fill,
                      'Document',
                      const Color.fromARGB(255, 61, 18, 181),
                      () async {
                        if (await PermissionHelper.checkPermission(
                                permission: Permission.storage) ||
                            await PermissionHelper.checkPermission(
                                permission: Permission.manageExternalStorage)) {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: supportedFiles);
                          if (result == null) {
                            print("No file selected");
                          } else {
                            for (var element in result.files) {
                              print("My file = ${element.path}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PreviewAttachment(
                                    file: File(element.path.toString()),
                                    onConfirm: (String message, File file) {
                                      onFilePicked(element.path!, message);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              );
                              //onFilePicked(element, "");
                            }
                          }
                        } else {
                          await PermissionHelper.requestPermission(
                              permission: Permission.storage);
                          await PermissionHelper.requestPermission(
                              permission: Permission.manageExternalStorage);
                        }
                      },
                    ),
                    _buildGridOption(
                      context,
                      Icons.photo,
                      'Gallery',
                      Colors.pink,
                      () async {
                        if (await PermissionHelper.checkPermission(
                                permission: Permission.photos) ||
                            await PermissionHelper.checkPermission(
                                permission: Permission.storage)) {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                'png',
                                'gif',
                                'jpg',
                                'jpeg',
                                'png',
                              ]);
                          if (result == null) {
                            print("No file selected");
                          } else {
                            for (var element in result.files) {
                              print("My file = ${element.path}");
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PreviewAttachment(
                                    file: File(element.path.toString()),
                                    onConfirm: (String message, File file) {
                                      onFilePicked(element.path!, message);
                                    },
                                  ),
                                ),
                              );
                            }
                          }
                        } else {
                          await PermissionHelper.requestPermission(
                              permission: Permission.photos);
                          await PermissionHelper.requestPermission(
                              permission: Permission.storage);
                        }
                      },
                    ),
                    _buildGridOption(
                      context,
                      Icons.camera_alt_outlined,
                      'Camera',
                      Colors.pink,
                      () async {
                        //camera logic
                        final int apiLevel = await ApiLevel.get();
                        final isAndroid = Platform.isAndroid;
                        if (!await PermissionHelper.checkPermission(
                            permission: Permission.camera)) {
                          log("Camera not grated, asking");
                          await PermissionHelper.requestPermission(
                              permission: Permission.camera);
                        } else if ((isAndroid && apiLevel >= 30) &&
                            !await PermissionHelper.checkPermission(
                                permission: Permission.manageExternalStorage)) {
                          await PermissionHelper.requestPermission(
                              permission: Permission.manageExternalStorage);
                        } else {
                          final picker = ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.camera);
                          if (pickedFile != null) {
                            String fileName =
                                'IMG_${DateTime.now().millisecondsSinceEpoch}.jpg';
                            String newPath =
                                '/storage/emulated/0/Download/$fileName';

                            await pickedFile.saveTo(newPath);
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PreviewAttachment(
                                  file: File(newPath),
                                  onConfirm: (String message, File file) {
                                    onFilePicked(newPath, message);
                                  },
                                ),
                              ),
                            );
                            /*File savedImage =
                                await File(pickedFile.path).copy(newPath);*/
                            log("SAVED IMAGE IS :${newPath}");
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 5,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop(); // Closes the dialog
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildGridOption(BuildContext context, IconData icon, String label,
    Color color, Function()? ontap) {
  return InkWell(
    //onTap: ontap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Icon(icon, color: Colors.white, size: 30.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
