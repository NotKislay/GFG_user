import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/chat_models/fetch_messages_model.dart';
import 'package:gofriendsgo/view/chat_screen/utils/voice_note_player.dart';
import 'package:provider/provider.dart';

import '../../../services/api/app_apis.dart';
import '../../../view_model/chats/create_chat_viewmodel.dart';
import 'chat_document_preview.dart';

class ChatAttachment extends StatefulWidget {
  final MessageAttachment? attachment;
  final Color color;
  final void Function() onTapImage;
  final bool isIncoming;

  const ChatAttachment(
      {super.key,
      //required Key keys,
      required this.attachment,
      required this.color,
      required this.onTapImage,
      required this.isIncoming});

  @override
  State<ChatAttachment> createState() => _ChatAttachmentState();
}

class _ChatAttachmentState extends State<ChatAttachment>
    with AutomaticKeepAliveClientMixin {
  late bool isImage;
  final CreateChatViewModel chatVM = CreateChatViewModel();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isImage = widget.attachment?.newName?.endsWith(".jpg") == true ||
        widget.attachment?.newName?.endsWith(".png") == true ||
        widget.attachment?.newName?.endsWith(".jpeg") == true;
    final isAudio = widget.attachment != null &&
        widget.attachment?.oldName?.endsWith(".mp3") == true;

    return isAudio
        ? IntrinsicWidth(
            child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: VoiceNotePlayer(
                    isIncoming: widget.isIncoming,
                    audioUrl:
                        "${APIConstants.baseImageUrl}attachments/${widget.attachment?.newName ?? "no_image"}"))) //audio player UI
        : Visibility(
            visible:
                widget.attachment != null && widget.attachment?.newName != null,
            child: IntrinsicWidth(
                child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: isImage
                  ? Material(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          widget.onTapImage();
                        },
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.65,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.4),
                          child: Image.network(
                            "${APIConstants.baseImageUrl}attachments/${widget.attachment?.newName ?? "no_image"}",
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        /*log("HON TAP");
                        if (widget.attachment?.isDownloaded == null ||
                            widget.attachment?.isDownloaded == false) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Downloading file......"),
                            duration: Duration(seconds: 1),
                          ));
                        }
                        chatVM.downloadOrOpenFile(
                            widget.attachment!, widget.attachment!.oldName!,
                            onDownloaded: () async {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("File downloaded to downloads folder!"),
                            duration: Duration(seconds: 1),
                          ));
                          widget.attachment?.isDownloaded =
                              await chatVM.doesFileExistsInDownloads(
                                  fileName: widget.attachment!.oldName!);
                          widget.attachment!.fileSize =
                              chatVM.docAttachmentSize;
                          log("New size given ${widget.attachment!.fileSize}");
                          chatVM.docAttachmentSize = null;
                          chatVM.updateAttachment(widget.attachment!);
                        }, onOpenError: (error) async {
                          final isDownloaded =
                              await chatVM.doesFileExistsInDownloads(
                            fileName: widget.attachment!.oldName!,
                          );
                          log("IZZEY: $isDownloaded");
                          final fileSize = chatVM.docAttachmentSize;
                          var attachment = widget.attachment;
                          attachment?.isDownloaded = isDownloaded;
                          attachment?.fileSize = fileSize;
                          if (attachment != null) {
                            chatVM.updateAttachment(attachment);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(error),
                            duration: Duration(seconds: 1),
                          ));
                        });*/
                      },
                      child: (widget.attachment == null ||
                              widget.attachment?.oldName == null)
                          ? SizedBox()
                          : ChatDocumentPreview(
                              keys: ValueKey(widget.attachment?.isDownloaded),
                              isIncoming: widget.isIncoming,
                              attachment: widget.attachment!,
                              onDownloaded: () async {
                                widget.attachment?.isDownloaded = true;
                                final chatVM =
                                    context.read<CreateChatViewModel>();
                                final isDownloaded =
                                    await chatVM.doesFileExistsInDownloads(
                                  fileName: widget.attachment!.oldName!,
                                );
                                final fileSize = chatVM.docAttachmentSize;
                                var attachment = widget.attachment;
                                attachment?.isDownloaded = isDownloaded;
                                attachment?.fileSize = fileSize;
                                if (attachment != null) {
                                  chatVM.updateAttachment(attachment);
                                }
                              },
                              onOpen: () {
                                widget.attachment?.isDownloaded = true;
                                chatVM.downloadOrOpenFile(
                                  widget.attachment!,
                                  widget.attachment!.oldName!,
                                  onDownloaded: () async {},
                                  onOpenError: (error) async {
                                    final isDownloaded =
                                        await chatVM.doesFileExistsInDownloads(
                                      fileName: widget.attachment!.oldName!,
                                    );

                                    widget.attachment?.isDownloaded = true;
                                    final fileSize = chatVM.docAttachmentSize;
                                    var attachment = widget.attachment;
                                    attachment?.isDownloaded = isDownloaded;
                                    attachment?.fileSize = fileSize;
                                    if (attachment != null) {
                                      chatVM.updateAttachment(attachment);
                                    }
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(error),
                                      duration: Duration(seconds: 1),
                                    ));
                                  },
                                );
                              },
                            )),
            )));
  }

  @override
  bool get wantKeepAlive => true;
}
