import 'dart:convert';
import 'dart:developer';

import 'package:gofriendsgo/model/chat_models/create_chat_model.dart';
import 'package:gofriendsgo/model/chat_models/send_message_response_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatServiceAPI {
  Future<Chat> createChat(String serviceName, String token,String id) async {
    final url = Uri.parse('${APIConstants.baseUrl}/chats');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final CreateChatRequest createChatRequest =
        CreateChatRequest(name: serviceName,service: id);
    final body = jsonEncode(createChatRequest.toJson());

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final fetchChatResponse = ChatCreationResponse.fromJson(parsed);
        log("SUCCESS in creating chat: ${fetchChatResponse.chat}");
        return fetchChatResponse.chat;
      } else {
        log("error in creating chat :${response.statusCode}");
        throw Exception("Error in request ${response.statusCode}");
      }
    } catch (error) {
      throw Exception(
          "Error while creating chat with $serviceName EXCEPTION: $error");
    }
  }

  Future<SendMessageResponse> sendMessage({
    required String token,
    required String message,
    required int chatId,
    String? filePath,
  })
  async {
    log('Sending message from service file');
    var uri = Uri.parse('${APIConstants.baseUrl}/sendMessage');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = chatId.toString();
    request.fields['type'] = 'user';
    request.fields['message'] = message;
    request.fields['temporaryMsgId'] = 'temp_1';
    request.fields['chat_id'] = chatId.toString();
    if (filePath != null) {
      var file = await http.MultipartFile.fromPath(
        'file',
        filePath,
        filename: filePath.split('/').last,
      );
      request.files.add(file);
    }
    request.headers['Authorization'] = 'Bearer $token';

    try {
      // Send the request
      var streamResponse = await request.send();
      final responseBody = await streamResponse.stream.bytesToString();
      final response = http.Response(
        responseBody,
        streamResponse.statusCode,
        headers: streamResponse.headers,
        request: streamResponse.request,
        isRedirect: streamResponse.isRedirect,
      );

      // Handle response
      if (response.statusCode == 200) {
        log('Response data: ${response.body}');
        final parsed = jsonDecode(response.body);
        return SendMessageResponse.fromJson(parsed);
      } else {
        log('Error: Failed to send message with status code ${streamResponse.statusCode}');
        throw Exception('Failed to send message');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to send message: $e');
    }
  }
}
