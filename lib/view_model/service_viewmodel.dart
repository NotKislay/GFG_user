import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/service_model/serivce_model.dart';
import 'package:gofriendsgo/services/service_fetch.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';

class ServiceViewModel extends ChangeNotifier {
  final ServiceService _service = ServiceService();
  List<ServiceModel> _services = [];
  bool _isLoading = false;

  List<ServiceModel> get services => _services;
  bool get isLoading => _isLoading;
  Future<void> fetchServices() async {
    _isLoading = true;

    try {
      _services = await _service.fetchServices(SharedPreferencesServices.token!);
      notifyListeners();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
