import 'dart:convert';
import 'package:http/http.dart' as http;

/// Thrown when the server rejects credentials or returns an error.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

/// The data returned by a successful login.
class LoginResult {
  final String token;
  final int userId;
  final int personId;
  final int clientId;
  final String email;
  final String role;

  const LoginResult({
    required this.token,
    required this.userId,
    required this.personId,
    required this.clientId,
    required this.email,
    required this.role,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      token: json['token'] as String,
      userId: json['userId'] as int,
      personId: json['personId'] as int,
      clientId: json['clientId'] as int,
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }
}

class AuthService {
  static const _base =
      'https://bookingtrip-api-2026-cyh0f4dhfednh3fj.westeurope-01.azurewebsites.net';

  /// Calls POST /api/Login/login.
  /// Throws [AuthException] on 401 or server errors.
  /// Throws a generic [Exception] on network failure.
  static Future<LoginResult> login(String email, String password) async {
    final uri = Uri.parse('$_base/api/Login/login');

    final http.Response response;
    try {
      response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 15));
    } catch (_) {
      throw const AuthException(
          'Could not reach the server. Check your connection.');
    }

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return LoginResult.fromJson(json);
    } else if (response.statusCode == 401) {
      // Server returns plain-text "Invalid credentials"
      throw const AuthException('Invalid email or password.');
    } else {
      throw AuthException(
          'Server error (${response.statusCode}). Please try again.');
    }
  }
}
