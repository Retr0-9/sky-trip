// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sky Trip';

  @override
  String get appVersion => 'SkyTrip v1.0.5';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName';
  }

  @override
  String get homeReady => 'Ready for your next adventure?';

  @override
  String get homeRecentSearches => 'Recent Searches';

  @override
  String get homeLatestOffers => 'Latest Offers';

  @override
  String get homeFeaturedDestinations => 'Featured Destinations';

  @override
  String get homeSeeAll => 'See All';

  @override
  String get bookingTitle => 'Book a Flight';

  @override
  String get bookingTripRoundtrip => 'Roundtrip';

  @override
  String get bookingTripOneWay => 'One Way';

  @override
  String get bookingTripMultiCity => 'Multi-City';

  @override
  String get bookingFromLabel => 'From';

  @override
  String get bookingToLabel => 'To';

  @override
  String get bookingSearchCity => 'Search city…';

  @override
  String get bookingDepartureDate => 'Departure';

  @override
  String get bookingReturnDate => 'Return';

  @override
  String get bookingAdults => 'Adults';

  @override
  String get bookingYouth => 'Youth';

  @override
  String get bookingChildren => 'Children';

  @override
  String get bookingInfants => 'Infants';

  @override
  String get bookingClass => 'Class';

  @override
  String get bookingSearch => 'Search Flights';

  @override
  String get bookingNoFlightsFound => 'No flights found';

  @override
  String get bookingTryAnother => 'Try another search';

  @override
  String get authSignIn => 'Sign In';

  @override
  String get authSignUp => 'Sign Up';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authConfirmPassword => 'Confirm Password';

  @override
  String get authFirstName => 'First Name';

  @override
  String get authLastName => 'Last Name';

  @override
  String get authStaffId => 'Staff ID';

  @override
  String get authErrorEmail => 'Enter a valid email address.';

  @override
  String get authErrorPassword => 'Password must be at least 6 characters.';

  @override
  String get authErrorRequired => 'Enter your email and password.';

  @override
  String get authErrorComingSoon => 'Registration coming soon. Please sign in.';

  @override
  String get authErrorGeneric => 'Something went wrong. Please try again.';

  @override
  String get authHaveAccount => 'Already have an account?';

  @override
  String get authNoAccount => 'Don\'t have an account?';

  @override
  String get authStaffMode => 'Staff Mode';

  @override
  String get availableFlightsTitle => 'Available Flights';

  @override
  String get availableFlightsPax => 'pax';

  @override
  String get availableFlightsEmpty => 'No flights available';

  @override
  String get availableFlightsNoResults => 'No flights match your search';

  @override
  String get flightDetailsTitle => 'Flight Details';

  @override
  String get flightDetailsFareBreakdown => 'Fare Breakdown';

  @override
  String get flightDetailsBaseFare => 'Base Fare';

  @override
  String flightDetailsBaseFareDetail(int pax, String currency, String price) {
    return 'Base Fare ($pax pax × $currency $price)';
  }

  @override
  String get flightDetailsTaxes => 'Taxes & Fees (15%)';

  @override
  String get flightDetailsTotal => 'Total Price';

  @override
  String get flightDetailsBaggage => 'Baggage Allowance';

  @override
  String get flightDetailsBaggageCarry => '1 Carry-on';

  @override
  String get flightDetailsBaggageChecked => 'Checked Bags';

  @override
  String get flightDetailsBaggageEconomy =>
      'Economy: 1 carry-on (7kg) + 1 checked bag (23kg)';

  @override
  String get flightDetailsBaggageBusiness =>
      'Business: 1 carry-on (10kg) + 2 checked bags (32kg each)';

  @override
  String get flightDetailsCancellation => 'Cancellation Policy';

  @override
  String get flightDetailsConfirm => 'Continue to Passengers';

  @override
  String get flightDetailsErrorCreating =>
      'Could not create booking. Please try again.';

  @override
  String get passengersFormTitle => 'Passenger Information';

  @override
  String passengersFormPassenger(int number) {
    return 'Passenger $number';
  }

  @override
  String get passengersFormFirstName => 'First Name';

  @override
  String get passengersFormLastName => 'Last Name';

  @override
  String get passengersFormEmail => 'Email';

  @override
  String get passengersFormPhone => 'Phone';

  @override
  String get passengersFormDOB => 'Date of Birth';

  @override
  String get passengersFormGender => 'Gender';

  @override
  String get passengersFormMale => 'Male';

  @override
  String get passengersFormFemale => 'Female';

  @override
  String get passengersFormDocument => 'Travel Document';

  @override
  String get passengersFormPassport => 'Passport';

  @override
  String get passengersFormDocumentIssue => 'Issued by Country';

  @override
  String get passengersFormSearchCountry => 'Search country…';

  @override
  String get passengersFormExpiry => 'Expiry Date';

  @override
  String get passengersFormContinue => 'Continue to Services';

  @override
  String get servicesTitle => 'Optional Services';

  @override
  String get servicesEnhance => 'Enhance Your Journey';

  @override
  String get servicesSubtitle =>
      'Add extra services to make your trip more comfortable';

  @override
  String get servicesTotal => 'Services total:';

  @override
  String get servicesCurrency => 'JOD';

  @override
  String get servicesSkip => 'Skip Services';

  @override
  String get servicesContinue => 'Continue to Seat Selection';

  @override
  String get servicesNoAvailable => 'No services available.';

  @override
  String get servicesLoadError => 'Could not load services.';

  @override
  String get servicesRetry => 'Retry';

  @override
  String get servicesErrorSaving =>
      'Could not save services. Please try again.';

  @override
  String get seatMapTitle => 'Select Your Seat';

  @override
  String get seatMapAvailable => 'Available';

  @override
  String get seatMapOccupied => 'Occupied';

  @override
  String get seatMapSelected => 'Selected';

  @override
  String get seatMapContinue => 'Confirm Seat Selection';

  @override
  String get paymentTitle => 'Payment';

  @override
  String get paymentBookingSummary => 'Booking Summary';

  @override
  String get paymentOrderDetails => 'Order Details';

  @override
  String get paymentFlightDetails => 'Flight Details';

  @override
  String get paymentPassengers => 'Passengers';

  @override
  String get paymentBaseFare => 'Base Fare';

  @override
  String get paymentTaxes => 'Taxes & Fees';

  @override
  String get paymentServicesFee => 'Services';

  @override
  String get paymentTotal => 'Total';

  @override
  String get paymentGrandTotal => 'Grand Total';

  @override
  String get paymentStripeInfo => 'Secured by Stripe';

  @override
  String get paymentProceed => 'Proceed to Payment';

  @override
  String get paymentStart => 'Start Payment';

  @override
  String get paymentErrorTicketId =>
      'Ticket ID missing — please restart booking.';

  @override
  String get paymentErrorSession =>
      'Could not create payment session. Please try again.';

  @override
  String get paymentErrorOpen => 'Could not open payment page.';

  @override
  String get paymentCurrency => 'JOD';

  @override
  String get paymentSuccessTitle => 'Booking Confirmed!';

  @override
  String get paymentSuccessMessage =>
      'Your payment was successful and your booking is confirmed. View your ticket in the Tickets tab.';

  @override
  String get paymentSuccessGoHome => 'Go Home';

  @override
  String get paymentSuccessViewTickets => 'View Tickets';

  @override
  String get ticketsUpcoming => 'Upcoming';

  @override
  String get ticketsPast => 'Past';

  @override
  String get ticketsNoUpcoming => 'No upcoming flights';

  @override
  String get ticketsNoPast => 'No past flights';

  @override
  String ticketsCount(int count, String type, String plural) {
    return '$count $type Flight$plural';
  }

  @override
  String get profileTitle => 'Profile';

  @override
  String get profilePersonalInfo => 'Personal Information';

  @override
  String get profileFullName => 'Full Name';

  @override
  String get profileEmail => 'Email';

  @override
  String get profilePhone => 'Phone';

  @override
  String get profileNationality => 'Nationality';

  @override
  String get profileTravelDocs => 'Travel Documents';

  @override
  String get profilePassport => 'Passport Number';

  @override
  String get profilePreferredClass => 'Preferred Class';

  @override
  String get profileLoyalty => 'Frequent Flyer';

  @override
  String get profileStats => 'Travel Stats';

  @override
  String get profileFlights => 'Flights';

  @override
  String get profileMiles => 'Miles';

  @override
  String get profileTier => 'Tier';

  @override
  String get profilePhotoUpload => 'Photo upload: Coming in Phase 6';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsFlightUpdates => 'Flight Updates';

  @override
  String get settingsFlightUpdatesDesc =>
      'Gate changes, delays & cancellations';

  @override
  String get settingsPriceAlerts => 'Price Alerts';

  @override
  String get settingsPriceAlertsDesc => 'Get notified when prices drop';

  @override
  String get settingsBookingReminders => 'Booking Reminders';

  @override
  String get settingsBookingRemindersDesc => '24h before departure';

  @override
  String get settingsPromotions => 'Promotions & Offers';

  @override
  String get settingsPromotionsDesc => 'Deals, discounts and seasonal offers';

  @override
  String get settingsSmsAlerts => 'SMS Alerts';

  @override
  String get settingsSmsAlertsDesc => 'Receive alerts via text message';

  @override
  String get settingsDisplay => 'Display & Language';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsCurrency => 'Currency';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsDarkModeDesc => 'Switch to dark theme';

  @override
  String get settingsPrivacy => 'Privacy & Security';

  @override
  String get settingsChangePassword => 'Change Password';

  @override
  String get settingsBiometric => 'Biometric Login';

  @override
  String get settingsBiometricDesc => 'Use fingerprint or Face ID';

  @override
  String get settingsShareData => 'Share Usage Data';

  @override
  String get settingsShareDataDesc => 'Help us improve the app';

  @override
  String get settingsLocation => 'Location Services';

  @override
  String get settingsLocationDesc => 'Used for nearby airports';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsDeleteAccount => 'Delete Account';

  @override
  String get settingsDeleteAccountDesc => 'Permanently remove your data';

  @override
  String get settingsAppVersion => 'App Version';

  @override
  String get settingsLogout => 'Log Out';

  @override
  String get settingsComingSoon => 'Coming in Phase 6';

  @override
  String get settingsSelectLanguage => 'Select Language';

  @override
  String get settingsSelectCurrency => 'Select Currency';

  @override
  String get hotelTitle => 'Book a Hotel';

  @override
  String get hotelSearch => 'Search Hotels';

  @override
  String get hotelWhere => 'Where to?';

  @override
  String get hotelDestination => 'Destination city or hotel name';

  @override
  String get hotelCheckIn => 'Check-in';

  @override
  String get hotelCheckOut => 'Check-out';

  @override
  String get hotelRooms => 'Rooms';

  @override
  String get hotelGuests => 'Guests';

  @override
  String get hotelEmptyMessage => 'Find your perfect stay';

  @override
  String get hotelEmptySubtitle => 'Enter a destination to search hotels';

  @override
  String hotelHotelsIn(int count, String destination) {
    return '$count hotels in $destination';
  }

  @override
  String hotelNights(int count, String plural) {
    return '$count night$plural';
  }

  @override
  String get hotelErrorDestination => 'Please enter a destination';

  @override
  String get vanTitle => 'Van Rental';

  @override
  String get vanFind => 'Find Vehicles';

  @override
  String get vanPickupLocation => 'Pick-up';

  @override
  String get vanDropLocation => 'Drop-off';

  @override
  String get vanPickupDate => 'Pick-up Date';

  @override
  String get vanReturnDate => 'Return Date';

  @override
  String get vanEmptyMessage => 'Find the perfect ride';

  @override
  String get vanEmptySubtitle =>
      'Select locations to browse available vehicles';

  @override
  String vanVehiclesAvailable(int count, String plural) {
    return '$count vehicle$plural available';
  }

  @override
  String get vanNoVehicles => 'No vehicles in this category';

  @override
  String get vanErrorPickup => 'Please select a pick-up location';

  @override
  String get contactUsTitle => 'Contact Us';

  @override
  String get contactGetInTouch => 'Get In Touch';

  @override
  String get contactCall => 'Call Us';

  @override
  String get contactCallNumber => '+962 6 510 0000';

  @override
  String get contactEmail => 'Email Us';

  @override
  String get contactEmailAddress => 'support@skytrip.com';

  @override
  String get contactChat => 'Live Chat';

  @override
  String get contactChatAvailable => 'Available 24/7';

  @override
  String get contactSendMessage => 'Send a Message';

  @override
  String get contactSubject => 'Subject';

  @override
  String get contactMessage => 'Message';

  @override
  String get contactSend => 'Send Message';

  @override
  String get contactFaq => 'FAQ';

  @override
  String contactOpening(String type) {
    return 'Opening $type…';
  }

  @override
  String get contactSuccess => 'Message sent! We\'ll respond within 24 hours.';

  @override
  String get contactComing => 'Live chat: Coming in Phase 6';

  @override
  String get dialogCancel => 'Cancel';

  @override
  String get dialogOk => 'OK';

  @override
  String get dialogConfirm => 'Confirm';

  @override
  String get dialogCannotCancel => 'Cancel Booking?';

  @override
  String get dialogCancelBookingDesc =>
      'You have a booking in progress. Leaving now will lose all your selections.';

  @override
  String get dialogKeepGoing => 'Keep Going';

  @override
  String get dialogLogout => 'Log Out';

  @override
  String get dialogLogoutConfirm => 'Are you sure you want to log out?';

  @override
  String get dialogDeleteAccount => 'Delete Account';

  @override
  String get dialogDeleteAccountConfirm =>
      'Permanently remove all your data? This action cannot be undone.';

  @override
  String get drawerHotel => 'Book a Hotel';

  @override
  String get drawerVanRental => 'Van Rental';

  @override
  String get drawerSettings => 'Settings';

  @override
  String get drawerContactUs => 'Contact Us';

  @override
  String get drawerAbout => 'About';

  @override
  String get drawerWelcome => 'Welcome';

  @override
  String drawerWelcomeName(String name) {
    return 'Welcome, $name';
  }

  @override
  String get drawerLogout => 'Log Out';

  @override
  String get drawerBooking => 'Booking';
}
