import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_client.dart';
import '../models/api_ticket_model.dart';
export '../models/api_ticket_model.dart' show ApiTicketDetailModel;

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
      passengerId:     json['passengerId']     as int,
      personId:        json['personId']        as int,
      documentationId: json['documentationId'] as int,
      current:         json['current']         as int,
      total:           json['total']           as int,
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
        'clientID':    clientId,
        'tripType':    tripTypeId,
        'isActive':    true,
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
        'bookID':           bookId,
        'passengerClassID': passengerClassId,
        'ticketPrice':      ticketPrice,
        'passengersCount':  passengersCount,
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
    final fields = <String, String>{
      'FirstName':         data.firstName,
      'SecondName':        data.secondName ?? '',
      'ThirdName':         data.thirdName  ?? '',
      'LastName':          data.lastName,
      'Email':             data.email,
      'Phone':             data.phone,
      'BirthDate':         data.birthDate.toIso8601String().substring(0, 10),
      'Gender':            data.gender,
      'IssueCountryId':    data.issueCountryId.toString(),
      'DocumentationType': data.documentationType,
      'ExpirationDate':    data.expirationDate.toIso8601String().substring(0, 10),
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

  /// POST /api/TicketFlights — links a ticket to a flight schedule
  static Future<void> createTicketFlight({
    required int ticketId,
    required int flightScheduleId,
    required String flightType,
    required String token,
  }) async {
    await ApiClient.post(
      '/api/TicketFlights',
      {
        'ticketId':         ticketId,
        'flightScheduleId': flightScheduleId,
        'flightType':       flightType,
      },
      token,
    );
  }

  /// GET /api/tickets/my/paid — richer ticket list with booking/payment status
  static Future<List<ApiTicketModel>> fetchPaidTickets({
    required String token,
  }) async {
    final res = await ApiClient.get('/api/tickets/my/paid', token);
    final list = ApiClient.decodeList(res);
    return list
        .map((j) => ApiTicketModel.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  /// GET /api/tickets/my/{ticketId} — full detail: flights, passengers, services
  static Future<ApiTicketDetailModel> fetchTicketDetail({
    required int ticketId,
    required String token,
  }) async {
    final res = await ApiClient.get('/api/tickets/my/$ticketId', token);
    return ApiTicketDetailModel.fromJson(ApiClient.decodeMap(res));
  }

  /// POST /api/tickets/my/{ticketId}/cancel
  static Future<void> cancelTicket({
    required int ticketId,
    required String token,
  }) async {
    await ApiClient.post('/api/tickets/my/$ticketId/cancel', {}, token);
  }
}
