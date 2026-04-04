import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

/// Base authenticated HTTP client.
/// Every request automatically injects `Authorization: Bearer {token}`.
/// Throws [AuthException] on 401 so callers can redirect to login.
class ApiClient {
  static const _base =
      'https://bookingtrip-api-2026-cyh0f4dhfednh3fj.westeurope-01.azurewebsites.net';

  static const Duration _timeout = Duration(seconds: 20);

  static Map<String, String> _headers(String token) => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  // ── GET ────────────────────────────────────────────────────────────────────

  static Future<http.Response> get(String path, String token) async {
    try {
      final res = await http
          .get(Uri.parse('$_base$path'), headers: _headers(token))
          .timeout(_timeout);
      _checkStatus(res);
      return res;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw _networkError(e);
    }
  }

  // ── POST (JSON) ────────────────────────────────────────────────────────────

  static Future<http.Response> post(
      String path, Map<String, dynamic> body, String token) async {
    try {
      final res = await http
          .post(Uri.parse('$_base$path'),
              headers: _headers(token), body: jsonEncode(body))
          .timeout(_timeout);
      _checkStatus(res);
      return res;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw _networkError(e);
    }
  }

  // ── POST (multipart/form-data) ─────────────────────────────────────────────

  static Future<http.Response> postMultipart(
    String path,
    Map<String, String> fields,
    Map<String, http.MultipartFile> files,
    String token,
  ) async {
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse('$_base$path'))
            ..headers['Authorization'] = 'Bearer $token'
            ..fields.addAll(fields)
            ..files.addAll(files.values);

      final streamed = await request.send().timeout(_timeout);
      final res = await http.Response.fromStream(streamed);
      _checkStatus(res);
      return res;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw _networkError(e);
    }
  }

  // ── PUT ────────────────────────────────────────────────────────────────────

  static Future<http.Response> put(
      String path, Map<String, dynamic> body, String token) async {
    try {
      final res = await http
          .put(Uri.parse('$_base$path'),
              headers: _headers(token), body: jsonEncode(body))
          .timeout(_timeout);
      _checkStatus(res);
      return res;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw _networkError(e);
    }
  }

  // ── DELETE ─────────────────────────────────────────────────────────────────

  static Future<http.Response> delete(String path, String token) async {
    try {
      final res = await http
          .delete(Uri.parse('$_base$path'), headers: _headers(token))
          .timeout(_timeout);
      _checkStatus(res);
      return res;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw _networkError(e);
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  static void _checkStatus(http.Response res) {
    if (res.statusCode == 401) {
      throw const AuthException('Session expired. Please log in again.');
    }
    if (res.statusCode >= 400) {
      // Try to extract a message from the response body
      String msg = 'Server error (${res.statusCode}).';
      try {
        final body = jsonDecode(res.body);
        if (body is Map) {
          msg = (body['detail'] ?? body['title'] ?? msg).toString();
        } else if (body is String) {
          msg = body;
        }
      } catch (_) {}
      throw AuthException(msg);
    }
  }

  static AuthException _networkError(Object e) =>
      const AuthException('Could not reach the server. Check your connection.');

  /// Convenience: decode response body as JSON map.
  static Map<String, dynamic> decodeMap(http.Response res) =>
      jsonDecode(res.body) as Map<String, dynamic>;

  /// Convenience: decode response body as JSON list.
  static List<dynamic> decodeList(http.Response res) =>
      jsonDecode(res.body) as List<dynamic>;
}
