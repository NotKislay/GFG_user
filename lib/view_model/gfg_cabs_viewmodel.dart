import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/cab_model/cab_model.dart';
import 'package:gofriendsgo/services/cab_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class GfgCabsViewmodel extends ChangeNotifier {
  final CabService _service = CabService();
  CabModel? _cabResponse;
  bool _isLoading = false;

  CabModel? get cabResponse => _cabResponse;
  bool get isLoading => _isLoading;

  final List<String> _cities = [
    "Mumbai",
    "Delhi",
    "Bengaluru",
    "Hyderabad",
    "Pune",
    "Ahmedabad",
    "Chennai",
  ];

  List<String> _filteredCities = [];
  String? _selectedCity;
  bool _showCityDropdown = false;
  Timer? _debounceTimer;

  List<String> get cities => _cities;
  Timer? get debounceTimer => _debounceTimer;

  List<String> get filteredCities => _filteredCities;

  String? get selectedCity => _selectedCity;

  bool get showCityDropdown => _showCityDropdown;

  void searchCity(String query) {
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      _filteredCities = [];
      _showCityDropdown = false;
      notifyListeners();
      return;
    }
    _showCityDropdown = true;
    notifyListeners();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final searchQuery = query.trim().toLowerCase();
      _filteredCities = _cities
          .where(
              (city) => city.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      _showCityDropdown = true;
      notifyListeners();
    });
  }

  void setSelectedCity(String newCity) {
    _selectedCity = newCity;

    _showCityDropdown = false;
    _filteredCities = [];
    notifyListeners();
  }

  void clearCitySearch() {
    _selectedCity = null;
    _filteredCities = [];
    _showCityDropdown = false;

    _debounceTimer?.cancel();

    notifyListeners();
  }

  Future<void> fetchCabs() async {
    _isLoading = true;

    try {
      _cabResponse = await _service.fetchCabs(SharedPreferencesServices.token!);
      if (_cabResponse != null) {
        log('Cabs fetched successfully');
        if (_cabResponse!.data.cabs.isNotEmpty) {
          log(_cabResponse!.data.cabs[0].type);
        }
      }
    } catch (e) {
      log('Error fetching cabs: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> redirectToPhone(String phoneNumber) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      log('Could not launch phone Call $uri');
    }
  }

  Future<void> redirectToWhatsApp(String phoneNumber) async {
    final Uri uri = Uri.parse("https://wa.me/$phoneNumber");

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
