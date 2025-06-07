import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofriendsgo/model/chat_models/pusher_events_model.dart';
import 'package:gofriendsgo/services/chats/create_chat_service_API.dart';
import 'package:gofriendsgo/services/chats/fetch_messages_service.dart';
import 'package:gofriendsgo/services/chats/puhser_cu.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/widgets/chat_widgets/utils.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../model/chat_models/fetch_messages_model.dart';
import '../../services/api/app_apis.dart';
import '../../services/shared_preferences.dart';
import '../../utils/constants/permission_helper.dart';

class CreateChatViewModel extends ChangeNotifier {
  final ChatServiceAPI _chatService = ChatServiceAPI();
  final FetchMessagesService _fetchMessagesService = FetchMessagesService();
  final pusherService = PusherControlUnit();
  late int chatId;
  late int serviceId;
  var serviceName = "";
  var service_Id = "";
  final TextEditingController searchController = TextEditingController();
  String? attachedFile;
  VoidCallback? onNewMessages;
  Function(String?)? onFetchMessagesError;
  bool _showTyping = false;
  String? docAttachmentSize;
  String? docAttachmentPages;
  bool doesFileExists = false;
  String? dateToFloat;
  final List<String> dates = [];
  List<int> indexFound = [];

  //chat scrolling variables
  final ItemScrollController scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  ValueNotifier<bool> isAtBottom = ValueNotifier(true);

  bool get showTyping => _showTyping;

  set showTyping(bool value) {
    _showTyping = value;
    notifyListeners();
  }

  bool _makeSeen = false;

  bool get makeSeen => _makeSeen;

  set makeSeen(bool value) {
    _makeSeen = value;
    notifyListeners();
  }

  void setAttachedFile(String? data) {
    attachedFile = data;
    notifyListeners();
  }

  //pusher
  late final Function(PusherEvent?) onPusherEventReceived;
  late StreamController<dynamic> _eventController;
  late Stream<dynamic> eventsStream;

  final List<MessageData> _messages = [];
  final _messageStreamController =
      StreamController<List<MessageData>>.broadcast();
  Stream<List<MessageData>>? _messageStream;

  Stream<List<MessageData>>? get messageStream =>
      _messageStreamController.stream;

  List<MessageData> messages = [];

  Future<void> createChat() async {
    await _chatService
        .createChat(serviceName, SharedPreferencesServices.token!, service_Id)
        .then((chat) {
      chatId = chat.id;
      pusherService.channelName = "private-chatify.$chatId";
      pusherService.initializePusher(
          onPusherEventReceived: _onPusherEventReceived);
    });
    log("MY chat is $chatId ");
  }

  CreateChatViewModel() {
    _eventController = StreamController<dynamic>.broadcast();
    eventsStream = _eventController.stream;
  }

  Future<void> _onPusherEventReceived(PusherEvent? event) async {
    if (event != null) {
      if (event.eventName == TextStrings.eventClientTyp) {
        final parsed = jsonDecode(event.data!);
        if (parsed['to_id'] as String != chatId.toString()) {
          return;
        }
        showTyping = !showTyping;
        notifyListeners();
        Future.delayed(const Duration(milliseconds: 800), () {
          showTyping = !showTyping;
          notifyListeners();
        });
      } else if (event.eventName == TextStrings.eventClientSeen) {
        log("Seen event received");
        _makeSeen = true;
        notifyListeners();
      } else {
        _eventController.add(event);
        final parsed = jsonDecode(event.data!);
        final newMessage = PusherEventModel.fromJson(parsed);

        if (newMessage.message?.toId! != chatId.toString()) {
          return;
        }

        final MessageAttachment? attachment;
        if (newMessage.message?.attachment != null) {
          doesFileExists = false;
          docAttachmentSize = null;
          await _assignFileExists(newMessage.message!.attachment!);
          log("For file ${newMessage.message?.attachment?.title} is available? = $doesFileExists and filesize = $docAttachmentSize");
          attachment = MessageAttachment(
              newName: newMessage.message?.attachment?.file,
              oldName: newMessage.message?.attachment?.title,
              type: newMessage.message?.attachment?.type,
              //pages: docAttachmentPages,
              fileSize: docAttachmentSize,
              isDownloaded: doesFileExists);
        } else {
          attachment = null;
        }
        final userMessage = MessageData(
            type: newMessage.message?.type,
            id: newMessage.message?.id,
            chatId: chatId,
            fromId: newMessage.message?.fromId,
            toId: int.parse(newMessage.message!.toId!),
            body: newMessage.message?.message,
            seen: newMessage.message?.seen,
            createdAt: newMessage.message?.createdAt,
            attachment: attachment,
            updatedAt: newMessage.message?.createdAt);

        if (messages.isEmpty) dates.clear();
        final date = DateTime.parse(userMessage.createdAt!);
        final formattedTimestamp = DateFormat('dd-MM-yyyy').format(date);
        checkNAddDateMessage(formattedTimestamp); //add a fake date message
        log("NEW ARRIVED : ${userMessage.body}");
        _messages.add(userMessage);
        messages = _messages.distinct();
        _messageStreamController.add(_messages);

        Future.delayed(const Duration(milliseconds: 400), () {
          onNewMessages!();
          sendSeenEvent();
        });
        notifyListeners();
      }
    }
  }

  String decodeHtmlEntities(String message) {
    return parse(message).documentElement!.text;
  }

  fetchAllMessages() {
    final request = FetchMessagesRequest(chatId: chatId);
    log("FETCH ALL MESSAGES FOR CHAT_ID $chatId");
    _messageStream = _fetchMessagesService.fetchMessagesStream(
        request, SharedPreferencesServices.token!);
    _messageStream?.listen((newMessages) {
      messages = newMessages.reversed.toList();
      //_messages.addAll(messages);

      dates.clear();
      messages = messages.distinct(); //Unique messages only
      messages.asMap().forEach((index, message) {
        final date = DateTime.parse(messages[index].createdAt!);
        final formattedTimestamp = DateFormat('dd-MM-yyyy').format(date);
        message.body = message.body;
        checkNAddDateMessage(formattedTimestamp); //add a fake date message
        _messages.add(message);
      });
      //adding to main list
      _messageStreamController.add(_messages);
      notifyListeners();
      if (onNewMessages != null) {
        Future.delayed(Duration.zero, () {
          onNewMessages!();
        });
      }
    });
  }

  void checkNAddDateMessage(String formattedTimestamp) {
    if (!dates.contains(formattedTimestamp) /* && messages.length >= 1*/) {
      dates.add(formattedTimestamp);
      final newDate = customizeDate(formattedTimestamp);
      final fakeMessage = MessageData(
          id: "",
          chatId: 0,
          fromId: 0,
          toId: 0,
          body: "",
          seen: 0,
          createdAt: "",
          updatedAt: newDate,
          type: TextStrings.fakeDate);
      _messages.add(fakeMessage);
      log("ADDING FAKE  $newDate and actual was $formattedTimestamp");
    }
  }

  initPusherAndFetchAll() {
    // this should only be called when you don't want the chat creation feature
    pusherService.channelName = "private-chatify.$chatId";
    pusherService.initializePusher(
        onPusherEventReceived: _onPusherEventReceived);

    fetchAllMessages();
  }

  sendMessage(String message) async {
    log("sendMessage called with attachment as $attachedFile");
    final response = await _chatService.sendMessage(
        token: SharedPreferencesServices.token!,
        message: message,
        chatId: chatId,
        filePath: attachedFile);
    Future.delayed(const Duration(milliseconds: 500), () {
      setAttachedFile(null);
      notifyListeners();
    });

    if (response.error?.status == 1) {
      onFetchMessagesError!(response.error?.message);
    }
  }

  void sendSeenEvent() {
    log("Send seen event");
    final Map<String, dynamic> body = {};
    body['from_id'] = SharedPreferencesServices.userId.toString();
    body['to_id'] = chatId.toString();
    body['seen'] = true;
    pusherService.triggerEvent(TextStrings.eventClientSeen, body);
  }

  void sendTypingEvent() {
    log("Calling send typing event");
    final Map<String, dynamic> body = {};
    body['from_id'] = SharedPreferencesServices.userId.toString();
    body['to_id'] = chatId.toString();
    body['typing'] = true;

    pusherService.triggerEvent(TextStrings.eventClientTyp, body);
    Future.delayed(const Duration(milliseconds: 900), () {
      body['typing'] = false;
      pusherService.triggerEvent(TextStrings.eventClientTyp, body);
    });
  }

  void resetOnClose() {
    _messages.clear();
    _messageStreamController.add(_messages);
  }

  _assignFileExists(Attachment attachment) async {
    doesFileExists =
        await doesFileExistsInDownloads(fileName: attachment.title ?? ".err");
  }

  downloadOrOpenFile(MessageAttachment attachment, String fileName,
      {required void Function() onDownloaded,
      required void Function(String) onOpenError}) async {
    try {
      if (!await PermissionHelper.checkPermission(
          permission: Permission.manageExternalStorage)) {
        !await PermissionHelper.requestPermission(
            permission: Permission.manageExternalStorage);
        log("No Permission to open files");
        return;
      } else {
        final filePath = await getFileDownloadPath(attachment.oldName!);
        if (filePath == null) {
          log("Can't download $fileName");
        } else if (await doesFileExistsInDownloads(fileName: fileName)) {
          try {
            final result = await _openFile(filePath);
            if (result != null) {
              onOpenError(result);
            }
          } catch (e) {
            log("Exception on opening file : $e");
          }
        } else {
          //download the file
          final dio = Dio();
          log("TRYING TO DOWNLOAD");

          await dio.download(
            "${APIConstants.baseImageUrl}attachments/${attachment.newName ?? "no_image"}",
            filePath,
            onReceiveProgress: (received, total) async {
              log("Received bytes: $received and total bytes: $total ");
              if (total != -1) {
                print(
                    "Download Progress: ${(received / total * 100).toStringAsFixed(0)}%");
              }
              if (total != -1 && (received == total)) {
                doesFileExists = await doesFileExistsInDownloads(
                    fileName: attachment.oldName!);
                onDownloaded();
              }
            },
          );
        }
      }
    } catch (e) {
      log("Some error occurred while Opening/downloading the file! : $e");
    }
  }

  Future<String?> _openFile(String path) async {
    const types = fileOpenerAllowedExtensions;
    final extension = path.split('.')[1];

    if (!await PermissionHelper.checkPermission(
            permission: Permission.manageExternalStorage) &&
        !await PermissionHelper.checkPermission(
            permission: Permission.storage)) {
      await PermissionHelper.requestPermission(permission: Permission.storage);
      await PermissionHelper.requestPermission(
          permission: Permission.manageExternalStorage);
    } else {
      try {
        final res = await OpenFilex.open(path, type: types[extension]);
        if (res.type != ResultType.done) {
          return res.message;
        } else {
          return null;
        }
      } catch (e) {
        log("Error in opening file : $e");
      }
    }
    return null;
  }

  Future<bool> doesFileExistsInDownloads({required String fileName}) async {
    final path = await getFileDownloadPath(fileName);
    final file = File(path!);
    final exists = await file.exists();
    if (exists) {
      final size = file.lengthSync();
      double sizeInMB = size / (1000 * 1000);
      double sizeInKB = sizeInMB * 1000;

      double sizeInMBRounded = double.parse(sizeInMB.toStringAsFixed(2));
      double sizeInKBRounded = double.parse(sizeInKB.toStringAsFixed(2));
      docAttachmentSize =
          sizeInMB > 1 ? "$sizeInMBRounded MB" : "$sizeInKBRounded kB";
      notifyListeners();
      return exists;
    }
    return exists;
  }

  void updateAttachment(MessageAttachment attachment) {
    final message = _messages.firstWhereOrNull((msg) {
      if (msg.attachment != null) {
        return msg.attachment!.newName == attachment.newName;
      } else {
        return false;
      }
    });
    if (message != null && message.attachment != null) {
      _messages[_messages.indexOf(message)].attachment = attachment;
      messages[messages.indexOf(message)].attachment = attachment;
    }
    notifyListeners();
  }

  Future<String?> getFileDownloadPath(String fileName) async {
    try {
      final directory = Directory('/storage/emulated/0/Download/');
      if (await directory.exists()) {
        return directory.path + fileName;
      } else {
        print("Downloads directory does not exist");
        return null;
      }
    } catch (e) {
      print("Error getting public downloads directory: $e");
      return null;
    }
  }

  VoidCallback? noMessageFound;
  Function(List<int>)? messageFound;

  void searchAndScroll(String searchKey) {
    log("Searching $searchKey ............... and ${_messages.length}");
    indexFound.clear();
    //_messages.indexWhere((message) => message.body!.contains(searchKey));
    final filteredMessages = _messages.where((mes) {
      return mes.type != TextStrings.messageTypeSystem;
    }).toList();

    filteredMessages.asMap().forEach((index, mes) {
      //log("mes in vm: ${mes.body}");
      if (mes.type != TextStrings.fakeDate &&
          mes.body!.toLowerCase().split(' ').any((word) {
            return word == searchKey.toLowerCase();
          })) {
        log("Add this message=${mes.body} with index : $index");
        if (!indexFound.contains(index)) {
          indexFound.add(index);
        }
      }
    });

    if (indexFound.isNotEmpty) {
      log("Found ${indexFound.length} occurrences, full details $indexFound");
      messageFound!(indexFound);
    } else {
      log("No messages");
      noMessageFound!();
    }
  }

  void observeDateScrolling() {
    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      if (positions.isNotEmpty && dates.isNotEmpty) {
        // final lastVisibleIndex = positions.last.index;
        // final firstVisibleIndex = positions.first.index;
        //log("THIS: ${_messages[firstVisibleIndex].body} : ${_messages[firstVisibleIndex].type} and ${_messages[lastVisibleIndex].body} : ${_messages[lastVisibleIndex].type}");
        /*if ((firstVisibleIndex >= 1 || lastVisibleIndex >= 0) &&
            (firstVisibleIndex <= 4 || lastVisibleIndex <= 4)) {
          dateToFloat = null;
          return;
        }*/
        final visibleMessages = positions.map((pos) {
          return _messages[pos.index];
        });
        //log("VSISIS: ${visibleMessages.first.body}");
        if (visibleMessages.first.body!.isEmpty) {
          dateToFloat = null;
          return;
        }
        var minIndex = _messages.indexOf(visibleMessages.first);
        /* visibleMessages.map((mess) {
          final ind = _messages.indexOf(mess);
          if (ind < minIndex) {
            minIndex = ind;
          }
          return mess.body;
        });

        if (minIndex > _messages.length) {
          minIndex = _messages.length - 1;
        } */

        final createdAt = _messages[minIndex].createdAt;

        if (createdAt == null || createdAt.isEmpty) {
          log("Skipping invalid date: $createdAt");
          dateToFloat = null;
          return;
        }
        final date = DateTime.tryParse(createdAt);
        if (date == null) return;
        final formattedTimestamp = DateFormat('dd-MM-yyyy').format(date);
        final newDate = customizeDate(formattedTimestamp);
        if (newDate != dateToFloat) {
          log("settinng date: $newDate");
          dateToFloat = newDate;
          notifyListeners();
        }
      }
    });
  }

  void observeChatScrolling() {
    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      if (positions.isNotEmpty && messages.isNotEmpty) {
        final lastVisibleIndex = positions.last.index;
        final atBottom = lastVisibleIndex <=
            _messages.length - 4; //at least three messages should pass
        isAtBottom.value = !atBottom;
        notifyListeners();
      }
    });
  }

  String customizeDate(String inputDate) {
    final now = DateTime.now();
    final inputDateTime = DateFormat('dd-MM-yyyy').parse(inputDate);

    final inputDateOnly =
        DateTime(inputDateTime.year, inputDateTime.month, inputDateTime.day);
    final todayDateOnly = DateTime(now.year, now.month, now.day);
    final yesterdayDateOnly = todayDateOnly.subtract(Duration(days: 1));
//format for day of the week EEEE
    if (inputDateOnly == todayDateOnly) {
      return "Today";
    } else if (inputDateOnly == yesterdayDateOnly) {
      return "Yesterday";
    } else if (inputDateOnly
            .isAfter(todayDateOnly.subtract(Duration(days: 7))) &&
        inputDateOnly.isBefore(todayDateOnly.add(Duration(days: 1)))) {
      return DateFormat('EEEE').format(inputDateTime);
    } else {
      return DateFormat('d MMMM yyyy').format(inputDateTime);
    }
  }

  @override
  void dispose() {
    _messages.clear();
    messages.clear();
    _messageStreamController.close();
    _eventController.close();
    super.dispose();
  }
}
