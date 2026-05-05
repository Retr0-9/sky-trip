// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(type) => "Opening ${type}…";

  static String m1(name) => "Welcome, ${name}";

  static String m2(pax, currency, price) =>
      "Base Fare (${pax} pax × ${currency} ${price})";

  static String m3(greeting, firstName) => "${greeting}, ${firstName}";

  static String m4(count, destination) => "${count} hotels in ${destination}";

  static String m5(count, plural) => "${count} night${plural}";

  static String m6(number) => "Passenger ${number}";

  static String m7(count, type, plural) => "${count} ${type} Flight${plural}";

  static String m8(count, plural) => "${count} vehicle${plural} available";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Sky Trip"),
    "appVersion": MessageLookupByLibrary.simpleMessage("SkyTrip v1.0.0"),
    "authConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "authEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "authErrorComingSoon": MessageLookupByLibrary.simpleMessage(
      "Registration coming soon. Please sign in.",
    ),
    "authErrorEmail": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email address.",
    ),
    "authErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "authErrorPassword": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters.",
    ),
    "authErrorRequired": MessageLookupByLibrary.simpleMessage(
      "Enter your email and password.",
    ),
    "authFirstName": MessageLookupByLibrary.simpleMessage("First Name"),
    "authHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "authLastName": MessageLookupByLibrary.simpleMessage("Last Name"),
    "authNoAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "authPassword": MessageLookupByLibrary.simpleMessage("Password"),
    "authSignIn": MessageLookupByLibrary.simpleMessage("Sign In"),
    "authSignUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "authStaffId": MessageLookupByLibrary.simpleMessage("Staff ID"),
    "authStaffMode": MessageLookupByLibrary.simpleMessage("Staff Mode"),
    "availableFlightsEmpty": MessageLookupByLibrary.simpleMessage(
      "No flights available",
    ),
    "availableFlightsNoResults": MessageLookupByLibrary.simpleMessage(
      "No flights match your search",
    ),
    "availableFlightsPax": MessageLookupByLibrary.simpleMessage("pax"),
    "availableFlightsTitle": MessageLookupByLibrary.simpleMessage(
      "Available Flights",
    ),
    "bookingAdults": MessageLookupByLibrary.simpleMessage("Adults"),
    "bookingChildren": MessageLookupByLibrary.simpleMessage("Children"),
    "bookingClass": MessageLookupByLibrary.simpleMessage("Class"),
    "bookingDepartureDate": MessageLookupByLibrary.simpleMessage("Departure"),
    "bookingFromLabel": MessageLookupByLibrary.simpleMessage("From"),
    "bookingInfants": MessageLookupByLibrary.simpleMessage("Infants"),
    "bookingNoFlightsFound": MessageLookupByLibrary.simpleMessage(
      "No flights found",
    ),
    "bookingReturnDate": MessageLookupByLibrary.simpleMessage("Return"),
    "bookingSearch": MessageLookupByLibrary.simpleMessage("Search Flights"),
    "bookingSearchCity": MessageLookupByLibrary.simpleMessage("Search city…"),
    "bookingTitle": MessageLookupByLibrary.simpleMessage("Book a Flight"),
    "bookingToLabel": MessageLookupByLibrary.simpleMessage("To"),
    "bookingTripMultiCity": MessageLookupByLibrary.simpleMessage("Multi-City"),
    "bookingTripOneWay": MessageLookupByLibrary.simpleMessage("One Way"),
    "bookingTripRoundtrip": MessageLookupByLibrary.simpleMessage("Roundtrip"),
    "bookingTryAnother": MessageLookupByLibrary.simpleMessage(
      "Try another search",
    ),
    "bookingYouth": MessageLookupByLibrary.simpleMessage("Youth"),
    "contactCall": MessageLookupByLibrary.simpleMessage("Call Us"),
    "contactCallNumber": MessageLookupByLibrary.simpleMessage(
      "+962 6 510 0000",
    ),
    "contactChat": MessageLookupByLibrary.simpleMessage("Live Chat"),
    "contactChatAvailable": MessageLookupByLibrary.simpleMessage(
      "Available 24/7",
    ),
    "contactComing": MessageLookupByLibrary.simpleMessage(
      "Live chat: Coming in Phase 6",
    ),
    "contactEmail": MessageLookupByLibrary.simpleMessage("Email Us"),
    "contactEmailAddress": MessageLookupByLibrary.simpleMessage(
      "support@skytrip.com",
    ),
    "contactFaq": MessageLookupByLibrary.simpleMessage("FAQ"),
    "contactGetInTouch": MessageLookupByLibrary.simpleMessage("Get In Touch"),
    "contactMessage": MessageLookupByLibrary.simpleMessage("Message"),
    "contactOpening": m0,
    "contactSend": MessageLookupByLibrary.simpleMessage("Send Message"),
    "contactSendMessage": MessageLookupByLibrary.simpleMessage(
      "Send a Message",
    ),
    "contactSubject": MessageLookupByLibrary.simpleMessage("Subject"),
    "contactSuccess": MessageLookupByLibrary.simpleMessage(
      "Message sent! We\'ll respond within 24 hours.",
    ),
    "contactUsTitle": MessageLookupByLibrary.simpleMessage("Contact Us"),
    "dialogCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "dialogCancelBookingDesc": MessageLookupByLibrary.simpleMessage(
      "You have a booking in progress. Leaving now will lose all your selections.",
    ),
    "dialogCannotCancel": MessageLookupByLibrary.simpleMessage(
      "Cancel Booking?",
    ),
    "dialogConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "dialogDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Delete Account",
    ),
    "dialogDeleteAccountConfirm": MessageLookupByLibrary.simpleMessage(
      "Permanently remove all your data? This action cannot be undone.",
    ),
    "dialogKeepGoing": MessageLookupByLibrary.simpleMessage("Keep Going"),
    "dialogLogout": MessageLookupByLibrary.simpleMessage("Log Out"),
    "dialogLogoutConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out?",
    ),
    "dialogOk": MessageLookupByLibrary.simpleMessage("OK"),
    "drawerAbout": MessageLookupByLibrary.simpleMessage("About"),
    "drawerBooking": MessageLookupByLibrary.simpleMessage("Booking"),
    "drawerContactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
    "drawerHotel": MessageLookupByLibrary.simpleMessage("Book a Hotel"),
    "drawerLogout": MessageLookupByLibrary.simpleMessage("Log Out"),
    "drawerSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "drawerVanRental": MessageLookupByLibrary.simpleMessage("Van Rental"),
    "drawerWelcome": MessageLookupByLibrary.simpleMessage("Welcome"),
    "drawerWelcomeName": m1,
    "flightDetailsBaggage": MessageLookupByLibrary.simpleMessage(
      "Baggage Allowance",
    ),
    "flightDetailsBaggageBusiness": MessageLookupByLibrary.simpleMessage(
      "Business: 1 carry-on (10kg) + 2 checked bags (32kg each)",
    ),
    "flightDetailsBaggageCarry": MessageLookupByLibrary.simpleMessage(
      "1 Carry-on",
    ),
    "flightDetailsBaggageChecked": MessageLookupByLibrary.simpleMessage(
      "Checked Bags",
    ),
    "flightDetailsBaggageEconomy": MessageLookupByLibrary.simpleMessage(
      "Economy: 1 carry-on (7kg) + 1 checked bag (23kg)",
    ),
    "flightDetailsBaseFare": MessageLookupByLibrary.simpleMessage("Base Fare"),
    "flightDetailsBaseFareDetail": m2,
    "flightDetailsCancellation": MessageLookupByLibrary.simpleMessage(
      "Cancellation Policy",
    ),
    "flightDetailsConfirm": MessageLookupByLibrary.simpleMessage(
      "Continue to Passengers",
    ),
    "flightDetailsErrorCreating": MessageLookupByLibrary.simpleMessage(
      "Could not create booking. Please try again.",
    ),
    "flightDetailsFareBreakdown": MessageLookupByLibrary.simpleMessage(
      "Fare Breakdown",
    ),
    "flightDetailsTaxes": MessageLookupByLibrary.simpleMessage(
      "Taxes & Fees (15%)",
    ),
    "flightDetailsTitle": MessageLookupByLibrary.simpleMessage(
      "Flight Details",
    ),
    "flightDetailsTotal": MessageLookupByLibrary.simpleMessage("Total Price"),
    "homeFeaturedDestinations": MessageLookupByLibrary.simpleMessage(
      "Featured Destinations",
    ),
    "homeGreeting": m3,
    "homeLatestOffers": MessageLookupByLibrary.simpleMessage("Latest Offers"),
    "homeReady": MessageLookupByLibrary.simpleMessage(
      "Ready for your next adventure?",
    ),
    "homeRecentSearches": MessageLookupByLibrary.simpleMessage(
      "Recent Searches",
    ),
    "homeSeeAll": MessageLookupByLibrary.simpleMessage("See All"),
    "hotelCheckIn": MessageLookupByLibrary.simpleMessage("Check-in"),
    "hotelCheckOut": MessageLookupByLibrary.simpleMessage("Check-out"),
    "hotelDestination": MessageLookupByLibrary.simpleMessage(
      "Destination city or hotel name",
    ),
    "hotelEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Find your perfect stay",
    ),
    "hotelEmptySubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter a destination to search hotels",
    ),
    "hotelErrorDestination": MessageLookupByLibrary.simpleMessage(
      "Please enter a destination",
    ),
    "hotelGuests": MessageLookupByLibrary.simpleMessage("Guests"),
    "hotelHotelsIn": m4,
    "hotelNights": m5,
    "hotelRooms": MessageLookupByLibrary.simpleMessage("Rooms"),
    "hotelSearch": MessageLookupByLibrary.simpleMessage("Search Hotels"),
    "hotelTitle": MessageLookupByLibrary.simpleMessage("Book a Hotel"),
    "hotelWhere": MessageLookupByLibrary.simpleMessage("Where to?"),
    "passengersFormContinue": MessageLookupByLibrary.simpleMessage(
      "Continue to Services",
    ),
    "passengersFormDOB": MessageLookupByLibrary.simpleMessage("Date of Birth"),
    "passengersFormDocument": MessageLookupByLibrary.simpleMessage(
      "Travel Document",
    ),
    "passengersFormDocumentIssue": MessageLookupByLibrary.simpleMessage(
      "Issued by Country",
    ),
    "passengersFormEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "passengersFormExpiry": MessageLookupByLibrary.simpleMessage("Expiry Date"),
    "passengersFormFemale": MessageLookupByLibrary.simpleMessage("Female"),
    "passengersFormFirstName": MessageLookupByLibrary.simpleMessage(
      "First Name",
    ),
    "passengersFormGender": MessageLookupByLibrary.simpleMessage("Gender"),
    "passengersFormLastName": MessageLookupByLibrary.simpleMessage("Last Name"),
    "passengersFormMale": MessageLookupByLibrary.simpleMessage("Male"),
    "passengersFormPassenger": m6,
    "passengersFormPassport": MessageLookupByLibrary.simpleMessage("Passport"),
    "passengersFormPhone": MessageLookupByLibrary.simpleMessage("Phone"),
    "passengersFormSearchCountry": MessageLookupByLibrary.simpleMessage(
      "Search country…",
    ),
    "passengersFormTitle": MessageLookupByLibrary.simpleMessage(
      "Passenger Information",
    ),
    "paymentBaseFare": MessageLookupByLibrary.simpleMessage("Base Fare"),
    "paymentBookingSummary": MessageLookupByLibrary.simpleMessage(
      "Booking Summary",
    ),
    "paymentCurrency": MessageLookupByLibrary.simpleMessage("JOD"),
    "paymentErrorOpen": MessageLookupByLibrary.simpleMessage(
      "Could not open payment page.",
    ),
    "paymentErrorSession": MessageLookupByLibrary.simpleMessage(
      "Could not create payment session. Please try again.",
    ),
    "paymentErrorTicketId": MessageLookupByLibrary.simpleMessage(
      "Ticket ID missing — please restart booking.",
    ),
    "paymentFlightDetails": MessageLookupByLibrary.simpleMessage(
      "Flight Details",
    ),
    "paymentGrandTotal": MessageLookupByLibrary.simpleMessage("Grand Total"),
    "paymentOrderDetails": MessageLookupByLibrary.simpleMessage(
      "Order Details",
    ),
    "paymentPassengers": MessageLookupByLibrary.simpleMessage("Passengers"),
    "paymentProceed": MessageLookupByLibrary.simpleMessage(
      "Proceed to Payment",
    ),
    "paymentServicesFee": MessageLookupByLibrary.simpleMessage("Services"),
    "paymentStart": MessageLookupByLibrary.simpleMessage("Start Payment"),
    "paymentStripeInfo": MessageLookupByLibrary.simpleMessage(
      "Secured by Stripe",
    ),
    "paymentSuccessGoHome": MessageLookupByLibrary.simpleMessage("Go Home"),
    "paymentSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Your payment was successful and your booking is confirmed. View your ticket in the Tickets tab.",
    ),
    "paymentSuccessTitle": MessageLookupByLibrary.simpleMessage(
      "Booking Confirmed!",
    ),
    "paymentSuccessViewTickets": MessageLookupByLibrary.simpleMessage(
      "View Tickets",
    ),
    "paymentTaxes": MessageLookupByLibrary.simpleMessage("Taxes & Fees"),
    "paymentTitle": MessageLookupByLibrary.simpleMessage("Payment"),
    "paymentTotal": MessageLookupByLibrary.simpleMessage("Total"),
    "profileEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "profileFlights": MessageLookupByLibrary.simpleMessage("Flights"),
    "profileFullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "profileLoyalty": MessageLookupByLibrary.simpleMessage("Frequent Flyer"),
    "profileMiles": MessageLookupByLibrary.simpleMessage("Miles"),
    "profileNationality": MessageLookupByLibrary.simpleMessage("Nationality"),
    "profilePassport": MessageLookupByLibrary.simpleMessage("Passport Number"),
    "profilePersonalInfo": MessageLookupByLibrary.simpleMessage(
      "Personal Information",
    ),
    "profilePhone": MessageLookupByLibrary.simpleMessage("Phone"),
    "profilePhotoUpload": MessageLookupByLibrary.simpleMessage(
      "Photo upload: Coming in Phase 6",
    ),
    "profilePreferredClass": MessageLookupByLibrary.simpleMessage(
      "Preferred Class",
    ),
    "profileStats": MessageLookupByLibrary.simpleMessage("Travel Stats"),
    "profileTier": MessageLookupByLibrary.simpleMessage("Tier"),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileTravelDocs": MessageLookupByLibrary.simpleMessage(
      "Travel Documents",
    ),
    "seatMapAvailable": MessageLookupByLibrary.simpleMessage("Available"),
    "seatMapContinue": MessageLookupByLibrary.simpleMessage(
      "Confirm Seat Selection",
    ),
    "seatMapOccupied": MessageLookupByLibrary.simpleMessage("Occupied"),
    "seatMapSelected": MessageLookupByLibrary.simpleMessage("Selected"),
    "seatMapTitle": MessageLookupByLibrary.simpleMessage("Select Your Seat"),
    "servicesContinue": MessageLookupByLibrary.simpleMessage(
      "Continue to Seat Selection",
    ),
    "servicesCurrency": MessageLookupByLibrary.simpleMessage("JOD"),
    "servicesEnhance": MessageLookupByLibrary.simpleMessage(
      "Enhance Your Journey",
    ),
    "servicesErrorSaving": MessageLookupByLibrary.simpleMessage(
      "Could not save services. Please try again.",
    ),
    "servicesLoadError": MessageLookupByLibrary.simpleMessage(
      "Could not load services.",
    ),
    "servicesNoAvailable": MessageLookupByLibrary.simpleMessage(
      "No services available.",
    ),
    "servicesRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "servicesSkip": MessageLookupByLibrary.simpleMessage("Skip Services"),
    "servicesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Add extra services to make your trip more comfortable",
    ),
    "servicesTitle": MessageLookupByLibrary.simpleMessage("Optional Services"),
    "servicesTotal": MessageLookupByLibrary.simpleMessage("Services total:"),
    "settingsAccount": MessageLookupByLibrary.simpleMessage("Account"),
    "settingsAppVersion": MessageLookupByLibrary.simpleMessage("App Version"),
    "settingsBiometric": MessageLookupByLibrary.simpleMessage(
      "Biometric Login",
    ),
    "settingsBiometricDesc": MessageLookupByLibrary.simpleMessage(
      "Use fingerprint or Face ID",
    ),
    "settingsBookingReminders": MessageLookupByLibrary.simpleMessage(
      "Booking Reminders",
    ),
    "settingsBookingRemindersDesc": MessageLookupByLibrary.simpleMessage(
      "24h before departure",
    ),
    "settingsChangePassword": MessageLookupByLibrary.simpleMessage(
      "Change Password",
    ),
    "settingsComingSoon": MessageLookupByLibrary.simpleMessage(
      "Coming in Phase 6",
    ),
    "settingsCurrency": MessageLookupByLibrary.simpleMessage("Currency"),
    "settingsDarkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "settingsDarkModeDesc": MessageLookupByLibrary.simpleMessage(
      "Switch to dark theme",
    ),
    "settingsDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Delete Account",
    ),
    "settingsDeleteAccountDesc": MessageLookupByLibrary.simpleMessage(
      "Permanently remove your data",
    ),
    "settingsDisplay": MessageLookupByLibrary.simpleMessage(
      "Display & Language",
    ),
    "settingsFlightUpdates": MessageLookupByLibrary.simpleMessage(
      "Flight Updates",
    ),
    "settingsFlightUpdatesDesc": MessageLookupByLibrary.simpleMessage(
      "Gate changes, delays & cancellations",
    ),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("Language"),
    "settingsLocation": MessageLookupByLibrary.simpleMessage(
      "Location Services",
    ),
    "settingsLocationDesc": MessageLookupByLibrary.simpleMessage(
      "Used for nearby airports",
    ),
    "settingsLogout": MessageLookupByLibrary.simpleMessage("Log Out"),
    "settingsNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "settingsPriceAlerts": MessageLookupByLibrary.simpleMessage("Price Alerts"),
    "settingsPriceAlertsDesc": MessageLookupByLibrary.simpleMessage(
      "Get notified when prices drop",
    ),
    "settingsPrivacy": MessageLookupByLibrary.simpleMessage(
      "Privacy & Security",
    ),
    "settingsPromotions": MessageLookupByLibrary.simpleMessage(
      "Promotions & Offers",
    ),
    "settingsPromotionsDesc": MessageLookupByLibrary.simpleMessage(
      "Deals, discounts and seasonal offers",
    ),
    "settingsSelectCurrency": MessageLookupByLibrary.simpleMessage(
      "Select Currency",
    ),
    "settingsSelectLanguage": MessageLookupByLibrary.simpleMessage(
      "Select Language",
    ),
    "settingsShareData": MessageLookupByLibrary.simpleMessage(
      "Share Usage Data",
    ),
    "settingsShareDataDesc": MessageLookupByLibrary.simpleMessage(
      "Help us improve the app",
    ),
    "settingsSmsAlerts": MessageLookupByLibrary.simpleMessage("SMS Alerts"),
    "settingsSmsAlertsDesc": MessageLookupByLibrary.simpleMessage(
      "Receive alerts via text message",
    ),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "ticketsCount": m7,
    "ticketsNoPast": MessageLookupByLibrary.simpleMessage("No past flights"),
    "ticketsNoUpcoming": MessageLookupByLibrary.simpleMessage(
      "No upcoming flights",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Past"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "vanDropLocation": MessageLookupByLibrary.simpleMessage("Drop-off"),
    "vanEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Find the perfect ride",
    ),
    "vanEmptySubtitle": MessageLookupByLibrary.simpleMessage(
      "Select locations to browse available vehicles",
    ),
    "vanErrorPickup": MessageLookupByLibrary.simpleMessage(
      "Please select a pick-up location",
    ),
    "vanFind": MessageLookupByLibrary.simpleMessage("Find Vehicles"),
    "vanNoVehicles": MessageLookupByLibrary.simpleMessage(
      "No vehicles in this category",
    ),
    "vanPickupDate": MessageLookupByLibrary.simpleMessage("Pick-up Date"),
    "vanPickupLocation": MessageLookupByLibrary.simpleMessage("Pick-up"),
    "vanReturnDate": MessageLookupByLibrary.simpleMessage("Return Date"),
    "vanTitle": MessageLookupByLibrary.simpleMessage("Van Rental"),
    "vanVehiclesAvailable": m8,
  };
}
