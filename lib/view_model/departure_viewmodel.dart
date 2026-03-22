import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/detarture_model/departure_model.dart';
import 'package:gofriendsgo/services/departure_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:gofriendsgo/view_model/filter_passports_viewmodel.dart';


class FixedDeparturesViewModel extends ChangeNotifier {
  final FixedDeparturesService _service = FixedDeparturesService();
  FixedDeparturesModel? _fixedDeparturesResponse;
  List<FixedDeparture>? _filteredDepartures;
  bool _isLoading = false;
  
  FixedDeparturesModel? get fixedDeparturesResponse => _fixedDeparturesResponse;
  List<FixedDeparture>? get filteredDepartures => _filteredDepartures;
  bool get isLoading => _isLoading;

  Future<void> fetchFixedDepartures() async {
    _isLoading = true;

    try {
      _fixedDeparturesResponse =
          await _service.fetchFixedDepartures(SharedPreferencesServices.token!);
      _filteredDepartures = _fixedDeparturesResponse?.data.fixedDepartures;
    } catch (e) {
      log('Error fetching fixed departures: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void applyFilters(FilterScreenViewModel filterModel) {
    // Parse the string values to the correct types
    int? selectedHotelRating = filterModel.selectedHotelRating.isNotEmpty
        ? int.tryParse(filterModel.selectedHotelRating)
        : null;

    int selectedMinPrice = filterModel.currentRangeValues.start.toInt();
    int selectedMaxPrice = filterModel.currentRangeValues.end.toInt();

    _filteredDepartures = _fixedDeparturesResponse?.data.fixedDepartures.where((departure) {
      final bool matchesRating = selectedHotelRating == null || 
          departure.rating == selectedHotelRating;
      // final bool matchesDuration = filterModel.selectedDuration.isEmpty || 
      //     _matchesDuration(departure, filterModel.selectedDuration);
      final bool matchesPrice = int.parse(departure.price) >= selectedMinPrice && 
          int.parse(departure.price) <= selectedMaxPrice;
      return matchesRating  && matchesPrice;
    }).toList();
    notifyListeners();
  }

  // bool _matchesDuration(FixedDeparture departure, String selectedDuration) {
  //   int days = _calculateDays(departure);
  //   switch (selectedDuration) {
  //     case 'Upto 3 Nights':
  //       return days <= 3;
  //     case '4 Nights':
  //       return days == 4;
  //     case '5 Nights+':
  //       return days >= 5;
  //     default:
  //       return false;
  //   }
  }

  // int _calculateDays(FixedDeparture departure) {
  //   // Assuming 'from' and 'to' are DateTime or have date information.
  //   // Implement the logic to calculate the number of days.
  //   // Example:
  //   // return departure.to.difference(departure.from).inDays;
  //   return 0;  // Replace with actual calculation
  // }

