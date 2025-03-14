import 'dart:convert';
import 'dart:developer';

import 'package:gofriendsgo/model/family_model/family_alter_model.dart';
import 'package:gofriendsgo/model/family_model/family_list_response.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:http/http.dart' as http;

class FamilyService {
  Future<FamilyListResponse?> fetchFamilyMembers() async {
    try {
      final response = await http.get(
        Uri.parse(
            '${APIConstants.baseUrl}/${TextStrings.endpointGetFamilyMembers}'),
        headers: {
          'Authorization': 'Bearer ${SharedPreferencesServices.token}',
        },
      );

      if (response.statusCode == 200) {
        log("Family members get successfully");
        final data = jsonDecode(response.body);
        return FamilyListResponse.fromJson(data);
      } else {
        log('Error: Failed to load family details with status code ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error in fetching family details: $e');
      return null;
    }
  }

  Future<FamilyUpdateResponse?> addFamilyMember({
    required String name,
    required String dob,
    required String mobile,
    required String email,
    required String relation,
  }) async {
    try {
      final uri = Uri.parse(
          '${APIConstants.baseUrl}/${TextStrings.endpointAddFamilyMember}');

      Map<String, dynamic> requestBody = {
        "name": name,
        "dob": dob,
        "mobile": mobile,
        "email": email,
        "relation": relation
      };

      var response = await http.post(uri,
          headers: {
            "Content-Type": "application/json", // Specify JSON format
            "Accept": "application/json",
            'Authorization': 'Bearer ${SharedPreferencesServices.token}'
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return FamilyUpdateResponse.fromJson(jsonResponse);
      } else {
        log("Failed to add family member ${response.body}");
        return null;
      }
    } catch (e) {
      log('Error in adding family member $e');
      return null;
    }
  }

  Future<FamilyUpdateResponse?> updateFamilyMember({
    required String id,
    required String name,
    required String dob,
    required String mobile,
    required String email,
    required String relation,
  }) async {
    try {
      final uri = Uri.parse(
          '${APIConstants.baseUrl}/${TextStrings.endpointUpdateFamilyMember}');
      Map<String, dynamic> requestBody = {
        "id": id,
        "name": name,
        "dob": dob,
        "mobile": mobile,
        "email": email,
        "relation": relation
      };
      var response = await http.put(uri,
          headers: {
            "Content-Type": "application/json", // Specify JSON format
            "Accept": "application/json",
            'Authorization': 'Bearer ${SharedPreferencesServices.token}'
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return FamilyUpdateResponse.fromJson(jsonResponse);
      } else {
        log("Failed to update family member ${response.body}");
        return null;
      }
    } catch (e) {
      log('Error in updating family member $e');
      return null;
    }
  }

  Future<FamilyUpdateResponse?> deleteFamilyMember({
    required String id,
  }) async {
    try {
      final uri = Uri.parse(
          '${APIConstants.baseUrl}/${TextStrings.endpointDeleteFamilyMember}');
      Map<String, dynamic> requestBody = {
        "id": id,
      };
      var response = await http.delete(uri,
          headers: {
            'Authorization': 'Bearer ${SharedPreferencesServices.token}'
          },
          body: requestBody);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return FamilyUpdateResponse.fromJson(jsonResponse);
      } else {
        log("Failed to delete family member ${response.request}");
        return null;
      }
    } catch (e) {
      log('Error in deleting family member $e');
      return null;
    }
  }
}
