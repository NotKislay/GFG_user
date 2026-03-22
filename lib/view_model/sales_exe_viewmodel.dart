import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/sales_exe_model/rating_response.dart';
import 'package:gofriendsgo/services/sales_exe_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';

import '../model/sales_exe_model/sales_execut_model.dart'; // Update with the actual path to your SharedPreferences service class

class SalesPersonViewModel extends ChangeNotifier {
  final SalesPersonService _service = SalesPersonService();
  SalesPersonResponse? _salesPersonResponse;
  RatingResponse? _ratingResponse;
  bool _isLoading = false;
  TextEditingController commentController = TextEditingController();
  int rating = 0;
  bool posted = false;

  SalesPersonResponse? get salesPersonResponse => _salesPersonResponse;
  RatingResponse? get ratingResponse => _ratingResponse;
  bool get isLoading => _isLoading;

  Future<void> fetchSalesPerson() async {
    log('Fetching sales person details from view model');
    _isLoading = true;

    try {
      _salesPersonResponse =
          await _service.fetchSalesPerson(SharedPreferencesServices.token!);
      log(_salesPersonResponse!.data.name);
      if (_salesPersonResponse != null) {
        log('Sales person details fetched successfully ${salesPersonResponse?.toJson().toString()}');
        if (salesPersonResponse?.userRating == 0 ||
            salesPersonResponse?.userRating == null) {
          posted = false;
        } else {
          posted = true;
        }
        log(_salesPersonResponse!.data.email!);
        log("Finally posted: ${posted}");
      }
      notifyListeners(); // Notify listeners that loading has started
    } catch (e) {
      // Handle error
      log('Error fetching sales person details: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that loading has ended
    }
  }

  Future<void> fetchRatings() async {
    log('Fetching ratings from view model');
    _isLoading = true;

    try {
      _ratingResponse =
          await _service.fetchRatings(41, SharedPreferencesServices.token!);
      if (_ratingResponse != null) {
        log('Ratings details fetched successfully');
      }
      notifyListeners(); // Notify listeners that loading has started
    } catch (e) {
      // Handle error
      log('Error fetching ratings : $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that loading has ended
    }
  }

  Future<void> postReview() async {
    _isLoading = true;
    notifyListeners(); // Notify UI that loading has started

    try {
      // Define the request body
      Map<String, dynamic> body = {
        "ratee_id": salesPersonResponse?.data.id,
        "rating": rating,
        "review": commentController.text
      };

      // Call the service to post the review
      final response =
          await _service.postReview(body, SharedPreferencesServices.token!);

      if (response != null) {
        posted = true;
        log('Review posted successfully');
        commentController.clear();
        fetchSalesPerson(); //have to call this in order to show the review
        notifyListeners();
      }
    } catch (e) {
      log('Error posting review: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI that loading has ended
    }
  }
}
