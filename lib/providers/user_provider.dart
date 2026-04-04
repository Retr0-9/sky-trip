import 'package:flutter/foundation.dart';
import '../services/profile_service.dart';

/// Manages user session and profile data.
class UserProvider extends ChangeNotifier {
  // ─────────────────────────────────────────────
  // USER STATE
  // ─────────────────────────────────────────────

  bool _isLoggedIn = false;
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phone = '';
  String _nationality = '';
  String _passportNumber = '';
  String _preferredClass = 'Economy';
  String _loyaltyNumber = '';
  String _loyaltyTier = 'Silver';
  int _milesBalance = 0;

  // Auth fields from API
  String _token = '';
  int _userId = 0;
  int _personId = 0;
  int _clientId = 0;
  String _role = '';

  // ─────────────────────────────────────────────
  // GETTERS
  // ─────────────────────────────────────────────

  bool get isLoggedIn => _isLoggedIn;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get fullName => '$_firstName $_lastName';
  String get email => _email;
  String get phone => _phone;
  String get nationality => _nationality;
  String get passportNumber => _passportNumber;
  String get preferredClass => _preferredClass;
  String get loyaltyNumber => _loyaltyNumber;
  String get loyaltyTier => _loyaltyTier;
  int get milesBalance => _milesBalance;
  String get token => _token;
  int get userId => _userId;
  int get personId => _personId;
  int get clientId => _clientId;
  String get role => _role;

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  // ─────────────────────────────────────────────
  // ACTIONS
  // ─────────────────────────────────────────────

  void updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? nationality,
    String? passportNumber,
    String? preferredClass,
  }) {
    if (firstName != null) _firstName = firstName;
    if (lastName != null) _lastName = lastName;
    if (email != null) _email = email;
    if (phone != null) _phone = phone;
    if (nationality != null) _nationality = nationality;
    if (passportNumber != null) _passportNumber = passportNumber;
    if (preferredClass != null) _preferredClass = preferredClass;
    notifyListeners();
  }

  void login({
    required String firstName,
    required String lastName,
    required String email,
    String token = '',
    int userId = 0,
    int personId = 0,
    int clientId = 0,
    String role = '',
  }) {
    _isLoggedIn = true;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _token = token;
    _userId = userId;
    _personId = personId;
    _clientId = clientId;
    _role = role;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _firstName = '';
    _lastName = '';
    _email = '';
    _milesBalance = 0;
    _token = '';
    _userId = 0;
    _personId = 0;
    _clientId = 0;
    _role = '';
    notifyListeners();
  }

  void addMiles(int miles) {
    _milesBalance += miles;
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // PROFILE SYNC
  // ─────────────────────────────────────────────

  /// Fetches GET /api/profile/me and populates full profile fields.
  /// Called silently after login — does not block navigation.
  Future<void> loadProfile() async {
    if (_token.isEmpty) return;
    try {
      final profile = await ProfileService.getMyProfile(_token);
      _firstName   = profile.firstName.isNotEmpty ? profile.firstName : _firstName;
      _lastName    = profile.lastName.isNotEmpty  ? profile.lastName  : _lastName;
      _email       = profile.email.isNotEmpty     ? profile.email     : _email;
      _phone       = profile.phone       ?? _phone;
      _nationality = profile.countryName ?? _nationality;
      notifyListeners();
    } catch (_) {
      // Silently ignore — profile will show what login returned
    }
  }
}
