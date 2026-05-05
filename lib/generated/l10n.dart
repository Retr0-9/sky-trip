// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sky Trip`
  String get appTitle {
    return Intl.message('Sky Trip', name: 'appTitle', desc: '', args: []);
  }

  /// `SkyTrip v1.0.0`
  String get appVersion {
    return Intl.message(
      'SkyTrip v1.0.0',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `{greeting}, {firstName}`
  String homeGreeting(String greeting, String firstName) {
    return Intl.message(
      '$greeting, $firstName',
      name: 'homeGreeting',
      desc: 'Personalized greeting on home screen',
      args: [greeting, firstName],
    );
  }

  /// `Ready for your next adventure?`
  String get homeReady {
    return Intl.message(
      'Ready for your next adventure?',
      name: 'homeReady',
      desc: '',
      args: [],
    );
  }

  /// `Recent Searches`
  String get homeRecentSearches {
    return Intl.message(
      'Recent Searches',
      name: 'homeRecentSearches',
      desc: '',
      args: [],
    );
  }

  /// `Latest Offers`
  String get homeLatestOffers {
    return Intl.message(
      'Latest Offers',
      name: 'homeLatestOffers',
      desc: '',
      args: [],
    );
  }

  /// `Featured Destinations`
  String get homeFeaturedDestinations {
    return Intl.message(
      'Featured Destinations',
      name: 'homeFeaturedDestinations',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get homeSeeAll {
    return Intl.message('See All', name: 'homeSeeAll', desc: '', args: []);
  }

  /// `Book a Flight`
  String get bookingTitle {
    return Intl.message(
      'Book a Flight',
      name: 'bookingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Roundtrip`
  String get bookingTripRoundtrip {
    return Intl.message(
      'Roundtrip',
      name: 'bookingTripRoundtrip',
      desc: '',
      args: [],
    );
  }

  /// `One Way`
  String get bookingTripOneWay {
    return Intl.message(
      'One Way',
      name: 'bookingTripOneWay',
      desc: '',
      args: [],
    );
  }

  /// `Multi-City`
  String get bookingTripMultiCity {
    return Intl.message(
      'Multi-City',
      name: 'bookingTripMultiCity',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get bookingFromLabel {
    return Intl.message('From', name: 'bookingFromLabel', desc: '', args: []);
  }

  /// `To`
  String get bookingToLabel {
    return Intl.message('To', name: 'bookingToLabel', desc: '', args: []);
  }

  /// `Search city…`
  String get bookingSearchCity {
    return Intl.message(
      'Search city…',
      name: 'bookingSearchCity',
      desc: '',
      args: [],
    );
  }

  /// `Departure`
  String get bookingDepartureDate {
    return Intl.message(
      'Departure',
      name: 'bookingDepartureDate',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get bookingReturnDate {
    return Intl.message(
      'Return',
      name: 'bookingReturnDate',
      desc: '',
      args: [],
    );
  }

  /// `Adults`
  String get bookingAdults {
    return Intl.message('Adults', name: 'bookingAdults', desc: '', args: []);
  }

  /// `Youth`
  String get bookingYouth {
    return Intl.message('Youth', name: 'bookingYouth', desc: '', args: []);
  }

  /// `Children`
  String get bookingChildren {
    return Intl.message(
      'Children',
      name: 'bookingChildren',
      desc: '',
      args: [],
    );
  }

  /// `Infants`
  String get bookingInfants {
    return Intl.message('Infants', name: 'bookingInfants', desc: '', args: []);
  }

  /// `Class`
  String get bookingClass {
    return Intl.message('Class', name: 'bookingClass', desc: '', args: []);
  }

  /// `Search Flights`
  String get bookingSearch {
    return Intl.message(
      'Search Flights',
      name: 'bookingSearch',
      desc: '',
      args: [],
    );
  }

  /// `No flights found`
  String get bookingNoFlightsFound {
    return Intl.message(
      'No flights found',
      name: 'bookingNoFlightsFound',
      desc: '',
      args: [],
    );
  }

  /// `Try another search`
  String get bookingTryAnother {
    return Intl.message(
      'Try another search',
      name: 'bookingTryAnother',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get authSignIn {
    return Intl.message('Sign In', name: 'authSignIn', desc: '', args: []);
  }

  /// `Sign Up`
  String get authSignUp {
    return Intl.message('Sign Up', name: 'authSignUp', desc: '', args: []);
  }

  /// `Email`
  String get authEmail {
    return Intl.message('Email', name: 'authEmail', desc: '', args: []);
  }

  /// `Password`
  String get authPassword {
    return Intl.message('Password', name: 'authPassword', desc: '', args: []);
  }

  /// `Confirm Password`
  String get authConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'authConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get authFirstName {
    return Intl.message(
      'First Name',
      name: 'authFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get authLastName {
    return Intl.message('Last Name', name: 'authLastName', desc: '', args: []);
  }

  /// `Staff ID`
  String get authStaffId {
    return Intl.message('Staff ID', name: 'authStaffId', desc: '', args: []);
  }

  /// `Enter a valid email address.`
  String get authErrorEmail {
    return Intl.message(
      'Enter a valid email address.',
      name: 'authErrorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters.`
  String get authErrorPassword {
    return Intl.message(
      'Password must be at least 6 characters.',
      name: 'authErrorPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email and password.`
  String get authErrorRequired {
    return Intl.message(
      'Enter your email and password.',
      name: 'authErrorRequired',
      desc: '',
      args: [],
    );
  }

  /// `Registration coming soon. Please sign in.`
  String get authErrorComingSoon {
    return Intl.message(
      'Registration coming soon. Please sign in.',
      name: 'authErrorComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get authErrorGeneric {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'authErrorGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get authHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'authHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get authNoAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'authNoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Staff Mode`
  String get authStaffMode {
    return Intl.message(
      'Staff Mode',
      name: 'authStaffMode',
      desc: '',
      args: [],
    );
  }

  /// `Available Flights`
  String get availableFlightsTitle {
    return Intl.message(
      'Available Flights',
      name: 'availableFlightsTitle',
      desc: '',
      args: [],
    );
  }

  /// `pax`
  String get availableFlightsPax {
    return Intl.message('pax', name: 'availableFlightsPax', desc: '', args: []);
  }

  /// `No flights available`
  String get availableFlightsEmpty {
    return Intl.message(
      'No flights available',
      name: 'availableFlightsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No flights match your search`
  String get availableFlightsNoResults {
    return Intl.message(
      'No flights match your search',
      name: 'availableFlightsNoResults',
      desc: '',
      args: [],
    );
  }

  /// `Flight Details`
  String get flightDetailsTitle {
    return Intl.message(
      'Flight Details',
      name: 'flightDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Fare Breakdown`
  String get flightDetailsFareBreakdown {
    return Intl.message(
      'Fare Breakdown',
      name: 'flightDetailsFareBreakdown',
      desc: '',
      args: [],
    );
  }

  /// `Base Fare`
  String get flightDetailsBaseFare {
    return Intl.message(
      'Base Fare',
      name: 'flightDetailsBaseFare',
      desc: '',
      args: [],
    );
  }

  /// `Base Fare ({pax} pax × {currency} {price})`
  String flightDetailsBaseFareDetail(int pax, String currency, String price) {
    return Intl.message(
      'Base Fare ($pax pax × $currency $price)',
      name: 'flightDetailsBaseFareDetail',
      desc: '',
      args: [pax, currency, price],
    );
  }

  /// `Taxes & Fees (15%)`
  String get flightDetailsTaxes {
    return Intl.message(
      'Taxes & Fees (15%)',
      name: 'flightDetailsTaxes',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get flightDetailsTotal {
    return Intl.message(
      'Total Price',
      name: 'flightDetailsTotal',
      desc: '',
      args: [],
    );
  }

  /// `Baggage Allowance`
  String get flightDetailsBaggage {
    return Intl.message(
      'Baggage Allowance',
      name: 'flightDetailsBaggage',
      desc: '',
      args: [],
    );
  }

  /// `1 Carry-on`
  String get flightDetailsBaggageCarry {
    return Intl.message(
      '1 Carry-on',
      name: 'flightDetailsBaggageCarry',
      desc: '',
      args: [],
    );
  }

  /// `Checked Bags`
  String get flightDetailsBaggageChecked {
    return Intl.message(
      'Checked Bags',
      name: 'flightDetailsBaggageChecked',
      desc: '',
      args: [],
    );
  }

  /// `Economy: 1 carry-on (7kg) + 1 checked bag (23kg)`
  String get flightDetailsBaggageEconomy {
    return Intl.message(
      'Economy: 1 carry-on (7kg) + 1 checked bag (23kg)',
      name: 'flightDetailsBaggageEconomy',
      desc: '',
      args: [],
    );
  }

  /// `Business: 1 carry-on (10kg) + 2 checked bags (32kg each)`
  String get flightDetailsBaggageBusiness {
    return Intl.message(
      'Business: 1 carry-on (10kg) + 2 checked bags (32kg each)',
      name: 'flightDetailsBaggageBusiness',
      desc: '',
      args: [],
    );
  }

  /// `Cancellation Policy`
  String get flightDetailsCancellation {
    return Intl.message(
      'Cancellation Policy',
      name: 'flightDetailsCancellation',
      desc: '',
      args: [],
    );
  }

  /// `Continue to Passengers`
  String get flightDetailsConfirm {
    return Intl.message(
      'Continue to Passengers',
      name: 'flightDetailsConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Could not create booking. Please try again.`
  String get flightDetailsErrorCreating {
    return Intl.message(
      'Could not create booking. Please try again.',
      name: 'flightDetailsErrorCreating',
      desc: '',
      args: [],
    );
  }

  /// `Passenger Information`
  String get passengersFormTitle {
    return Intl.message(
      'Passenger Information',
      name: 'passengersFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Passenger {number}`
  String passengersFormPassenger(int number) {
    return Intl.message(
      'Passenger $number',
      name: 'passengersFormPassenger',
      desc: '',
      args: [number],
    );
  }

  /// `First Name`
  String get passengersFormFirstName {
    return Intl.message(
      'First Name',
      name: 'passengersFormFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get passengersFormLastName {
    return Intl.message(
      'Last Name',
      name: 'passengersFormLastName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get passengersFormEmail {
    return Intl.message(
      'Email',
      name: 'passengersFormEmail',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get passengersFormPhone {
    return Intl.message(
      'Phone',
      name: 'passengersFormPhone',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get passengersFormDOB {
    return Intl.message(
      'Date of Birth',
      name: 'passengersFormDOB',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get passengersFormGender {
    return Intl.message(
      'Gender',
      name: 'passengersFormGender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get passengersFormMale {
    return Intl.message('Male', name: 'passengersFormMale', desc: '', args: []);
  }

  /// `Female`
  String get passengersFormFemale {
    return Intl.message(
      'Female',
      name: 'passengersFormFemale',
      desc: '',
      args: [],
    );
  }

  /// `Travel Document`
  String get passengersFormDocument {
    return Intl.message(
      'Travel Document',
      name: 'passengersFormDocument',
      desc: '',
      args: [],
    );
  }

  /// `Passport`
  String get passengersFormPassport {
    return Intl.message(
      'Passport',
      name: 'passengersFormPassport',
      desc: '',
      args: [],
    );
  }

  /// `Issued by Country`
  String get passengersFormDocumentIssue {
    return Intl.message(
      'Issued by Country',
      name: 'passengersFormDocumentIssue',
      desc: '',
      args: [],
    );
  }

  /// `Search country…`
  String get passengersFormSearchCountry {
    return Intl.message(
      'Search country…',
      name: 'passengersFormSearchCountry',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get passengersFormExpiry {
    return Intl.message(
      'Expiry Date',
      name: 'passengersFormExpiry',
      desc: '',
      args: [],
    );
  }

  /// `Continue to Services`
  String get passengersFormContinue {
    return Intl.message(
      'Continue to Services',
      name: 'passengersFormContinue',
      desc: '',
      args: [],
    );
  }

  /// `Optional Services`
  String get servicesTitle {
    return Intl.message(
      'Optional Services',
      name: 'servicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enhance Your Journey`
  String get servicesEnhance {
    return Intl.message(
      'Enhance Your Journey',
      name: 'servicesEnhance',
      desc: '',
      args: [],
    );
  }

  /// `Add extra services to make your trip more comfortable`
  String get servicesSubtitle {
    return Intl.message(
      'Add extra services to make your trip more comfortable',
      name: 'servicesSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Services total:`
  String get servicesTotal {
    return Intl.message(
      'Services total:',
      name: 'servicesTotal',
      desc: '',
      args: [],
    );
  }

  /// `JOD`
  String get servicesCurrency {
    return Intl.message('JOD', name: 'servicesCurrency', desc: '', args: []);
  }

  /// `Skip Services`
  String get servicesSkip {
    return Intl.message(
      'Skip Services',
      name: 'servicesSkip',
      desc: '',
      args: [],
    );
  }

  /// `Continue to Seat Selection`
  String get servicesContinue {
    return Intl.message(
      'Continue to Seat Selection',
      name: 'servicesContinue',
      desc: '',
      args: [],
    );
  }

  /// `No services available.`
  String get servicesNoAvailable {
    return Intl.message(
      'No services available.',
      name: 'servicesNoAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Could not load services.`
  String get servicesLoadError {
    return Intl.message(
      'Could not load services.',
      name: 'servicesLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get servicesRetry {
    return Intl.message('Retry', name: 'servicesRetry', desc: '', args: []);
  }

  /// `Could not save services. Please try again.`
  String get servicesErrorSaving {
    return Intl.message(
      'Could not save services. Please try again.',
      name: 'servicesErrorSaving',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Seat`
  String get seatMapTitle {
    return Intl.message(
      'Select Your Seat',
      name: 'seatMapTitle',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get seatMapAvailable {
    return Intl.message(
      'Available',
      name: 'seatMapAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Occupied`
  String get seatMapOccupied {
    return Intl.message(
      'Occupied',
      name: 'seatMapOccupied',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get seatMapSelected {
    return Intl.message(
      'Selected',
      name: 'seatMapSelected',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Seat Selection`
  String get seatMapContinue {
    return Intl.message(
      'Confirm Seat Selection',
      name: 'seatMapContinue',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get paymentTitle {
    return Intl.message('Payment', name: 'paymentTitle', desc: '', args: []);
  }

  /// `Booking Summary`
  String get paymentBookingSummary {
    return Intl.message(
      'Booking Summary',
      name: 'paymentBookingSummary',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get paymentOrderDetails {
    return Intl.message(
      'Order Details',
      name: 'paymentOrderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Flight Details`
  String get paymentFlightDetails {
    return Intl.message(
      'Flight Details',
      name: 'paymentFlightDetails',
      desc: '',
      args: [],
    );
  }

  /// `Passengers`
  String get paymentPassengers {
    return Intl.message(
      'Passengers',
      name: 'paymentPassengers',
      desc: '',
      args: [],
    );
  }

  /// `Base Fare`
  String get paymentBaseFare {
    return Intl.message(
      'Base Fare',
      name: 'paymentBaseFare',
      desc: '',
      args: [],
    );
  }

  /// `Taxes & Fees`
  String get paymentTaxes {
    return Intl.message(
      'Taxes & Fees',
      name: 'paymentTaxes',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get paymentServicesFee {
    return Intl.message(
      'Services',
      name: 'paymentServicesFee',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get paymentTotal {
    return Intl.message('Total', name: 'paymentTotal', desc: '', args: []);
  }

  /// `Grand Total`
  String get paymentGrandTotal {
    return Intl.message(
      'Grand Total',
      name: 'paymentGrandTotal',
      desc: '',
      args: [],
    );
  }

  /// `Secured by Stripe`
  String get paymentStripeInfo {
    return Intl.message(
      'Secured by Stripe',
      name: 'paymentStripeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to Payment`
  String get paymentProceed {
    return Intl.message(
      'Proceed to Payment',
      name: 'paymentProceed',
      desc: '',
      args: [],
    );
  }

  /// `Start Payment`
  String get paymentStart {
    return Intl.message(
      'Start Payment',
      name: 'paymentStart',
      desc: '',
      args: [],
    );
  }

  /// `Ticket ID missing — please restart booking.`
  String get paymentErrorTicketId {
    return Intl.message(
      'Ticket ID missing — please restart booking.',
      name: 'paymentErrorTicketId',
      desc: '',
      args: [],
    );
  }

  /// `Could not create payment session. Please try again.`
  String get paymentErrorSession {
    return Intl.message(
      'Could not create payment session. Please try again.',
      name: 'paymentErrorSession',
      desc: '',
      args: [],
    );
  }

  /// `Could not open payment page.`
  String get paymentErrorOpen {
    return Intl.message(
      'Could not open payment page.',
      name: 'paymentErrorOpen',
      desc: '',
      args: [],
    );
  }

  /// `JOD`
  String get paymentCurrency {
    return Intl.message('JOD', name: 'paymentCurrency', desc: '', args: []);
  }

  /// `Booking Confirmed!`
  String get paymentSuccessTitle {
    return Intl.message(
      'Booking Confirmed!',
      name: 'paymentSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your payment was successful and your booking is confirmed. View your ticket in the Tickets tab.`
  String get paymentSuccessMessage {
    return Intl.message(
      'Your payment was successful and your booking is confirmed. View your ticket in the Tickets tab.',
      name: 'paymentSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Go Home`
  String get paymentSuccessGoHome {
    return Intl.message(
      'Go Home',
      name: 'paymentSuccessGoHome',
      desc: '',
      args: [],
    );
  }

  /// `View Tickets`
  String get paymentSuccessViewTickets {
    return Intl.message(
      'View Tickets',
      name: 'paymentSuccessViewTickets',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get ticketsUpcoming {
    return Intl.message(
      'Upcoming',
      name: 'ticketsUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `Past`
  String get ticketsPast {
    return Intl.message('Past', name: 'ticketsPast', desc: '', args: []);
  }

  /// `No upcoming flights`
  String get ticketsNoUpcoming {
    return Intl.message(
      'No upcoming flights',
      name: 'ticketsNoUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `No past flights`
  String get ticketsNoPast {
    return Intl.message(
      'No past flights',
      name: 'ticketsNoPast',
      desc: '',
      args: [],
    );
  }

  /// `{count} {type} Flight{plural}`
  String ticketsCount(int count, String type, String plural) {
    return Intl.message(
      '$count $type Flight$plural',
      name: 'ticketsCount',
      desc: '',
      args: [count, type, plural],
    );
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message('Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `Personal Information`
  String get profilePersonalInfo {
    return Intl.message(
      'Personal Information',
      name: 'profilePersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get profileFullName {
    return Intl.message(
      'Full Name',
      name: 'profileFullName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get profileEmail {
    return Intl.message('Email', name: 'profileEmail', desc: '', args: []);
  }

  /// `Phone`
  String get profilePhone {
    return Intl.message('Phone', name: 'profilePhone', desc: '', args: []);
  }

  /// `Nationality`
  String get profileNationality {
    return Intl.message(
      'Nationality',
      name: 'profileNationality',
      desc: '',
      args: [],
    );
  }

  /// `Travel Documents`
  String get profileTravelDocs {
    return Intl.message(
      'Travel Documents',
      name: 'profileTravelDocs',
      desc: '',
      args: [],
    );
  }

  /// `Passport Number`
  String get profilePassport {
    return Intl.message(
      'Passport Number',
      name: 'profilePassport',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Class`
  String get profilePreferredClass {
    return Intl.message(
      'Preferred Class',
      name: 'profilePreferredClass',
      desc: '',
      args: [],
    );
  }

  /// `Frequent Flyer`
  String get profileLoyalty {
    return Intl.message(
      'Frequent Flyer',
      name: 'profileLoyalty',
      desc: '',
      args: [],
    );
  }

  /// `Travel Stats`
  String get profileStats {
    return Intl.message(
      'Travel Stats',
      name: 'profileStats',
      desc: '',
      args: [],
    );
  }

  /// `Flights`
  String get profileFlights {
    return Intl.message('Flights', name: 'profileFlights', desc: '', args: []);
  }

  /// `Miles`
  String get profileMiles {
    return Intl.message('Miles', name: 'profileMiles', desc: '', args: []);
  }

  /// `Tier`
  String get profileTier {
    return Intl.message('Tier', name: 'profileTier', desc: '', args: []);
  }

  /// `Photo upload: Coming in Phase 6`
  String get profilePhotoUpload {
    return Intl.message(
      'Photo upload: Coming in Phase 6',
      name: 'profilePhotoUpload',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message('Settings', name: 'settingsTitle', desc: '', args: []);
  }

  /// `Notifications`
  String get settingsNotifications {
    return Intl.message(
      'Notifications',
      name: 'settingsNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Flight Updates`
  String get settingsFlightUpdates {
    return Intl.message(
      'Flight Updates',
      name: 'settingsFlightUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Gate changes, delays & cancellations`
  String get settingsFlightUpdatesDesc {
    return Intl.message(
      'Gate changes, delays & cancellations',
      name: 'settingsFlightUpdatesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Price Alerts`
  String get settingsPriceAlerts {
    return Intl.message(
      'Price Alerts',
      name: 'settingsPriceAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Get notified when prices drop`
  String get settingsPriceAlertsDesc {
    return Intl.message(
      'Get notified when prices drop',
      name: 'settingsPriceAlertsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Booking Reminders`
  String get settingsBookingReminders {
    return Intl.message(
      'Booking Reminders',
      name: 'settingsBookingReminders',
      desc: '',
      args: [],
    );
  }

  /// `24h before departure`
  String get settingsBookingRemindersDesc {
    return Intl.message(
      '24h before departure',
      name: 'settingsBookingRemindersDesc',
      desc: '',
      args: [],
    );
  }

  /// `Promotions & Offers`
  String get settingsPromotions {
    return Intl.message(
      'Promotions & Offers',
      name: 'settingsPromotions',
      desc: '',
      args: [],
    );
  }

  /// `Deals, discounts and seasonal offers`
  String get settingsPromotionsDesc {
    return Intl.message(
      'Deals, discounts and seasonal offers',
      name: 'settingsPromotionsDesc',
      desc: '',
      args: [],
    );
  }

  /// `SMS Alerts`
  String get settingsSmsAlerts {
    return Intl.message(
      'SMS Alerts',
      name: 'settingsSmsAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Receive alerts via text message`
  String get settingsSmsAlertsDesc {
    return Intl.message(
      'Receive alerts via text message',
      name: 'settingsSmsAlertsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Display & Language`
  String get settingsDisplay {
    return Intl.message(
      'Display & Language',
      name: 'settingsDisplay',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsLanguage {
    return Intl.message(
      'Language',
      name: 'settingsLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get settingsCurrency {
    return Intl.message(
      'Currency',
      name: 'settingsCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get settingsDarkMode {
    return Intl.message(
      'Dark Mode',
      name: 'settingsDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Switch to dark theme`
  String get settingsDarkModeDesc {
    return Intl.message(
      'Switch to dark theme',
      name: 'settingsDarkModeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Privacy & Security`
  String get settingsPrivacy {
    return Intl.message(
      'Privacy & Security',
      name: 'settingsPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get settingsChangePassword {
    return Intl.message(
      'Change Password',
      name: 'settingsChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Biometric Login`
  String get settingsBiometric {
    return Intl.message(
      'Biometric Login',
      name: 'settingsBiometric',
      desc: '',
      args: [],
    );
  }

  /// `Use fingerprint or Face ID`
  String get settingsBiometricDesc {
    return Intl.message(
      'Use fingerprint or Face ID',
      name: 'settingsBiometricDesc',
      desc: '',
      args: [],
    );
  }

  /// `Share Usage Data`
  String get settingsShareData {
    return Intl.message(
      'Share Usage Data',
      name: 'settingsShareData',
      desc: '',
      args: [],
    );
  }

  /// `Help us improve the app`
  String get settingsShareDataDesc {
    return Intl.message(
      'Help us improve the app',
      name: 'settingsShareDataDesc',
      desc: '',
      args: [],
    );
  }

  /// `Location Services`
  String get settingsLocation {
    return Intl.message(
      'Location Services',
      name: 'settingsLocation',
      desc: '',
      args: [],
    );
  }

  /// `Used for nearby airports`
  String get settingsLocationDesc {
    return Intl.message(
      'Used for nearby airports',
      name: 'settingsLocationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get settingsAccount {
    return Intl.message('Account', name: 'settingsAccount', desc: '', args: []);
  }

  /// `Delete Account`
  String get settingsDeleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'settingsDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Permanently remove your data`
  String get settingsDeleteAccountDesc {
    return Intl.message(
      'Permanently remove your data',
      name: 'settingsDeleteAccountDesc',
      desc: '',
      args: [],
    );
  }

  /// `App Version`
  String get settingsAppVersion {
    return Intl.message(
      'App Version',
      name: 'settingsAppVersion',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get settingsLogout {
    return Intl.message('Log Out', name: 'settingsLogout', desc: '', args: []);
  }

  /// `Coming in Phase 6`
  String get settingsComingSoon {
    return Intl.message(
      'Coming in Phase 6',
      name: 'settingsComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get settingsSelectLanguage {
    return Intl.message(
      'Select Language',
      name: 'settingsSelectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select Currency`
  String get settingsSelectCurrency {
    return Intl.message(
      'Select Currency',
      name: 'settingsSelectCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Book a Hotel`
  String get hotelTitle {
    return Intl.message('Book a Hotel', name: 'hotelTitle', desc: '', args: []);
  }

  /// `Search Hotels`
  String get hotelSearch {
    return Intl.message(
      'Search Hotels',
      name: 'hotelSearch',
      desc: '',
      args: [],
    );
  }

  /// `Where to?`
  String get hotelWhere {
    return Intl.message('Where to?', name: 'hotelWhere', desc: '', args: []);
  }

  /// `Destination city or hotel name`
  String get hotelDestination {
    return Intl.message(
      'Destination city or hotel name',
      name: 'hotelDestination',
      desc: '',
      args: [],
    );
  }

  /// `Check-in`
  String get hotelCheckIn {
    return Intl.message('Check-in', name: 'hotelCheckIn', desc: '', args: []);
  }

  /// `Check-out`
  String get hotelCheckOut {
    return Intl.message('Check-out', name: 'hotelCheckOut', desc: '', args: []);
  }

  /// `Rooms`
  String get hotelRooms {
    return Intl.message('Rooms', name: 'hotelRooms', desc: '', args: []);
  }

  /// `Guests`
  String get hotelGuests {
    return Intl.message('Guests', name: 'hotelGuests', desc: '', args: []);
  }

  /// `Find your perfect stay`
  String get hotelEmptyMessage {
    return Intl.message(
      'Find your perfect stay',
      name: 'hotelEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Enter a destination to search hotels`
  String get hotelEmptySubtitle {
    return Intl.message(
      'Enter a destination to search hotels',
      name: 'hotelEmptySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `{count} hotels in {destination}`
  String hotelHotelsIn(int count, String destination) {
    return Intl.message(
      '$count hotels in $destination',
      name: 'hotelHotelsIn',
      desc: '',
      args: [count, destination],
    );
  }

  /// `{count} night{plural}`
  String hotelNights(int count, String plural) {
    return Intl.message(
      '$count night$plural',
      name: 'hotelNights',
      desc: '',
      args: [count, plural],
    );
  }

  /// `Please enter a destination`
  String get hotelErrorDestination {
    return Intl.message(
      'Please enter a destination',
      name: 'hotelErrorDestination',
      desc: '',
      args: [],
    );
  }

  /// `Van Rental`
  String get vanTitle {
    return Intl.message('Van Rental', name: 'vanTitle', desc: '', args: []);
  }

  /// `Find Vehicles`
  String get vanFind {
    return Intl.message('Find Vehicles', name: 'vanFind', desc: '', args: []);
  }

  /// `Pick-up`
  String get vanPickupLocation {
    return Intl.message(
      'Pick-up',
      name: 'vanPickupLocation',
      desc: '',
      args: [],
    );
  }

  /// `Drop-off`
  String get vanDropLocation {
    return Intl.message(
      'Drop-off',
      name: 'vanDropLocation',
      desc: '',
      args: [],
    );
  }

  /// `Pick-up Date`
  String get vanPickupDate {
    return Intl.message(
      'Pick-up Date',
      name: 'vanPickupDate',
      desc: '',
      args: [],
    );
  }

  /// `Return Date`
  String get vanReturnDate {
    return Intl.message(
      'Return Date',
      name: 'vanReturnDate',
      desc: '',
      args: [],
    );
  }

  /// `Find the perfect ride`
  String get vanEmptyMessage {
    return Intl.message(
      'Find the perfect ride',
      name: 'vanEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Select locations to browse available vehicles`
  String get vanEmptySubtitle {
    return Intl.message(
      'Select locations to browse available vehicles',
      name: 'vanEmptySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `{count} vehicle{plural} available`
  String vanVehiclesAvailable(int count, String plural) {
    return Intl.message(
      '$count vehicle$plural available',
      name: 'vanVehiclesAvailable',
      desc: '',
      args: [count, plural],
    );
  }

  /// `No vehicles in this category`
  String get vanNoVehicles {
    return Intl.message(
      'No vehicles in this category',
      name: 'vanNoVehicles',
      desc: '',
      args: [],
    );
  }

  /// `Please select a pick-up location`
  String get vanErrorPickup {
    return Intl.message(
      'Please select a pick-up location',
      name: 'vanErrorPickup',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUsTitle {
    return Intl.message(
      'Contact Us',
      name: 'contactUsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get In Touch`
  String get contactGetInTouch {
    return Intl.message(
      'Get In Touch',
      name: 'contactGetInTouch',
      desc: '',
      args: [],
    );
  }

  /// `Call Us`
  String get contactCall {
    return Intl.message('Call Us', name: 'contactCall', desc: '', args: []);
  }

  /// `+962 6 510 0000`
  String get contactCallNumber {
    return Intl.message(
      '+962 6 510 0000',
      name: 'contactCallNumber',
      desc: '',
      args: [],
    );
  }

  /// `Email Us`
  String get contactEmail {
    return Intl.message('Email Us', name: 'contactEmail', desc: '', args: []);
  }

  /// `support@skytrip.com`
  String get contactEmailAddress {
    return Intl.message(
      'support@skytrip.com',
      name: 'contactEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Live Chat`
  String get contactChat {
    return Intl.message('Live Chat', name: 'contactChat', desc: '', args: []);
  }

  /// `Available 24/7`
  String get contactChatAvailable {
    return Intl.message(
      'Available 24/7',
      name: 'contactChatAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Send a Message`
  String get contactSendMessage {
    return Intl.message(
      'Send a Message',
      name: 'contactSendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get contactSubject {
    return Intl.message('Subject', name: 'contactSubject', desc: '', args: []);
  }

  /// `Message`
  String get contactMessage {
    return Intl.message('Message', name: 'contactMessage', desc: '', args: []);
  }

  /// `Send Message`
  String get contactSend {
    return Intl.message(
      'Send Message',
      name: 'contactSend',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get contactFaq {
    return Intl.message('FAQ', name: 'contactFaq', desc: '', args: []);
  }

  /// `Opening {type}…`
  String contactOpening(String type) {
    return Intl.message(
      'Opening $type…',
      name: 'contactOpening',
      desc: '',
      args: [type],
    );
  }

  /// `Message sent! We'll respond within 24 hours.`
  String get contactSuccess {
    return Intl.message(
      'Message sent! We\'ll respond within 24 hours.',
      name: 'contactSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Live chat: Coming in Phase 6`
  String get contactComing {
    return Intl.message(
      'Live chat: Coming in Phase 6',
      name: 'contactComing',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get dialogCancel {
    return Intl.message('Cancel', name: 'dialogCancel', desc: '', args: []);
  }

  /// `OK`
  String get dialogOk {
    return Intl.message('OK', name: 'dialogOk', desc: '', args: []);
  }

  /// `Confirm`
  String get dialogConfirm {
    return Intl.message('Confirm', name: 'dialogConfirm', desc: '', args: []);
  }

  /// `Cancel Booking?`
  String get dialogCannotCancel {
    return Intl.message(
      'Cancel Booking?',
      name: 'dialogCannotCancel',
      desc: '',
      args: [],
    );
  }

  /// `You have a booking in progress. Leaving now will lose all your selections.`
  String get dialogCancelBookingDesc {
    return Intl.message(
      'You have a booking in progress. Leaving now will lose all your selections.',
      name: 'dialogCancelBookingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Keep Going`
  String get dialogKeepGoing {
    return Intl.message(
      'Keep Going',
      name: 'dialogKeepGoing',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get dialogLogout {
    return Intl.message('Log Out', name: 'dialogLogout', desc: '', args: []);
  }

  /// `Are you sure you want to log out?`
  String get dialogLogoutConfirm {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'dialogLogoutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get dialogDeleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'dialogDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Permanently remove all your data? This action cannot be undone.`
  String get dialogDeleteAccountConfirm {
    return Intl.message(
      'Permanently remove all your data? This action cannot be undone.',
      name: 'dialogDeleteAccountConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Book a Hotel`
  String get drawerHotel {
    return Intl.message(
      'Book a Hotel',
      name: 'drawerHotel',
      desc: '',
      args: [],
    );
  }

  /// `Van Rental`
  String get drawerVanRental {
    return Intl.message(
      'Van Rental',
      name: 'drawerVanRental',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get drawerSettings {
    return Intl.message('Settings', name: 'drawerSettings', desc: '', args: []);
  }

  /// `Contact Us`
  String get drawerContactUs {
    return Intl.message(
      'Contact Us',
      name: 'drawerContactUs',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get drawerAbout {
    return Intl.message('About', name: 'drawerAbout', desc: '', args: []);
  }

  /// `Welcome`
  String get drawerWelcome {
    return Intl.message('Welcome', name: 'drawerWelcome', desc: '', args: []);
  }

  /// `Welcome, {name}`
  String drawerWelcomeName(String name) {
    return Intl.message(
      'Welcome, $name',
      name: 'drawerWelcomeName',
      desc: '',
      args: [name],
    );
  }

  /// `Log Out`
  String get drawerLogout {
    return Intl.message('Log Out', name: 'drawerLogout', desc: '', args: []);
  }

  /// `Booking`
  String get drawerBooking {
    return Intl.message('Booking', name: 'drawerBooking', desc: '', args: []);
  }

  String? get paymentContinue => null;

  String? get dialogDone => null;

  String? get vanRentalConfirmed => null;
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
