import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Sky Trip'**
  String get appTitle;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'SkyTrip v1.0.0'**
  String get appVersion;

  /// Personalized greeting on home screen
  ///
  /// In en, this message translates to:
  /// **'{greeting}, {firstName}'**
  String homeGreeting(String greeting, String firstName);

  /// No description provided for @homeReady.
  ///
  /// In en, this message translates to:
  /// **'Ready for your next adventure?'**
  String get homeReady;

  /// No description provided for @homeRecentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get homeRecentSearches;

  /// No description provided for @homeLatestOffers.
  ///
  /// In en, this message translates to:
  /// **'Latest Offers'**
  String get homeLatestOffers;

  /// No description provided for @homeFeaturedDestinations.
  ///
  /// In en, this message translates to:
  /// **'Featured Destinations'**
  String get homeFeaturedDestinations;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get homeSeeAll;

  /// No description provided for @bookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Book a Flight'**
  String get bookingTitle;

  /// No description provided for @bookingTripRoundtrip.
  ///
  /// In en, this message translates to:
  /// **'Roundtrip'**
  String get bookingTripRoundtrip;

  /// No description provided for @bookingTripOneWay.
  ///
  /// In en, this message translates to:
  /// **'One Way'**
  String get bookingTripOneWay;

  /// No description provided for @bookingTripMultiCity.
  ///
  /// In en, this message translates to:
  /// **'Multi-City'**
  String get bookingTripMultiCity;

  /// No description provided for @bookingFromLabel.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get bookingFromLabel;

  /// No description provided for @bookingToLabel.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get bookingToLabel;

  /// No description provided for @bookingSearchCity.
  ///
  /// In en, this message translates to:
  /// **'Search city…'**
  String get bookingSearchCity;

  /// No description provided for @bookingDepartureDate.
  ///
  /// In en, this message translates to:
  /// **'Departure'**
  String get bookingDepartureDate;

  /// No description provided for @bookingReturnDate.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get bookingReturnDate;

  /// No description provided for @bookingAdults.
  ///
  /// In en, this message translates to:
  /// **'Adults'**
  String get bookingAdults;

  /// No description provided for @bookingYouth.
  ///
  /// In en, this message translates to:
  /// **'Youth'**
  String get bookingYouth;

  /// No description provided for @bookingChildren.
  ///
  /// In en, this message translates to:
  /// **'Children'**
  String get bookingChildren;

  /// No description provided for @bookingInfants.
  ///
  /// In en, this message translates to:
  /// **'Infants'**
  String get bookingInfants;

  /// No description provided for @bookingClass.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get bookingClass;

  /// No description provided for @bookingPassengers.
  ///
  /// In en, this message translates to:
  /// **'Passengers'**
  String get bookingPassengers;

  /// No description provided for @bookingSearch.
  ///
  /// In en, this message translates to:
  /// **'Search Flights'**
  String get bookingSearch;

  /// No description provided for @bookingNoFlightsFound.
  ///
  /// In en, this message translates to:
  /// **'No flights found'**
  String get bookingNoFlightsFound;

  /// No description provided for @bookingTryAnother.
  ///
  /// In en, this message translates to:
  /// **'Try another search'**
  String get bookingTryAnother;

  /// No description provided for @bookingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Where would you like to go today?'**
  String get bookingSubtitle;

  /// No description provided for @bookingDepartureCityHint.
  ///
  /// In en, this message translates to:
  /// **'Departure city'**
  String get bookingDepartureCityHint;

  /// No description provided for @bookingArrivalCityHint.
  ///
  /// In en, this message translates to:
  /// **'Arrival city'**
  String get bookingArrivalCityHint;

  /// No description provided for @bookingSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get bookingSelectDate;

  /// No description provided for @bookingSelectReturnDate.
  ///
  /// In en, this message translates to:
  /// **'Select return date'**
  String get bookingSelectReturnDate;

  /// No description provided for @bookingSelectClass.
  ///
  /// In en, this message translates to:
  /// **'Select Class'**
  String get bookingSelectClass;

  /// No description provided for @bookingErrorSelectCities.
  ///
  /// In en, this message translates to:
  /// **'Please select departure and arrival cities.'**
  String get bookingErrorSelectCities;

  /// No description provided for @bookingErrorDifferentCities.
  ///
  /// In en, this message translates to:
  /// **'Departure and arrival cities must be different.'**
  String get bookingErrorDifferentCities;

  /// No description provided for @bookingErrorSelectDeparture.
  ///
  /// In en, this message translates to:
  /// **'Please select a departure date.'**
  String get bookingErrorSelectDeparture;

  /// No description provided for @bookingErrorSelectReturn.
  ///
  /// In en, this message translates to:
  /// **'Please select a return date.'**
  String get bookingErrorSelectReturn;

  /// No description provided for @bookingErrorSearchFailed.
  ///
  /// In en, this message translates to:
  /// **'Search failed. Please try again.'**
  String get bookingErrorSearchFailed;

  /// No description provided for @bookingPassengersCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 Passenger} other{{count} Passengers}}'**
  String bookingPassengersCount(int count);

  /// No description provided for @bookingAdultSubtext.
  ///
  /// In en, this message translates to:
  /// **'12+ years'**
  String get bookingAdultSubtext;

  /// No description provided for @bookingYouthSubtext.
  ///
  /// In en, this message translates to:
  /// **'2–11 years'**
  String get bookingYouthSubtext;

  /// No description provided for @bookingChildrenSubtext.
  ///
  /// In en, this message translates to:
  /// **'Under 2'**
  String get bookingChildrenSubtext;

  /// No description provided for @bookingInfantsSubtext.
  ///
  /// In en, this message translates to:
  /// **'Lap infant'**
  String get bookingInfantsSubtext;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get greetingEvening;

  /// No description provided for @dialogRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get dialogRetry;

  /// No description provided for @authSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authSignIn;

  /// No description provided for @authSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get authSignUp;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get authConfirmPassword;

  /// No description provided for @authFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get authFirstName;

  /// No description provided for @authLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get authLastName;

  /// No description provided for @authStaffId.
  ///
  /// In en, this message translates to:
  /// **'Staff ID'**
  String get authStaffId;

  /// No description provided for @authErrorEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get authErrorEmail;

  /// No description provided for @authErrorPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get authErrorPassword;

  /// No description provided for @authErrorRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and password.'**
  String get authErrorRequired;

  /// No description provided for @authErrorComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Registration coming soon. Please sign in.'**
  String get authErrorComingSoon;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authErrorGeneric;

  /// No description provided for @authHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authHaveAccount;

  /// No description provided for @authNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get authNoAccount;

  /// No description provided for @authStaffMode.
  ///
  /// In en, this message translates to:
  /// **'Staff Mode'**
  String get authStaffMode;

  /// No description provided for @availableFlightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Available Flights'**
  String get availableFlightsTitle;

  /// No description provided for @availableFlightsPax.
  ///
  /// In en, this message translates to:
  /// **'pax'**
  String get availableFlightsPax;

  /// No description provided for @availableFlightsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No flights available'**
  String get availableFlightsEmpty;

  /// No description provided for @availableFlightsNoResults.
  ///
  /// In en, this message translates to:
  /// **'No flights match your search'**
  String get availableFlightsNoResults;

  /// No description provided for @flightDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Flight Details'**
  String get flightDetailsTitle;

  /// No description provided for @flightDetailsFareBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Fare Breakdown'**
  String get flightDetailsFareBreakdown;

  /// No description provided for @flightDetailsBaseFare.
  ///
  /// In en, this message translates to:
  /// **'Base Fare'**
  String get flightDetailsBaseFare;

  /// No description provided for @flightDetailsBaseFareDetail.
  ///
  /// In en, this message translates to:
  /// **'Base Fare ({pax} pax × {currency} {price})'**
  String flightDetailsBaseFareDetail(int pax, String currency, String price);

  /// No description provided for @flightDetailsTaxes.
  ///
  /// In en, this message translates to:
  /// **'Taxes & Fees (15%)'**
  String get flightDetailsTaxes;

  /// No description provided for @flightDetailsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get flightDetailsTotal;

  /// No description provided for @flightDetailsBaggage.
  ///
  /// In en, this message translates to:
  /// **'Baggage Allowance'**
  String get flightDetailsBaggage;

  /// No description provided for @flightDetailsBaggageCarry.
  ///
  /// In en, this message translates to:
  /// **'1 Carry-on'**
  String get flightDetailsBaggageCarry;

  /// No description provided for @flightDetailsBaggageChecked.
  ///
  /// In en, this message translates to:
  /// **'Checked Bags'**
  String get flightDetailsBaggageChecked;

  /// No description provided for @flightDetailsBaggageEconomy.
  ///
  /// In en, this message translates to:
  /// **'Economy: 1 carry-on (7kg) + 1 checked bag (23kg)'**
  String get flightDetailsBaggageEconomy;

  /// No description provided for @flightDetailsBaggageBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business: 1 carry-on (10kg) + 2 checked bags (32kg each)'**
  String get flightDetailsBaggageBusiness;

  /// No description provided for @flightDetailsCancellation.
  ///
  /// In en, this message translates to:
  /// **'Cancellation Policy'**
  String get flightDetailsCancellation;

  /// No description provided for @flightDetailsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Continue to Passengers'**
  String get flightDetailsConfirm;

  /// No description provided for @flightDetailsErrorCreating.
  ///
  /// In en, this message translates to:
  /// **'Could not create booking. Please try again.'**
  String get flightDetailsErrorCreating;

  /// No description provided for @passengersFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Passenger Information'**
  String get passengersFormTitle;

  /// No description provided for @passengersFormPassenger.
  ///
  /// In en, this message translates to:
  /// **'Passenger {number}'**
  String passengersFormPassenger(int number);

  /// No description provided for @passengersFormFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get passengersFormFirstName;

  /// No description provided for @passengersFormLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get passengersFormLastName;

  /// No description provided for @passengersFormEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get passengersFormEmail;

  /// No description provided for @passengersFormPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get passengersFormPhone;

  /// No description provided for @passengersFormDOB.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get passengersFormDOB;

  /// No description provided for @passengersFormGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get passengersFormGender;

  /// No description provided for @passengersFormMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get passengersFormMale;

  /// No description provided for @passengersFormFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get passengersFormFemale;

  /// No description provided for @passengersFormDocument.
  ///
  /// In en, this message translates to:
  /// **'Travel Document'**
  String get passengersFormDocument;

  /// No description provided for @passengersFormPassport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passengersFormPassport;

  /// No description provided for @passengersFormDocumentIssue.
  ///
  /// In en, this message translates to:
  /// **'Issued by Country'**
  String get passengersFormDocumentIssue;

  /// No description provided for @passengersFormSearchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search country…'**
  String get passengersFormSearchCountry;

  /// No description provided for @passengersFormExpiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get passengersFormExpiry;

  /// No description provided for @passengersFormContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue to Services'**
  String get passengersFormContinue;

  /// No description provided for @servicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Optional Services'**
  String get servicesTitle;

  /// No description provided for @servicesEnhance.
  ///
  /// In en, this message translates to:
  /// **'Enhance Your Journey'**
  String get servicesEnhance;

  /// No description provided for @servicesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add extra services to make your trip more comfortable'**
  String get servicesSubtitle;

  /// No description provided for @servicesTotal.
  ///
  /// In en, this message translates to:
  /// **'Services total:'**
  String get servicesTotal;

  /// No description provided for @servicesCurrency.
  ///
  /// In en, this message translates to:
  /// **'JOD'**
  String get servicesCurrency;

  /// No description provided for @servicesSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip Services'**
  String get servicesSkip;

  /// No description provided for @servicesContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue to Seat Selection'**
  String get servicesContinue;

  /// No description provided for @servicesNoAvailable.
  ///
  /// In en, this message translates to:
  /// **'No services available.'**
  String get servicesNoAvailable;

  /// No description provided for @servicesLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load services.'**
  String get servicesLoadError;

  /// No description provided for @servicesRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get servicesRetry;

  /// No description provided for @servicesErrorSaving.
  ///
  /// In en, this message translates to:
  /// **'Could not save services. Please try again.'**
  String get servicesErrorSaving;

  /// No description provided for @seatMapTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Your Seat'**
  String get seatMapTitle;

  /// No description provided for @seatMapAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get seatMapAvailable;

  /// No description provided for @seatMapOccupied.
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get seatMapOccupied;

  /// No description provided for @seatMapSelected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get seatMapSelected;

  /// No description provided for @seatMapContinue.
  ///
  /// In en, this message translates to:
  /// **'Confirm Seat Selection'**
  String get seatMapContinue;

  /// No description provided for @paymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get paymentTitle;

  /// No description provided for @paymentBookingSummary.
  ///
  /// In en, this message translates to:
  /// **'Booking Summary'**
  String get paymentBookingSummary;

  /// No description provided for @paymentOrderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get paymentOrderDetails;

  /// No description provided for @paymentFlightDetails.
  ///
  /// In en, this message translates to:
  /// **'Flight Details'**
  String get paymentFlightDetails;

  /// No description provided for @paymentPassengers.
  ///
  /// In en, this message translates to:
  /// **'Passengers'**
  String get paymentPassengers;

  /// No description provided for @paymentBaseFare.
  ///
  /// In en, this message translates to:
  /// **'Base Fare'**
  String get paymentBaseFare;

  /// No description provided for @paymentTaxes.
  ///
  /// In en, this message translates to:
  /// **'Taxes & Fees'**
  String get paymentTaxes;

  /// No description provided for @paymentServicesFee.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get paymentServicesFee;

  /// No description provided for @paymentTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get paymentTotal;

  /// No description provided for @paymentGrandTotal.
  ///
  /// In en, this message translates to:
  /// **'Grand Total'**
  String get paymentGrandTotal;

  /// No description provided for @paymentStripeInfo.
  ///
  /// In en, this message translates to:
  /// **'Secured by Stripe'**
  String get paymentStripeInfo;

  /// No description provided for @paymentProceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Payment'**
  String get paymentProceed;

  /// No description provided for @paymentStart.
  ///
  /// In en, this message translates to:
  /// **'Start Payment'**
  String get paymentStart;

  /// No description provided for @paymentErrorTicketId.
  ///
  /// In en, this message translates to:
  /// **'Ticket ID missing — please restart booking.'**
  String get paymentErrorTicketId;

  /// No description provided for @paymentErrorSession.
  ///
  /// In en, this message translates to:
  /// **'Could not create payment session. Please try again.'**
  String get paymentErrorSession;

  /// No description provided for @paymentErrorOpen.
  ///
  /// In en, this message translates to:
  /// **'Could not open payment page.'**
  String get paymentErrorOpen;

  /// No description provided for @paymentCurrency.
  ///
  /// In en, this message translates to:
  /// **'JOD'**
  String get paymentCurrency;

  /// No description provided for @paymentSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed!'**
  String get paymentSuccessTitle;

  /// No description provided for @paymentSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your payment was successful and your booking is confirmed. View your ticket in the Tickets tab.'**
  String get paymentSuccessMessage;

  /// No description provided for @paymentSuccessGoHome.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get paymentSuccessGoHome;

  /// No description provided for @paymentSuccessViewTickets.
  ///
  /// In en, this message translates to:
  /// **'View Tickets'**
  String get paymentSuccessViewTickets;

  /// No description provided for @ticketsUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get ticketsUpcoming;

  /// No description provided for @ticketsPast.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get ticketsPast;

  /// No description provided for @ticketsNoUpcoming.
  ///
  /// In en, this message translates to:
  /// **'No upcoming flights'**
  String get ticketsNoUpcoming;

  /// No description provided for @ticketsNoPast.
  ///
  /// In en, this message translates to:
  /// **'No past flights'**
  String get ticketsNoPast;

  /// No description provided for @ticketsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} {type}} other{{count} {type}s}}'**
  String ticketsCount(int count, String type);

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profilePersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get profilePersonalInfo;

  /// No description provided for @profileFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get profileFullName;

  /// No description provided for @profileEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileEmail;

  /// No description provided for @profilePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get profilePhone;

  /// No description provided for @profileNationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get profileNationality;

  /// No description provided for @profileTravelDocs.
  ///
  /// In en, this message translates to:
  /// **'Travel Documents'**
  String get profileTravelDocs;

  /// No description provided for @profilePassport.
  ///
  /// In en, this message translates to:
  /// **'Passport Number'**
  String get profilePassport;

  /// No description provided for @profilePreferredClass.
  ///
  /// In en, this message translates to:
  /// **'Preferred Class'**
  String get profilePreferredClass;

  /// No description provided for @profileLoyalty.
  ///
  /// In en, this message translates to:
  /// **'Frequent Flyer'**
  String get profileLoyalty;

  /// No description provided for @profileStats.
  ///
  /// In en, this message translates to:
  /// **'Travel Stats'**
  String get profileStats;

  /// No description provided for @profileFlights.
  ///
  /// In en, this message translates to:
  /// **'Flights'**
  String get profileFlights;

  /// No description provided for @profileMiles.
  ///
  /// In en, this message translates to:
  /// **'Miles'**
  String get profileMiles;

  /// No description provided for @profileTier.
  ///
  /// In en, this message translates to:
  /// **'Tier'**
  String get profileTier;

  /// No description provided for @profilePhotoUpload.
  ///
  /// In en, this message translates to:
  /// **'Photo upload: Coming in Phase 6'**
  String get profilePhotoUpload;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsFlightUpdates.
  ///
  /// In en, this message translates to:
  /// **'Flight Updates'**
  String get settingsFlightUpdates;

  /// No description provided for @settingsFlightUpdatesDesc.
  ///
  /// In en, this message translates to:
  /// **'Gate changes, delays & cancellations'**
  String get settingsFlightUpdatesDesc;

  /// No description provided for @settingsPriceAlerts.
  ///
  /// In en, this message translates to:
  /// **'Price Alerts'**
  String get settingsPriceAlerts;

  /// No description provided for @settingsPriceAlertsDesc.
  ///
  /// In en, this message translates to:
  /// **'Get notified when prices drop'**
  String get settingsPriceAlertsDesc;

  /// No description provided for @settingsBookingReminders.
  ///
  /// In en, this message translates to:
  /// **'Booking Reminders'**
  String get settingsBookingReminders;

  /// No description provided for @settingsBookingRemindersDesc.
  ///
  /// In en, this message translates to:
  /// **'24h before departure'**
  String get settingsBookingRemindersDesc;

  /// No description provided for @settingsPromotions.
  ///
  /// In en, this message translates to:
  /// **'Promotions & Offers'**
  String get settingsPromotions;

  /// No description provided for @settingsPromotionsDesc.
  ///
  /// In en, this message translates to:
  /// **'Deals, discounts and seasonal offers'**
  String get settingsPromotionsDesc;

  /// No description provided for @settingsSmsAlerts.
  ///
  /// In en, this message translates to:
  /// **'SMS Alerts'**
  String get settingsSmsAlerts;

  /// No description provided for @settingsSmsAlertsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive alerts via text message'**
  String get settingsSmsAlertsDesc;

  /// No description provided for @settingsDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display & Language'**
  String get settingsDisplay;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get settingsCurrency;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsDarkModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Switch to dark theme'**
  String get settingsDarkModeDesc;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get settingsPrivacy;

  /// No description provided for @settingsChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get settingsChangePassword;

  /// No description provided for @settingsBiometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric Login'**
  String get settingsBiometric;

  /// No description provided for @settingsBiometricDesc.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint or Face ID'**
  String get settingsBiometricDesc;

  /// No description provided for @settingsShareData.
  ///
  /// In en, this message translates to:
  /// **'Share Usage Data'**
  String get settingsShareData;

  /// No description provided for @settingsShareDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Help us improve the app'**
  String get settingsShareDataDesc;

  /// No description provided for @ticketsHotels.
  ///
  /// In en, this message translates to:
  /// **'Hotels'**
  String get ticketsHotels;

  /// No description provided for @ticketsVehicles.
  ///
  /// In en, this message translates to:
  /// **'Vehicles'**
  String get ticketsVehicles;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccount;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteAccountDesc.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove your data'**
  String get settingsDeleteAccountDesc;

  /// No description provided for @settingsAppVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get settingsAppVersion;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get settingsLogout;

  /// No description provided for @settingsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming in Phase 6'**
  String get settingsComingSoon;

  /// No description provided for @settingsSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settingsSelectLanguage;

  /// No description provided for @settingsSelectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get settingsSelectCurrency;

  /// No description provided for @hotelTitle.
  ///
  /// In en, this message translates to:
  /// **'Book a Hotel'**
  String get hotelTitle;

  /// No description provided for @hotelSearch.
  ///
  /// In en, this message translates to:
  /// **'Search Hotels'**
  String get hotelSearch;

  /// No description provided for @hotelWhere.
  ///
  /// In en, this message translates to:
  /// **'Where to?'**
  String get hotelWhere;

  /// No description provided for @hotelDestination.
  ///
  /// In en, this message translates to:
  /// **'Destination city or hotel name'**
  String get hotelDestination;

  /// No description provided for @hotelCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get hotelCheckIn;

  /// No description provided for @hotelCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Check-out'**
  String get hotelCheckOut;

  /// No description provided for @hotelRooms.
  ///
  /// In en, this message translates to:
  /// **'Rooms'**
  String get hotelRooms;

  /// No description provided for @hotelGuests.
  ///
  /// In en, this message translates to:
  /// **'Guests'**
  String get hotelGuests;

  /// No description provided for @hotelEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Find your perfect stay'**
  String get hotelEmptyMessage;

  /// No description provided for @hotelEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter a destination to search hotels'**
  String get hotelEmptySubtitle;

  /// No description provided for @hotelHotelsIn.
  ///
  /// In en, this message translates to:
  /// **'{count} hotels in {destination}'**
  String hotelHotelsIn(int count, String destination);

  /// No description provided for @hotelNights.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 night} other{{count} nights}}'**
  String hotelNights(int count);

  /// No description provided for @hotelErrorDestination.
  ///
  /// In en, this message translates to:
  /// **'Please enter a destination'**
  String get hotelErrorDestination;

  /// No description provided for @vanTitle.
  ///
  /// In en, this message translates to:
  /// **'Van Rental'**
  String get vanTitle;

  /// No description provided for @vanFind.
  ///
  /// In en, this message translates to:
  /// **'Find Vehicles'**
  String get vanFind;

  /// No description provided for @vanPickupLocation.
  ///
  /// In en, this message translates to:
  /// **'Pick-up'**
  String get vanPickupLocation;

  /// No description provided for @vanDropLocation.
  ///
  /// In en, this message translates to:
  /// **'Drop-off'**
  String get vanDropLocation;

  /// No description provided for @vanPickupDate.
  ///
  /// In en, this message translates to:
  /// **'Pick-up Date'**
  String get vanPickupDate;

  /// No description provided for @vanReturnDate.
  ///
  /// In en, this message translates to:
  /// **'Return Date'**
  String get vanReturnDate;

  /// No description provided for @vanEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Find the perfect ride'**
  String get vanEmptyMessage;

  /// No description provided for @vanEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select locations to browse available vehicles'**
  String get vanEmptySubtitle;

  /// No description provided for @vanVehiclesAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 vehicle available} other{{count} vehicles available}}'**
  String vanVehiclesAvailable(int count);

  /// No description provided for @vanNoVehicles.
  ///
  /// In en, this message translates to:
  /// **'No vehicles in this category'**
  String get vanNoVehicles;

  /// No description provided for @vanErrorPickup.
  ///
  /// In en, this message translates to:
  /// **'Please select a pick-up location'**
  String get vanErrorPickup;

  /// No description provided for @contactUsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUsTitle;

  /// No description provided for @contactGetInTouch.
  ///
  /// In en, this message translates to:
  /// **'Get In Touch'**
  String get contactGetInTouch;

  /// No description provided for @contactCall.
  ///
  /// In en, this message translates to:
  /// **'Call Us'**
  String get contactCall;

  /// No description provided for @contactCallNumber.
  ///
  /// In en, this message translates to:
  /// **'+962 6 510 0000'**
  String get contactCallNumber;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Us'**
  String get contactEmail;

  /// No description provided for @contactEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'support@skytrip.com'**
  String get contactEmailAddress;

  /// No description provided for @contactChat.
  ///
  /// In en, this message translates to:
  /// **'Live Chat'**
  String get contactChat;

  /// No description provided for @contactChatAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available 24/7'**
  String get contactChatAvailable;

  /// No description provided for @contactSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send a Message'**
  String get contactSendMessage;

  /// No description provided for @contactSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get contactSubject;

  /// No description provided for @contactMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get contactMessage;

  /// No description provided for @contactSend.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get contactSend;

  /// No description provided for @contactFaq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get contactFaq;

  /// No description provided for @contactOpening.
  ///
  /// In en, this message translates to:
  /// **'Opening {type}…'**
  String contactOpening(String type);

  /// No description provided for @contactSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message sent! We\'ll respond within 24 hours.'**
  String get contactSuccess;

  /// No description provided for @contactComing.
  ///
  /// In en, this message translates to:
  /// **'Live chat: Coming in Phase 6'**
  String get contactComing;

  /// No description provided for @dialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dialogCancel;

  /// No description provided for @dialogOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get dialogOk;

  /// No description provided for @dialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get dialogConfirm;

  /// No description provided for @dialogCannotCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking?'**
  String get dialogCannotCancel;

  /// No description provided for @dialogCancelBookingDesc.
  ///
  /// In en, this message translates to:
  /// **'You have a booking in progress. Leaving now will lose all your selections.'**
  String get dialogCancelBookingDesc;

  /// No description provided for @dialogKeepGoing.
  ///
  /// In en, this message translates to:
  /// **'Keep Going'**
  String get dialogKeepGoing;

  /// No description provided for @dialogLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get dialogLogout;

  /// No description provided for @dialogLogoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get dialogLogoutConfirm;

  /// No description provided for @dialogDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get dialogDeleteAccount;

  /// No description provided for @dialogDeleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove all your data? This action cannot be undone.'**
  String get dialogDeleteAccountConfirm;

  /// No description provided for @drawerHotel.
  ///
  /// In en, this message translates to:
  /// **'Book a Hotel'**
  String get drawerHotel;

  /// No description provided for @drawerVanRental.
  ///
  /// In en, this message translates to:
  /// **'Van Rental'**
  String get drawerVanRental;

  /// No description provided for @drawerSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get drawerSettings;

  /// No description provided for @drawerContactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get drawerContactUs;

  /// No description provided for @drawerAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get drawerAbout;

  /// No description provided for @drawerWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get drawerWelcome;

  /// No description provided for @drawerWelcomeName.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String drawerWelcomeName(String name);

  /// No description provided for @drawerLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get drawerLogout;

  /// No description provided for @drawerBooking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get drawerBooking;

  /// No description provided for @dialogDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get dialogDone;

  /// No description provided for @paymentContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue to Payment'**
  String get paymentContinue;

  /// No description provided for @profileEditLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit {label}'**
  String profileEditLabel(String label);

  /// No description provided for @profileLabelUpdated.
  ///
  /// In en, this message translates to:
  /// **'{label} updated'**
  String profileLabelUpdated(String label);

  /// No description provided for @profileSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get profileSave;

  /// No description provided for @hotelBook.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get hotelBook;

  /// No description provided for @hotelConfirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get hotelConfirmBooking;

  /// No description provided for @hotelBooked.
  ///
  /// In en, this message translates to:
  /// **'Hotel Booked!'**
  String get hotelBooked;

  /// No description provided for @vanRent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get vanRent;

  /// No description provided for @vanConfirmRental.
  ///
  /// In en, this message translates to:
  /// **'Confirm Rental'**
  String get vanConfirmRental;

  /// No description provided for @vanRentalConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Rental Confirmed!'**
  String get vanRentalConfirmed;

  /// No description provided for @authGoogleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In: Coming in Phase 6'**
  String get authGoogleSignIn;

  /// No description provided for @settingsSave.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get settingsSave;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully'**
  String get settingsSaved;

  /// No description provided for @settingsErrorSaving.
  ///
  /// In en, this message translates to:
  /// **'Error saving settings: {error}'**
  String settingsErrorSaving(String error);

  /// No description provided for @settingsFeatureComing.
  ///
  /// In en, this message translates to:
  /// **'{feature}: Coming in Phase 6'**
  String settingsFeatureComing(String feature);

  /// No description provided for @settingsAccountDeletion.
  ///
  /// In en, this message translates to:
  /// **'Account deletion: TODO in Phase 6'**
  String get settingsAccountDeletion;

  /// No description provided for @ticketDetail.
  ///
  /// In en, this message translates to:
  /// **'Ticket {id}: TODO detail view'**
  String ticketDetail(String id);

  /// No description provided for @availableFlightsPerPerson.
  ///
  /// In en, this message translates to:
  /// **'per person'**
  String get availableFlightsPerPerson;

  /// No description provided for @availableFlightsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total: {currency} {price}'**
  String availableFlightsTotal(String currency, String price);

  /// No description provided for @ticketsFlightSingular.
  ///
  /// In en, this message translates to:
  /// **'Flight'**
  String get ticketsFlightSingular;

  /// No description provided for @ticketsFlightPlural.
  ///
  /// In en, this message translates to:
  /// **'Flights'**
  String get ticketsFlightPlural;

  /// No description provided for @ticketsNoHotelBookings.
  ///
  /// In en, this message translates to:
  /// **'No hotel bookings'**
  String get ticketsNoHotelBookings;

  /// No description provided for @ticketsNoVehicleBookings.
  ///
  /// In en, this message translates to:
  /// **'No vehicle bookings'**
  String get ticketsNoVehicleBookings;

  /// No description provided for @ticketsCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get ticketsCheckIn;

  /// No description provided for @ticketsCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Check-out'**
  String get ticketsCheckOut;

  /// No description provided for @ticketsGuests.
  ///
  /// In en, this message translates to:
  /// **'Guests'**
  String get ticketsGuests;

  /// No description provided for @hotelSelectDestination.
  ///
  /// In en, this message translates to:
  /// **'Select Destination'**
  String get hotelSelectDestination;

  /// No description provided for @hotelDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get hotelDuration;

  /// No description provided for @hotelRoomType.
  ///
  /// In en, this message translates to:
  /// **'Room Type'**
  String get hotelRoomType;

  /// No description provided for @hotelRoomsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{room} other{rooms}}'**
  String hotelRoomsLabel(int count);

  /// No description provided for @hotelGuestsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{guest} other{guests}}'**
  String hotelGuestsLabel(int count);

  /// No description provided for @vanPricePerDay.
  ///
  /// In en, this message translates to:
  /// **'{currency} {price}/day'**
  String vanPricePerDay(String currency, String price);

  /// No description provided for @vanDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 day} other{{count} days}}'**
  String vanDays(int count);

  /// No description provided for @vanFeatures.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get vanFeatures;

  /// No description provided for @vanDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get vanDuration;

  /// No description provided for @dialogTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get dialogTotal;

  /// No description provided for @servicesFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get servicesFree;

  /// No description provided for @servicesPricePerPerson.
  ///
  /// In en, this message translates to:
  /// **'{currency} {price} per person'**
  String servicesPricePerPerson(String currency, String price);

  /// No description provided for @flightDetailsBookingCreating.
  ///
  /// In en, this message translates to:
  /// **'Creating Booking...'**
  String get flightDetailsBookingCreating;

  /// No description provided for @flightDetailsPolicies.
  ///
  /// In en, this message translates to:
  /// **'Policies'**
  String get flightDetailsPolicies;

  /// No description provided for @flightDetailsDateChange.
  ///
  /// In en, this message translates to:
  /// **'Date Change'**
  String get flightDetailsDateChange;

  /// No description provided for @flightDetailsRefundableWithFee.
  ///
  /// In en, this message translates to:
  /// **'Refundable with fee'**
  String get flightDetailsRefundableWithFee;

  /// No description provided for @flightDetailsAllowedWithFee.
  ///
  /// In en, this message translates to:
  /// **'Allowed with fee'**
  String get flightDetailsAllowedWithFee;

  /// No description provided for @flightDetailsChangeDate.
  ///
  /// In en, this message translates to:
  /// **'Date Change'**
  String get flightDetailsChangeDate;

  /// No description provided for @profilePhotoUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Photo upload: Coming in Phase 6'**
  String get profilePhotoUpcoming;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'de', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
