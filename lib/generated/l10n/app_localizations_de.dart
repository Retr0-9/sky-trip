// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Sky Trip';

  @override
  String get appVersion => 'SkyTrip v1.0.0';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName';
  }

  @override
  String get homeReady => 'Bereit für dein nächstes Abenteuer?';

  @override
  String get homeRecentSearches => 'Letzte Suchen';

  @override
  String get homeLatestOffers => 'Neueste Angebote';

  @override
  String get homeFeaturedDestinations => 'Empfohlene Reiseziele';

  @override
  String get homeSeeAll => 'Alle anzeigen';

  @override
  String get bookingTitle => 'Flug buchen';

  @override
  String get bookingTripRoundtrip => 'Hin- und Rückflug';

  @override
  String get bookingTripOneWay => 'Einweg';

  @override
  String get bookingTripMultiCity => 'Mehrere Städte';

  @override
  String get bookingFromLabel => 'Von';

  @override
  String get bookingToLabel => 'Nach';

  @override
  String get bookingSearchCity => 'Stadt suchen…';

  @override
  String get bookingDepartureDate => 'Abflug';

  @override
  String get bookingReturnDate => 'Rückflug';

  @override
  String get bookingAdults => 'Erwachsene';

  @override
  String get bookingYouth => 'Jugendliche';

  @override
  String get bookingChildren => 'Kinder';

  @override
  String get bookingInfants => 'Säuglinge';

  @override
  String get bookingClass => 'Klasse';

  @override
  String get bookingPassengers => 'Passagiere';

  @override
  String get bookingSearch => 'Flüge suchen';

  @override
  String get bookingNoFlightsFound => 'Keine Flüge gefunden';

  @override
  String get bookingTryAnother => 'Versuche eine andere Suche';

  @override
  String get bookingSubtitle => 'Wohin möchtest du heute reisen?';

  @override
  String get bookingDepartureCityHint => 'Abflugstadt';

  @override
  String get bookingArrivalCityHint => 'Ankunftsstadt';

  @override
  String get bookingSelectDate => 'Datum auswählen';

  @override
  String get bookingSelectReturnDate => 'Rückreisedatum auswählen';

  @override
  String get bookingSelectClass => 'Klasse auswählen';

  @override
  String get bookingErrorSelectCities =>
      'Bitte wähle Abflug- und Ankunftsstädte aus.';

  @override
  String get bookingErrorDifferentCities =>
      'Abflug- und Ankunftsstadt müssen unterschiedlich sein.';

  @override
  String get bookingErrorSelectDeparture => 'Bitte wähle ein Abflugdatum aus.';

  @override
  String get bookingErrorSelectReturn => 'Bitte wähle ein Rückreisedatum aus.';

  @override
  String get bookingErrorSearchFailed =>
      'Suche fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String bookingPassengersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Passagiere',
      one: '1 Passagier',
    );
    return '$_temp0';
  }

  @override
  String get bookingAdultSubtext => '12+ Jahre';

  @override
  String get bookingYouthSubtext => '2–11 Jahre';

  @override
  String get bookingChildrenSubtext => 'Unter 2';

  @override
  String get bookingInfantsSubtext => 'Sitzendes Kleinkind';

  @override
  String get greetingMorning => 'Guten Morgen';

  @override
  String get greetingAfternoon => 'Guten Nachmittag';

  @override
  String get greetingEvening => 'Guten Abend';

  @override
  String get dialogRetry => 'Erneut versuchen';

  @override
  String get authSignIn => 'Anmelden';

  @override
  String get authSignUp => 'Registrieren';

  @override
  String get authEmail => 'E-Mail';

  @override
  String get authPassword => 'Passwort';

  @override
  String get authConfirmPassword => 'Passwort bestätigen';

  @override
  String get authFirstName => 'Vorname';

  @override
  String get authLastName => 'Nachname';

  @override
  String get authStaffId => 'Mitarbeiter-ID';

  @override
  String get authErrorEmail => 'Bitte eine gültige E-Mail-Adresse eingeben.';

  @override
  String get authErrorPassword =>
      'Das Passwort muss mindestens 6 Zeichen lang sein.';

  @override
  String get authErrorRequired => 'Bitte E-Mail und Passwort eingeben.';

  @override
  String get authErrorComingSoon =>
      'Registrierung bald verfügbar. Bitte anmelden.';

  @override
  String get authErrorGeneric =>
      'Etwas ist schiefgelaufen. Bitte versuche es erneut.';

  @override
  String get authHaveAccount => 'Hast du bereits ein Konto?';

  @override
  String get authNoAccount => 'Noch kein Konto?';

  @override
  String get authStaffMode => 'Mitarbeitermodus';

  @override
  String get availableFlightsTitle => 'Verfügbare Flüge';

  @override
  String get availableFlightsPax => 'Passagier';

  @override
  String get availableFlightsEmpty => 'Keine Flüge verfügbar';

  @override
  String get availableFlightsNoResults =>
      'Keine Flüge entsprechen deiner Suche';

  @override
  String get flightDetailsTitle => 'Flugdetails';

  @override
  String get flightDetailsFareBreakdown => 'Preisübersicht';

  @override
  String get flightDetailsBaseFare => 'Grundpreis';

  @override
  String flightDetailsBaseFareDetail(int pax, String currency, String price) {
    return 'Grundpreis ($pax Passagiere × $currency $price)';
  }

  @override
  String get flightDetailsTaxes => 'Steuern & Gebühren (15%)';

  @override
  String get flightDetailsTotal => 'Gesamtpreis';

  @override
  String get flightDetailsBaggage => 'Gepäckbestimmungen';

  @override
  String get flightDetailsBaggageCarry => '1 Handgepäckstück';

  @override
  String get flightDetailsBaggageChecked => 'Aufgegebenes Gepäck';

  @override
  String get flightDetailsBaggageEconomy =>
      'Economy: 1 Handgepäck (7 kg) + 1 Aufgabegepäck (23 kg)';

  @override
  String get flightDetailsBaggageBusiness =>
      'Business: 1 Handgepäck (10 kg) + 2 Aufgabegepäckstücke (32 kg jeweils)';

  @override
  String get flightDetailsCancellation => 'Stornierungsbedingungen';

  @override
  String get flightDetailsConfirm => 'Weiter zu Passagieren';

  @override
  String get flightDetailsErrorCreating =>
      'Buchung konnte nicht erstellt werden. Bitte erneut versuchen.';

  @override
  String get passengersFormTitle => 'Passagierinformationen';

  @override
  String passengersFormPassenger(int number) {
    return 'Passagier $number';
  }

  @override
  String get passengersFormFirstName => 'Vorname';

  @override
  String get passengersFormLastName => 'Nachname';

  @override
  String get passengersFormEmail => 'E-Mail';

  @override
  String get passengersFormPhone => 'Telefon';

  @override
  String get passengersFormDOB => 'Geburtsdatum';

  @override
  String get passengersFormGender => 'Geschlecht';

  @override
  String get passengersFormMale => 'Männlich';

  @override
  String get passengersFormFemale => 'Weiblich';

  @override
  String get passengersFormDocument => 'Reisedokument';

  @override
  String get passengersFormPassport => 'Reisepass';

  @override
  String get passengersFormDocumentIssue => 'Ausstellungsland';

  @override
  String get passengersFormSearchCountry => 'Land suchen…';

  @override
  String get passengersFormExpiry => 'Ablaufdatum';

  @override
  String get passengersFormContinue => 'Weiter zu Services';

  @override
  String get servicesTitle => 'Optionale Services';

  @override
  String get servicesEnhance => 'Verbessere deine Reise';

  @override
  String get servicesSubtitle =>
      'Füge zusätzliche Services für mehr Komfort hinzu';

  @override
  String get servicesTotal => 'Services gesamt:';

  @override
  String get servicesCurrency => 'JOD';

  @override
  String get servicesSkip => 'Services überspringen';

  @override
  String get servicesContinue => 'Weiter zur Sitzplatzwahl';

  @override
  String get servicesNoAvailable => 'Keine Services verfügbar.';

  @override
  String get servicesLoadError => 'Services konnten nicht geladen werden.';

  @override
  String get servicesRetry => 'Erneut versuchen';

  @override
  String get servicesErrorSaving =>
      'Services konnten nicht gespeichert werden. Bitte erneut versuchen.';

  @override
  String get seatMapTitle => 'Sitzplatz wählen';

  @override
  String get seatMapAvailable => 'Verfügbar';

  @override
  String get seatMapOccupied => 'Belegt';

  @override
  String get seatMapSelected => 'Ausgewählt';

  @override
  String get seatMapContinue => 'Sitzplatz bestätigen';

  @override
  String get paymentTitle => 'Zahlung';

  @override
  String get paymentBookingSummary => 'Buchungsübersicht';

  @override
  String get paymentOrderDetails => 'Bestelldetails';

  @override
  String get paymentFlightDetails => 'Flugdetails';

  @override
  String get paymentPassengers => 'Passagiere';

  @override
  String get paymentBaseFare => 'Grundpreis';

  @override
  String get paymentTaxes => 'Steuern & Gebühren';

  @override
  String get paymentServicesFee => 'Services';

  @override
  String get paymentTotal => 'Gesamt';

  @override
  String get paymentGrandTotal => 'Gesamtsumme';

  @override
  String get paymentStripeInfo => 'Gesichert durch Stripe';

  @override
  String get paymentProceed => 'Zur Zahlung fortfahren';

  @override
  String get paymentStart => 'Zahlung starten';

  @override
  String get paymentErrorTicketId => 'Ticket-ID fehlt – bitte neu starten.';

  @override
  String get paymentErrorSession =>
      'Zahlungssitzung konnte nicht erstellt werden.';

  @override
  String get paymentErrorOpen => 'Zahlungsseite konnte nicht geöffnet werden.';

  @override
  String get paymentCurrency => 'JOD';

  @override
  String get paymentSuccessTitle => 'Buchung bestätigt!';

  @override
  String get paymentSuccessMessage =>
      'Zahlung erfolgreich. Deine Buchung ist bestätigt. Du findest dein Ticket im Tickets-Tab.';

  @override
  String get paymentSuccessGoHome => 'Startseite';

  @override
  String get paymentSuccessViewTickets => 'Tickets anzeigen';

  @override
  String get ticketsUpcoming => 'Kommend';

  @override
  String get ticketsPast => 'Vergangen';

  @override
  String get ticketsNoUpcoming => 'Keine kommenden Flüge';

  @override
  String get ticketsNoPast => 'Keine vergangenen Flüge';

  @override
  String ticketsCount(int count, String type) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ${type}s',
      one: '$count $type',
    );
    return '$_temp0';
  }

  @override
  String get profileTitle => 'Profil';

  @override
  String get profilePersonalInfo => 'Persönliche Informationen';

  @override
  String get profileFullName => 'Vollständiger Name';

  @override
  String get profileEmail => 'E-Mail';

  @override
  String get profilePhone => 'Telefon';

  @override
  String get profileNationality => 'Nationalität';

  @override
  String get profileTravelDocs => 'Reisedokumente';

  @override
  String get profilePassport => 'Reisepassnummer';

  @override
  String get profilePreferredClass => 'Bevorzugte Klasse';

  @override
  String get profileLoyalty => 'Vielflieger';

  @override
  String get profileStats => 'Reisestatistiken';

  @override
  String get profileFlights => 'Flüge';

  @override
  String get profileMiles => 'Meilen';

  @override
  String get profileTier => 'Status';

  @override
  String get profilePhotoUpload => 'Foto-Upload: kommt in Phase 6';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsNotifications => 'Benachrichtigungen';

  @override
  String get settingsFlightUpdates => 'Flugupdates';

  @override
  String get settingsFlightUpdatesDesc =>
      'Gate-Änderungen, Verspätungen & Stornierungen';

  @override
  String get settingsPriceAlerts => 'Preisalarme';

  @override
  String get settingsPriceAlertsDesc =>
      'Benachrichtigungen bei Preisrückgängen';

  @override
  String get settingsBookingReminders => 'Buchungserinnerungen';

  @override
  String get settingsBookingRemindersDesc => '24h vor Abflug';

  @override
  String get settingsPromotions => 'Aktionen & Angebote';

  @override
  String get settingsPromotionsDesc => 'Deals, Rabatte und saisonale Angebote';

  @override
  String get settingsSmsAlerts => 'SMS-Benachrichtigungen';

  @override
  String get settingsSmsAlertsDesc => 'Benachrichtigungen per SMS erhalten';

  @override
  String get settingsDisplay => 'Anzeige & Sprache';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsCurrency => 'Währung';

  @override
  String get settingsDarkMode => 'Dunkler Modus';

  @override
  String get settingsDarkModeDesc => 'Zum dunklen Design wechseln';

  @override
  String get settingsPrivacy => 'Datenschutz & Sicherheit';

  @override
  String get settingsChangePassword => 'Passwort ändern';

  @override
  String get settingsBiometric => 'Biometrischer Login';

  @override
  String get settingsBiometricDesc => 'Fingerabdruck oder Face ID verwenden';

  @override
  String get settingsShareData => 'Nutzungsdaten teilen';

  @override
  String get settingsShareDataDesc => 'Hilf uns, die App zu verbessern';

  @override
  String get ticketsHotels => 'Hotels';

  @override
  String get ticketsVehicles => 'Fahrzeuge';

  @override
  String get settingsAccount => 'Konto';

  @override
  String get settingsDeleteAccount => 'Konto löschen';

  @override
  String get settingsDeleteAccountDesc => 'Daten dauerhaft entfernen';

  @override
  String get settingsAppVersion => 'App-Version';

  @override
  String get settingsLogout => 'Abmelden';

  @override
  String get settingsComingSoon => 'Bald in Phase 6';

  @override
  String get settingsSelectLanguage => 'Sprache auswählen';

  @override
  String get settingsSelectCurrency => 'Währung auswählen';

  @override
  String get hotelTitle => 'Hotel buchen';

  @override
  String get hotelSearch => 'Hotels suchen';

  @override
  String get hotelWhere => 'Wohin?';

  @override
  String get hotelDestination => 'Stadt oder Hotelname';

  @override
  String get hotelCheckIn => 'Check-in';

  @override
  String get hotelCheckOut => 'Check-out';

  @override
  String get hotelRooms => 'Zimmer';

  @override
  String get hotelGuests => 'Gäste';

  @override
  String get hotelEmptyMessage => 'Finde deinen perfekten Aufenthalt';

  @override
  String get hotelEmptySubtitle => 'Gib ein Reiseziel ein, um Hotels zu suchen';

  @override
  String hotelHotelsIn(int count, String destination) {
    return '$count Hotels in $destination';
  }

  @override
  String hotelNights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Nächte',
      one: '1 Nacht',
    );
    return '$_temp0';
  }

  @override
  String get hotelErrorDestination => 'Bitte ein Reiseziel eingeben';

  @override
  String get vanTitle => 'Van-Miete';

  @override
  String get vanFind => 'Fahrzeuge finden';

  @override
  String get vanPickupLocation => 'Abholort';

  @override
  String get vanDropLocation => 'Rückgabeort';

  @override
  String get vanPickupDate => 'Abholdatum';

  @override
  String get vanReturnDate => 'Rückgabedatum';

  @override
  String get vanEmptyMessage => 'Finde das perfekte Fahrzeug';

  @override
  String get vanEmptySubtitle => 'Standorte auswählen, um Fahrzeuge zu sehen';

  @override
  String vanVehiclesAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Fahrzeuge verfügbar',
      one: '1 Fahrzeug verfügbar',
    );
    return '$_temp0';
  }

  @override
  String get vanNoVehicles => 'Keine Fahrzeuge in dieser Kategorie';

  @override
  String get vanErrorPickup => 'Bitte Abholort auswählen';

  @override
  String get contactUsTitle => 'Kontakt';

  @override
  String get contactGetInTouch => 'Kontakt aufnehmen';

  @override
  String get contactCall => 'Ruf uns an';

  @override
  String get contactCallNumber => '+962 6 510 0000';

  @override
  String get contactEmail => 'E-Mail senden';

  @override
  String get contactEmailAddress => 'support@skytrip.com';

  @override
  String get contactChat => 'Live-Chat';

  @override
  String get contactChatAvailable => '24/7 verfügbar';

  @override
  String get contactSendMessage => 'Nachricht senden';

  @override
  String get contactSubject => 'Betreff';

  @override
  String get contactMessage => 'Nachricht';

  @override
  String get contactSend => 'Nachricht senden';

  @override
  String get contactFaq => 'FAQ';

  @override
  String contactOpening(String type) {
    return '$type wird geöffnet…';
  }

  @override
  String get contactSuccess =>
      'Nachricht gesendet! Wir antworten innerhalb von 24 Stunden.';

  @override
  String get contactComing => 'Live-Chat: kommt in Phase 6';

  @override
  String get dialogCancel => 'Abbrechen';

  @override
  String get dialogOk => 'OK';

  @override
  String get dialogConfirm => 'Bestätigen';

  @override
  String get dialogCannotCancel => 'Buchung abbrechen?';

  @override
  String get dialogCancelBookingDesc =>
      'Du hast eine laufende Buchung. Beim Verlassen gehen alle Auswahl verloren.';

  @override
  String get dialogKeepGoing => 'Weiter machen';

  @override
  String get dialogLogout => 'Abmelden';

  @override
  String get dialogLogoutConfirm => 'Möchtest du dich wirklich abmelden?';

  @override
  String get dialogDeleteAccount => 'Konto löschen';

  @override
  String get dialogDeleteAccountConfirm =>
      'Alle Daten dauerhaft löschen? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get drawerHotel => 'Hotel buchen';

  @override
  String get drawerVanRental => 'Van-Miete';

  @override
  String get drawerSettings => 'Einstellungen';

  @override
  String get drawerContactUs => 'Kontakt';

  @override
  String get drawerAbout => 'Über uns';

  @override
  String get drawerWelcome => 'Willkommen';

  @override
  String drawerWelcomeName(String name) {
    return 'Willkommen, $name';
  }

  @override
  String get drawerLogout => 'Abmelden';

  @override
  String get drawerBooking => 'Buchung';

  @override
  String get dialogDone => 'Fertig';

  @override
  String get paymentContinue => 'Weiter zur Zahlung';

  @override
  String profileEditLabel(String label) {
    return 'Bearbeiten $label';
  }

  @override
  String profileLabelUpdated(String label) {
    return '$label aktualisiert';
  }

  @override
  String get profileSave => 'Speichern';

  @override
  String get hotelBook => 'Buchen';

  @override
  String get hotelConfirmBooking => 'Buchung bestätigen';

  @override
  String get hotelBooked => 'Hotel gebucht!';

  @override
  String get vanRent => 'Mieten';

  @override
  String get vanConfirmRental => 'Miete bestätigen';

  @override
  String get vanRentalConfirmed => 'Miete bestätigt!';

  @override
  String get authGoogleSignIn => 'Google-Anmeldung: kommt in Phase 6';

  @override
  String get settingsSave => 'Einstellungen speichern';

  @override
  String get settingsSaved => 'Einstellungen erfolgreich gespeichert';

  @override
  String settingsErrorSaving(String error) {
    return 'Fehler beim Speichern der Einstellungen: $error';
  }

  @override
  String settingsFeatureComing(String feature) {
    return '$feature: kommt in Phase 6';
  }

  @override
  String get settingsAccountDeletion => 'Konto löschen: TODO in Phase 6';

  @override
  String ticketDetail(String id) {
    return 'Ticket $id: TODO Detailansicht';
  }

  @override
  String get availableFlightsPerPerson => 'Verfügbare Flüge pro Person';

  @override
  String availableFlightsTotal(String currency, String price) {
    return 'Verfügbare Flüge insgesamt';
  }

  @override
  String get ticketsFlightSingular => 'Flug';

  @override
  String get ticketsFlightPlural => 'Flüge';

  @override
  String get ticketsNoHotelBookings => 'Keine Hotelbuchungen';

  @override
  String get ticketsNoVehicleBookings => 'Keine Fahrzeugbuchungen';

  @override
  String get ticketsCheckIn => 'Check-in';

  @override
  String get ticketsCheckOut => 'Check-out';

  @override
  String get ticketsGuests => 'Gäste';

  @override
  String get hotelSelectDestination => 'Hotel-Ziel auswählen';

  @override
  String get hotelDuration => 'Hotel-Dauer';

  @override
  String get hotelRoomType => 'Zimmertyp';

  @override
  String hotelRoomsLabel(int count) {
    return 'Zimmer';
  }

  @override
  String hotelGuestsLabel(int count) {
    return 'Gäste';
  }

  @override
  String vanPricePerDay(String currency, String price) {
    return 'Preis pro Tag';
  }

  @override
  String vanDays(int count) {
    return 'Tage';
  }

  @override
  String get vanFeatures => 'Ausstattung';

  @override
  String get vanDuration => 'Dauer';

  @override
  String get dialogTotal => 'Gesamt';

  @override
  String get servicesFree => 'Kostenlos';

  @override
  String servicesPricePerPerson(String currency, String price) {
    return 'Preis pro Person';
  }

  @override
  String get flightDetailsBookingCreating => 'Buchung wird erstellt';

  @override
  String get flightDetailsPolicies => 'Richtlinien';

  @override
  String get flightDetailsDateChange => 'Datumsänderung';

  @override
  String get flightDetailsRefundableWithFee => 'Rückerstattbar mit Gebühr';

  @override
  String get flightDetailsAllowedWithFee => 'Erlaubt mit Gebühr';

  @override
  String get flightDetailsChangeDate => 'Datum ändern';

  @override
  String get profilePhotoUpcoming => 'Foto demnächst';
}
