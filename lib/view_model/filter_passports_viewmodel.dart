import 'package:flutter/material.dart';

class FilterScreenViewModel extends ChangeNotifier {
  String selectedHotelRating = "";
  String selectedDuration = "";
  String selectedPackageType = "";
  String selectedTransportation = "";
  RangeValues currentRangeValues = const RangeValues(0, 500000);

  void resettingSettings() {
    selectedHotelRating = "";
    selectedDuration = "";
    selectedPackageType = "";
    selectedTransportation = "";
    currentRangeValues = const RangeValues(0, 500000);
    notifyListeners();
  }

  void settingRangeValues(RangeValues value) {
    currentRangeValues = value;
    notifyListeners();
  }

  void settingHotelRating(int index) {
    selectedHotelRating = index.toString();
    notifyListeners();
  }

  void settingDuration(String duration) {
    selectedDuration = duration;
    notifyListeners();
  }

  void settingPackageType(String packageType) {
    selectedPackageType = packageType;
    notifyListeners();
  }

  void settingTransportation(String transportation) {
    selectedTransportation = transportation;
    notifyListeners();
  }
}
