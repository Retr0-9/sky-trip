// providers/vehicle_provider.dart
import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import '../models/vehicle.dart';
import '../models/booked_vehicle_model.dart';

class VehicleProvider extends ChangeNotifier {
  
  static const String _storageKey = 'vehicle_bookings_list';
  
  List<BookedVehicleModel> _bookedVehicles = [];

  final List<Vehicle> _vehicles = [
    Vehicle(
      name: 'Toyota Camry',
      type: 'Economy',
      seats: 5,
      bags: 3,
      rating: 4.5,
      price: 45.0,
      features: ['AC', 'Bluetooth', 'GPS'],
    ),
    
    Vehicle(
      name: 'Hyundai Tucson',
      type: 'SUV',
      seats: 7,
      bags: 4,
      rating: 4.7,
      price: 75.0,
      features: ['AC', 'Bluetooth', 'GPS', 'AWD'],
    ),
    Vehicle(
      name: 'Mercedes Sprinter',
      type: 'Van',
      seats: 12,
      bags: 8,
      rating: 4.6,
      price: 120.0,
      features: ['AC', 'WiFi', 'USB Charging'],
    ),
    Vehicle(
      name: 'BMW 7 Series',
      type: 'Luxury',
      seats: 4,
      bags: 3,
      rating: 4.9,
      price: 200.0,
      features: ['AC', 'Heated Seats', 'Massage', 'GPS'],
    ),
  ];

  String _selectedType = 'All';

  // --- Getters ---
  
  List<Vehicle> get filteredVehicles {
    if (_selectedType == 'All') return _vehicles;
    return _vehicles.where((v) => v.type == _selectedType).toList();
  }

  List<BookedVehicleModel> get allVehicles => _bookedVehicles;

  String get selectedType => _selectedType;

  // --- Methods ---

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_storageKey);

    if (data != null && data.isNotEmpty) {
      final List<dynamic> decodedList = jsonDecode(data);
      _bookedVehicles = decodedList
          .map((item) => BookedVehicleModel.fromJson(item))
          .toList();
    }
    notifyListeners();
  }

  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(_bookedVehicles.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, data);
  }

  void setType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  
  Future<void> addBookedVehicle(BookedVehicleModel booking) async {
    _bookedVehicles.add(booking);
    await _saveToPreferences(); 
    notifyListeners();
  }

  // 
  Future<void> removeBookedVehicle(String id) async {
    _bookedVehicles.removeWhere((b) => b.id == id);
    await _saveToPreferences(); 
    notifyListeners();
  }
}