// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gofriendsgo/model/chat_models/chat_list_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/chat_consts.dart';
import 'package:gofriendsgo/utils/constants/custom_app_bar.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view/chat_screen/utils/chat_attachment.dart';
import 'package:gofriendsgo/view/chat_screen/utils/display_image_attachment.dart';
import 'package:gofriendsgo/view/chat_screen/utils/formatted_text.dart';
import 'package:gofriendsgo/view_model/chats/create_chat_viewmodel.dart';
import 'package:gofriendsgo/widgets/chat_widgets/chat_field.dart';
import 'package:gofriendsgo/widgets/chat_widgets/utils.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../model/chat_models/fetch_messages_model.dart';
import '../../services/shared_preferences.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/constants/paths.dart';

class ChatScreen extends StatefulWidget {
  final ChatData chatData;
  final String image;

  const ChatScreen({super.key, required this.chatData, required this.image});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late final CreateChatViewModel chatVM;

  Timer? _checkTypingTimer;
  ValueNotifier<bool> isSearchClicked = ValueNotifier(false);
  ValueNotifier<bool> showMessageField = ValueNotifier(true);
  int highlightedIndex = -1;
  List<int> searchedIndexes = [];

  final localBUCK = TextEditingController();
  static GlobalKey<FormState> searchKey = GlobalKey<FormState>();

  final _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  late FocusNode searchFocusNode;

  @override
  void initState() {
    searchFocusNode = FocusNode();
    chatVM = Provider.of<CreateChatViewModel>(context, listen: false);
    chatVM.chatId = widget.chatData.id;
    chatVM.initPusherAndFetchAll();
    chatVM.onNewMessages = _scrollToBottom;
    chatVM.onFetchMessagesError = _showErrorSnackBar;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    super.initState();
    chatVM.noMessageFound = () {
      _showErrorSnackBar("No messages found");
    };
    chatVM.messageFound = (indexList) {
      searchedIndexes = indexList;
      highlightedIndex = indexList.last;
      if (highlightedIndex == -1) {
        log("ye to null h");
        return;
      }

      chatVM.scrollController.scrollTo(
          index: highlightedIndex, duration: Duration(milliseconds: 1));
      /* _scrollController.scrollTo(
        index: highlightedIndex * 50,
        duration: Duration(
            milliseconds:
                1), /*duration: Duration(milliseconds: 1), curve: Curves.linear*/
      ); */
    };

    chatVM.observeChatScrolling();
    chatVM.observeDateScrolling();
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

  Future<void> _scrollToBottom() async {
    if (chatVM.scrollController.isAttached) {
      if (chatVM.messages.length - 1 < 0) return;
      chatVM.scrollController.scrollTo(
        index: chatVM.messages.length - 1,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeOut,
      );
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatVM.setAttachedFile(null);
    });
    chatVM.resetOnClose();
    searchFocusNode.dispose();
    //_scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          image: widget.image,
          title: widget.chatData.name,
          leading: Icon(Icons.arrow_back),
          chatVM: chatVM,
          onSearchClicked: () {
            showMessageField.value = !showMessageField.value;
          },
          onMoveUp: () {
            int prev = searchedIndexes.indexOf(highlightedIndex);
            log("New prev: $prev and full $searchedIndexes");
            if (mounted && prev > 0) {
              highlightedIndex = searchedIndexes[--prev];
              WidgetsBinding.instance.addPostFrameCallback((_) {
                chatVM.scrollController.jumpTo(index: highlightedIndex);
                /* _scrollController.scrollTo(
                    index: highlightedIndex * 50,
                    duration: Duration(
                        milliseconds:
                            1), /*duration: Duration(milliseconds: 1), curve: Curves.linear*/
                  ); */
              });
            } else {
              _showErrorSnackBar("No messages found");
            }
            if (prev > 0) prev--;
          },
          onMoveDown: () {
            int next = searchedIndexes.indexOf(highlightedIndex);
            next++;
            log("New next: $next and full $searchedIndexes");
            if (mounted && next < searchedIndexes.length) {
              highlightedIndex = searchedIndexes[next];
              WidgetsBinding.instance.addPostFrameCallback((_) {
                chatVM.scrollController.jumpTo(index: highlightedIndex);
              });
            } else {
              _showErrorSnackBar("No messages found");
            }
          },
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
                                ),
                              )
                            ],
                          );
                        }
                        //_scrollToBottom();
                        final messages = snapshot.data!;
                        var filteredMessages = messages.where((mes) {
                          return mes.type != TextStrings.messageTypeSystem;
                        }).toList();
                        
                        log("RAW list: ${filteredMessages.length}");
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
                                            color: Colors.black, fontSize: ChatConstants.floatingDayTextSize),
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
                                //log("CASE 1: $index and $highlightedIndex");
                                return _buildOutgoingMessage(
                                  message.fromId.toString(),
                                  message.body!,
                                  formattedTimestamp,
                                  attachment,
                                  index == highlightedIndex,
                                );
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
                ValueListenableBuilder(
                    valueListenable: showMessageField,
                    builder: (context, value, child) {
                      log("Message visi: $value");
                      return Visibility(
                          visible: value,
                          child: _buildMessageInput(context, (message) {
                            _messageController.clear();
                            chatVM.sendMessage(message);
                          }, (attachedFile) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              chatVM.setAttachedFile(attachedFile);
                            });
                          }));
                    }),
              ],
            ),
            Consumer<CreateChatViewModel>(builder: (context, value, child) {
              return Visibility(
                  visible: value.dateToFloat != null,
                  child: Positioned(
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Card(
                        color: Color(0x952FF91C),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            value.dateToFloat ?? "",
                            style: TextStyle(color: Colors.black, fontSize: ChatConstants.floatingDayTextSize),
                          ),
                        ),
                      ),
                    ),
                  ));
            }),
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
    //log("parsed: $parsedMessage");
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
                                        chatVM.searchController.text.toLowerCase() == mesg.toLowerCase()
                                            ? Color(0xc8ffef00).withOpacity(0.6)
                                            : Colors.transparent,
                                    fontSize: ChatConstants.messageTextSize,
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
                              style: const TextStyle(fontSize: ChatConstants.messaageTimeTextSize))),
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
    if (isSearchedMessage != null && isSearchedMessage) {
      log("Rebuild alert in outgoing $isSearchedMessage and ${message}");
    }
    final parsedMessage = chatVM.decodeHtmlEntities(message);
    //log("parsed out: ${parsedMessage}");
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
                                log("Currrrrr: ${mesg}");
                                return TextSpan(
                                  text: '$mesg ',
                                  style: TextStyle(
                                    height: 1.5,
                                    backgroundColor:
                                        chatVM.searchController.text.toLowerCase() == mesg.toLowerCase()
                                            ? Color(0xc8ffef00).withOpacity(0.6)
                                            : Colors.transparent,
                                    fontSize: ChatConstants.messageTextSize,
                                    color: Colors.white,
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
                                    fontSize: ChatConstants.messaageTimeTextSize, color: Colors.white)),
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
}
