import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/teams_model/teams_model.dart';
import 'package:gofriendsgo/services/teams_service.dart'; // Update with the actual path to your Teams service class
import 'package:gofriendsgo/services/shared_preferences.dart'; // Update with the actual path to your SharedPreferences service class

class TeamsViewModel extends ChangeNotifier {
  final TeamsService _service = TeamsService();
  TeamsResponse? _teamsResponse;
  bool _isLoading = false;

  TeamsResponse? get teamsResponse => _teamsResponse;
  bool get isLoading => _isLoading;

  Future<void> fetchTeams() async {
    log('Fetching teams details from view model');
    _isLoading = true;

    try {
      _teamsResponse =
          await _service.fetchTeams(SharedPreferencesServices.token!);
      if (_teamsResponse != null) {
        log('Teams details fetched successfully');
        // Example: logging the name of the first team if it exists
        if (_teamsResponse!.data.teams.isNotEmpty) {
          log(_teamsResponse!.data.teams[0].designation);
        }
      }
      notifyListeners();
    } catch (e) {
      // Handle error
      log('Error fetching teams details: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that loading has ended
    }
  }
}
