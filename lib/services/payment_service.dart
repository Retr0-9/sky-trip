import 'dart:convert';
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
  /// Returns 'Paid' when payment confirmed, otherwise 'Pending'.
  static Future<String> getPaymentStatus({
    required int ticketId,
    required String token,
  }) async {
    final res = await ApiClient.get(
      '/api/payments/my/status/$ticketId',
      token,
    );
    try {
      final body = jsonDecode(res.body);
      if (body is Map) {
        // Check isConfirmed first (truthy = paid)
        final confirmed = body['isConfirmed'];
        if (confirmed == true || confirmed == 1) return 'Paid';
        // Then check paymentStatus string
        final ps = (body['paymentStatus'] ?? body['PaymentStatus'] ?? '') as String;
        if (ps.toLowerCase() == 'paid') return 'Paid';
        // Fall back to bookingStatus
        final bs = (body['bookingStatus'] ?? body['BookingStatus'] ?? '') as String;
        return bs.isEmpty ? 'Pending' : bs;
      }
      // Plain string response e.g. "Paid"
      return (body as String).trim();
    } catch (_) {
      return res.body.trim().replaceAll('"', '');
    }
  }
}
