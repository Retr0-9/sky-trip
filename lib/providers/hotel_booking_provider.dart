// providers/hotel_booking_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/hotel_booking_model.dart';

class HotelBookingProvider extends ChangeNotifier {
  static const String _storageKey = 'hotel_bookings_list';

  List<HotelBookingModel> _bookings = [];

  List<HotelBookingModel> get allHotelBookings => _bookings;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_storageKey);

    if (data != null && data.isNotEmpty) {
      final List<dynamic> decodedList = jsonDecode(data);
      _bookings = decodedList
          .map((item) =>
              HotelBookingModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    notifyListeners();
  }

  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(_bookings.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, data);
  }

  Future<void> addBooking(HotelBookingModel booking) async {
    _bookings.add(booking);
    await _saveToPreferences();
    notifyListeners();
  }

  Future<void> removeBooking(String id) async {
    _bookings.removeWhere((b) => b.id == id);
    await _saveToPreferences();
    notifyListeners();
  }
}
