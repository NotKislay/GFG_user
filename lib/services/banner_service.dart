import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/model/banner_model/banner_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class BannerService {
  Future<BannersModel> fetchBanner(String token) async {
    log('Fetching banners from service file');
    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/banners'),
        headers: {'Authorization': 'Bearer $token'},
      );

      log('Response status: ${response.statusCode}');
      log('Response headers: ${response.headers}');
      log('Response body: ${response.body}');

      // if (response.statusCode == 200) {
      //   final parsed = jsonDecode(response.body);
      //   log("heloo Anit--->$parsed");
      //   return BannersModel.fromJson(parsed);
      // } else {
      //   log("error Anit");
      //   log('Error: Failed to load carousals with status code ${response.statusCode}');
      //   throw Exception(
      //       'Failed to load carousal this error is showing from banner service area ');
      // }
      if (response.statusCode == 200 &&
          response.headers['content-type']?.contains('application/json') ==
              true) {
        log("recieved json response:${response.body}");
        final parsed = jsonDecode(response.body);
        return BannersModel.fromJson(parsed);
      } else if (response.headers['content-type']?.contains('text/html') ==
          true) {
        log('Received HTML response: ${response.body}');
        throw Exception('Failed to fetch banners: Received HTML response');
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log("exception Anit");
      log('Exception caught: $e');
      throw Exception('Failed to load carousals: $e');
    }
  }
}
