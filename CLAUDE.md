# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

**SkyTrip** — a Flutter flight booking app (multi-platform: iOS, Android, Web, Desktop). Currently at the UI/UX polish stage; backend integration is planned but not yet implemented. All data is currently served from static dummy data files in `lib/data/`.

## Commands

```bash
flutter pub get       # Install dependencies
flutter run           # Run the app
flutter analyze       # Static analysis (flutter_lints)
flutter test          # Run tests (minimal test suite currently)
flutter build apk     # Build Android APK
flutter build ios     # Build iOS (requires macOS)
```

## Architecture

### Navigation & App Shell

`lib/widgets/main_scaffold.dart` is the persistent app shell after login. It provides:
- Bottom navigation bar with 4 tabs: Home, Book, Tickets, Profile
- Side drawer with additional screens (Hotel Booking, Van Rental, Settings, etc.)
- Booking flow guard: switching tabs mid-booking shows a cancellation dialog

Routes are defined in `lib/main.dart` using named routes. The entry point sets up `MultiProvider` with `BookingProvider` and `UserProvider`.

**Auth flow:** `AuthScreen` → `MainScaffold` (persistent shell wrapping all post-login screens).

### Booking Flow

A multi-step flow managed entirely by `BookingProvider`:

```
BookingScreen (search form)
  → AvailableFlightsScreen
  → FlightDetailsScreen
  → PassengersFormScreen
  → ServicesScreen
  → SeatMapScreen (random seat or selected)
  → PaymentScreen
  → TicketsScreen
```

State accumulates in `BookingProvider` across all steps. `resetBooking()` is called on completion or cancellation.

### State Management

Two `ChangeNotifier` providers in `lib/providers/`:

- **`BookingProvider`** — entire booking flow state: search criteria, selected flight, passengers, extras (meals, wheelchair, special assistance, seat selection), and computed price totals (`baseFare`, `taxes`, `grandTotal`, etc.)
- **`UserProvider`** — user session and profile: login state, personal info, passport, loyalty program. Currently uses hardcoded dummy data (no real auth).

### Design System

All visual tokens are in `lib/theme/app_theme.dart`:
- **Colors:** Cyan primary (`#5BB8C8`), orange accent, green, purple, gold
- **Gradient background:** warm cream → pale sky → soft cyan-blue (applied via `GradientBackground` widget wrapper)
- **Border radii:** `sm`(8), `md`(12), `lg`(16), `xl`(24), `full`(999)
- **Shadows:** `sm`, `md`, `lg`, `card` (layered)
- **Reusable widgets in theme file:** `GradientBackground`, `AppCard`, `SettingsTile`, `AppSectionLabel`, `PriceBadge`

All screens use `GradientBackground` as their root widget for consistent styling. Use `AppCard` for card containers and pull color/typography constants from `AppTheme` rather than hardcoding values.

### Data Layer

`lib/data/` contains static dummy data: `dummy_flights.dart`, `dummy_offers.dart`, `dummy_recent_searches.dart`, `dummy_tickets.dart`. These are intended to be replaced with API calls. Models live in `lib/models/`.
