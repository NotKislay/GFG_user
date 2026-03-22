import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/model/teams_model/teams_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class TeamsService {
  Future<TeamsResponse> fetchTeams(String token) async {
    log('Fetching teams details from service file');
    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/teams'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return TeamsResponse.fromJson(parsed);
      } else {
        log('Error: Failed to load teams details with status code ${response.statusCode}');
        throw Exception(
            'Failed to load teams details. Error from teams service area.');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load teams details: $e');
    }
  }
}
