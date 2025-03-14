import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gofriendsgo/model/chat_models/fetch_messages_model.dart';
import 'package:gofriendsgo/view/chat_screen/utils/get_attachment_image.dart';
import 'package:gofriendsgo/view_model/chats/create_chat_viewmodel.dart';
import 'package:gofriendsgo/widgets/chat_widgets/utils.dart';
import 'package:image/image.dart' as img;
import 'package:pdfx/pdfx.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/constants/paths.dart';
import '../../../utils/constants/permission_helper.dart';

class ChatDocumentPreview extends StatefulWidget {
  final bool isIncoming;
  final MessageAttachment attachment;
  final void Function() onDownloaded;
  final void Function() onOpen;

  const ChatDocumentPreview(
      {super.key,
      required Key keys,
      required this.isIncoming,
      required this.attachment,
      required this.onOpen,
      required this.onDownloaded});

  @override
  State<ChatDocumentPreview> createState() => _ChatDocumentPreviewState();
}

//ATTACHMENT AFTER MESSAGE SENT
class _ChatDocumentPreviewState extends State<ChatDocumentPreview> {
  late final String filename;
  final CreateChatViewModel chatVM = CreateChatViewModel();
  var isDownloaded = false;

  @override
  void initState() {
    filename = widget.attachment.oldName!;
    isDownloaded = widget.attachment.isDownloaded == null
        ? false
        : widget.attachment.isDownloaded!;

    isDownloaded = widget.attachment.oldName!.doesFileExistsInDownloads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Image?>(
        future: getPDFCoverPage(widget.attachment),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data == null) {
            log("Errr for $filename and ${widget.attachment.fileSize}");
            return GestureDetector(
              onTap: () {
                downloadFile(widget.attachment);
              },
              child: Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.4,
                ),
                decoration: BoxDecoration(
                  color:
                      widget.isIncoming ? Color(0xFFC4C4C4) : Color(0xFF5184FD),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Fixed-width image
                      Image.asset(
                        filename.getAttachmentImage(),
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 8), // Spacing between image and text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // First line of text
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.sizeOf(context).width * 0.41),
                              child: Text(
                                filename,
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                                style: TextStyle(
                                    color: widget.isIncoming
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                            SizedBox(height: 4), // Spacing between lines
                            // Second line of text with dynamic width
                            Text(
                              "${widget.attachment.pages != null ? "${widget.attachment.pages} •" : ""} ${widget.attachment.oldName?.split('.').last.toUpperCase()} ${widget.attachment.fileSize != null ? "• ${widget.attachment.fileSize}" : ""}",
                              style: TextStyle(
                                color: widget.isIncoming
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: !isDownloaded,
                          child: IconButton(
                              onPressed: () {
                                downloadFile(widget.attachment);
                              },
                              icon: SvgPicture.asset(
                                AppImages.iconDownloadRound,
                                width: 40,
                                height: 40,
                              )))
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading PDF: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                downloadFile(widget.attachment);
              },
              child: Container(
                decoration: BoxDecoration(
                  color:
                      widget.isIncoming ? Color(0xFFC4C4C4) : Color(0xFF5184FD),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image(
                          image: snapshot.data!.image,
                          fit: BoxFit.cover,
                          width: 220,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 7),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 220),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth:
                                              MediaQuery.sizeOf(context).width *
                                                  0.41),
                                      child: Text(
                                        filename,
                                        overflow: TextOverflow.clip,
                                        // Ensures text truncates
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: widget.isIncoming
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                    ),
                                    Text(
                                      "${widget.attachment.pages != null ? "${widget.attachment.pages} •" : ""} ${widget.attachment.oldName?.split('.').last.toUpperCase()} ${widget.attachment.fileSize != null ? "• ${widget.attachment.fileSize}" : ""}",
                                      style: TextStyle(
                                          color: widget.isIncoming
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                  visible:
                                      widget.attachment.isDownloaded == null
                                          ? false
                                          : !widget.attachment.isDownloaded!,
                                  child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        downloadFile(widget.attachment);
                                      },
                                      icon: SvgPicture.asset(
                                        AppImages.iconDownloadRound,
                                        width: 40,
                                        height: 40,
                                      )))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text("No Image"));
          }
        });
  }

  Future<Image?> getPDFCoverPage(MessageAttachment attachment) async {
    final fileName = attachment.oldName!;
    final filePath = await chatVM.getFileDownloadPath(fileName);
    var pdfDoc = File(filePath!);

    late PdfDocument? document = null;

    if (!await PermissionHelper.checkPermission(
        permission: Permission.manageExternalStorage)) {
      await PermissionHelper.requestPermission(permission: Permission.storage);
      await PermissionHelper.requestPermission(
          permission: Permission.manageExternalStorage);

      if (!await PermissionHelper.checkPermission(
          permission: Permission.manageExternalStorage)) {
        return null;
      }
    } else {
      final result = await doesFileExistsInDownloads(fileName);
      if (!result) {
        chatVM.doesFileExists = result;
        return null;
      }
      document = await PdfDocument.openFile(pdfDoc.path.toString());
    }
    //need to call this so that we will get the size of PDF

    attachment.pages = "${document?.pagesCount} pages";
    log("Pages count: ${chatVM.docAttachmentPages}");

    final page = await document!.getPage(1);

    final pageWidth = page.width;
    final pageHeight = page.height;

    final pageImage = await page.render(
        width: pageWidth,
        height: pageHeight,
        format: PdfPageImageFormat.jpeg,
        backgroundColor: '#ffffff');

    final croppedHeight = (pageHeight * 0.4).toInt();
    final fullImage = img.decodeImage(pageImage!.bytes);
    if (fullImage == null) {
      log("Full image error ");
    } else {}

    final croppedImage = img.copyCrop(fullImage!,
        x: 0, y: 0, width: fullImage.width, height: croppedHeight);
    final croppedImageBytes = img.encodeJpg(croppedImage);

    return Image.memory(Uint8List.fromList(croppedImageBytes));
  }

  Future<bool> doesFileExistsInDownloads(String fileName) async {
    var path = await chatVM.getFileDownloadPath(fileName);
    var file = File(path!);
    chatVM.doesFileExists = await file.exists();
    if (!chatVM.doesFileExists) return await file.exists();
    final size = file.lengthSync();
    double sizeInMB = size / (1000 * 1000);
    double sizeInKB = sizeInMB * 1000;

    double sizeInMBRounded = double.parse(sizeInMB.toStringAsFixed(2));
    double sizeInKBRounded = double.parse(sizeInKB.toStringAsFixed(2));

    chatVM.docAttachmentSize =
        sizeInMB > 1 ? "$sizeInMBRounded MB" : "$sizeInKBRounded kB";

    log("Checking file existence at: ${file.path} and nad ${await file.exists()}");
    return await file.exists();
  }

  void downloadFile(MessageAttachment attachment) {
    log("ON DOWNLOAD REQUEST for ${widget.attachment.oldName} and isAvailable: ${isDownloaded}");
    if (isDownloaded) {
      //open call
      widget.onOpen();
    } else {
      //download call
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Downloading file......"),
          duration: Duration(seconds: 1),
        ),
      );

      chatVM.downloadOrOpenFile(
        attachment,
        attachment.oldName!,
        onDownloaded: () async {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("File downloaded to downloads folder!"),
              duration: Duration(seconds: 1),
            ),
          );
          setState(() {
            log("HO GYA");
            isDownloaded = true;
          });
        },
        onOpenError: (error) async {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error),
            duration: Duration(seconds: 1),
          ));
          widget.onOpen();
        },
      );
    }
  }
}
