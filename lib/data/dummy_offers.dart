import 'package:flutter/material.dart';
import '../models/offer_model.dart';

class DummyOffers {
  // TODO: Replace with API call in Phase 6
  static const List<OfferModel> offers = [
    OfferModel(
      id: 'offer1',
      title: 'Summer Sale',
      subtitle: 'Book flights to Europe',
      discount: '30% OFF',
      validUntil: 'Dec 31, 2025',
      color: Color(0xFFFFA726), // orange
    ),
    OfferModel(
      id: 'offer2',
      title: 'Weekend Getaway',
      subtitle: 'Domestic flights',
      discount: '20% OFF',
      validUntil: 'Dec 20, 2025',
      color: Color(0xFF4FC3F7), // light blue
    ),
    OfferModel(
      id: 'offer3',
      title: 'Business Class Upgrade',
      subtitle: 'Selected routes',
      discount: '40% OFF',
      validUntil: 'Dec 15, 2025',
      color: Color(0xFFA1887F), // brown
    ),
    OfferModel(
      id: 'offer4',
      title: 'Family Package',
      subtitle: 'Travel with the whole family',
      discount: '15% OFF',
      validUntil: 'Jan 10, 2026',
      color: Color(0xFF66BB6A), // green
    ),
  ];
}
