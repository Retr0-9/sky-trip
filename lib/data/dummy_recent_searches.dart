import '../models/booking_search_model.dart';

class DummyRecentSearches {
  // TODO: Replace with local storage (SharedPreferences) in Phase 6
  static final List<BookingSearchModel> searches = [
    BookingSearchModel(
      fromCode: 'AMM',
      fromCity: 'Amman',
      toCode: 'DXB',
      toCity: 'Dubai',
      departureDate: DateTime(2025, 3, 15),
      tripType: 'one_way',
      adults: 1,
      youth: 0,
      children: 0,
      infants: 0,
      travelClass: 'Economy',
    ),
    BookingSearchModel(
      fromCode: 'AMM',
      fromCity: 'Amman',
      toCode: 'LHR',
      toCity: 'London',
      departureDate: DateTime(2025, 4, 10),
      returnDate: DateTime(2025, 4, 20),
      tripType: 'round_trip',
      adults: 2,
      youth: 0,
      children: 0,
      infants: 0,
      travelClass: 'Economy',
    ),
  ];
}
