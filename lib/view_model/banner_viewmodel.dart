import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/banner_model/banner_model.dart';
import 'package:gofriendsgo/services/banner_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';

class BannerViewModel extends ChangeNotifier {
  final BannerService _service = BannerService();
  BannersModel? _bannersResponse;
  bool _isLoading = false;

  BannersModel? get bannersResponse => _bannersResponse;
  bool get isLoading => _isLoading;

  Future<void> fetchBanners() async {
    _isLoading = true;

    try {
      _bannersResponse =
          await _service.fetchBanner(SharedPreferencesServices.token!);
      if (_bannersResponse != null) {
        log('Banners fetched successfully');
        // log(Banner());
        // For example, logging the name of the first banner item if it exists
        if (_bannersResponse!.data.banners.isNotEmpty) {
          log(_bannersResponse!.data.banners[0].image);
        }
      }
      notifyListeners();
    } catch (e) {
      // Handle error
      log('Error fetching banners: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
