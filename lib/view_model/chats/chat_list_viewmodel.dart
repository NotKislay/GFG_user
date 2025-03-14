import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/chat_models/chat_list_model.dart';
import 'package:gofriendsgo/services/chats/get_chat_list_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/chat_models/fetch_messages_model.dart';
import '../../services/api/app_apis.dart';

class ChatListViewmodel extends ChangeNotifier {
  final ChatServices _service = ChatServices();
  ChatsListModel? _chatsModel;
  bool _isLoading = false;

  ChatsListModel? get chatsModel => _chatsModel;

  bool get isLoading => _isLoading;

  Future<void> fetchChatList() async {
    _isLoading = true;
    try {
      final response =
          await _service.fetchChats(SharedPreferencesServices.token!);
      var chats = response.data.reversed.toList();
      _chatsModel = ChatsListModel(
          status: response.status, message: response.message, data: chats);
      if (_chatsModel != null) {
        log('chats fetched successfully');
        _chatsModel?.data.reversed;
        _chatsModel?.data.asMap().forEach((index, chatData) async {
          final request = FetchMessagesRequest(chatId: chatData.id);
          final prefs = SharedPreferencesServices();
          final message = await fetchLastMessagesID(
              request, SharedPreferencesServices.token!);
          _chatsModel?.data[index].isLast = false;
          chatData.isLast = (message?.id ?? -1) ==
              await prefs.getLatestMessagesId(chatData.id);
        });
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      log('Error fetching chats: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendSeenAllEvent(int chatId) async {
    //_isLoading = true;
    log("Calling api with this chat id : $chatId");
    try {
      final response = await _service.setMessagesToSeen(
          chatId, SharedPreferencesServices.token!);
      log("STATUS OF SEEN MESG API: $response");
    } catch (e) {
      // Handle error
      log('Error in sending seen API : $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<MessageData?> fetchLastMessagesID(
      FetchMessagesRequest fetchMessageRequest, String token) async {
    final url = Uri.parse('{APIConstants.baseUrl}/fetchMessages');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode(fetchMessageRequest.toJson());

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final fetchMessagesModel = FetchMessagesModel.fromJson(parsed);
        return fetchMessagesModel.messages.reversed.last;
      } else {
        throw Exception("Error in request ${response.statusCode}");
      }
    } catch (error) {
      log('Error registering user: $error');
      return null;
    }
  }
}
