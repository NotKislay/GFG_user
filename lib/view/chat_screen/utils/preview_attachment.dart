import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofriendsgo/view/chat_screen/utils/get_attachment_image.dart';
import 'package:gofriendsgo/widgets/chat_widgets/utils.dart';
import 'package:pdfx/pdfx.dart';
import '../../../utils/color_theme/colors.dart';
import '../../../utils/constants/mediaquery.dart';
import '../../../utils/constants/sizedbox.dart';

class PreviewAttachment extends StatelessWidget {
  final File file;
  final void Function(String message, File file) onConfirm;

  PreviewAttachment({super.key, required this.file, required this.onConfirm});

  final TextEditingController _messageController = TextEditingController();

  //PREVIEW ATTACHMENT BEFORE SENDING
  @override
  Widget build(BuildContext context) {
    _messageController.text = file.path.split('/').last.replaceAll('.', ' ');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              navigator?.pop();
            },
            icon: const Icon(
              size: 35,
              Icons.close,
              color: Colors.white,
            )),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: file.path
                        .split('/')
                        .last
                        .isFileAllowed() //is File(Non-Image) allowed or not
                    ? FutureBuilder<Image>(
                        future: file.path.endsWith('.pdf')
                            ? renderPdfFirstPage(file)
                            : Future.error("Not a PDF"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            log("${snapshot.error}");
                            return Center(
                                child: _buildRenderError(context, file));
                          } else if (snapshot.hasData) {
                            return Center(child: snapshot.data!);
                          } else {
                            return Center(child: Text("No Image"));
                          }
                        })
                    : Image.file(
                        file,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(52),
                  color: Colors.grey[200],
                  border:
                      Border.all(color: const Color.fromARGB(54, 38, 8, 37)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (String data) {
                          _messageController.text = data;
                        },
                        style: const TextStyle(color: Colors.black),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _messageController,
                        validator: null,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(52)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(52),
                              borderSide: BorderSide.none),
                          labelText: null,
                          hintText: "Type your message",
                          prefixIcon: null,
                          suffixIcon: null,
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 183, 177, 177)),
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(52)),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const CustomSizedBoxWidth(0.02),
                    Container(
                      width: mediaquerywidth(0.13, context),
                      height: mediaqueryheight(0.06, context),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient:
                              LinearGradient(colors: AppColors.gradientColors)),
                      child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            onConfirm(_messageController.text, file);
                            navigator?.pop();
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRenderError(BuildContext context, File file) {
    final fileName = file.path.split('/').last;
    final fileSize = file.getFileSize();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          fileName.getAttachmentTypeImage(),
          width: 200,
          height: 200,
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              fileName,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              " • $fileSize",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          ],
        )
      ],
    );
  }

  Future<Image> renderPdfFirstPage(File pdf) async {
    final document = await PdfDocument.openFile(pdf.path.toString());

    final page = await document.getPage(1);

    final pageWidth = page.width;
    final pageHeight = page.height;

    final pageImage = await page.render(
        width: pageWidth,
        height: pageHeight,
        format: PdfPageImageFormat.jpeg,
        backgroundColor: '#ffffff');
    return Image.memory(pageImage!.bytes);
  }
}
