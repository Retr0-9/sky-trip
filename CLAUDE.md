# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

**SkyTrip** — a Flutter flight booking app (iOS, Android, Web, Desktop) modeled after Royal Jordanian. The app is wired to a live REST backend hosted on Azure (see `lib/services/api_client.dart` for the base URL). Some screens still consume static data from `lib/data/dummy_*.dart` while the migration to the API completes — when editing a screen, check whether it uses `FlightModel` (legacy/dummy) or `FlightScheduleModel` (API).

## Commands

```bash
flutter pub get       # install deps + run intl/build_runner codegen
flutter run           # run on the selected device
flutter analyze       # static analysis (flutter_lints)
flutter test          # run tests (suite is minimal)
flutter test test/path/to_test.dart   # run a single test file
flutter build apk     # Android release build
flutter build ios     # iOS build (macOS only)
```

The `lib/generated/` tree (intl messages, `app_localizations*.dart`) is generated — do not edit it by hand. Add ARB strings under `lib/l10n/` and re-run codegen.

## Architecture

### Backend integration

`lib/services/api_client.dart` is the single HTTP entry point. It:
- Holds the API base URL (Azure-hosted REST API).
- Injects `Authorization: Bearer <token>` on every request.
- Throws a typed `AuthException` (defined in `auth_service.dart`) on 401 or any 4xx/5xx, with the message extracted from `detail` / `title` in the JSON body.
- Wraps network errors into a friendly `AuthException` so call sites only deal with one exception type.

Per-domain services (`auth_service`, `flight_service`, `booking_service`, `payment_service`, `extras_service`, `profile_service`, `country_service`) sit on top of `ApiClient` and own JSON encoding/decoding. The token used by `ApiClient` is read off `UserProvider` at the call site — services do not own auth state.

### Navigation & app shell

`lib/widgets/main_scaffold.dart` is the persistent shell after login: bottom nav (Home, Book, Tickets, Profile) + side drawer (Hotel Booking, Van Rental, Settings, Contact Us, Logout). It also enforces a **booking-flow guard** — switching tabs while `BookingProvider.isInBookingFlow` is true prompts a cancellation dialog before navigating.

Routes are defined in `lib/main.dart` using named routes. The root route (`/`) branches on `UserProvider.isLoggedIn` between `AuthScreen` and `MainScaffold`.

### Booking flow

Multi-step flow with state accumulating in `BookingProvider`:

```
BookingScreen → AvailableFlightsScreen → FlightDetailsScreen
  → PassengersFormScreen → ServicesScreen
  → SeatMapScreen (only if user opted to choose a seat)
  → PaymentScreen → TicketsScreen
```

`BookingProvider` tracks both the legacy dummy model (`_selectedFlight: FlightModel`) and the API model (`_selectedSchedule: FlightScheduleModel`) plus server-side IDs (`bookId`, `ticketId`, `selectedClassId`) accumulated as the flow progresses. Pricing getters (`flightPrice`, `baseFare`, `taxes`, `grandTotal`) prefer the API schedule when present and fall back to the dummy flight. Always call `resetBooking()` on completion or cancellation.

### State management

Four `ChangeNotifier` providers, registered in `main.dart` via `MultiProvider`:

- **`BookingProvider`** — booking flow state (search criteria, selected flight/schedule, passengers, services, seat, server IDs, computed totals).
- **`UserProvider`** — auth state (token, userId/personId/clientId/role) **plus** UI preferences: theme mode, locale, currency. Currency conversion lives here (`convertPrice`, `_conversionRates` keyed off JOD). Theme/language/currency are persisted to `SharedPreferences`; `main()` awaits their loaders before `runApp`.
- **`VehicleProvider`** — van rental catalog (hardcoded list) plus booked vehicles persisted to `SharedPreferences` under `vehicle_bookings_list`. `init()` must run before `runApp`.
- **`HotelBookingProvider`** — hotel bookings persisted to `SharedPreferences` under `hotel_bookings_list`. `init()` must run before `runApp`.

Note: `pubspec.yaml` lists `hive_flutter` but it is currently unused — persistence is via `SharedPreferences`.

### Design system

All visual tokens live in `lib/theme/app_theme.dart`. Both `AppTheme.lightTheme` and `AppTheme.darkTheme` are wired up; `UserProvider.themeMode` selects between them.

- **Colors:** cyan primary (`#5BB8C8`), orange accent, green, purple, gold.
- **Gradient background:** warm cream → pale sky → soft cyan-blue. Apply via the `GradientBackground` widget exported from the theme file — every screen should use it as its root.
- **Border radii:** `sm`(8), `md`(12), `lg`(16), `xl`(24), `full`(999).
- **Shadows:** `sm`, `md`, `lg`, `card`.
- **Reusable widgets exported from the theme:** `GradientBackground`, `AppCard`, `SettingsTile`, `AppSectionLabel`, `PriceBadge`.

Pull color/typography constants from `AppTheme` rather than hardcoding values, and use `AppCard` for card containers.

### Localization

Supported locales are `en` and `ar` (declared in `main.dart`). Generated delegates live under `lib/generated/l10n/`. ARB sources are in `lib/l10n/`. Stubs for `de`, `es`, `fr` exist in the generated tree but are not declared in `supportedLocales`.

### Data layer

`lib/data/` holds static dummy data still used by some screens: `dummy_flights.dart`, `dummy_offers.dart`, `dummy_recent_searches.dart`, `dummy_tickets.dart`, `dummy-vehicle.dart`, `dummy_hotelBooking.dart`. Models are in `lib/models/`; both legacy (`flight_model.dart`) and API-shaped (`flight_schedule_model.dart`, `booking_search_model.dart`) variants coexist during the migration.
