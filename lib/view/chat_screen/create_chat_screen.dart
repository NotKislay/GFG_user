// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gofriendsgo/model/chat_models/fetch_messages_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/permission_helper.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/chat_screen/utils/chat_attachment.dart';
import 'package:gofriendsgo/view/chat_screen/utils/display_image_attachment.dart';
import 'package:gofriendsgo/view/chat_screen/utils/formatted_text.dart';
import 'package:gofriendsgo/view_model/chats/create_chat_viewmodel.dart';
import 'package:gofriendsgo/view_model/profile_viewmodel.dart';
import 'package:gofriendsgo/widgets/chat_widgets/chat_field.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../utils/constants/app_strings.dart';

class CreateChatScreen extends StatefulWidget {
  final String serviceName;
  final String? image;
  final String id;

  const CreateChatScreen(
      {super.key, required this.serviceName, this.image, required this.id});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<CreateChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late final CreateChatViewModel chatVM;
  final _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  late PlatformFile file;
  Timer? _checkTypingTimer;
  bool isSearchClicked = false;
  int highlightedIndex = -1;
  List<int> searchedIndexes = [];
  late final String downloadDirPath;

  //var showTyping = false;

  @override
  void initState() {
    super.initState();
    setPath();
    log("CALLED For ${widget.serviceName}");
    log("CALLED For service_id-->${widget.id}");
    chatVM = Provider.of<CreateChatViewModel>(context, listen: false);
    chatVM.serviceName = widget.serviceName;
    chatVM.service_Id = widget.id;
    context.read<ProfileViewModel>().fetchProfile();

    chatVM.createChat().then((_) {
      chatVM.fetchAllMessages();
    }); //creating chat
    chatVM.onNewMessages = _scrollToBottom;
    chatVM.onFetchMessagesError = _showErrorSnackBar;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    chatVM.noMessageFound = () {
      _showErrorSnackBar("No messages found");
    };
    chatVM.messageFound = (indexList) {
      searchedIndexes = indexList;
      highlightedIndex = indexList.last;
      if (highlightedIndex == -1) return;
      _scrollController.scrollTo(
        index: highlightedIndex * 50,
        duration: Duration(
            milliseconds:
                1), /*duration: Duration(milliseconds: 1), curve: Curves.linear*/
      );
    };
    //isAtBottom();
  }

  void setPath() async {
    final directory = await getDownloadsDirectory();
    downloadDirPath = directory?.path ?? '';
  }

  void startTimer() {
    _checkTypingTimer = Timer(const Duration(milliseconds: 700), () {
      chatVM.sendTypingEvent();
    });
  }

  void resetTimer() {
    _checkTypingTimer?.cancel();
    startTimer();
  }

  void _showErrorSnackBar(String? message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message!),
      duration: Duration(milliseconds: 1500),
    ));
  }

  void _scrollToBottom() {
    if (chatVM.scrollController.isAttached && mounted) {
      if (chatVM.messages.length - 1 < 0) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.scrollTo(
          index: chatVM.messages.length - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } else {
      //log("no clients");
      Future.delayed(Duration(milliseconds: 2), () {
        _scrollToBottom();
      });
    }
  }

  @override
  void dispose() {
    chatVM.messages.clear();
    chatVM.resetOnClose();
    chatVM.setAttachedFile(null);
    //_scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          leading: IconButton(
            onPressed: () {
              if (isSearchClicked) {
                setState(() {
                  isSearchClicked = !isSearchClicked;
                  chatVM.searchController.clear();
                });
              } else {
                PageNavigations().pop();
              }
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          title: isSearchClicked
              ? Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onSubmitted: (searchedString) {
                          log("Searched string was : $searchedString");
                          chatVM.searchAndScroll(searchedString);
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        cursorColor: Colors.white,
                        controller: chatVM.searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.white)),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (highlightedIndex - 1 >= 0) {
                            highlightedIndex -= 1;
                            if (mounted) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _scrollController.scrollTo(
                                  index: highlightedIndex * 50,
                                  duration: Duration(
                                      milliseconds:
                                          1), /*duration: Duration(milliseconds: 1), curve: Curves.linear*/
                                );
                              });
                            }
                          } else {
                            _showErrorSnackBar("No messages found");
                          }
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          if (highlightedIndex + 1 < searchedIndexes.length) {
                            highlightedIndex += 1;
                            if (mounted) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _scrollController.scrollTo(
                                  index: highlightedIndex * 50,
                                  duration: Duration(
                                      milliseconds:
                                          1), /*duration: Duration(milliseconds: 1), curve: Curves.linear*/
                                );
                              });
                            }
                          } else {
                            _showErrorSnackBar("No messages found");
                          }
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.white,
                        )),
                  ],
                )
              : Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.whiteColor,
                      ),
                      child: widget.image == null
                          ? Image.asset(AppImages.goFriendsGoLogoMini)
                          : ClipOval(
                              child: widget.image!
                                      .toLowerCase()
                                      .endsWith('.svg')
                                  ? SvgPicture.network(
                                      APIConstants.baseImageUrl + widget.image!,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.contain,
                                    )
                                  : Image.network(
                                      APIConstants.baseImageUrl + widget.image!,
                                      fit: BoxFit.cover,
                                      width: 40,
                                      height: 40,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                    ),
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomText(
                        weight: FontWeight.w600,
                        text: widget.serviceName,
                        fontFamily: CustomFonts.inter,
                        size: 0.045,
                        color: Colors.white)
                  ],
                ),
          flexibleSpace: Container(
              decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.gradientColors,
                begin: Alignment.centerRight,
                end: Alignment.centerLeft),
          )),
          actions: [
            /*!isSearchClicked
                ? IconButton(
                    onPressed: () {
                      */ /*setState(() {
                        isSearchClicked = true;
                      });*/ /*
                    },
                    icon: Icon(
                      Icons.search,
                      size: 28,
                      color: Colors.white,
                    ))
                : SizedBox()*/
          ],
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  color: Color(0xfff0f8ff),
                  child: StreamBuilder(
                      stream: chatVM.messageStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Stack(
                            children: [
                              Center(
                                child: Image.asset(
                                  AppImages.goFriendsGoLogoMax,
                                  opacity: const AlwaysStoppedAnimation(0.5),
                                  height: 250,
                                  width: 250,
                                ),
                              ),
                              const Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Welcome to ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Go",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0E2DE8)),
                                  ),
                                  Text(
                                    "friends",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFF3213C)),
                                  ),
                                  Text(
                                    " Go Pvt. Ltd.",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0E2DE8)),
                                  ),
                                ],
                              ))
                            ],
                          );
                        }
                        final messages = snapshot.data!;
                        final filteredMessages = messages.where((mes) {
                          return mes.type != TextStrings.messageTypeSystem;
                        }).toList();

                        return ScrollablePositionedList.builder(
                            itemScrollController: chatVM.scrollController,
                            itemPositionsListener: chatVM.itemPositionsListener,
                            itemCount: filteredMessages.length,
                            itemBuilder: (context, index) {
                              final message = filteredMessages[index];
                              if (message.type == TextStrings.fakeDate) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: Card(
                                    color: Color(0x952FF91C),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        message.updatedAt!,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final date = DateTime.parse(message.updatedAt!);
                              final attachment = message.attachment;
                              final formattedTimestamp =
                                  DateFormat('dd-MM-yyyy hh:mm a').format(date);
                              if (SharedPreferencesServices.userId ==
                                  message.fromId) {
                                return _buildOutgoingMessage(
                                    message.fromId.toString(),
                                    message.body!,
                                    formattedTimestamp,
                                    attachment,
                                    index == highlightedIndex);
                              } else {
                                return _buildIncomingMessage(
                                    message.fromId.toString(),
                                    message.body!,
                                    formattedTimestamp,
                                    attachment,
                                    index == highlightedIndex);
                              }
                            });
                      }),
                )),
                Consumer<CreateChatViewModel>(
                    builder: (context, chatVM, child) {
                  return Column(
                    children: [
                      Visibility(
                          visible: chatVM.showTyping,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: const Color(0xFF3120D8),
                              size: 35,
                            ),
                          )),
                    ],
                  );
                }),
                _buildMessageInput(context, (message) {
                  _messageController.clear();
                  chatVM.sendMessage(message);
                }, (attachedFile) {
                  chatVM.setAttachedFile(attachedFile);
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> PreviewAttachment(file: File(attachedFile.path.toString()))));
                }),
              ],
            ),
            ValueListenableBuilder(
                valueListenable: chatVM.isAtBottom,
                builder: (context, isBelow, child) {
                  return !isBelow
                      ? Positioned(
                          right: 15,
                          bottom: 100,
                          child: MaterialButton(
                            elevation: 20,
                            color: Colors.white,
                            onPressed: () {
                              _scrollToBottom();
                            },
                            shape: CircleBorder(),
                            child: const Icon(
                                Icons.keyboard_double_arrow_down_rounded),
                          ),
                        )
                      : SizedBox();
                })
          ],
        ));
  }

  Widget _buildMessageInput(BuildContext context, Function(String) onSend,
      Function(String) onFileAttached) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: ChatField(
            controller: _messageController,
            hintText: 'Type your message',
            onFileReceived: (fileData, message) {
              chatVM.attachedFile = fileData;
              onFileAttached(fileData);
              onSend(message!);
            },
            onTextChange: () {
              resetTimer();
            },
          )),
          const CustomSizedBoxWidth(0.02),
          Container(
            width: mediaquerywidth(0.13, context),
            height: mediaqueryheight(0.06, context),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: AppColors.gradientColors)),
            child: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: AppColors.whiteColor,
                ),
                onPressed: () {
                  if (_messageController.text.isNotEmpty ||
                      chatVM.attachedFile != null) {
                    onSend(_messageController.text.trim());
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomingMessage(String name, String message, String time,
      MessageAttachment? attachment, bool? isSearchedMessage) {
    final parsedMessage = chatVM.decodeHtmlEntities(message);
    final date = DateFormat('dd-MM-yyyy hh:mm a').parse(time);
    final formattedTime = DateFormat('hh:mm a').format(date);

    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: IntrinsicWidth(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChatAttachment(
                        //keys: ValueKey(attachment?.newName),
                        attachment: attachment,
                        color: Colors.deepPurple,
                        onTapImage: () {
                          if (attachment != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DisplayImageAttachment(
                                        file: attachment,
                                        directoryPath: downloadDirPath,
                                        dateTime: time,
                                        senderName: 'Support',
                                        message: parsedMessage,
                                      )),
                            );
                          }
                        },
                        isIncoming: true),
                    Visibility(
                        visible: parsedMessage.isNotEmpty,
                        child: (isSearchedMessage != null && isSearchedMessage)
                            ? RichText(
                                text: TextSpan(
                                    children:
                                        parsedMessage.split(' ').map((mesg) {
                                return TextSpan(
                                  text: '$mesg ',
                                  style: TextStyle(
                                    height: 1.5,
                                    backgroundColor:
                                        chatVM.searchController.text == mesg
                                            ? Color(0xc8ffef00).withOpacity(0.6)
                                            : Colors.transparent,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                );
                              }).toList()))
                            : FormattedText.build(parsedMessage, Colors.black)),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(formattedTime,
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 12)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _buildOutgoingMessage(String name, String message, String time,
      MessageAttachment? attachment, bool? isSearchedMessage) {
    final parsedMessage = chatVM.decodeHtmlEntities(message);
    /*log("IN UI ${chatVM.makeSeen}");
    final date = DateFormat('dd-MM-yyyy hh:mm a').parse(time);
    final formattedTime = DateFormat('hh:mm a').format(date);*/
    return Column(children: [
      Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: AppColors.outgoingMessageGradient),
                shape: BoxShape.rectangle,
                color: Color(0xFF6391FF),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: IntrinsicWidth(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChatAttachment(
                        //keys: ValueKey(attachment?.newName),
                        attachment: attachment,
                        color: Colors.white,
                        onTapImage: () {
                          if (attachment != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DisplayImageAttachment(
                                        file: attachment,
                                        directoryPath: downloadDirPath,
                                        dateTime: time,
                                        senderName: 'You',
                                        message: parsedMessage,
                                      )),
                            );
                          }
                        },
                        isIncoming: false),
                    Visibility(
                        visible: parsedMessage.isNotEmpty,
                        child: (isSearchedMessage != null && isSearchedMessage)
                            ? RichText(
                                text: TextSpan(
                                    children:
                                        parsedMessage.split(' ').map((mesg) {
                                return TextSpan(
                                  text: '$mesg ',
                                  style: TextStyle(
                                    height: 1.5,
                                    backgroundColor:
                                        chatVM.searchController.text == mesg
                                            ? Colors.yellow
                                            : Colors.transparent,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                );
                              }).toList()))
                            : FormattedText.build(parsedMessage, Colors.white)),
                    Consumer<CreateChatViewModel>(
                        builder: (context, chatVM, child) {
                      final date = DateFormat('dd-MM-yyyy hh:mm a').parse(time);
                      final formattedTime = DateFormat('hh:mm a').format(date);

                      return Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(formattedTime,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SvgPicture.asset(
                                width: 20,
                                height: 20,
                                chatVM.makeSeen
                                    ? AppImages.doubleCheck
                                    : AppImages.singleCheck,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
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

  Future<Image?> getPDFCoverPage(MessageAttachment attachment) async {
    final fileName = attachment.oldName!;
    final filePath = await chatVM.getFileDownloadPath(fileName);
    var pdfDoc = File(filePath!);

    late PdfDocument? document = null;

    final result = await doesFileExistsInDownloads(fileName);
    if (!result) {
      chatVM.doesFileExists = result;
      return null;
    }
    document = await PdfDocument.openFile(pdfDoc.path.toString());

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

  bool isAtBottom() {
    setState(() {});
    final positions = _itemPositionsListener.itemPositions.value;
    if (chatVM.messages.isEmpty) return true;
    if (positions.isNotEmpty) {
      final lastVisibleIndex = positions.last.index;
      log("BBBBTTTT IF true");
      return lastVisibleIndex == chatVM.messages.length - 1;
    }
    log("BBBTTT IF false");
    return false;
  }
}
