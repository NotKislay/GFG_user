import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/gallery_model/gallery_model.dart';
import 'package:gofriendsgo/services/gallery_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';

class GalleryViewModel extends ChangeNotifier {
  final GalleryService _service = GalleryService();
  GalleryResponse? _galleryResponse;
  bool _isLoading = false;

  GalleryResponse? get galleryResponse => _galleryResponse;
  bool get isLoading => _isLoading;

  Future<void> fetchGallery() async {
    _isLoading = true;

    try {
      _galleryResponse = await _service.fetchGallery(SharedPreferencesServices.token!);
      if (_galleryResponse != null) {
        log('Gallery fetched successfully');
        if (_galleryResponse!.data.galleries.isNotEmpty) {
          log(_galleryResponse!.data.galleries[0].image);
        }
      }
      notifyListeners();
    } catch (e) {
      // Handle error
      log('Error fetching gallery: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
