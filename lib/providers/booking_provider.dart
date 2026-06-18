import 'package:flutter/foundation.dart';
import '../models/flight_model.dart';
import '../models/flight_schedule_model.dart';
import '../models/booking_search_model.dart';
import '../models/passenger_model.dart';
import '../models/service_model.dart';

/// Tracks the state of the entire booking flow.
/// Accessible from any screen or widget via context.read/watch.
class BookingProvider extends ChangeNotifier {
  // ─────────────────────────────────────────────
  // BOOKING FLOW STATE
  // ─────────────────────────────────────────────

  BookingSearchModel? _search;

  // Legacy FlightModel (used by dummy screens still in transition)
  FlightModel? _selectedFlight;

  // API FlightScheduleModel (used by all new API-connected screens)
  FlightScheduleModel? _selectedSchedule;

  List<PassengerModel> _passengers = [];
  String? _selectedSeat;

  // Server-side IDs accumulated during the booking flow
  int? _bookId;
  int? _ticketId;
  int? _selectedClassId;
  int? _tripTypeId;

  // Services — loaded from API + user selections (serviceId → quantity)
  List<ServiceModel> _availableServices = [];
  Map<int, int> _selectedServices = {};

  // Legacy service toggles (kept for SeatMap routing + backward compat)
  int _mealCount = 0;
  bool _wheelchairSelected = false;
  bool _specialAssistanceSelected = false;
  bool _seatSelectionSelected = false;

  // ─────────────────────────────────────────────
  // GETTERS
  // ─────────────────────────────────────────────

  BookingSearchModel? get search          => _search;
  FlightModel?        get selectedFlight  => _selectedFlight;
  FlightScheduleModel? get selectedSchedule => _selectedSchedule;
  List<PassengerModel> get passengers     => List.unmodifiable(_passengers);
  String? get selectedSeat                => _selectedSeat;
  int? get bookId                         => _bookId;
  int? get ticketId                       => _ticketId;
  int? get selectedClassId                => _selectedClassId;
  int? get tripTypeId                     => _tripTypeId;
  List<ServiceModel>  get availableServices => List.unmodifiable(_availableServices);
  Map<int, int>       get selectedServices  => Map.unmodifiable(_selectedServices);

  int  get mealCount                  => _mealCount;
  bool get wheelchairSelected         => _wheelchairSelected;
  bool get specialAssistanceSelected  => _specialAssistanceSelected;
  bool get seatSelectionSelected      => _seatSelectionSelected;

  /// True when user has started but not completed a booking
  bool get isInBookingFlow =>
      _selectedSchedule != null || _selectedFlight != null;

  // ─────────────────────────────────────────────
  // PRICE CALCULATIONS
  // ─────────────────────────────────────────────

  /// Unit price for selected flight (prefers API schedule)
  double get flightPrice =>
      _selectedSchedule?.basePrice ?? _selectedFlight?.price ?? 0.0;

  String get currency => _selectedFlight?.currency ?? 'JOD';

  int get passengerCount => _search?.totalPassengers ?? 1;

  double get baseFare => flightPrice * passengerCount;
  double get taxes    => baseFare * 0.15;

  /// Total from API-sourced selected services
  double get servicesTotal {
    double total = 0;
    for (final entry in _selectedServices.entries) {
      final svc = _availableServices
          .where((s) => s.serviceId == entry.key)
          .firstOrNull;
      if (svc != null) total += svc.fees * entry.value;
    }
    return total;
  }

  // Legacy price helpers (used by old screens still in transition)
  double get mealsTotal  => _mealCount * 15.0;
  double get seatTotal   => _seatSelectionSelected ? 10.0 : 0.0;
  double get specialTotal => _specialAssistanceSelected ? 25.0 : 0.0;

  double get grandTotal =>
      baseFare + taxes + servicesTotal + mealsTotal + seatTotal + specialTotal;

  // ─────────────────────────────────────────────
  // SEARCH & FLIGHT SELECTION
  // ─────────────────────────────────────────────

  void setSearch(BookingSearchModel search) {
    _search = search;
    notifyListeners();
  }

  /// Legacy: used by dummy-data screens
  void selectFlight(FlightModel flight) {
    _selectedFlight = flight;
    notifyListeners();
  }

  /// API: used by new screens connected to backend
  void selectSchedule(FlightScheduleModel schedule) {
    _selectedSchedule = schedule;
    _selectedFlight = null; // clear legacy when API schedule is set
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // SERVER IDs
  // ─────────────────────────────────────────────

  void setBookId(int id) {
    _bookId = id;
    notifyListeners();
  }

  void setTicketId(int id) {
    _ticketId = id;
    notifyListeners();
  }

  void setSelectedClassId(int id) {
    _selectedClassId = id;
    notifyListeners();
  }

  void setTripTypeId(int id) {
    _tripTypeId = id;
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
  // SERVICES (API-driven)
  // ─────────────────────────────────────────────

  void setAvailableServices(List<ServiceModel> services) {
    _availableServices = services;
    notifyListeners();
  }

  void setServiceQuantity(int serviceId, int quantity) {
    if (quantity <= 0) {
      _selectedServices.remove(serviceId);
    } else {
      _selectedServices[serviceId] = quantity;
    }
    notifyListeners();
  }

  int getServiceQuantity(int serviceId) =>
      _selectedServices[serviceId] ?? 0;

  void clearSelectedServices() {
    _selectedServices = {};
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // SERVICES (legacy toggles)
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

  void resetBooking() {
    _search = null;
    _selectedFlight = null;
    _selectedSchedule = null;
    _passengers = [];
    _selectedSeat = null;
    _bookId = null;
    _ticketId = null;
    _selectedClassId = null;
    _tripTypeId = null;
    _availableServices = [];
    _selectedServices = {};
    _mealCount = 0;
    _wheelchairSelected = false;
    _specialAssistanceSelected = false;
    _seatSelectionSelected = false;
    notifyListeners();
  }
}
