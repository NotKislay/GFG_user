import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/model/service_model/serivce_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class ServiceService {
  Future<List<ServiceModel>> fetchServices(String token) async {
    log('fetching funtion started from service file');
    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/services'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return (parsed['data']['services'] as List)
            .map<ServiceModel>((json) => ServiceModel.fromJson(json))
            .toList();
      } else {
        log('Error: Failed to load services with status code ${response.statusCode}');
        throw Exception('Failed to load services');
      }
    } catch (e) {
      log('Exception caughts: $e');
      throw Exception('Failed to load services: $e');
    }
  }
}
