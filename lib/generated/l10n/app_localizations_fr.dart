// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Sky Trip';

  @override
  String get appVersion => 'SkyTrip v1.0.0';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName';
  }

  @override
  String get homeReady => 'Prêt pour votre prochaine aventure ?';

  @override
  String get homeRecentSearches => 'Recherches récentes';

  @override
  String get homeLatestOffers => 'Dernières offres';

  @override
  String get homeFeaturedDestinations => 'Destinations en vedette';

  @override
  String get homeSeeAll => 'Voir tout';

  @override
  String get bookingTitle => 'Réserver un vol';

  @override
  String get bookingTripRoundtrip => 'Aller-retour';

  @override
  String get bookingTripOneWay => 'Aller simple';

  @override
  String get bookingTripMultiCity => 'Multi-destinations';

  @override
  String get bookingFromLabel => 'De';

  @override
  String get bookingToLabel => 'À';

  @override
  String get bookingSearchCity => 'Rechercher une ville…';

  @override
  String get bookingDepartureDate => 'Départ';

  @override
  String get bookingReturnDate => 'Retour';

  @override
  String get bookingAdults => 'Adultes';

  @override
  String get bookingYouth => 'Jeunes';

  @override
  String get bookingChildren => 'Enfants';

  @override
  String get bookingInfants => 'Bébés';

  @override
  String get bookingClass => 'Classe';

  @override
  String get bookingPassengers => 'Passagers';

  @override
  String get bookingSearch => 'Rechercher des vols';

  @override
  String get bookingNoFlightsFound => 'Aucun vol trouvé';

  @override
  String get bookingTryAnother => 'Essayez une autre recherche';

  @override
  String get bookingSubtitle => 'Où souhaitez-vous aller aujourd\'hui ?';

  @override
  String get bookingDepartureCityHint => 'Ville de départ';

  @override
  String get bookingArrivalCityHint => 'Ville d\'arrivée';

  @override
  String get bookingSelectDate => 'Sélectionner une date';

  @override
  String get bookingSelectReturnDate => 'Sélectionner la date de retour';

  @override
  String get bookingSelectClass => 'Sélectionner la classe';

  @override
  String get bookingErrorSelectCities =>
      'Veuillez sélectionner les villes de départ et d\'arrivée.';

  @override
  String get bookingErrorDifferentCities =>
      'Les villes de départ et d\'arrivée doivent être différentes.';

  @override
  String get bookingErrorSelectDeparture =>
      'Veuillez sélectionner une date de départ.';

  @override
  String get bookingErrorSelectReturn =>
      'Veuillez sélectionner une date de retour.';

  @override
  String get bookingErrorSearchFailed =>
      'La recherche a échoué. Veuillez réessayer.';

  @override
  String bookingPassengersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count passagers',
      one: '1 passager',
    );
    return '$_temp0';
  }

  @override
  String get bookingAdultSubtext => '12 ans et plus';

  @override
  String get bookingYouthSubtext => '2–11 ans';

  @override
  String get bookingChildrenSubtext => 'Moins de 2 ans';

  @override
  String get bookingInfantsSubtext => 'Bébé sur les genoux';

  @override
  String get greetingMorning => 'Bonjour';

  @override
  String get greetingAfternoon => 'Bon après-midi';

  @override
  String get greetingEvening => 'Bonsoir';

  @override
  String get dialogRetry => 'Réessayer';

  @override
  String get authSignIn => 'Se connecter';

  @override
  String get authSignUp => 'S\'inscrire';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authPassword => 'Mot de passe';

  @override
  String get authConfirmPassword => 'Confirmer le mot de passe';

  @override
  String get authFirstName => 'Prénom';

  @override
  String get authLastName => 'Nom';

  @override
  String get authStaffId => 'ID employé';

  @override
  String get authErrorEmail => 'Entrez une adresse e-mail valide.';

  @override
  String get authErrorPassword =>
      'Le mot de passe doit contenir au moins 6 caractères.';

  @override
  String get authErrorRequired => 'Entrez votre e-mail et votre mot de passe.';

  @override
  String get authErrorComingSoon =>
      'Inscription bientôt disponible. Veuillez vous connecter.';

  @override
  String get authErrorGeneric =>
      'Une erreur s\'est produite. Veuillez réessayer.';

  @override
  String get authHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get authNoAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get authStaffMode => 'Mode employé';

  @override
  String get availableFlightsTitle => 'Vols disponibles';

  @override
  String get availableFlightsPax => 'passager';

  @override
  String get availableFlightsEmpty => 'Aucun vol disponible';

  @override
  String get availableFlightsNoResults =>
      'Aucun vol ne correspond à votre recherche';

  @override
  String get flightDetailsTitle => 'Détails du vol';

  @override
  String get flightDetailsFareBreakdown => 'Détail du tarif';

  @override
  String get flightDetailsBaseFare => 'Tarif de base';

  @override
  String flightDetailsBaseFareDetail(int pax, String currency, String price) {
    return 'Tarif de base ($pax passager × $currency $price)';
  }

  @override
  String get flightDetailsTaxes => 'Taxes et frais (15%)';

  @override
  String get flightDetailsTotal => 'Prix total';

  @override
  String get flightDetailsBaggage => 'Bagages autorisés';

  @override
  String get flightDetailsBaggageCarry => '1 bagage cabine';

  @override
  String get flightDetailsBaggageChecked => 'Bagages enregistrés';

  @override
  String get flightDetailsBaggageEconomy =>
      'Économie : 1 bagage cabine (7 kg) + 1 bagage enregistré (23 kg)';

  @override
  String get flightDetailsBaggageBusiness =>
      'Affaires : 1 bagage cabine (10 kg) + 2 bagages enregistrés (32 kg chacun)';

  @override
  String get flightDetailsCancellation => 'Politique d\'annulation';

  @override
  String get flightDetailsConfirm => 'Continuer vers les passagers';

  @override
  String get flightDetailsErrorCreating =>
      'Impossible de créer la réservation. Veuillez réessayer.';

  @override
  String get passengersFormTitle => 'Informations passagers';

  @override
  String passengersFormPassenger(int number) {
    return 'Passager $number';
  }

  @override
  String get passengersFormFirstName => 'Prénom';

  @override
  String get passengersFormLastName => 'Nom';

  @override
  String get passengersFormEmail => 'E-mail';

  @override
  String get passengersFormPhone => 'Téléphone';

  @override
  String get passengersFormDOB => 'Date de naissance';

  @override
  String get passengersFormGender => 'Genre';

  @override
  String get passengersFormMale => 'Homme';

  @override
  String get passengersFormFemale => 'Femme';

  @override
  String get passengersFormDocument => 'Document de voyage';

  @override
  String get passengersFormPassport => 'Passeport';

  @override
  String get passengersFormDocumentIssue => 'Pays d\'émission';

  @override
  String get passengersFormSearchCountry => 'Rechercher un pays…';

  @override
  String get passengersFormExpiry => 'Date d\'expiration';

  @override
  String get passengersFormContinue => 'Continuer vers les services';

  @override
  String get servicesTitle => 'Services optionnels';

  @override
  String get servicesEnhance => 'Améliorez votre voyage';

  @override
  String get servicesSubtitle =>
      'Ajoutez des services supplémentaires pour plus de confort';

  @override
  String get servicesTotal => 'Total des services :';

  @override
  String get servicesCurrency => 'JOD';

  @override
  String get servicesSkip => 'Ignorer les services';

  @override
  String get servicesContinue => 'Continuer vers la sélection des sièges';

  @override
  String get servicesNoAvailable => 'Aucun service disponible.';

  @override
  String get servicesLoadError => 'Impossible de charger les services.';

  @override
  String get servicesRetry => 'Réessayer';

  @override
  String get servicesErrorSaving =>
      'Impossible d\'enregistrer les services. Veuillez réessayer.';

  @override
  String get seatMapTitle => 'Sélectionnez votre siège';

  @override
  String get seatMapAvailable => 'Disponible';

  @override
  String get seatMapOccupied => 'Occupé';

  @override
  String get seatMapSelected => 'Sélectionné';

  @override
  String get seatMapContinue => 'Confirmer la sélection du siège';

  @override
  String get paymentTitle => 'Paiement';

  @override
  String get paymentBookingSummary => 'Résumé de la réservation';

  @override
  String get paymentOrderDetails => 'Détails de la commande';

  @override
  String get paymentFlightDetails => 'Détails du vol';

  @override
  String get paymentPassengers => 'Passagers';

  @override
  String get paymentBaseFare => 'Tarif de base';

  @override
  String get paymentTaxes => 'Taxes et frais';

  @override
  String get paymentServicesFee => 'Services';

  @override
  String get paymentTotal => 'Total';

  @override
  String get paymentGrandTotal => 'Total général';

  @override
  String get paymentStripeInfo => 'Sécurisé par Stripe';

  @override
  String get paymentProceed => 'Procéder au paiement';

  @override
  String get paymentStart => 'Commencer le paiement';

  @override
  String get paymentErrorTicketId =>
      'ID de billet manquant — veuillez recommencer.';

  @override
  String get paymentErrorSession =>
      'Impossible de créer la session de paiement. Veuillez réessayer.';

  @override
  String get paymentErrorOpen => 'Impossible d\'ouvrir la page de paiement.';

  @override
  String get paymentCurrency => 'JOD';

  @override
  String get paymentSuccessTitle => 'Réservation confirmée !';

  @override
  String get paymentSuccessMessage =>
      'Votre paiement a été effectué avec succès et votre réservation est confirmée. Consultez votre billet dans l\'onglet Billets.';

  @override
  String get paymentSuccessGoHome => 'Accueil';

  @override
  String get paymentSuccessViewTickets => 'Voir les billets';

  @override
  String get ticketsUpcoming => 'À venir';

  @override
  String get ticketsPast => 'Passés';

  @override
  String get ticketsNoUpcoming => 'Aucun vol à venir';

  @override
  String get ticketsNoPast => 'Aucun vol passé';

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
  String get profilePersonalInfo => 'Informations personnelles';

  @override
  String get profileFullName => 'Nom complet';

  @override
  String get profileEmail => 'E-mail';

  @override
  String get profilePhone => 'Téléphone';

  @override
  String get profileNationality => 'Nationalité';

  @override
  String get profileTravelDocs => 'Documents de voyage';

  @override
  String get profilePassport => 'Numéro de passeport';

  @override
  String get profilePreferredClass => 'Classe préférée';

  @override
  String get profileLoyalty => 'Voyageur fréquent';

  @override
  String get profileStats => 'Statistiques de voyage';

  @override
  String get profileFlights => 'Vols';

  @override
  String get profileMiles => 'Miles';

  @override
  String get profileTier => 'Niveau';

  @override
  String get profilePhotoUpload =>
      'Téléversement de photo : bientôt en phase 6';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsFlightUpdates => 'Mises à jour des vols';

  @override
  String get settingsFlightUpdatesDesc =>
      'Changements de porte, retards et annulations';

  @override
  String get settingsPriceAlerts => 'Alertes de prix';

  @override
  String get settingsPriceAlertsDesc =>
      'Soyez averti lorsque les prix baissent';

  @override
  String get settingsBookingReminders => 'Rappels de réservation';

  @override
  String get settingsBookingRemindersDesc => '24h avant le départ';

  @override
  String get settingsPromotions => 'Promotions et offres';

  @override
  String get settingsPromotionsDesc => 'Offres et réductions saisonnières';

  @override
  String get settingsSmsAlerts => 'Alertes SMS';

  @override
  String get settingsSmsAlertsDesc => 'Recevoir des alertes par SMS';

  @override
  String get settingsDisplay => 'Affichage et langue';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsCurrency => 'Devise';

  @override
  String get settingsDarkMode => 'Mode sombre';

  @override
  String get settingsDarkModeDesc => 'Passer au thème sombre';

  @override
  String get settingsPrivacy => 'Confidentialité et sécurité';

  @override
  String get settingsChangePassword => 'Changer le mot de passe';

  @override
  String get settingsBiometric => 'Connexion biométrique';

  @override
  String get settingsBiometricDesc => 'Utiliser l\'empreinte ou Face ID';

  @override
  String get settingsShareData => 'Partager les données d\'utilisation';

  @override
  String get settingsShareDataDesc => 'Aidez-nous à améliorer l\'application';

  @override
  String get ticketsHotels => 'Hôtels';

  @override
  String get ticketsVehicles => 'Véhicules';

  @override
  String get settingsAccount => 'Compte';

  @override
  String get settingsDeleteAccount => 'Supprimer le compte';

  @override
  String get settingsDeleteAccountDesc =>
      'Supprimer définitivement vos données';

  @override
  String get settingsAppVersion => 'Version de l\'application';

  @override
  String get settingsLogout => 'Se déconnecter';

  @override
  String get settingsComingSoon => 'Bientôt en phase 6';

  @override
  String get settingsSelectLanguage => 'Sélectionner la langue';

  @override
  String get settingsSelectCurrency => 'Sélectionner la devise';

  @override
  String get hotelTitle => 'Réserver un hôtel';

  @override
  String get hotelSearch => 'Rechercher des hôtels';

  @override
  String get hotelWhere => 'Destination ?';

  @override
  String get hotelDestination => 'Ville ou nom de l\'hôtel';

  @override
  String get hotelCheckIn => 'Arrivée';

  @override
  String get hotelCheckOut => 'Départ';

  @override
  String get hotelRooms => 'Chambres';

  @override
  String get hotelGuests => 'Invités';

  @override
  String get hotelEmptyMessage => 'Trouvez votre séjour idéal';

  @override
  String get hotelEmptySubtitle =>
      'Entrez une destination pour rechercher des hôtels';

  @override
  String hotelHotelsIn(int count, String destination) {
    return '$count hôtels à $destination';
  }

  @override
  String hotelNights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nuits',
      one: '1 nuit',
    );
    return '$_temp0';
  }

  @override
  String get hotelErrorDestination => 'Veuillez entrer une destination';

  @override
  String get vanTitle => 'Location de van';

  @override
  String get vanFind => 'Trouver des véhicules';

  @override
  String get vanPickupLocation => 'Lieu de prise en charge';

  @override
  String get vanDropLocation => 'Lieu de dépôt';

  @override
  String get vanPickupDate => 'Date de prise en charge';

  @override
  String get vanReturnDate => 'Date de retour';

  @override
  String get vanEmptyMessage => 'Trouvez le véhicule parfait';

  @override
  String get vanEmptySubtitle =>
      'Sélectionnez des lieux pour voir les véhicules disponibles';

  @override
  String vanVehiclesAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count véhicules disponibles',
      one: '1 véhicule disponible',
    );
    return '$_temp0';
  }

  @override
  String get vanNoVehicles => 'Aucun véhicule dans cette catégorie';

  @override
  String get vanErrorPickup =>
      'Veuillez sélectionner un lieu de prise en charge';

  @override
  String get contactUsTitle => 'Contactez-nous';

  @override
  String get contactGetInTouch => 'Entrer en contact';

  @override
  String get contactCall => 'Appelez-nous';

  @override
  String get contactCallNumber => '+962 6 510 0000';

  @override
  String get contactEmail => 'Envoyez-nous un e-mail';

  @override
  String get contactEmailAddress => 'support@skytrip.com';

  @override
  String get contactChat => 'Chat en direct';

  @override
  String get contactChatAvailable => 'Disponible 24/7';

  @override
  String get contactSendMessage => 'Envoyer un message';

  @override
  String get contactSubject => 'Sujet';

  @override
  String get contactMessage => 'Message';

  @override
  String get contactSend => 'Envoyer le message';

  @override
  String get contactFaq => 'FAQ';

  @override
  String contactOpening(String type) {
    return 'Ouverture de $type…';
  }

  @override
  String get contactSuccess =>
      'Message envoyé ! Nous vous répondrons sous 24h.';

  @override
  String get contactComing => 'Chat en direct : bientôt en phase 6';

  @override
  String get dialogCancel => 'Annuler';

  @override
  String get dialogOk => 'OK';

  @override
  String get dialogConfirm => 'Confirmer';

  @override
  String get dialogCannotCancel => 'Annuler la réservation ?';

  @override
  String get dialogCancelBookingDesc =>
      'Vous avez une réservation en cours. Quitter maintenant annulera toutes vos sélections.';

  @override
  String get dialogKeepGoing => 'Continuer';

  @override
  String get dialogLogout => 'Se déconnecter';

  @override
  String get dialogLogoutConfirm =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get dialogDeleteAccount => 'Supprimer le compte';

  @override
  String get dialogDeleteAccountConfirm =>
      'Supprimer définitivement toutes vos données ? Cette action est irréversible.';

  @override
  String get drawerHotel => 'Réserver un hôtel';

  @override
  String get drawerVanRental => 'Location de van';

  @override
  String get drawerSettings => 'Paramètres';

  @override
  String get drawerContactUs => 'Contactez-nous';

  @override
  String get drawerAbout => 'À propos';

  @override
  String get drawerWelcome => 'Bienvenue';

  @override
  String drawerWelcomeName(String name) {
    return 'Bienvenue, $name';
  }

  @override
  String get drawerLogout => 'Se déconnecter';

  @override
  String get drawerBooking => 'Réservation';

  @override
  String get dialogDone => 'Terminé';

  @override
  String get paymentContinue => 'Continuer vers le paiement';

  @override
  String profileEditLabel(String label) {
    return 'Modifier $label';
  }

  @override
  String profileLabelUpdated(String label) {
    return '$label mis à jour';
  }

  @override
  String get profileSave => 'Enregistrer';

  @override
  String get hotelBook => 'Réserver';

  @override
  String get hotelConfirmBooking => 'Confirmer la Réservation';

  @override
  String get hotelBooked => 'Hôtel Réservé !';

  @override
  String get vanRent => 'Louer';

  @override
  String get vanConfirmRental => 'Confirmer la Location';

  @override
  String get vanRentalConfirmed => 'Location Confirmée !';

  @override
  String get authGoogleSignIn => 'Connexion Google : bientôt en phase 6';

  @override
  String get settingsSave => 'Enregistrer les Paramètres';

  @override
  String get settingsSaved => 'Paramètres enregistrés avec succès';

  @override
  String settingsErrorSaving(String error) {
    return 'Erreur lors de l\'enregistrement des paramètres : $error';
  }

  @override
  String settingsFeatureComing(String feature) {
    return '$feature : bientôt en phase 6';
  }

  @override
  String get settingsAccountDeletion =>
      'Suppression de compte : TODO en phase 6';

  @override
  String ticketDetail(String id) {
    return 'Ticket $id : vue détaillée TODO';
  }

  @override
  String get availableFlightsPerPerson => 'Vols disponibles par personne';

  @override
  String availableFlightsTotal(String currency, String price) {
    return 'Total des vols disponibles';
  }

  @override
  String get ticketsFlightSingular => 'Vol';

  @override
  String get ticketsFlightPlural => 'Vols';

  @override
  String get ticketsNoHotelBookings => 'Aucune réservation d\'hôtel';

  @override
  String get ticketsNoVehicleBookings => 'Aucune réservation de véhicule';

  @override
  String get ticketsCheckIn => 'Enregistrement';

  @override
  String get ticketsCheckOut => 'Départ';

  @override
  String get ticketsGuests => 'Invités';

  @override
  String get hotelSelectDestination => 'Sélectionner une destination';

  @override
  String get hotelDuration => 'Durée';

  @override
  String get hotelRoomType => 'Type de chambre';

  @override
  String hotelRoomsLabel(int count) {
    return 'Chambres';
  }

  @override
  String hotelGuestsLabel(int count) {
    return 'Hôtes';
  }

  @override
  String vanPricePerDay(String currency, String price) {
    return 'Prix par jour';
  }

  @override
  String vanDays(int count) {
    return 'Jours';
  }

  @override
  String get vanFeatures => 'Caractéristiques';

  @override
  String get vanDuration => 'Durée';

  @override
  String get dialogTotal => 'Total';

  @override
  String get servicesFree => 'Gratuit';

  @override
  String servicesPricePerPerson(String currency, String price) {
    return 'Prix par personne';
  }

  @override
  String get flightDetailsBookingCreating => 'Création de la réservation';

  @override
  String get flightDetailsPolicies => 'Politiques';

  @override
  String get flightDetailsDateChange => 'Changement de date';

  @override
  String get flightDetailsRefundableWithFee => 'Remboursable avec frais';

  @override
  String get flightDetailsAllowedWithFee => 'Autorisé avec frais';

  @override
  String get flightDetailsChangeDate => 'Modifier la date';

  @override
  String get profilePhotoUpcoming => 'Photo à venir';
}
