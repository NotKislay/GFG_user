import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/model/story_model/story_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class StoryService {
  Future<StoriesModel> fetchStories(String token) async {
    log('Fetching stories from service file');
    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/stories'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return StoriesModel.fromJson(parsed);
      } else {
        log('Error: Failed to load stories with status code ${response.statusCode}');
        throw Exception('Failed to load stories');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load stories: $e');
    }
  }
}
