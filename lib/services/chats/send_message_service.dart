import 'dart:developer';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class SendMessageService {
  Future<void> sendMessage({
    required String token,
    required String message,
    required dynamic chatId,
    String? filePath,
  }) async {
    log('Sending message from service file');
    var uri = Uri.parse('${APIConstants.baseUrl}/sendMessage');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = '2';
    request.fields['type'] = 'user';
    request.fields['message'] = message;
    request.fields['temporaryMsgId'] = 'temp_1';
    request.fields['chat_id'] = chatId;
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
      var response = await request.send();

      // Handle response
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        log('Response status: ${response.statusCode}');
        log('Response data: $responseData');
      } else {
        log('Error: Failed to send message with status code ${response.statusCode}');
        throw Exception('Failed to send message');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to send message: $e');
    }
  }
}
