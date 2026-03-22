import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofriendsgo/model/user_model/user_details_model.dart';
import 'package:gofriendsgo/services/sign_up_service.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/login_screen/login_screen.dart';
import 'package:gofriendsgo/view/otp_verify_screen/otp_screen.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = UserService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int? otpCode;
  String? _message;
  String? get message => _message;
  String _sourceController = '';

  String get sourceController => _sourceController;
  bool isButtonPressed = false;

  updateIsButtonPressed() {
    if (!isButtonPressed) {
      isButtonPressed = !isButtonPressed;
    }
    log("Is button : ${isButtonPressed}");
    notifyListeners();
  }

  set sourceController(String value) {
    _sourceController = value;
    notifyListeners();
  }

  // Future<void> registerUser(UserDetails userDetails) async {
  //   log('reached');
  //   _isLoading = true;
  //   _message = null;
  //   notifyListeners();
  //
  //   final response = await _userService.registerUser(userDetails);
  //   _isLoading = false;
  //
  //   if (response != null && response['status'] == true) {
  //     _isLoading = false;
  //     _message = response['message'];
  //     log('successfully registered');
  //     // log(_message.toString());
  //     log(response['data']['user']['otp']);
  //     // PageNavigations().pushAndRemoveUntill(const BottomNavigationScreen());
  //   } else {
  //     _isLoading = false;
  //     _message = response?['message'] ?? 'Registration failed';
  //     Get.snackbar(
  //         "Validation error", response?['message'] ?? 'Registration failed',
  //         backgroundColor: Colors.red.shade400,
  //         colorText: AppColors.whiteColor);
  //
  //     log('registration failed');
  //   }
  //
  //   notifyListeners();
  // }
  Future<bool> registerUser(UserDetails userDetails) async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    try {
      final response = await _userService.registerUser(userDetails);
      _isLoading = false;

      if (response != null && response['status'] == true) {
        // Registration successful
        _message = response['message'];
        log("$_message and OTP: ${response['otp']}");
        return true;
      } else {
        // Handle specific validation errors
        if (response != null && response['errors'] != null) {
          // Handle email already taken
          if (response['errors']['email'] != null &&
              response['errors']['email'][0].contains('already been taken')) {
            _message = "This email is already registered. Please log in.";
            Get.snackbar(
              "Email Error",
              _message!,
              backgroundColor: Colors.red.shade400,
              colorText: Colors.white,
            );
            return false; // Block the sign-up process in this case
          }
          // Generic error handling
          _message = response['message'] ?? 'Registration failed.';
          Get.snackbar(
            "Registration Error",
            _message!,
            backgroundColor: Colors.red.shade400,
            colorText: Colors.white,
          );
        }
        notifyListeners();
        return false; // Block sign-up for other errors
      }
    } catch (e) {
      _isLoading = false;
      _message = 'An error occurred: $e';
      Get.snackbar(
        "Error",
        _message!,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
      notifyListeners();
      return false; // Registration failed due to an exception
    }
  }

  Future<void> loginUser(String userEmail) async {
    log('started login fun');
    _isLoading = true;
    _message = null;
    notifyListeners();

    final response = await _userService.postEmail(userEmail);
    _isLoading = false;
    if (response.statusCode == 200) {
      PageNavigations().push(OtpVerifyScreen(
        loginEmail: emailController.text,
      ));
    }
    log(response.body);

    notifyListeners();
  }

  Future<void> verifyOtp(int otp, String email) async {
    _isLoading = true;
    try {
      await _userService.verifyOtp(otp, email);
      //tprint("Token ---->>> ${SharedPreferecesServices.token}");
//  if(response.statusCode==200){}
      // Handle success
      // Update any state if needed
      notifyListeners();
      _isLoading = false;
    } catch (e) {
      final response = await _userService.verifyOtp(otp, email);
      if (response.statusCode != 200) {
        _isLoading = false;
        notifyListeners();
      }
      // Update any state if needed
      notifyListeners();
    }
  }
}
