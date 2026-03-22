import 'dart:developer';

import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static String? token;
  static int? userId;

  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(TextStrings.authToken);
    return token;
  }

  Future<int?> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getInt(TextStrings.userID);
    return userId;
  }

  Future<String?> getLatestMessagesId(int key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key.toString());
  }

  Future<void> updateMessageID(int serviceID, String messageID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(serviceID.toString(), messageID);
  }

  Future<void> putLatestMessageID(int serviceId, String messageID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(serviceId.toString(), messageID);
  }
}
