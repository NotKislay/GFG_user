import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/model/sales_exe_model/rating_response.dart';
import 'package:gofriendsgo/model/sales_exe_model/sales_execut_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class SalesPersonService {
  Future<SalesPersonResponse> fetchSalesPerson(String token) async {
    log('Fetching sales person details from service file');
    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/sales-executive'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return SalesPersonResponse.fromJson(parsed);
      } else {
        log('Error: ${response.body}');
        log('Error: Failed to load sales person details with status code ${response.statusCode}');
        throw Exception(
            'Failed to load sales person details. Error from sales person service area.');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load sales person details: $e');
    }
  }

  Future<RatingResponse?> fetchRatings(int rateeId, String token) async {
    final url = Uri.parse('${APIConstants.baseUrl}/ratings/$rateeId');

    try {
      final response = await http.get(url, headers: {'Authorization': 'Bearer $token'},);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RatingResponse.fromJson(data);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<dynamic> postReview( Map<String, dynamic> body, String token) async {
  final url = Uri.parse('${APIConstants.baseUrl}/ratings'); // Adjust API endpoint

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Review posted successfully: ${response.body}');
      return jsonDecode(response.body);
    } else {
      log('Failed to post review: ${response.statusCode} - ${response.body}');
      //throw Exception('Failed to post review');
    }
  } catch (e) {
    log('Error in postReview service: $e');
    throw e;
  }
}

}
