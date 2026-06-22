import 'dart:convert';
import 'package:http/http.dart' as http;

/// Thrown when the server rejects credentials or returns an error.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

/// Thrown when login is attempted on an unverified email.
class EmailNotVerifiedException extends AuthException {
  final String email;
  const EmailNotVerifiedException(this.email)
      : super('Please verify your email before logging in.');
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

class RegisterResult {
  final bool success;
  final String message;
  const RegisterResult({required this.success, required this.message});
}

class AuthService {
  static const _base =
      'https://bookingtrip-api-2026-cyh0f4dhfednh3fj.westeurope-01.azurewebsites.net';

  /// Calls POST /api/Login/register.
  static Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required String gender,
    required int countryId,
    required DateTime birthDate,
    required String documentationType,
    required int issueCountryId,
    required DateTime expirationDate,
  }) async {
    final uri = Uri.parse('$_base/api/Login/register');
    final http.Response response;
    try {
      response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email,
              'password': password,
              'firstName': firstName,
              'secondName': '',
              'thirdName': '',
              'lastName': lastName,
              'phone': phone,
              'gender': gender,
              'countryID': countryId,
              'birthDate': birthDate.toIso8601String(),
              'documentationType': documentationType,
              'issueCountryID': issueCountryId,
              'expirationDate': expirationDate.toIso8601String(),
            }),
          )
          .timeout(const Duration(seconds: 20));
    } catch (_) {
      throw const AuthException('Could not reach the server. Check your connection.');
    }

    if (response.statusCode == 200 || response.statusCode == 201) return;

    String msg = 'Registration failed. Please try again.';
    try {
      final body = jsonDecode(response.body);
      if (body is Map) {
        msg = (body['detail'] ?? body['title'] ?? body['message'] ?? msg).toString();
      } else if (body is String && body.isNotEmpty) {
        msg = body;
      }
    } catch (_) {}
    throw AuthException(msg);
  }

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
      throw const AuthException('Invalid email or password.');
    } else if (response.statusCode == 403) {
      try {
        final body = jsonDecode(response.body);
        if (body is Map && body['error'] == 'email_not_verified') {
          throw EmailNotVerifiedException(
            (body['email'] ?? email).toString(),
          );
        }
      } catch (e) {
        if (e is EmailNotVerifiedException) rethrow;
      }
      throw const AuthException('Access denied. Please contact support.');
    } else {
      throw AuthException(
          'Server error (${response.statusCode}). Please try again.');
    }
  }

  /// Calls POST /api/Auth/verify-email.
  static Future<void> verifyEmail(String email, String code) async {
    final uri = Uri.parse('$_base/api/Auth/verify-email');
    final http.Response response;
    try {
      response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'code': code}),
          )
          .timeout(const Duration(seconds: 15));
    } catch (_) {
      throw const AuthException(
          'Could not reach the server. Check your connection.');
    }

    if (response.statusCode == 200) return;

    String msg = 'Verification failed. Please try again.';
    try {
      final body = jsonDecode(response.body);
      if (body is Map) {
        msg = (body['detail'] ?? body['title'] ?? body['message'] ?? msg)
            .toString();
      } else if (body is String && body.isNotEmpty) {
        msg = body;
      }
    } catch (_) {}
    throw AuthException(msg);
  }

  /// Calls POST /api/Auth/resend-code.
  static Future<void> resendCode(String email) async {
    final uri = Uri.parse('$_base/api/Auth/resend-code');
    final http.Response response;
    try {
      response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email}),
          )
          .timeout(const Duration(seconds: 15));
    } catch (_) {
      throw const AuthException(
          'Could not reach the server. Check your connection.');
    }

    if (response.statusCode == 200) return;

    String msg = 'Could not resend code. Please try again.';
    try {
      final body = jsonDecode(response.body);
      if (body is Map) {
        msg = (body['detail'] ?? body['title'] ?? body['message'] ?? msg)
            .toString();
      } else if (body is String && body.isNotEmpty) {
        msg = body;
      }
    } catch (_) {}
    throw AuthException(msg);
  }
}
