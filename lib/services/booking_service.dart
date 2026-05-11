import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_client.dart';

class AddPassengerResult {
  final int passengerId;
  final int personId;
  final int documentationId;
  final int current;
  final int total;

  const AddPassengerResult({
    required this.passengerId,
    required this.personId,
    required this.documentationId,
    required this.current,
    required this.total,
  });

  factory AddPassengerResult.fromJson(Map<String, dynamic> json) {
    return AddPassengerResult(
      passengerId: json['passengerId'] as int,
      personId: json['personId'] as int,
      documentationId: json['documentationId'] as int,
      current: json['current'] as int,
      total: json['total'] as int,
    );
  }
}

class PassengerFormData {
  final String firstName;
  final String? secondName;
  final String? thirdName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime birthDate;
  final String gender;
  final int issueCountryId;
  final String documentationType;
  final DateTime expirationDate;
  final File? documentFile;

  const PassengerFormData({
    required this.firstName,
    this.secondName,
    this.thirdName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.issueCountryId,
    required this.documentationType,
    required this.expirationDate,
    this.documentFile,
  });
}

/// Strips milliseconds: "2000-01-01T00:00:00.000" → "2000-01-01T00:00:00"
String _isoNoMs(DateTime d) => d.toIso8601String().split('.').first;

class BookingService {
  /// POST /api/BookingTrip → returns bookID
  static Future<int> createBookingTrip({
    required int clientId,
    required int tripTypeId,
    required String token,
  }) async {
    final res = await ApiClient.post(
      '/api/BookingTrip',
      {
        'clientID': clientId,
        'tripType': tripTypeId,
        'isActive': true,
        'bookingDate': DateTime.now().toIso8601String(),
      },
      token,
    );
    final body = jsonDecode(res.body);
    if (body is Map) return (body['bookID'] ?? body['bookId'] ?? 0) as int;
    return 0;
  }

  /// POST /api/InfoTickets → returns ticketID
  static Future<int> createInfoTicket({
    required int bookId,
    required int passengerClassId,
    required double ticketPrice,
    required int passengersCount,
    required String token,
  }) async {
    final res = await ApiClient.post(
      '/api/InfoTickets',
      {
        'bookID': bookId,
        'passengerClassID': passengerClassId,
        'ticketPrice': ticketPrice,
        'passengersCount': passengersCount,
      },
      token,
    );
    final body = jsonDecode(res.body);
    if (body is Map) return (body['ticketID'] ?? body['ticketId'] ?? 0) as int;
    return 0;
  }

  /// POST /api/bookings/{bookId}/passengers  (multipart/form-data)
  static Future<AddPassengerResult> addPassenger({
    required int bookId,
    required PassengerFormData data,
    required String token,
  }) async {
    // SecondName and ThirdName must always be present (SP_AddNewPerson requires them)
    final fields = <String, String>{
      'FirstName': data.firstName,
      'SecondName':
          data.secondName?.isNotEmpty == true ? data.secondName! : 'Guest',
      'ThirdName':
          data.thirdName?.isNotEmpty == true ? data.thirdName! : 'Guest',
      'LastName': data.lastName,
      'Email': data.email,
      'Phone': data.phone,
      'BirthDate': _isoNoMs(data.birthDate),
      'Gender': data.gender,
      'IssueCountryId': data.issueCountryId.toString(),
      'DocumentationType': data.documentationType,
      'ExpirationDate': _isoNoMs(data.expirationDate),
    };

    final files = <String, http.MultipartFile>{};
    if (data.documentFile != null) {
      files['DocumentFile'] = await http.MultipartFile.fromPath(
        'DocumentFile',
        data.documentFile!.path,
      );
    }

    final res = await ApiClient.postMultipart(
      '/api/bookings/$bookId/passengers',
      fields,
      files,
      token,
    );

    return AddPassengerResult.fromJson(ApiClient.decodeMap(res));
  }

  /// POST /api/BookingTrip/{bookId}/confirm
  static Future<void> confirmBooking({
    required int bookId,
    required String token,
  }) async {
    await ApiClient.post('/api/BookingTrip/$bookId/confirm', {}, token);
  }
}
