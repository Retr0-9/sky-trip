import 'package:flutter/foundation.dart';

/// Manages user session and profile data.
/// TODO: Connect to Firebase Auth in Phase 6.
class UserProvider extends ChangeNotifier {
  // ─────────────────────────────────────────────
  // USER STATE
  // ─────────────────────────────────────────────

  bool _isLoggedIn = true; // TODO: Default to false when Auth is connected
  String _firstName = 'John';
  String _lastName = 'Doe';
  String _email = 'john.doe@email.com';
  String _phone = '+962 79 123 4567';
  String _nationality = 'Jordanian';
  String _passportNumber = 'A12345678';
  String _preferredClass = 'Economy';
  String _loyaltyNumber = 'RJ-9876543';
  String _loyaltyTier = 'Silver';
  int _milesBalance = 12450;

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
  }) {
    _isLoggedIn = true;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _firstName = '';
    _lastName = '';
    _email = '';
    _milesBalance = 0;
    notifyListeners();
  }

  void addMiles(int miles) {
    _milesBalance += miles;
    notifyListeners();
  }
}
