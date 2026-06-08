import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/profile_service.dart';

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
  String? _profileImageUrl;

  // ─────────────────────────────────────────────
  // THEME & LOCALIZATION STATE
  // ─────────────────────────────────────────────
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');
  String _currency = 'JOD';

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  String get currency => _currency;

  /// Currency conversion rates (from JOD)
  static const Map<String, double> _conversionRates = {
    'JOD': 1.0,
    'USD': 0.71,
    'EUR': 0.65,
    'GBP': 0.56,
    'AED': 2.61,
  };

  /// Convert price from JOD to current currency
  double convertPrice(double price) {
    final rate = _conversionRates[_currency] ?? 1.0;
    return price * rate;
  }

  /// Toggle dark/light theme and save preference
  Future<void> toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  /// Load theme preference on app start
  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  /// Change language and save preference
  Future<void> changeLanguage(String code) async {
    _locale = Locale(code);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', code);

    notifyListeners();
  }

  /// Load language preference on app start
  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('language') ?? 'en';
    _locale = Locale(langCode);
    notifyListeners();
  }

  /// Change currency and save preference
  Future<void> setCurrency(String currencyCode) async {
    _currency = currencyCode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency', currencyCode);
  }

  /// Load currency preference on app start
  Future<void> loadCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    _currency = prefs.getString('currency') ?? 'JOD';
    notifyListeners();
  }

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
  String? get profileImageUrl => _profileImageUrl;

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

  void setProfileImageUrl(String url) {
    _profileImageUrl = url;
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
      _phone            = profile.phone            ?? _phone;
      _nationality      = profile.countryName      ?? _nationality;
      final rawUrl = profile.profileImageUrl;
      if (rawUrl != null) {
        _profileImageUrl = rawUrl.startsWith('http')
            ? rawUrl
            : 'https://bookingtrip-api-2026-cyh0f4dhfednh3fj.westeurope-01.azurewebsites.net$rawUrl';
      }
      notifyListeners();
    } catch (_) {
      // Silently ignore — profile will show what login returned
    }
  }
}