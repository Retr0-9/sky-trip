import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country_model.dart';
import 'api_client.dart';

class CountryService {
  static const _base =
      'https://bookingtrip-api-2026-cyh0f4dhfednh3fj.westeurope-01.azurewebsites.net';

  /// GET /api/Country/All (authenticated)
  static Future<List<CountryModel>> getAllCountries(String token) async {
    final res = await ApiClient.get('/api/Country/All', token);
    return _parse(res.body);
  }

  /// GET /api/Country/All without a token — used during sign-up before login.
  static Future<List<CountryModel>> getAllPublic() async {
    try {
      final res = await http
          .get(Uri.parse('$_base/api/Country/All'))
          .timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) return _parse(res.body);
    } catch (_) {}
    return [];
  }

  static List<CountryModel> _parse(String body) {
    final decoded = jsonDecode(body);
    final list = decoded is List
        ? decoded
        : (decoded is Map ? (decoded[r'$values'] ?? decoded['value'] ?? decoded['data'] ?? []) : []);
    return (list as List)
        .map((j) => CountryModel.fromJson(j as Map<String, dynamic>))
        .toList();
  }
}
