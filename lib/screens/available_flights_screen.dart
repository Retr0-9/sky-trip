import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../models/booking_search_model.dart';
import '../models/flight_schedule_model.dart';
import '../providers/booking_provider.dart';
import '../providers/user_provider.dart';

class AvailableFlightsScreen extends StatefulWidget {
  const AvailableFlightsScreen({super.key});

  @override
  State<AvailableFlightsScreen> createState() =>
      _AvailableFlightsScreenState();
}

class _AvailableFlightsScreenState extends State<AvailableFlightsScreen> {
  late BookingSearchModel _search;
  List<FlightScheduleModel> _flights = [];
  List<MultiCityItinerary> _itineraries = [];
  bool _isFallback = false;
  bool _loaded = false;

  bool get _isMultiCity =>
      _search.tripType.toLowerCase().contains('multi');
  bool get _isRoundTrip =>
      _search.tripType.toLowerCase().contains('round');

  bool get _hasResults =>
      _isMultiCity ? _itineraries.isNotEmpty : _flights.isNotEmpty;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;

    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _search =
        (args?['search'] as BookingSearchModel?) ?? _fallbackSearch();
    _flights =
        (args?['flights'] as List<FlightScheduleModel>?) ?? [];
    _itineraries =
        (args?['itineraries'] as List<MultiCityItinerary>?) ?? [];
    _isFallback = (args?['isFallback'] as bool?) ?? false;

    _loaded = true;
  }

  BookingSearchModel _fallbackSearch() => BookingSearchModel(
        fromCode: '',
        fromCity: '',
        toCode: '',
        toCity: '',
        departureDate: DateTime.now(),
        tripType: 'one_way',
        adults: 1,
        youth: 0,
        children: 0,
        infants: 0,
        travelClass: 'Economy',
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(l10n.availableFlightsTitle),
          elevation: 0,
        ),
        body: Column(
          children: [
            _buildSummaryBar(),
            if (_isFallback && _flights.isNotEmpty) _buildFallbackBanner(),
            Expanded(
              child:
                  !_hasResults ? _buildEmpty() : _buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryBar() {
    final d = _search.departureDate;
    final dateStr = '${d.day}/${d.month}/${d.year}';

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.cyanLight,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  _search.fromCity.isNotEmpty
                      ? _search.fromCity
                      : _search.fromCode,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, size: 16),
                ),
                Text(
                  _search.toCity.isNotEmpty
                      ? _search.toCity
                      : _search.toCode,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
          _chip(dateStr),
          const SizedBox(width: 8),
          // ignore: invalid_null_aware_operator
          _chip('${_search.totalPassengers} ${AppLocalizations.of(context)!.availableFlightsPax}'),
        ],
      ),
    );
  }

  Widget _buildFallbackBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.orange.withValues(alpha: 0.12),
      child: Row(children: [
        const Icon(Icons.info_outline, color: Colors.orange, size: 18),
        const SizedBox(width: 8),
        const Expanded(
          child: Text(
            'No flights matched your date. Showing other available flights on this route.',
            style: TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.w600),
          ),
        ),
      ]),
    );
  }

  Widget _chip(String label) {
    final theme = Theme.of(context);

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: theme.textTheme.bodySmall?.color,
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flight_takeoff,
            size: 64,
            color: theme.disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.availableFlightsNoResults,
            style: TextStyle(
              color:
                  theme.textTheme.bodyMedium?.color,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.availableFlightsEmpty,
            style: TextStyle(
              color:
                  theme.textTheme.bodySmall?.color,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    if (_isMultiCity) {
      return _buildMultiCityList();
    }
    if (_isRoundTrip) {
      return _buildRoundTripList();
    }
    return _buildOneWayList();
  }

  Widget _buildOneWayList() => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _flights.length,
        itemBuilder: (_, i) => _FlightScheduleCard(
          schedule: _flights[i],
          passengerCount: _search.totalPassengers,
          onTap: () => _selectFlight(_flights[i]),
        ),
      );

  Widget _buildRoundTripList() {
    final from = _search.fromCity.toLowerCase();
    final to = _search.toCity.toLowerCase();

    final outbound = _flights.where((f) =>
        f.departureCity.toLowerCase() == from &&
        f.arrivalCity.toLowerCase() == to).toList();
    final inbound = _flights.where((f) =>
        f.departureCity.toLowerCase() == to &&
        f.arrivalCity.toLowerCase() == from).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionHeader('Outbound  ${_search.fromCity} → ${_search.toCity}'),
        if (outbound.isEmpty)
          _emptySection('No outbound flights found.')
        else
          ...outbound.map((f) => _FlightScheduleCard(
                schedule: f,
                passengerCount: _search.totalPassengers,
                onTap: () => _selectFlight(f),
              )),
        const SizedBox(height: 16),
        _sectionHeader('Return  ${_search.toCity} → ${_search.fromCity}'),
        if (inbound.isEmpty)
          _emptySection('No return flights found.')
        else
          ...inbound.map((f) => _FlightScheduleCard(
                schedule: f,
                passengerCount: _search.totalPassengers,
                onTap: () => _selectFlight(f),
              )),
      ],
    );
  }

  Widget _buildMultiCityList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _itineraries.length,
      itemBuilder: (_, i) => _MultiCityItineraryCard(
        itinerary: _itineraries[i],
        passengerCount: _search.totalPassengers,
        onTap: () => _selectItinerary(_itineraries[i]),
      ),
    );
  }

  void _selectItinerary(MultiCityItinerary itinerary) {
    final first = itinerary.segments.first;
    context.read<BookingProvider>().selectSchedule(first);
    Navigator.pushNamed(context, '/flight-details',
        arguments: {
          'schedule': first,
          'search': _search,
          'itinerary': itinerary,
        });
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        const Icon(Icons.flight_takeoff, size: 18, color: AppColors.cyan),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.cyanDark)),
      ]),
    );
  }

  Widget _emptySection(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).hintColor, fontSize: 13)),
    );
  }

  void _selectFlight(FlightScheduleModel flight) {
    context.read<BookingProvider>().selectSchedule(flight);
    Navigator.pushNamed(context, '/flight-details',
        arguments: {'schedule': flight, 'search': _search});
  }
}

// Flight Card

class _FlightScheduleCard extends StatelessWidget {
  final FlightScheduleModel schedule;
  final int passengerCount;
  final VoidCallback onTap;

  const _FlightScheduleCard({
    required this.schedule,
    required this.passengerCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.watch<UserProvider>();
    final convertedPrice = user.convertPrice(schedule.basePrice);
    final totalPrice = convertedPrice * passengerCount;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:
            const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius:
              BorderRadius.circular(12),
          border: Border.all(
            color: theme.dividerColor,
          ),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        AppColors.cyanLight,
                    borderRadius:
                        BorderRadius.circular(
                            8),
                  ),
                  child: const Icon(
                    Icons.flight,
                    color: AppColors.cyan,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${schedule.departureCity} → ${schedule.arrivalCity}',
                    style: theme
                        .textTheme.titleMedium
                        ?.copyWith(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        schedule
                            .departureDisplay,
                        style: theme
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      Text(
                        schedule
                            .departureCity,
                        style: theme
                            .textTheme
                            .bodySmall,
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    const Icon(
                      Icons.flight_takeoff,
                      color:
                          AppColors.cyan,
                      size: 20,
                    ),
                    const SizedBox(
                        height: 4),
                    Text(
                      _flightDate(
                          schedule
                              .flightDate),
                      style: theme
                          .textTheme
                          .bodySmall,
                    ),
                  ],
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .end,
                    children: [
                      Text(
                        schedule
                            .arrivalDisplay,
                        style: theme
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      Text(
                        schedule
                            .arrivalCity,
                        style: theme
                            .textTheme
                            .bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 20),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      '${user.currency} ${convertedPrice.toStringAsFixed(2)}',
                      style:
                          const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight
                                .bold,
                        color: AppColors
                            .cyan,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.availableFlightsPerPerson,
                      style: theme
                          .textTheme
                          .bodySmall,
                    ),
                  ],
                ),

                if (passengerCount > 1)
                  Text(
                    AppLocalizations.of(context)!.availableFlightsTotal(
                      user.currency,
                      totalPrice.toStringAsFixed(2),
                    ),
                    style: theme
                        .textTheme
                        .bodyMedium,
                  ),

                Icon(
                  Icons
                      .arrow_forward_ios,
                  size: 16,
                  color:
                      theme.hintColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _flightDate(DateTime d) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${months[d.month]} ${d.day}';
  }
}

class _MultiCityItineraryCard extends StatelessWidget {
  final MultiCityItinerary itinerary;
  final int passengerCount;
  final VoidCallback onTap;

  const _MultiCityItineraryCard({
    required this.itinerary,
    required this.passengerCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.watch<UserProvider>();
    final totalPrice = user.convertPrice(itinerary.totalPrice) * passengerCount;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.cyanLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.connecting_airports,
                      color: AppColors.cyan, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Multi-City Trip',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      Text('${itinerary.segments.length} legs',
                          style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 16, color: theme.hintColor),
              ],
            ),
            const Divider(height: 20),
            ...itinerary.segments.asMap().entries.map((entry) {
              final i = entry.key;
              final seg = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: i < itinerary.segments.length - 1 ? 12 : 0),
                child: Row(
                  children: [
                    Container(
                      width: 24, height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.cyan.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text('${i + 1}',
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.cyanDark)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${seg.departureCity} → ${seg.arrivalCity}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14)),
                          Text(
                            '${_fmtDate(seg.flightDate)}  •  ${seg.departureDisplay} – ${seg.arrivalDisplay}',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.currency} ${user.convertPrice(itinerary.totalPrice).toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cyan),
                    ),
                    Text(
                      AppLocalizations.of(context)!.availableFlightsPerPerson,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                if (passengerCount > 1)
                  Text(
                    AppLocalizations.of(context)!.availableFlightsTotal(
                      user.currency,
                      totalPrice.toStringAsFixed(2),
                    ),
                    style: theme.textTheme.bodyMedium,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) {
    const m = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
               'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${m[d.month]} ${d.day}';
  }
}