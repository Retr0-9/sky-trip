import 'dart:convert';
import '../models/service_model.dart';
import 'api_client.dart';

class ExtrasService {
  /// GET /api/Services/All
  static Future<List<ServiceModel>> getAllServices(String token) async {
    final res = await ApiClient.get('/api/Services/All', token);
    final list = jsonDecode(res.body) as List<dynamic>;
    return list
        .map((j) => ServiceModel.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  /// POST /api/tickets/{ticketId}/services
  static Future<void> addService({
    required int ticketId,
    required int serviceId,
    required int quantity,
    required String token,
  }) async {
    await ApiClient.post(
      '/api/tickets/$ticketId/services',
      {'serviceID': serviceId, 'quantity': quantity},
      token,
    );
  }

  /// DELETE /api/tickets/{ticketId}/services  (remove all services)
  static Future<void> removeAllServices({
    required int ticketId,
    required String token,
  }) async {
    await ApiClient.delete('/api/tickets/$ticketId/services', token);
  }
}
