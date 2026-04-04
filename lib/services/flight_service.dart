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
    return list.map((e) => e.toString().trim()).where((s) => s.isNotEmpty).toList();
  }

  /// POST /api/FlightSchedules/oneway
  static Future<List<FlightScheduleModel>> searchOneWay(
    String from,
    String to,
    DateTime date,
    String token,
  ) async {
    final res = await ApiClient.post(
      '/api/FlightSchedules/oneway',
      {'from': from, 'to': to, 'date': date.toIso8601String()},
      token,
    );
    return _parseList(res.body);
  }

  /// POST /api/FlightSchedules/roundtrip
  static Future<List<FlightScheduleModel>> searchRoundTrip(
    String from,
    String to,
    DateTime departureDate,
    DateTime returnDate,
    String token,
  ) async {
    final res = await ApiClient.post(
      '/api/FlightSchedules/roundtrip',
      {
        'from': from,
        'to': to,
        'departureDate': departureDate.toIso8601String(),
        'returnDate': returnDate.toIso8601String(),
        'maxItineraries': 10,
        'maxOptionsPerLeg': 5,
      },
      token,
    );
    return _parseList(res.body);
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
    final decoded = jsonDecode(body);
    if (decoded is List) {
      return decoded
          .map((j) =>
              FlightScheduleModel.fromJson(j as Map<String, dynamic>))
          .toList();
    }
    // Some endpoints wrap the list in an object
    if (decoded is Map) {
      final vals = decoded.values.firstWhere(
        (v) => v is List,
        orElse: () => <dynamic>[],
      ) as List<dynamic>;
      return vals
          .map((j) =>
              FlightScheduleModel.fromJson(j as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
