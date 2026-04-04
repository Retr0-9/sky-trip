import 'dart:convert';
import '../models/country_model.dart';
import 'api_client.dart';

class CountryService {
  /// GET /api/Country/All
  static Future<List<CountryModel>> getAllCountries(String token) async {
    final res = await ApiClient.get('/api/Country/All', token);
    final list = jsonDecode(res.body) as List<dynamic>;
    return list
        .map((j) => CountryModel.fromJson(j as Map<String, dynamic>))
        .toList();
  }
}
