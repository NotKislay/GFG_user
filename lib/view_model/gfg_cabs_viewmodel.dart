import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/quick_rides_model/quick_ride_model.dart';
import 'package:gofriendsgo/model/quick_rides_model/quick_rides_location_model.dart';
import 'package:gofriendsgo/services/quick_rides_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickRidesViewmodel extends ChangeNotifier {
  final QuickRideService _service = QuickRideService();
  QuickRideModel? _quickRideResponse;
  QuickRideLocationModel? _quickRideLocationResponse;
  bool _isLoadingCities = false;
  bool _isLoadingRides = false;

  QuickRideModel? get quickRideResponse => _quickRideResponse;
  QuickRideLocationModel? get quickRideLocationResponse =>
      _quickRideLocationResponse;
  bool get isLoadingCities => _isLoadingCities;
  bool get isLoadingRides => _isLoadingRides;

  List<CityModel> _cities = [];
  List<QuickRide> _rides = [];

  bool hasMore = true;

  int currentPage = 1;
  final int perPage = 3;

  String? _selectedCity;
  int? _selectedLocationId;
  bool _showCityDropdown = false;
  Timer? _debounceTimer;

  List<CityModel> get cities => _cities;
  List<QuickRide> get rides => _rides;
  Timer? get debounceTimer => _debounceTimer;

  String? get selectedCity => _selectedCity;

  bool get showCityDropdown => _showCityDropdown;

  Future<void> loadInitial() async {
    currentPage = 1;
    hasMore = true;
    _selectedLocationId = null;
    _rides = [];
    _quickRideResponse = null;

    await loadMore();
  }

  Future<void> loadMore() async {
    if (_isLoadingRides || !hasMore) return;

    _isLoadingRides = true;
    notifyListeners();

    try {
      final result = await _service.getQuickRides(
        page: currentPage,
        perPage: perPage,
        token: SharedPreferencesServices.token!,
        locationId: _selectedLocationId,
      );

      _quickRideResponse = result;
      final parsedRides = result.data.quickRides;

      if (currentPage == 1) {
        _rides = List.from(parsedRides);
      } else {
        _rides.addAll(parsedRides);
      }

      if (parsedRides.length < perPage) {
        hasMore = false;
      } else {
        currentPage++;
      }
    } catch (e) {
      log('Error loading quick rides: $e');
    } finally {
      _isLoadingRides = false;
      notifyListeners();
    }
  }

  void searchCity(String query) {
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      _cities = [];
      _showCityDropdown = false;
      notifyListeners();
      return;
    }
    _showCityDropdown = true;
    notifyListeners();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final searchQuery = query.trim().toLowerCase();
      fetchCities(searchQuery);

      _showCityDropdown = true;
      notifyListeners();
    });
  }

  Future<void> setSelectedCity(int id, String name) async {
    _selectedCity = name;
    _selectedLocationId = id;
    _showCityDropdown = false;
    currentPage = 1;
    hasMore = true;
    _rides = [];
    notifyListeners();

    await fetchRides(id);
  }

  void clearCitySearch() {
    _selectedCity = null;
    _selectedLocationId = null;
    _cities = [];
    _rides = [];
    _quickRideResponse = null;
    _showCityDropdown = false;
    currentPage = 1;
    hasMore = true;

    loadInitial();
    //Reload initial data when city is cleared

    _debounceTimer?.cancel();

    notifyListeners();
  }

  Future<void> fetchCities(String query) async {
    _isLoadingCities = true;
    notifyListeners();

    try {
      _quickRideLocationResponse = await _service.fetchCitiesOnSearch(
          query, SharedPreferencesServices.token!);
      if (_quickRideLocationResponse != null) {
        log('Cities fetched successfully');
        _cities = _quickRideLocationResponse!.data.locations
            .map((location) => CityModel(name: location.name, id: location.id))
            .toList();
      }
    } catch (e) {
      log('Error fetching cities: $e');
    } finally {
      _isLoadingCities = false;
      notifyListeners();
    }
  }

  Future<void> fetchRides(int id) async {
    if (_isLoadingRides || !hasMore) return;

    _isLoadingRides = true;
    notifyListeners();

    try {
      final result = await _service.getQuickRides(
        page: currentPage,
        perPage: perPage,
        token: SharedPreferencesServices.token!,
        locationId: id,
      );

      _quickRideResponse = result;
      final parsedRides = result.data.quickRides;
      _rides = List.from(parsedRides);

      if (parsedRides.length < perPage) {
        hasMore = false;
      } else {
        currentPage++;
        hasMore = true;
      }

      if (_quickRideResponse != null &&
          _quickRideResponse!.data.quickRides.isNotEmpty) {
        log(_quickRideResponse!.data.quickRides[0].toJson().toString());
      }
    } catch (e) {
      log('Error fetching quick rides: $e');
    } finally {
      _isLoadingRides = false;
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

class CityModel {
  final String name;
  final int id;

  CityModel({required this.name, required this.id});
}
