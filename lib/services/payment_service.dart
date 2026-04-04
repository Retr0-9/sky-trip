import 'api_client.dart';

class PaymentService {
  /// POST /api/payments/checkout-session → Stripe checkout URL
  static Future<String> createCheckoutSession({
    required int ticketId,
    required String token,
  }) async {
    final res = await ApiClient.post(
      '/api/payments/checkout-session',
      {'ticketId': ticketId},
      token,
    );
    final body = ApiClient.decodeMap(res);
    return (body['url'] as String? ?? '');
  }

  /// GET /api/payments/my/status/{ticketId}
  /// Returns the payment status string (e.g. 'Paid', 'Pending', 'Failed')
  static Future<String> getPaymentStatus({
    required int ticketId,
    required String token,
  }) async {
    final res = await ApiClient.get(
      '/api/payments/my/status/$ticketId',
      token,
    );
    // Response may be a plain string or a JSON object
    final raw = res.body.trim().replaceAll('"', '');
    return raw;
  }
}
