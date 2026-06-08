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
  late List<FlightScheduleModel> _flights;
  bool _isFallback = false;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;

    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _search =
        (args?['search'] as BookingSearchModel?) ?? _fallbackSearch();
    _flights =
        (args?['flights'] as List<FlightScheduleModel>?) ?? [];
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
                  _flights.isEmpty ? _buildEmpty() : _buildList(),
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
            'No flights matched your search. Showing other available flights instead.',
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

  Widget _buildList() => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _flights.length,
        itemBuilder: (_, i) => _FlightScheduleCard(
          schedule: _flights[i],
          passengerCount:
              _search.totalPassengers,
          onTap: () {
            context
                .read<BookingProvider>()
                .selectSchedule(_flights[i]);

            Navigator.pushNamed(
              context,
              '/flight-details',
              arguments: {
                'schedule': _flights[i],
                'search': _search
              },
            );
          },
        ),
      );
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
    final convertedPrice = user.convertPrice(schedule.totalPrice);
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