import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/bookings_model/bookings_model.dart';
import 'package:gofriendsgo/services/booking_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';

class BookingViewModel extends ChangeNotifier {
  final BookingService _service = BookingService();

  BookingResponse? _bookingResponse;
  List<BookingModel> _originalBookings = [];
  List<BookingModel> _filteredBookings = [];

  bool _isLoading = false;

  BookingResponse? get bookingResponse => _bookingResponse;
  List<BookingModel> get filteredBookings => _filteredBookings;
  bool get isLoading => _isLoading;

  Future<void> fetchBookingsfromservice() async {
    log('Fetching bookings started');
    _isLoading = true;

    try {
      _bookingResponse =
          await _service.fetchBookings(SharedPreferencesServices.token!);
      if (_bookingResponse != null) {
        log('Bookings fetched successfully');
        _originalBookings = _bookingResponse!.data.bookings;
        _filteredBookings = _originalBookings;
        if (_originalBookings.isNotEmpty) {
          log(_originalBookings[0].services);
        }
      }
      notifyListeners();
    } catch (e) {
      // Handle error
      log('Error fetching bookings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterBookings(String query) {
    log('filter started');
    if (query.isEmpty) {
      _filteredBookings = _originalBookings;
    } else {
      log('filter avandyeth aahnyy');
      _filteredBookings = _originalBookings.where((booking) {
        return (booking.services.toLowerCase().contains(query.toLowerCase()) ||
            booking.sector.toLowerCase().contains(query.toLowerCase()) ||
            booking.amount.contains(query));
      }).toList();
    }
    notifyListeners();
  }
}
