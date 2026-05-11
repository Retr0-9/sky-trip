import 'dart:convert';
import '../models/flight_schedule_model.dart';
import '../models/passenger_class_model.dart';
import '../models/trip_type_model.dart';
import 'api_client.dart';

class FlightService {
  /// GET /api/FlightSchedules/Cities → list of city name strings
  static Future<List<String>> getCities(String token) async {
    final res = await ApiClient.get('/api/FlightSchedules/Cities', token);
    final list = jsonDecode(res.body) as List<dynamic>;
    // Deduplicate and filter blanks; preserve original order via LinkedHashSet
    final seen = <String>{};
    return list
        .map((e) => e.toString().trim())
        .where((s) => s.isNotEmpty && seen.add(s))
        .toList();
  }

  /// POST /api/FlightSchedules/Search — one-way (covers the entire selected day)
  static Future<List<FlightScheduleModel>> searchOneWay(
    String from,
    String to,
    DateTime date,
    String token, {
    int? classId,
  }) async {
    final res = await ApiClient.post(
      '/api/FlightSchedules/Search',
      _buildSearchBody(from, to, date, date, classId),
      token,
    );
    return _parseList(res.body);
  }

  /// POST /api/FlightSchedules/Search — round-trip outbound leg
  static Future<List<FlightScheduleModel>> searchRoundTrip(
    String from,
    String to,
    DateTime departureDate,
    DateTime returnDate,
    String token, {
    int? classId,
  }) async {
    // Search for outbound flights on the departure date
    final res = await ApiClient.post(
      '/api/FlightSchedules/Search',
      _buildSearchBody(from, to, departureDate, departureDate, classId),
      token,
    );
    return _parseList(res.body);
  }

  static Map<String, dynamic> _buildSearchBody(
    String from,
    String to,
    DateTime dateFrom,
    DateTime dateTo,
    int? classId,
  ) {
    // Cover the full calendar day: 00:00:00 → 23:59:59
    final start = DateTime(dateFrom.year, dateFrom.month, dateFrom.day);
    final end = DateTime(dateTo.year, dateTo.month, dateTo.day, 23, 59, 59);
    return {
      'departureCity': from,
      'arrivalCity': to,
      'flightDateFrom': start.toIso8601String(),
      'flightDateTo': end.toIso8601String(),
      if (classId != null) 'passengerClassID': classId,
    };
  }

  /// GET /api/PassengerClass/All
  static Future<List<PassengerClassModel>> getPassengerClasses(
      String token) async {
    final res = await ApiClient.get('/api/PassengerClass/All', token);
    final list = jsonDecode(res.body) as List<dynamic>;
    return list
        .map((j) => PassengerClassModel.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  /// GET /api/Triptypes/All
  static Future<List<TripTypeModel>> getTripTypes(String token) async {
    final res = await ApiClient.get('/api/Triptypes/All', token);
    final list = jsonDecode(res.body) as List<dynamic>;
    return list
        .map((j) => TripTypeModel.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  static List<FlightScheduleModel> _parseList(String body) {
    // Guard against empty / null body
    if (body.isEmpty) return [];
    final dynamic decoded;
    try {
      decoded = jsonDecode(body);
    } catch (_) {
      return [];
    }
    if (decoded == null) return [];

    List<dynamic> raw;
    if (decoded is List) {
      raw = decoded;
    } else if (decoded is Map) {
      // Some endpoints wrap the list in an object
      raw = decoded.values.firstWhere(
        (v) => v is List,
        orElse: () => <dynamic>[],
      ) as List<dynamic>;
    } else {
      return [];
    }

    final results = <FlightScheduleModel>[];
    for (final j in raw) {
      if (j is Map<String, dynamic>) {
        try {
          results.add(FlightScheduleModel.fromJson(j));
        } catch (_) {
          // Skip malformed entries
        }
      }
    }
    return results;
  }
}
