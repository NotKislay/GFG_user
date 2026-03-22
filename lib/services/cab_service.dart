import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/model/cab_model/cab_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class CabService {
  Future<CabModel> fetchCabs(String token) async {
    log('Fetching cabs from service file');
    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/cabs'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return CabModel.fromJson(parsed);
      } else {
        log('Error: Failed to load cabs with status code ${response.statusCode}');
        throw Exception('Failed to load cabs');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load cabs: $e');
    }
  }
}
