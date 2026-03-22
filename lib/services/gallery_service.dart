import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/model/gallery_model/gallery_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class GalleryService {
  Future<GalleryResponse> fetchGallery(String token) async {
    log('Fetching gallery from service file');
    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/gallery'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return GalleryResponse.fromMap(parsed);
      } else {
        log('Error: Failed to load gallery with status code ${response.statusCode}');
        throw Exception('Failed to load gallery, error in GalleryService');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load gallery: $e');
    }
  }
}
