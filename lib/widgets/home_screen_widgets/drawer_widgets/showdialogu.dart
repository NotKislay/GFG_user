import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void showLogoutDialog() {
  Get.dialog(
    AlertDialog(
      title: const CustomText(
          text: 'Logout',
          fontFamily: CustomFonts.poppins,
          size: 0.06,
          color: Colors.black),
      content: const Text('Do you want to logout from GoFriendsGo?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog without any action
          },
          child: const CustomText(
              text: 'Cancel',
              fontFamily: CustomFonts.inter,
              size: 0.04,
              color: Colors.black),
        ),
        TextButton(
          onPressed: () async {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString(TextStrings.authToken, "");
            PageNavigations().pushAndRemoveUntill(LoginScreen());
          },
          child: const CustomText(
              text: 'Logout',
              fontFamily: CustomFonts.inter,
              size: 0.04,
              color: Colors.red),
        ),
      ],
    ),
    barrierDismissible: true,
  );
}

void showDeleteAccountDialog() {
  Get.dialog(
    AlertDialog(
      title: const CustomText(
          text: 'Delete Account',
          fontFamily: CustomFonts.poppins,
          size: 0.06,
          color: Colors.red),
      content: const Text(
        'This will delete all your data\n Are you sure?',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog without any action
          },
          child: const CustomText(
              text: 'Cancel',
              fontFamily: CustomFonts.inter,
              size: 0.04,
              color: Colors.black),
        ),
        TextButton(
          onPressed: () async {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            final token = sharedPreferences.getString(TextStrings.authToken);
            if (token == null || token.isEmpty) {
              if (Get.isDialogOpen == true) {
                Get.back();
              }
              _showDeleteAccountErrorDialog(
                  'Missing auth token. Please login again.');
              return;
            }

            final url = Uri.parse('${APIConstants.baseUrl}/account/delete');
            try {
              final response = await http.delete(
                url,
                headers: {
                  'Authorization': 'Bearer $token',
                },
              );

              if (response.statusCode == 200) {
                sharedPreferences.setString(TextStrings.authToken, "");
                if (Get.isDialogOpen == true) {
                  Get.back();
                }
                PageNavigations().pushAndRemoveUntill(LoginScreen());
              } else {
                if (Get.isDialogOpen == true) {
                  Get.back();
                }
                _showDeleteAccountErrorDialog(
                    'Failed to delete account (${response.statusCode}). Please try again.');
              }
            } catch (e) {
              if (Get.isDialogOpen == true) {
                Get.back();
              }
              _showDeleteAccountErrorDialog(
                  'Something went wrong. Please try again.');
            }
          },
          child: const CustomText(
              text: 'Delete',
              fontFamily: CustomFonts.inter,
              size: 0.04,
              color: Colors.red),
        ),
      ],
    ),
    barrierDismissible: true,
  );
}

void _showDeleteAccountErrorDialog(String message) {
  Get.dialog(
    AlertDialog(
      title: const CustomText(
          text: 'Delete Failed',
          fontFamily: CustomFonts.poppins,
          size: 0.055,
          color: Colors.red),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const CustomText(
              text: 'OK',
              fontFamily: CustomFonts.inter,
              size: 0.04,
              color: Colors.black),
        ),
      ],
    ),
    barrierDismissible: true,
  );
}
