import 'package:flutter/foundation.dart';
import '../models/flight_model.dart';
import '../models/booking_search_model.dart';
import '../models/passenger_model.dart';

/// Tracks the state of the entire booking flow.
/// Accessible from any screen or widget via context.read/watch.
class BookingProvider extends ChangeNotifier {
  // ─────────────────────────────────────────────
  // BOOKING FLOW STATE
  // ─────────────────────────────────────────────

  BookingSearchModel? _search;
  FlightModel? _selectedFlight;
  List<PassengerModel> _passengers = [];
  String? _selectedSeat;
  int _mealCount = 0;
  bool _wheelchairSelected = false;
  bool _specialAssistanceSelected = false;
  bool _seatSelectionSelected = false;

  // ─────────────────────────────────────────────
  // GETTERS
  // ─────────────────────────────────────────────

  BookingSearchModel? get search => _search;
  FlightModel? get selectedFlight => _selectedFlight;
  List<PassengerModel> get passengers => List.unmodifiable(_passengers);
  String? get selectedSeat => _selectedSeat;
  int get mealCount => _mealCount;
  bool get wheelchairSelected => _wheelchairSelected;
  bool get specialAssistanceSelected => _specialAssistanceSelected;
  bool get seatSelectionSelected => _seatSelectionSelected;

  /// True when user has started but not completed a booking
  bool get isInBookingFlow => _selectedFlight != null;

  // ─────────────────────────────────────────────
  // PRICE CALCULATIONS
  // ─────────────────────────────────────────────

  double get flightPrice => _selectedFlight?.price ?? 0.0;
  String get currency => _selectedFlight?.currency ?? 'JOD';
  int get passengerCount => _search?.totalPassengers ?? 1;

  double get baseFare => flightPrice * passengerCount;
  double get taxes => baseFare * 0.15;
  double get mealsTotal => _mealCount * 15.0;
  double get seatTotal => _seatSelectionSelected ? 10.0 : 0.0;
  double get specialTotal => _specialAssistanceSelected ? 25.0 : 0.0;
  double get grandTotal => baseFare + taxes + mealsTotal + seatTotal + specialTotal;

  // ─────────────────────────────────────────────
  // SEARCH & FLIGHT SELECTION
  // ─────────────────────────────────────────────

  void setSearch(BookingSearchModel search) {
    _search = search;
    notifyListeners();
  }

  void selectFlight(FlightModel flight) {
    _selectedFlight = flight;
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // PASSENGERS
  // ─────────────────────────────────────────────

  void addPassenger(PassengerModel passenger) {
    _passengers.add(passenger);
    notifyListeners();
  }

  void updatePassenger(int index, PassengerModel passenger) {
    if (index >= 0 && index < _passengers.length) {
      _passengers[index] = passenger;
      notifyListeners();
    }
  }

  void clearPassengers() {
    _passengers = [];
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // SERVICES
  // ─────────────────────────────────────────────

  void setMealCount(int count) {
    _mealCount = count < 0 ? 0 : count;
    notifyListeners();
  }

  void toggleWheelchair() {
    _wheelchairSelected = !_wheelchairSelected;
    notifyListeners();
  }

  void toggleSpecialAssistance() {
    _specialAssistanceSelected = !_specialAssistanceSelected;
    notifyListeners();
  }

  void toggleSeatSelection() {
    _seatSelectionSelected = !_seatSelectionSelected;
    // Clear seat if deselected
    if (!_seatSelectionSelected) _selectedSeat = null;
    notifyListeners();
  }

  void selectSeat(String seatId) {
    _selectedSeat = seatId;
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // FLOW CONTROL
  // ─────────────────────────────────────────────

  /// Call this when booking is completed or cancelled
  void resetBooking() {
    _search = null;
    _selectedFlight = null;
    _passengers = [];
    _selectedSeat = null;
    _mealCount = 0;
    _wheelchairSelected = false;
    _specialAssistanceSelected = false;
    _seatSelectionSelected = false;
    notifyListeners();
  }
}
