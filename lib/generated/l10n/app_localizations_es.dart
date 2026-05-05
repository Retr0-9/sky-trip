// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Sky Trip';

  @override
  String get appVersion => 'SkyTrip v1.0.0';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName';
  }

  @override
  String get homeReady => '¿Listo para tu próxima aventura?';

  @override
  String get homeRecentSearches => 'Búsquedas Recientes';

  @override
  String get homeLatestOffers => 'Últimas Ofertas';

  @override
  String get homeFeaturedDestinations => 'Destinos Destacados';

  @override
  String get homeSeeAll => 'Ver Todo';

  @override
  String get bookingTitle => 'Reservar un Vuelo';

  @override
  String get bookingTripRoundtrip => 'Ida y Vuelta';

  @override
  String get bookingTripOneWay => 'Solo Ida';

  @override
  String get bookingTripMultiCity => 'Multiciudad';

  @override
  String get bookingFromLabel => 'Desde';

  @override
  String get bookingToLabel => 'Hacia';

  @override
  String get bookingSearchCity => 'Buscar ciudad…';

  @override
  String get bookingDepartureDate => 'Salida';

  @override
  String get bookingReturnDate => 'Regreso';

  @override
  String get bookingAdults => 'Adultos';

  @override
  String get bookingYouth => 'Jóvenes';

  @override
  String get bookingChildren => 'Niños';

  @override
  String get bookingInfants => 'Bebés';

  @override
  String get bookingClass => 'Clase';

  @override
  String get bookingPassengers => 'Pasajeros';

  @override
  String get bookingSearch => 'Buscar Vuelos';

  @override
  String get bookingNoFlightsFound => 'No se encontraron vuelos';

  @override
  String get bookingTryAnother => 'Intenta otra búsqueda';

  @override
  String get bookingSubtitle => '¿A dónde te gustaría ir hoy?';

  @override
  String get bookingDepartureCityHint => 'Ciudad de salida';

  @override
  String get bookingArrivalCityHint => 'Ciudad de llegada';

  @override
  String get bookingSelectDate => 'Seleccionar fecha';

  @override
  String get bookingSelectReturnDate => 'Seleccionar fecha de regreso';

  @override
  String get bookingSelectClass => 'Seleccionar clase';

  @override
  String get bookingErrorSelectCities =>
      'Por favor selecciona ciudad de salida y llegada.';

  @override
  String get bookingErrorDifferentCities =>
      'La ciudad de salida y la de llegada deben ser diferentes.';

  @override
  String get bookingErrorSelectDeparture =>
      'Por favor selecciona una fecha de salida.';

  @override
  String get bookingErrorSelectReturn =>
      'Por favor selecciona una fecha de regreso.';

  @override
  String get bookingErrorSearchFailed =>
      'La búsqueda falló. Por favor intenta de nuevo.';

  @override
  String bookingPassengersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pasajeros',
      one: '1 pasajero',
    );
    return '$_temp0';
  }

  @override
  String get bookingAdultSubtext => '12+ años';

  @override
  String get bookingYouthSubtext => '2–11 años';

  @override
  String get bookingChildrenSubtext => 'Menos de 2';

  @override
  String get bookingInfantsSubtext => 'Bebé en el regazo';

  @override
  String get greetingMorning => 'Buenos días';

  @override
  String get greetingAfternoon => 'Buenas tardes';

  @override
  String get greetingEvening => 'Buenas noches';

  @override
  String get dialogRetry => 'Reintentar';

  @override
  String get authSignIn => 'Iniciar Sesión';

  @override
  String get authSignUp => 'Registrarse';

  @override
  String get authEmail => 'Correo Electrónico';

  @override
  String get authPassword => 'Contraseña';

  @override
  String get authConfirmPassword => 'Confirmar Contraseña';

  @override
  String get authFirstName => 'Nombre';

  @override
  String get authLastName => 'Apellido';

  @override
  String get authStaffId => 'ID de Personal';

  @override
  String get authErrorEmail => 'Ingrese un correo electrónico válido.';

  @override
  String get authErrorPassword =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get authErrorRequired => 'Ingrese su correo electrónico y contraseña.';

  @override
  String get authErrorComingSoon =>
      'Registro próximamente. Por favor inicie sesión.';

  @override
  String get authErrorGeneric => 'Algo salió mal. Inténtelo de nuevo.';

  @override
  String get authHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get authNoAccount => '¿No tienes una cuenta?';

  @override
  String get authStaffMode => 'Modo Personal';

  @override
  String get availableFlightsTitle => 'Vuelos Disponibles';

  @override
  String get availableFlightsPax => 'pasajeros';

  @override
  String get availableFlightsEmpty => 'No hay vuelos disponibles';

  @override
  String get availableFlightsNoResults =>
      'Ningún vuelo coincide con tu búsqueda';

  @override
  String get flightDetailsTitle => 'Detalles del Vuelo';

  @override
  String get flightDetailsFareBreakdown => 'Desglose de Tarifas';

  @override
  String get flightDetailsBaseFare => 'Tarifa Base';

  @override
  String flightDetailsBaseFareDetail(int pax, String currency, String price) {
    return 'Tarifa Base ($pax pasajeros × $currency $price)';
  }

  @override
  String get flightDetailsTaxes => 'Impuestos y Tarifas (15%)';

  @override
  String get flightDetailsTotal => 'Precio Total';

  @override
  String get flightDetailsBaggage => 'Equipaje Permitido';

  @override
  String get flightDetailsBaggageCarry => '1 Equipaje de Mano';

  @override
  String get flightDetailsBaggageChecked => 'Equipaje Facturado';

  @override
  String get flightDetailsBaggageEconomy =>
      'Economy: 1 equipaje de mano (7kg) + 1 maleta facturada (23kg)';

  @override
  String get flightDetailsBaggageBusiness =>
      'Business: 1 equipaje de mano (10kg) + 2 maletas facturadas (32kg cada una)';

  @override
  String get flightDetailsCancellation => 'Política de Cancelación';

  @override
  String get flightDetailsConfirm => 'Continuar a Pasajeros';

  @override
  String get flightDetailsErrorCreating =>
      'No se pudo crear la reserva. Inténtelo de nuevo.';

  @override
  String get passengersFormTitle => 'Información del Pasajero';

  @override
  String passengersFormPassenger(int number) {
    return 'Pasajero $number';
  }

  @override
  String get passengersFormFirstName => 'Nombre';

  @override
  String get passengersFormLastName => 'Apellido';

  @override
  String get passengersFormEmail => 'Correo Electrónico';

  @override
  String get passengersFormPhone => 'Teléfono';

  @override
  String get passengersFormDOB => 'Fecha de Nacimiento';

  @override
  String get passengersFormGender => 'Género';

  @override
  String get passengersFormMale => 'Masculino';

  @override
  String get passengersFormFemale => 'Femenino';

  @override
  String get passengersFormDocument => 'Documento de Viaje';

  @override
  String get passengersFormPassport => 'Pasaporte';

  @override
  String get passengersFormDocumentIssue => 'Emitido por País';

  @override
  String get passengersFormSearchCountry => 'Buscar país…';

  @override
  String get passengersFormExpiry => 'Fecha de Expiración';

  @override
  String get passengersFormContinue => 'Continuar a Servicios';

  @override
  String get servicesTitle => 'Servicios Opcionales';

  @override
  String get servicesEnhance => 'Mejora Tu Viaje';

  @override
  String get servicesSubtitle =>
      'Agrega servicios extra para hacer tu viaje más cómodo';

  @override
  String get servicesTotal => 'Total de servicios:';

  @override
  String get servicesCurrency => 'JOD';

  @override
  String get servicesSkip => 'Omitir Servicios';

  @override
  String get servicesContinue => 'Continuar a Selección de Asientos';

  @override
  String get servicesNoAvailable => 'No hay servicios disponibles.';

  @override
  String get servicesLoadError => 'No se pudieron cargar los servicios.';

  @override
  String get servicesRetry => 'Reintentar';

  @override
  String get servicesErrorSaving =>
      'No se pudieron guardar los servicios. Inténtelo de nuevo.';

  @override
  String get seatMapTitle => 'Selecciona Tu Asiento';

  @override
  String get seatMapAvailable => 'Disponible';

  @override
  String get seatMapOccupied => 'Ocupado';

  @override
  String get seatMapSelected => 'Seleccionado';

  @override
  String get seatMapContinue => 'Confirmar Selección de Asiento';

  @override
  String get paymentTitle => 'Pago';

  @override
  String get paymentBookingSummary => 'Resumen de Reserva';

  @override
  String get paymentOrderDetails => 'Detalles del Pedido';

  @override
  String get paymentFlightDetails => 'Detalles del Vuelo';

  @override
  String get paymentPassengers => 'Pasajeros';

  @override
  String get paymentBaseFare => 'Tarifa Base';

  @override
  String get paymentTaxes => 'Impuestos y Tarifas';

  @override
  String get paymentServicesFee => 'Servicios';

  @override
  String get paymentTotal => 'Total';

  @override
  String get paymentGrandTotal => 'Total General';

  @override
  String get paymentStripeInfo => 'Protegido por Stripe';

  @override
  String get paymentProceed => 'Proceder al Pago';

  @override
  String get paymentStart => 'Iniciar Pago';

  @override
  String get paymentErrorTicketId =>
      'Falta ID de ticket — reinicie la reserva.';

  @override
  String get paymentErrorSession => 'No se pudo crear la sesión de pago.';

  @override
  String get paymentErrorOpen => 'No se pudo abrir la página de pago.';

  @override
  String get paymentCurrency => 'JOD';

  @override
  String get paymentSuccessTitle => '¡Reserva Confirmada!';

  @override
  String get paymentSuccessMessage =>
      'Tu pago fue exitoso y tu reserva está confirmada. Ver tu ticket en la pestaña Tickets.';

  @override
  String get paymentSuccessGoHome => 'Ir al Inicio';

  @override
  String get paymentSuccessViewTickets => 'Ver Tickets';

  @override
  String get ticketsUpcoming => 'Próximos';

  @override
  String get ticketsPast => 'Pasados';

  @override
  String get ticketsNoUpcoming => 'No hay vuelos próximos';

  @override
  String get ticketsNoPast => 'No hay vuelos pasados';

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
  String get profileTitle => 'Perfil';

  @override
  String get profilePersonalInfo => 'Información Personal';

  @override
  String get profileFullName => 'Nombre Completo';

  @override
  String get profileEmail => 'Correo Electrónico';

  @override
  String get profilePhone => 'Teléfono';

  @override
  String get profileNationality => 'Nacionalidad';

  @override
  String get profileTravelDocs => 'Documentos de Viaje';

  @override
  String get profilePassport => 'Número de Pasaporte';

  @override
  String get profilePreferredClass => 'Clase Preferida';

  @override
  String get profileLoyalty => 'Viajero Frecuente';

  @override
  String get profileStats => 'Estadísticas de Viaje';

  @override
  String get profileFlights => 'Vuelos';

  @override
  String get profileMiles => 'Millas';

  @override
  String get profileTier => 'Nivel';

  @override
  String get profilePhotoUpload => 'Subida de Foto: Próximamente en Fase 6';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsFlightUpdates => 'Actualizaciones de Vuelo';

  @override
  String get settingsFlightUpdatesDesc =>
      'Cambios de puerta, retrasos y cancelaciones';

  @override
  String get settingsPriceAlerts => 'Alertas de Precio';

  @override
  String get settingsPriceAlertsDesc =>
      'Recibe notificaciones cuando bajen los precios';

  @override
  String get settingsBookingReminders => 'Recordatorios de Reserva';

  @override
  String get settingsBookingRemindersDesc => '24h antes de la salida';

  @override
  String get settingsPromotions => 'Promociones y Ofertas';

  @override
  String get settingsPromotionsDesc => 'Ofertas, descuentos y promociones';

  @override
  String get settingsSmsAlerts => 'Alertas SMS';

  @override
  String get settingsSmsAlertsDesc => 'Recibir alertas por mensaje de texto';

  @override
  String get settingsDisplay => 'Pantalla e Idioma';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsCurrency => 'Moneda';

  @override
  String get settingsDarkMode => 'Modo Oscuro';

  @override
  String get settingsDarkModeDesc => 'Cambiar a tema oscuro';

  @override
  String get settingsPrivacy => 'Privacidad y Seguridad';

  @override
  String get settingsChangePassword => 'Cambiar Contraseña';

  @override
  String get settingsBiometric => 'Inicio Biométrico';

  @override
  String get settingsBiometricDesc => 'Usar huella o Face ID';

  @override
  String get settingsShareData => 'Compartir Datos de Uso';

  @override
  String get settingsShareDataDesc => 'Ayúdanos a mejorar la app';

  @override
  String get ticketsHotels => 'Hoteles';

  @override
  String get ticketsVehicles => 'Vehículos';

  @override
  String get settingsAccount => 'Cuenta';

  @override
  String get settingsDeleteAccount => 'Eliminar Cuenta';

  @override
  String get settingsDeleteAccountDesc => 'Eliminar permanentemente tus datos';

  @override
  String get settingsAppVersion => 'Versión de la App';

  @override
  String get settingsLogout => 'Cerrar Sesión';

  @override
  String get settingsComingSoon => 'Próximamente en Fase 6';

  @override
  String get settingsSelectLanguage => 'Seleccionar Idioma';

  @override
  String get settingsSelectCurrency => 'Seleccionar Moneda';

  @override
  String get hotelTitle => 'Reservar Hotel';

  @override
  String get hotelSearch => 'Buscar Hoteles';

  @override
  String get hotelWhere => '¿A dónde vas?';

  @override
  String get hotelDestination => 'Ciudad destino o nombre del hotel';

  @override
  String get hotelCheckIn => 'Check-in';

  @override
  String get hotelCheckOut => 'Check-out';

  @override
  String get hotelRooms => 'Habitaciones';

  @override
  String get hotelGuests => 'Huéspedes';

  @override
  String get hotelEmptyMessage => 'Encuentra tu estancia perfecta';

  @override
  String get hotelEmptySubtitle => 'Ingresa un destino para buscar hoteles';

  @override
  String hotelHotelsIn(int count, String destination) {
    return '$count hoteles en $destination';
  }

  @override
  String hotelNights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count noches',
      one: '1 noche',
    );
    return '$_temp0';
  }

  @override
  String get hotelErrorDestination => 'Por favor ingrese un destino';

  @override
  String get vanTitle => 'Alquiler de Van';

  @override
  String get vanFind => 'Buscar Vehículos';

  @override
  String get vanPickupLocation => 'Recogida';

  @override
  String get vanDropLocation => 'Entrega';

  @override
  String get vanPickupDate => 'Fecha de Recogida';

  @override
  String get vanReturnDate => 'Fecha de Devolución';

  @override
  String get vanEmptyMessage => 'Encuentra el vehículo perfecto';

  @override
  String get vanEmptySubtitle =>
      'Selecciona ubicaciones para ver vehículos disponibles';

  @override
  String vanVehiclesAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vehículos disponibles',
      one: '1 vehículo disponible',
    );
    return '$_temp0';
  }

  @override
  String get vanNoVehicles => 'No hay vehículos en esta categoría';

  @override
  String get vanErrorPickup => 'Seleccione un punto de recogida';

  @override
  String get contactUsTitle => 'Contáctanos';

  @override
  String get contactGetInTouch => 'Ponte en Contacto';

  @override
  String get contactCall => 'Llámanos';

  @override
  String get contactCallNumber => '+962 6 510 0000';

  @override
  String get contactEmail => 'Envíanos un Email';

  @override
  String get contactEmailAddress => 'support@skytrip.com';

  @override
  String get contactChat => 'Chat en Vivo';

  @override
  String get contactChatAvailable => 'Disponible 24/7';

  @override
  String get contactSendMessage => 'Enviar un Mensaje';

  @override
  String get contactSubject => 'Asunto';

  @override
  String get contactMessage => 'Mensaje';

  @override
  String get contactSend => 'Enviar Mensaje';

  @override
  String get contactFaq => 'FAQ';

  @override
  String contactOpening(String type) {
    return 'Abriendo $type…';
  }

  @override
  String get contactSuccess => '¡Mensaje enviado! Responderemos en 24 horas.';

  @override
  String get contactComing => 'Chat en vivo: Próximamente en Fase 6';

  @override
  String get dialogCancel => 'Cancelar';

  @override
  String get dialogOk => 'OK';

  @override
  String get dialogConfirm => 'Confirmar';

  @override
  String get dialogCannotCancel => '¿Cancelar Reserva?';

  @override
  String get dialogCancelBookingDesc =>
      'Tienes una reserva en progreso. Si sales ahora perderás tus selecciones.';

  @override
  String get dialogKeepGoing => 'Continuar';

  @override
  String get dialogLogout => 'Cerrar Sesión';

  @override
  String get dialogLogoutConfirm => '¿Seguro que deseas cerrar sesión?';

  @override
  String get dialogDeleteAccount => 'Eliminar Cuenta';

  @override
  String get dialogDeleteAccountConfirm =>
      '¿Eliminar permanentemente todos tus datos? Esta acción no se puede deshacer.';

  @override
  String get drawerHotel => 'Reservar Hotel';

  @override
  String get drawerVanRental => 'Alquiler de Van';

  @override
  String get drawerSettings => 'Configuración';

  @override
  String get drawerContactUs => 'Contáctanos';

  @override
  String get drawerAbout => 'Acerca de';

  @override
  String get drawerWelcome => 'Bienvenido';

  @override
  String drawerWelcomeName(String name) {
    return 'Bienvenido, $name';
  }

  @override
  String get drawerLogout => 'Cerrar Sesión';

  @override
  String get drawerBooking => 'Reservas';

  @override
  String get dialogDone => 'Hecho';

  @override
  String get paymentContinue => 'Continuar al pago';

  @override
  String profileEditLabel(String label) {
    return 'Editar $label';
  }

  @override
  String profileLabelUpdated(String label) {
    return '$label actualizado';
  }

  @override
  String get profileSave => 'Guardar';

  @override
  String get hotelBook => 'Reservar';

  @override
  String get hotelConfirmBooking => 'Confirmar Reserva';

  @override
  String get hotelBooked => '¡Hotel Reservado!';

  @override
  String get vanRent => 'Alquilar';

  @override
  String get vanConfirmRental => 'Confirmar Alquiler';

  @override
  String get vanRentalConfirmed => '¡Alquiler Confirmado!';

  @override
  String get authGoogleSignIn =>
      'Inicio de Sesión con Google: Próximamente en Fase 6';

  @override
  String get settingsSave => 'Guardar Configuración';

  @override
  String get settingsSaved => 'Configuración guardada exitosamente';

  @override
  String settingsErrorSaving(String error) {
    return 'Error guardando configuración: $error';
  }

  @override
  String settingsFeatureComing(String feature) {
    return '$feature: Próximamente en Fase 6';
  }

  @override
  String get settingsAccountDeletion => 'Eliminación de cuenta: TODO en Fase 6';

  @override
  String ticketDetail(String id) {
    return 'Ticket $id: Vista de detalles TODO';
  }

  @override
  String get availableFlightsPerPerson => 'per person';

  @override
  String availableFlightsTotal(String currency, String price) {
    return 'Total: $currency $price';
  }

  @override
  String get ticketsFlightSingular => 'Vuelo';

  @override
  String get ticketsFlightPlural => 'Vuelos';

  @override
  String get ticketsNoHotelBookings => 'No hay reservas de hoteles';

  @override
  String get ticketsNoVehicleBookings => 'No hay reservas de vehículos';

  @override
  String get ticketsCheckIn => 'Registro de entrada';

  @override
  String get ticketsCheckOut => 'Salida';

  @override
  String get ticketsGuests => 'Huéspedes';

  @override
  String get hotelSelectDestination => 'Select Destination';

  @override
  String get hotelDuration => 'Duration';

  @override
  String get hotelRoomType => 'Room Type';

  @override
  String hotelRoomsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'rooms',
      one: 'room',
    );
    return '$_temp0';
  }

  @override
  String hotelGuestsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'guests',
      one: 'guest',
    );
    return '$_temp0';
  }

  @override
  String vanPricePerDay(String currency, String price) {
    return '$currency $price/day';
  }

  @override
  String vanDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get vanFeatures => 'Features';

  @override
  String get vanDuration => 'Duration';

  @override
  String get dialogTotal => 'Total';

  @override
  String get servicesFree => 'Free';

  @override
  String servicesPricePerPerson(String currency, String price) {
    return '$currency $price per person';
  }

  @override
  String get flightDetailsBookingCreating => 'Creating Booking...';

  @override
  String get flightDetailsPolicies => 'Policies';

  @override
  String get flightDetailsDateChange => 'Date Change';

  @override
  String get flightDetailsRefundableWithFee => 'Refundable with fee';

  @override
  String get flightDetailsAllowedWithFee => 'Allowed with fee';

  @override
  String get flightDetailsChangeDate => 'Date Change';

  @override
  String get profilePhotoUpcoming => 'Photo upload: Coming in Phase 6';
}
