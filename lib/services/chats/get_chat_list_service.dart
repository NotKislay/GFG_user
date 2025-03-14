import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;
import 'package:gofriendsgo/model/chat_models/chat_list_model.dart';

class ChatServices {
  Future<int> setMessagesToSeen(int chatId, String token) async {
    try {
      Map<String, int> body = {'id': chatId};
      //body['']=1;
      final response =
          await http.post(Uri.parse('${APIConstants.baseUrl}/makeSeen'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(body));
      //log("RAW REQUEST: ${jsonEncode(body)} AND FULL BODY: ${response.request}");
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return parsed['status'] as int;
      } else {
        throw Exception('Failed to load chats');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to hit message count api: $e');
    }
  }

  Future<ChatsListModel> fetchChats(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/chats'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      log("RAWWW: ${response.request} and token: $token");
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return ChatsListModel.fromJson(parsed);
      } else {
        throw Exception('Failed to load chats');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load chats: $e');
    }
  }
}
