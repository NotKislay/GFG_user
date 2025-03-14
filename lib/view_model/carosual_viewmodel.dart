import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/carosual_model/carosual_model.dart';
import 'package:gofriendsgo/services/carosual_fetch.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';

class CarousalViewModel extends ChangeNotifier {
  final CarousalsService _service = CarousalsService();
  CarouselsModel? _carouselsModel;
  bool _isLoading = false;

  CarouselsModel? get carouselsModel => _carouselsModel;
  bool get isLoading => _isLoading;

  Future<void> fetchCarousals() async {
    _isLoading = true;
 

    try {
      _carouselsModel = await _service.fetchCarousals(SharedPreferencesServices.token!);
      if (_carouselsModel != null) {
        log('Carousels fetched successfully');
        // For example, logging the title of the first carousel item if it exists
        if (_carouselsModel!.data.isNotEmpty) {
          log(_carouselsModel!.data[0].title);
        }
      }   notifyListeners();
    } catch (e) {
      // Handle error
      log('Error fetching carousals: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
