import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import '../models/booking_search_model.dart';
import '../models/flight_schedule_model.dart';
// MultiCityItinerary is exported from flight_schedule_model.dart
import '../models/passenger_class_model.dart';
import '../models/trip_type_model.dart';
import '../providers/booking_provider.dart';
import '../providers/user_provider.dart';
import '../services/auth_service.dart';
import '../services/flight_service.dart';
import '../theme/app_theme.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // ── Trip type ────────────────────────────────────────────────
  List<TripTypeModel> _tripTypes = [];
  TripTypeModel? _selectedTripType;

  // ── Cities ───────────────────────────────────────────────────
  List<String> _cities = [];
  String _fromCity = '';
  String _toCity = '';

  // ── Dates ────────────────────────────────────────────────────
  DateTime? _departureDate;
  DateTime? _returnDate;

  // ── Multi-city legs ───────────────────────────────────────────
  // Each leg: {'from': '', 'to': '', 'date': DateTime?}
  final List<Map<String, dynamic>> _legs = [
    {'from': '', 'to': '', 'date': null},
    {'from': '', 'to': '', 'date': null},
  ];

  // ── Passengers ───────────────────────────────────────────────
  int _adults = 1;
  int _youth = 0;
  int _children = 0;
  int _infants = 0;

  // ── Class ────────────────────────────────────────────────────
  List<PassengerClassModel> _classes = [];
  PassengerClassModel? _selectedClass;

  // ── Loading / error ──────────────────────────────────────────
  bool _loadingMeta = true;
  bool _searchLoading = false;
  String _metaError = '';

  @override
  void initState() {
    super.initState();
    _loadMeta();
  }

  Future<void> _loadMeta() async {
    final token = context.read<UserProvider>().token;
    try {
      final results = await Future.wait([
        FlightService.getCities(token),
        FlightService.getPassengerClasses(token),
        FlightService.getTripTypes(token),
      ]);
      if (!mounted) return;
      final cities = results[0] as List<String>;
      final classes = results[1] as List<PassengerClassModel>;
      final tripTypes = results[2] as List<TripTypeModel>;

      setState(() {
        _cities = cities;
        _classes = classes;
        _tripTypes = tripTypes;
        _selectedClass = classes.isNotEmpty ? classes.first : null;
        _selectedTripType = tripTypes.isNotEmpty ? tripTypes.first : null;
        _loadingMeta = false;
      });
    } on AuthException catch (e) {
      if (mounted)
        setState(() {
          _metaError = e.message;
          _loadingMeta = false;
        });
    } catch (_) {
      if (mounted)
        setState(() {
          _metaError = 'Failed to load flight data.';
          _loadingMeta = false;
        });
    }
  }

  // ── City picker ──────────────────────────────────────────────
  Future<void> _pickCity({required bool isFrom}) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        String query = '';
        // ── Dynamic: handle bar color ──
        final cs = Theme.of(ctx).colorScheme;
        return StatefulBuilder(builder: (ctx, setS) {
          final filtered = _cities
              .where((c) => c.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            maxChildSize: 0.9,
            builder: (_, ctrl) => Column(children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant, // was: Colors.grey.shade300
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.bookingSearchCity,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onChanged: (v) => setS(() => query = v),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: ctrl,
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => ListTile(
                    leading:
                        const Icon(Icons.flight_takeoff, color: AppColors.cyan),
                    title: Text(filtered[i]),
                    onTap: () => Navigator.pop(ctx, filtered[i]),
                  ),
                ),
              ),
            ]),
          );
        });
      },
    );
    if (picked == null) return;
    setState(() => isFrom ? _fromCity = picked : _toCity = picked);
  }

  // ── Date picker ──────────────────────────────────────────────
  Future<void> _pickDate({required bool isDeparture}) async {
    final now = DateTime.now();
    final first = isDeparture ? now : (_departureDate ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: first,
      firstDate: first,
      lastDate: now.add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.cyan),
        ),
        child: child!,
      ),
    );
    if (picked == null) return;
    setState(() {
      if (isDeparture) {
        _departureDate = picked;
        if (_returnDate != null && _returnDate!.isBefore(picked))
          _returnDate = null;
      } else {
        _returnDate = picked;
      }
    });
  }

  // ── Passenger selector ────────────────────────────────────────
  void _showPassengerSelector() {
    int a = _adults, y = _youth, c = _children, inf = _infants;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(builder: (ctx, setS) {
        // ── Dynamic: subtitle text color ──
        final cs = Theme.of(ctx).colorScheme;

        Widget row(String label, String sub, int val, VoidCallback dec,
                VoidCallback inc) =>
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              child: Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(sub,
                          style: TextStyle(
                              color: cs
                                  .onSurfaceVariant, // was: Colors.grey.shade500
                              fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: dec,
                    icon: const Icon(Icons.remove_circle_outline),
                    color: AppColors.cyan),
                Text('$val',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                IconButton(
                    onPressed: inc,
                    icon: const Icon(Icons.add_circle_outline),
                    color: AppColors.cyan),
              ]),
            );

        return Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 16),
          Text(AppLocalizations.of(ctx)!.bookingPassengers,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Divider(height: 24),
          row(AppLocalizations.of(ctx)!.bookingAdults,
              AppLocalizations.of(ctx)!.bookingAdultSubtext, a, () {
            if (a > 1) setS(() => a--);
          }, () {
            setS(() => a++);
          }),
          row(AppLocalizations.of(ctx)!.bookingYouth,
              AppLocalizations.of(ctx)!.bookingYouthSubtext, y, () {
            if (y > 0) setS(() => y--);
          }, () {
            setS(() => y++);
          }),
          row(AppLocalizations.of(ctx)!.bookingChildren,
              AppLocalizations.of(ctx)!.bookingChildrenSubtext, c, () {
            if (c > 0) setS(() => c--);
          }, () {
            setS(() => c++);
          }),
          row(AppLocalizations.of(ctx)!.bookingInfants,
              AppLocalizations.of(ctx)!.bookingInfantsSubtext, inf, () {
            if (inf > 0) setS(() => inf--);
          }, () {
            setS(() => inf++);
          }),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cyan,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  setState(() {
                    _adults = a;
                    _youth = y;
                    _children = c;
                    _infants = inf;
                  });
                  Navigator.pop(ctx);
                },
                child: Text(AppLocalizations.of(ctx)!.dialogConfirm),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ]);
      }),
    );
  }

  // ── Class selector ────────────────────────────────────────────
  void _showClassSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 16),
        Text(AppLocalizations.of(ctx)!.bookingSelectClass,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Divider(height: 24),
        ..._classes.map((cls) => ListTile(
              leading: const Icon(Icons.airline_seat_recline_extra,
                  color: AppColors.cyan),
              title: Text(cls.name),
              subtitle: cls.fees > 0
                  ? Text(
                      '+${cls.fees.toStringAsFixed(0)} ${Provider.of<UserProvider>(ctx).currency}')
                  : null,
              trailing: _selectedClass?.classId == cls.classId
                  ? const Icon(Icons.check_circle, color: AppColors.cyan)
                  : null,
              onTap: () {
                setState(() => _selectedClass = cls);
                context.read<BookingProvider>().setSelectedClassId(cls.classId);
                Navigator.pop(ctx);
              },
            )),
        const SizedBox(height: 16),
      ]),
    );
  }

  // ── Trip type helpers ─────────────────────────────────────────
  bool get _isRoundTrip =>
      _selectedTripType?.name.toLowerCase().contains('round') ?? false;

  bool get _isMultiCity =>
      _selectedTripType?.name.toLowerCase().contains('multi') ?? false;

  // ── Multi-city leg pickers ────────────────────────────────────
  Future<void> _pickLegCity(int legIndex, {required bool isFrom}) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        String query = '';
        final cs = Theme.of(ctx).colorScheme;
        return StatefulBuilder(builder: (ctx, setS) {
          final filtered = _cities
              .where((c) => c.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return DraggableScrollableSheet(
            expand: false, initialChildSize: 0.6, maxChildSize: 0.9,
            builder: (_, ctrl) => Column(children: [
              const SizedBox(height: 12),
              Container(width: 40, height: 4,
                  decoration: BoxDecoration(color: cs.outlineVariant,
                      borderRadius: BorderRadius.circular(2))),
              Padding(padding: const EdgeInsets.all(16),
                child: TextField(autofocus: true,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.bookingSearchCity,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onChanged: (v) => setS(() => query = v),
                ),
              ),
              Expanded(child: ListView.builder(
                controller: ctrl, itemCount: filtered.length,
                itemBuilder: (_, i) => ListTile(
                  leading: const Icon(Icons.flight_takeoff, color: AppColors.cyan),
                  title: Text(filtered[i]),
                  onTap: () => Navigator.pop(ctx, filtered[i]),
                ),
              )),
            ]),
          );
        });
      },
    );
    if (picked == null) return;
    setState(() {
      _legs[legIndex][isFrom ? 'from' : 'to'] = picked;
      if (!isFrom && legIndex < _legs.length - 1) {
        _legs[legIndex + 1]['from'] = picked;
      }
    });
  }

  Future<void> _pickLegDate(int legIndex) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.cyan)),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _legs[legIndex]['date'] = picked);
  }

  // ── Search ────────────────────────────────────────────────────
  Future<void> _search() async {
    if (_isMultiCity) {
      for (int i = 0; i < _legs.length; i++) {
        if ((_legs[i]['from'] as String).isEmpty || (_legs[i]['to'] as String).isEmpty) {
          _snack('Please select cities for leg ${i + 1}.'); return;
        }
        if (_legs[i]['date'] == null) {
          _snack('Please select a date for leg ${i + 1}.'); return;
        }
      }
    } else {
      if (_fromCity.isEmpty || _toCity.isEmpty) {
        _snack(AppLocalizations.of(context)!.bookingErrorSelectCities); return;
      }
      if (_fromCity == _toCity) {
        _snack(AppLocalizations.of(context)!.bookingErrorDifferentCities); return;
      }
      if (_departureDate == null) {
        _snack(AppLocalizations.of(context)!.bookingErrorSelectDeparture); return;
      }
      if (_isRoundTrip && _returnDate == null) {
        _snack(AppLocalizations.of(context)!.bookingErrorSelectReturn); return;
      }
    }

    setState(() => _searchLoading = true);

    final token = context.read<UserProvider>().token;
    final firstLeg = _isMultiCity ? _legs[0] : null;
    final search = BookingSearchModel(
      fromCode:      _isMultiCity ? firstLeg!['from'] as String : _fromCity,
      fromCity:      _isMultiCity ? firstLeg!['from'] as String : _fromCity,
      toCode:        _isMultiCity ? _legs.last['to'] as String  : _toCity,
      toCity:        _isMultiCity ? _legs.last['to'] as String  : _toCity,
      departureDate: _isMultiCity ? firstLeg!['date'] as DateTime : _departureDate!,
      returnDate:    _returnDate,
      tripType:      _selectedTripType?.name ?? 'one_way',
      adults:        _adults,
      youth:         _youth,
      children:      _children,
      infants:       _infants,
      travelClass:   _selectedClass?.name ?? 'Economy',
    );

    try {
      if (_isMultiCity) {
        final legMaps = _legs.map((l) => {
          'from': l['from'] as String,
          'to':   l['to']   as String,
          'date': (l['date'] as DateTime).toIso8601String().substring(0, 10),
        }).toList();
        var itineraries = await FlightService.searchMultiCityGrouped(legMaps, token);

        bool isFallback = false;
        if (itineraries.isEmpty) {
          try {
            final all = await FlightService.getAllFlights(token);
            final builtLegs = <List<FlightScheduleModel>>[];
            for (final leg in _legs) {
              final from = (leg['from'] as String).toLowerCase();
              final to = (leg['to'] as String).toLowerCase();
              final matching = all.where((f) =>
                  f.departureCity.toLowerCase() == from &&
                  f.arrivalCity.toLowerCase() == to).toList();
              builtLegs.add(matching);
            }
            if (builtLegs.every((l) => l.isNotEmpty)) {
              itineraries = [MultiCityItinerary(
                segments: builtLegs.map((l) => l.first).toList(),
                totalPrice: builtLegs.map((l) => l.first.basePrice).fold(0, (a, b) => a + b),
              )];
              isFallback = true;
            }
          } catch (_) {}
        }

        if (!mounted) return;
        context.read<BookingProvider>().setSearch(search);
        Navigator.pushNamed(context, '/available-flights',
            arguments: {
              'search': search,
              'itineraries': itineraries,
              'isFallback': isFallback,
            });
      } else {
        List<FlightScheduleModel> results;
        if (_isRoundTrip) {
          results = await FlightService.searchRoundTrip(
              _fromCity, _toCity, _departureDate!, _returnDate!, token);
        } else {
          results = await FlightService.searchOneWay(
              _fromCity, _toCity, _departureDate!, token);
        }

        bool isFallback = false;
        if (results.isEmpty) {
          try {
            final all = await FlightService.getAllFlights(token);
            final from = _fromCity.toLowerCase();
            final to = _toCity.toLowerCase();
            results = all.where((f) =>
                f.departureCity.toLowerCase() == from &&
                f.arrivalCity.toLowerCase() == to).toList();
            if (_isRoundTrip) {
              final returnFlights = all.where((f) =>
                  f.departureCity.toLowerCase() == to &&
                  f.arrivalCity.toLowerCase() == from).toList();
              results = [...results, ...returnFlights];
            }
            isFallback = results.isNotEmpty;
          } catch (_) {}
        }

        if (!mounted) return;
        context.read<BookingProvider>().setSearch(search);
        Navigator.pushNamed(context, '/available-flights',
            arguments: {
              'search': search,
              'flights': results,
              'isFallback': isFallback,
            });
      }
    } on AuthException catch (e) {
      _snack(e.message);
    } catch (_) {
      _snack(AppLocalizations.of(context)!.bookingErrorSearchFailed);
    } finally {
      if (mounted) setState(() => _searchLoading = false);
    }
  }

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));

  // ── Build ─────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_loadingMeta) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.cyan));
    }
    if (_metaError.isNotEmpty) {
      return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
        const SizedBox(height: 12),
        Text(_metaError, textAlign: TextAlign.center),
        const SizedBox(height: 12),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _loadingMeta = true;
                _metaError = '';
              });
              _loadMeta();
            },
            child: Text(AppLocalizations.of(context)!.dialogRetry)),
      ]));
    }

    // ── Dynamic: theme-aware tokens for the whole build ──
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final user = context.watch<UserProvider>();
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? AppLocalizations.of(context)!.greetingMorning
        : hour < 17
            ? AppLocalizations.of(context)!.greetingAfternoon
            : AppLocalizations.of(context)!.greetingEvening;
    final totalPax = _adults + _youth + _children + _infants;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Greeting ─────────────────────────────────────────────
        Row(children: [
          Icon(hour < 12 ? Icons.wb_sunny_outlined : Icons.wb_twilight_outlined,
              color: Colors.orange, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
                AppLocalizations.of(context)!.homeGreeting(greeting,
                    user.firstName.isEmpty ? 'Traveller' : user.firstName),
                style: TextStyle(
                  fontSize: 16,
                  color: cs.onSurfaceVariant,
                )),
          ),
        ]),
        const SizedBox(height: 4),
        Text(AppLocalizations.of(context)!.bookingSubtitle,
            style: TextStyle(
              fontSize: 14,
              color: cs.onSurfaceVariant,
            )),
        const SizedBox(height: 24),

        // ── Trip Type ─────────────────────────────────────────────
        Row(
          children: _tripTypes.map((t) {
            final selected = _selectedTripType?.tripTypeId == t.tripTypeId;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: t == _tripTypes.last ? 0 : 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() => _selectedTripType = t);
                    context.read<BookingProvider>().setTripTypeId(t.tripTypeId);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.cyanLight
                          : (isDark
                              ? cs.surfaceVariant // was: Colors.grey.shade200
                              : Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(t.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: selected
                              ? AppColors.cyanDark
                              : cs.onSurfaceVariant, // was: Colors.grey.shade600
                          fontWeight:
                              selected ? FontWeight.w600 : FontWeight.normal,
                        )),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // ── Multi-city legs ───────────────────────────────────────
        if (_isMultiCity) ...[
          ..._legs.asMap().entries.map((entry) {
            final i   = entry.key;
            final leg = entry.value;
            final from = leg['from'] as String;
            final to   = leg['to']   as String;
            final date = leg['date'] as DateTime?;
            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Leg ${i + 1}', style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600,
                    color: cs.onSurface)),
                if (_legs.length > 2)
                  GestureDetector(
                    onTap: () => setState(() => _legs.removeAt(i)),
                    child: const Icon(Icons.remove_circle_outline,
                        color: Colors.redAccent, size: 20),
                  ),
              ]),
              const SizedBox(height: 8),
              _cityTile(context, value: from,
                  hint: AppLocalizations.of(context)!.bookingDepartureCityHint,
                  onTap: () => _pickLegCity(i, isFrom: true)),
              const SizedBox(height: 8),
              _cityTile(context, value: to,
                  hint: AppLocalizations.of(context)!.bookingArrivalCityHint,
                  onTap: () => _pickLegCity(i, isFrom: false)),
              const SizedBox(height: 8),
              _dateTile(context,
                  value: date != null ? _formatDate(date) : null,
                  hint: AppLocalizations.of(context)!.bookingSelectDate,
                  onTap: () => _pickLegDate(i)),
              const SizedBox(height: 16),
            ]);
          }),
          if (_legs.length < 5)
            TextButton.icon(
              onPressed: () => setState(() => _legs.add({'from': '', 'to': '', 'date': null})),
              icon: const Icon(Icons.add_circle_outline, color: AppColors.cyan),
              label: const Text('Add another leg',
                  style: TextStyle(color: AppColors.cyan)),
            ),
          const SizedBox(height: 8),
        ],

        // ── From / To / Dates (one-way + round-trip) ─────────────
        if (!_isMultiCity) ...[
        _label(context),
        const SizedBox(height: 8),
        _cityTile(context,
            value: _fromCity,
            hint: AppLocalizations.of(context)!.bookingDepartureCityHint,
            onTap: () => _pickCity(isFrom: true)),
        const SizedBox(height: 16),

        // ── To ────────────────────────────────────────────────────
        _labelTo(context),
        const SizedBox(height: 8),
        _cityTile(context,
            value: _toCity,
            hint: AppLocalizations.of(context)!.bookingArrivalCityHint,
            onTap: () => _pickCity(isFrom: false)),
        const SizedBox(height: 16),

        // ── Departure Date ────────────────────────────────────────
        _labelDep(context),
        const SizedBox(height: 8),
        _dateTile(
          context,
          value: _departureDate != null ? _formatDate(_departureDate!) : null,
          hint: AppLocalizations.of(context)!.bookingSelectDate,
          onTap: () => _pickDate(isDeparture: true),
        ),
        const SizedBox(height: 16),

        // ── Return Date (round trip only) ─────────────────────────
        if (_isRoundTrip) ...[
          _labelRet(context),
          const SizedBox(height: 8),
          _dateTile(
            context,
            value: _returnDate != null ? _formatDate(_returnDate!) : null,
            hint: AppLocalizations.of(context)!.bookingSelectReturnDate,
            onTap: () => _pickDate(isDeparture: false),
          ),
          const SizedBox(height: 16),
        ],
        ], // end if (!_isMultiCity)

        // ── Passengers + Class ────────────────────────────────────
        Row(children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                _labelPax(context),
                const SizedBox(height: 8),
                _tappableTile(
                  context,
                  icon: Icons.people_outline,
                  text: AppLocalizations.of(context)!
                      .bookingPassengersCount(totalPax),
                  onTap: _showPassengerSelector,
                ),
              ])),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                _labelClass(context),
                const SizedBox(height: 8),
                _tappableTile(
                  context,
                  icon: Icons.airline_seat_recline_normal,
                  text: _selectedClass?.name ?? 'Economy',
                  onTap: _classes.isEmpty ? null : _showClassSelector,
                ),
              ])),
        ]),
        const SizedBox(height: 32),

        // ── Search Button ─────────────────────────────────────────
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _searchLoading ? null : _search,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cyan,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: _searchLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5))
                : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(AppLocalizations.of(context)!.bookingSearch,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    const Icon(Icons.search, size: 20),
                  ]),
          ),
        ),
      ]),
    );
  }

  // ── Small helpers ─────────────────────────────────────────────

  // ── Dynamic: label color adapts to theme ──
  Widget _label(BuildContext context) => Text(
      AppLocalizations.of(context)!.bookingFromLabel,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color:
              Theme.of(context).colorScheme.onSurface)); // was: Colors.black87

  Widget _labelTo(BuildContext context) =>
      Text(AppLocalizations.of(context)!.bookingToLabel,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface));

  Widget _labelDep(BuildContext context) =>
      Text(AppLocalizations.of(context)!.bookingDepartureDate,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface));

  Widget _labelRet(BuildContext context) =>
      Text(AppLocalizations.of(context)!.bookingReturnDate,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface));

  Widget _labelPax(BuildContext context) =>
      Text(AppLocalizations.of(context)!.bookingPassengers,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface));

  Widget _labelClass(BuildContext context) =>
      Text(AppLocalizations.of(context)!.bookingClass,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface));

  Widget _cityTile(BuildContext context,
      {required String value,
      required String hint,
      required VoidCallback onTap}) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: cs.surfaceVariant, // was: Colors.grey.shade100
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: value.isNotEmpty
                  ? AppColors.cyan
                  : cs.outlineVariant), // was: Colors.grey.shade300
        ),
        child: Row(children: [
          Icon(Icons.location_on_outlined,
              color: value.isNotEmpty
                  ? AppColors.cyan
                  : cs.onSurfaceVariant), // was: Colors.grey.shade400
          const SizedBox(width: 12),
          Text(value.isNotEmpty ? value : hint,
              style: TextStyle(
                  color: value.isNotEmpty
                      ? cs.onSurface // was: Colors.black87
                      : cs.onSurfaceVariant)), // was: Colors.grey.shade500
        ]),
      ),
    );
  }

  Widget _dateTile(BuildContext context,
      {String? value, required String hint, required VoidCallback onTap}) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: cs.surfaceVariant, // was: Colors.grey.shade100
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: value != null
                  ? AppColors.cyan
                  : cs.outlineVariant), // was: Colors.grey.shade300
        ),
        child: Row(children: [
          Icon(Icons.calendar_today_outlined,
              color: value != null
                  ? AppColors.cyan
                  : cs.onSurfaceVariant), // was: Colors.grey.shade400
          const SizedBox(width: 12),
          Text(value ?? hint,
              style: TextStyle(
                  color: value != null
                      ? cs.onSurface // was: Colors.black87
                      : cs.onSurfaceVariant)), // was: Colors.grey.shade500
        ]),
      ),
    );
  }

  Widget _tappableTile(BuildContext context,
      {required IconData icon, required String text, VoidCallback? onTap}) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: cs.surfaceVariant, // was: Colors.grey.shade100
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: cs.outlineVariant), // was: Colors.grey.shade300
        ),
        child: Row(children: [
          Icon(icon,
              color: cs.onSurfaceVariant,
              size: 18), // was: Colors.grey.shade400
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: cs.onSurfaceVariant, // was: Colors.grey.shade700
                    fontSize: 13)),
          ),
          Icon(Icons.keyboard_arrow_down,
              color: cs.onSurfaceVariant,
              size: 18), // was: Colors.grey.shade400
        ]),
      ),
    );
  }

  String _formatDate(DateTime d) => '${_month(d.month)} ${d.day}, ${d.year}';

  String _month(int m) => const [
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
      ][m];
}
