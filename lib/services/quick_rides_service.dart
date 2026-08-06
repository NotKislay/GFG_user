import 'dart:convert';
import 'dart:developer';

import 'package:gofriendsgo/model/quick_rides_model/quick_ride_model.dart';
import 'package:gofriendsgo/model/quick_rides_model/quick_rides_location_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class QuickRideService {
  Future<QuickRideModel> fetchQuickRidesByLocationId(
      int id, String token) async {
    log('Fetching quick rides from service file');
    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/quick-rides?location_id=$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return QuickRideModel.fromJson(parsed);
      } else {
        log('Error: Failed to load quick rides with status code ${response.statusCode}');
        throw Exception('Failed to load quick rides');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load quick rides: $e');
    }
  }

  Future<QuickRideLocationModel> fetchCitiesOnSearch(
      String query, String token) async {
    log('Searching cities from service file');
    try {
      final uri = Uri.parse(APIConstants.loginUrl).replace(
        path: '/api/user/locations',
        queryParameters: {
          'search': query,
        },
      );
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return QuickRideLocationModel.fromJson(parsed);
      } else {
        log('Error: Failed to search cities with status code ${response.statusCode}');
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to search cities: $e');
    }
  }

  Future<QuickRideModel> getQuickRides({
    required int page,
    required int perPage,
    required String token,
    int? locationId,
  }) async {
    final queryParameters = <String, String>{
      'page': page.toString(),
      'per_page': perPage.toString(),
      if (locationId != null) 'location_id': locationId.toString(),
    };

    final uri = Uri.parse(APIConstants.loginUrl).replace(
      path: '/api/user/quick-rides',
      queryParameters: queryParameters,
    );

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final parsed = jsonDecode(response.body);
    return QuickRideModel.fromJson(parsed);
  }
}
