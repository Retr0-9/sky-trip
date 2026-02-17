# SkyTrip - Flight Booking App

A Flutter mobile app for booking flights, hotels, and van rentals.

## Phase 1 Status: App Skeleton ✅

### Current Implementation
- ✅ 14 screen files (empty placeholders)
- ✅ Bottom navigation (Home, Book, Tickets, Profile)
- ✅ Side drawer (Hotel, Van Rental, Settings, Contact Us, Logout)
- ✅ Booking flow navigation configured
- ✅ All routes defined

### Folder Structure
```
lib/
 ├─ screens/          (14 placeholder screens)
 ├─ widgets/          (MainScaffold with nav)
 └─ main.dart         (App entry point)
```

## How to Run

1. Ensure Flutter SDK is installed
2. Run: `flutter pub get`
3. Run: `flutter run`

## Navigation Flow

**Booking Flow:**
Home → Booking → Available Flights → Flight Details → Passengers Form → Services → [Random Seat → Payment] OR [Choose Seat → Seat Map → Payment] → Home/Tickets

**Bottom Nav:**
- Home
- Book (starts booking flow)
- Tickets
- Profile

**Drawer:**
- Book a Hotel
- Van Rental
- Settings
- Contact Us
- Logout

## Next Steps
- Phase 2: Add layout skeletons to each screen
- Phase 3: Build reusable widgets
- Phase 4: Wire up dummy data
