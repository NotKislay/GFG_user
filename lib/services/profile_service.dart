import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:gofriendsgo/model/profile_model/profile_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<UserProfileModel?> fetchProfile() async {
    // log(token);
    // String token =
    //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzkzZTc4YmJjMDBiNjEzODY2NTM2YTY1YTdmM2Y1NjgzOWFmZWVhMjBmMTgyMGY2ZTNmMDgwMzJjYjFiOTQ2ZTYxYzRkMTQ5MjE5NTlhZDMiLCJpYXQiOjE3MjI1MDYzMzAuODgxMzU0LCJuYmYiOjE3MjI1MDYzMzAuODgxMzU2LCJleHAiOjE3NTQwNDIzMzAuODc5OTE0LCJzdWIiOiIyMyIsInNjb3BlcyI6W119.b7F-dCgQQAsOL7DqjxU2Fzjz-euSWWWvAytouFzQCs5k1KJntoHavhwfwEtg09kwtf-UCA0JKS4wbXo_IBPzX7Ya4aF6QIcC29rLKqpv8NlePmIzQ-zbitiQkwSdsW59DyygFTTvp-Yy72e3LM7hKTQGyWedX8SE2JbsI0sKgJb8bOSCgYxv2FPRJunT5FaZlpGHnc-qkOJpsElJUjGbRH7-hE6GjUAViB9ue8TY9Xo02zYMpFNQ8QUR2CxgJhLMWjBmppOKkdy0swa7WiBZcjfr2D9dwHWK7QtR_4vXDlAGulKO-qOGTni6BEpXlw9VC-HEB8kZwGm7YKVkvl5XqvrbpOdv9IOIDCoQ3bjPJ14rSYLPqIhAyovgGr0dNeVX_XZnv-4Y83TmzE8E04rtmmQgLdJxVX8vWMjtXE74oVOb1f19vpGxiij7DsjU-ym3y6Z25RKaMHrvvKWiuUHCQ5g7f-mNWYbihWKnhj1L4jy8fyg2NWPVmgIrKD29KQJHEjBbnbX3VNYZsv77D-6JW9WNctCcLeb-cHvP2EuKokYT9yXZpDOMBNxyg2t6t77CCWeqzE0I6C2-soSFnw59r5X89RAH0VJ_d_kTH_ucJHRgsjlA4vg1OLO5ZKi1oHa29j6Z9VR4GOyDdyeBX1yfATZgd6vAJcc6URnUTiw3GTk';

    log("shaham ${SharedPreferencesServices.token}");
    log('Fetching profile started');
    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/profile'),
        headers: {
          'Authorization': 'Bearer ${SharedPreferencesServices.token}',
        },
      );

      if (response.statusCode == 200) {
        log('successsss');
        final data = jsonDecode(response.body);
        return UserProfileModel.fromJson(data);
      } else {
        log('Error: Failed to load profile with status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error fetching profiles: $e');
      return null;
    }
  }

  // Future<bool> updateUserProfile(
  //     int userId, Map<String, dynamic> updatedData, String token) async {
  //   print('started working');
  //   final Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };

  //   try {
  //     final response = await http.patch(
  //       Uri.parse('${API.baseUrl}/profile/$userId'),
  //       headers: headers,
  //       body: jsonEncode(updatedData),
  //     );

  //     if (response.statusCode == 200) {
  //       print('Profile updated successfully');
  //       return true; // Indicate success
  //     } else {
  //       print('Failed to update profile. Status code: ${response.statusCode}');
  //       return false; // Indicate failure
  //     }
  //   } catch (e) {
  //     print('Error updating profile: $e');
  //     return false; // Indicate failure
  //   }
  // }
 
Future<bool> updateUserProfile(
  int userId,
  Map<String, dynamic> updatedData,
  String token,
) async {
  print('Started working');

  final uri = Uri.parse('${APIConstants.baseUrl}/profile/$userId');
  final request = http.MultipartRequest('POST', uri)
    ..headers['Authorization'] = 'Bearer $token';

  // Add form fields and handle the image file
  updatedData.forEach((key, value) async{
    if (value is String) {
      request.fields[key] = value;
    } else if (value is File){
      // Handle the image file
      request.files.add(
       await http.MultipartFile.fromPath(key, value.path),
      );
    }
  });

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      print('Profile updated successfully');
      return true; // Indicate success
    } else {
      print('Failed to update profile. Status code: ${response.statusCode}');
      return false; // Indicate failure
    }
  } catch (e) {
    print('Error updating profile: $e');
    return false; // Indicate failure
  }
}
}
