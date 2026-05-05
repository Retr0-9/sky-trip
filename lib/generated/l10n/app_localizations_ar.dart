// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'سكاي تريب';

  @override
  String get appVersion => 'SkyTrip v1.0.0';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting، $firstName';
  }

  @override
  String get homeReady => 'جاهز لمغامرتك القادمة؟';

  @override
  String get homeRecentSearches => 'عمليات البحث الأخيرة';

  @override
  String get homeLatestOffers => 'أحدث العروض';

  @override
  String get homeFeaturedDestinations => 'وجهات مميزة';

  @override
  String get homeSeeAll => 'عرض الكل';

  @override
  String get bookingTitle => 'حجز رحلة طيران';

  @override
  String get bookingTripRoundtrip => 'ذهاب وعودة';

  @override
  String get bookingTripOneWay => 'ذهاب فقط';

  @override
  String get bookingTripMultiCity => 'مدن متعددة';

  @override
  String get bookingFromLabel => 'من';

  @override
  String get bookingToLabel => 'إلى';

  @override
  String get bookingSearchCity => 'ابحث عن مدينة…';

  @override
  String get bookingDepartureDate => 'تاريخ المغادرة';

  @override
  String get bookingReturnDate => 'تاريخ العودة';

  @override
  String get bookingAdults => 'بالغون';

  @override
  String get bookingYouth => 'شباب';

  @override
  String get bookingChildren => 'أطفال';

  @override
  String get bookingInfants => 'رضّع';

  @override
  String get bookingClass => 'الدرجة';

  @override
  String get bookingPassengers => 'الركاب';

  @override
  String get bookingSearch => 'بحث عن رحلات';

  @override
  String get bookingNoFlightsFound => 'لم يتم العثور على رحلات';

  @override
  String get bookingTryAnother => 'جرّب بحثًا آخر';

  @override
  String get bookingSubtitle => 'إلى أي وجهة تريد الذهاب اليوم؟';

  @override
  String get bookingDepartureCityHint => 'مدينة المغادرة';

  @override
  String get bookingArrivalCityHint => 'مدينة الوصول';

  @override
  String get bookingSelectDate => 'اختر التاريخ';

  @override
  String get bookingSelectReturnDate => 'اختر تاريخ العودة';

  @override
  String get bookingSelectClass => 'اختر الدرجة';

  @override
  String get bookingErrorSelectCities => 'يرجى تحديد مدينتي المغادرة والوصول.';

  @override
  String get bookingErrorDifferentCities =>
      'يجب أن تكون مدينتا المغادرة والوصول مختلفتين.';

  @override
  String get bookingErrorSelectDeparture => 'يرجى اختيار تاريخ المغادرة.';

  @override
  String get bookingErrorSelectReturn => 'يرجى اختيار تاريخ العودة.';

  @override
  String get bookingErrorSearchFailed => 'فشل البحث. حاول مرة أخرى.';

  @override
  String bookingPassengersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ركاب',
      one: 'راكب واحد',
    );
    return '$_temp0';
  }

  @override
  String get bookingAdultSubtext => '12 سنة أو أكثر';

  @override
  String get bookingYouthSubtext => '2–11 سنة';

  @override
  String get bookingChildrenSubtext => 'أقل من سنتين';

  @override
  String get bookingInfantsSubtext => 'رضيع في حضن الأم';

  @override
  String get greetingMorning => 'صباح الخير';

  @override
  String get greetingAfternoon => 'مساء الخير';

  @override
  String get greetingEvening => 'مساء الخير';

  @override
  String get dialogRetry => 'إعادة المحاولة';

  @override
  String get authSignIn => 'تسجيل الدخول';

  @override
  String get authSignUp => 'إنشاء حساب';

  @override
  String get authEmail => 'البريد الإلكتروني';

  @override
  String get authPassword => 'كلمة المرور';

  @override
  String get authConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get authFirstName => 'الاسم الأول';

  @override
  String get authLastName => 'اسم العائلة';

  @override
  String get authStaffId => 'رقم الموظف';

  @override
  String get authErrorEmail => 'أدخل بريدًا إلكترونيًا صالحًا.';

  @override
  String get authErrorPassword => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل.';

  @override
  String get authErrorRequired => 'أدخل البريد الإلكتروني وكلمة المرور.';

  @override
  String get authErrorComingSoon => 'التسجيل قريبًا. يرجى تسجيل الدخول.';

  @override
  String get authErrorGeneric => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get authHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get authNoAccount => 'ليس لديك حساب؟';

  @override
  String get authStaffMode => 'وضع الموظف';

  @override
  String get availableFlightsTitle => 'الرحلات المتاحة';

  @override
  String get availableFlightsPax => 'راكب';

  @override
  String get availableFlightsEmpty => 'لا توجد رحلات متاحة';

  @override
  String get availableFlightsNoResults => 'لا توجد رحلات مطابقة لبحثك';

  @override
  String get flightDetailsTitle => 'تفاصيل الرحلة';

  @override
  String get flightDetailsFareBreakdown => 'تفصيل السعر';

  @override
  String get flightDetailsBaseFare => 'السعر الأساسي';

  @override
  String flightDetailsBaseFareDetail(int pax, String currency, String price) {
    return 'السعر الأساسي ($pax راكب × $currency $price)';
  }

  @override
  String get flightDetailsTaxes => 'الضرائب والرسوم (15%)';

  @override
  String get flightDetailsTotal => 'السعر الإجمالي';

  @override
  String get flightDetailsBaggage => 'الأمتعة المسموح بها';

  @override
  String get flightDetailsBaggageCarry => 'حقيبة يد واحدة';

  @override
  String get flightDetailsBaggageChecked => 'الأمتعة المسجلة';

  @override
  String get flightDetailsBaggageEconomy =>
      'الدرجة الاقتصادية: حقيبة يد (7 كجم) + حقيبة مسجلة (23 كجم)';

  @override
  String get flightDetailsBaggageBusiness =>
      'درجة رجال الأعمال: حقيبة يد (10 كجم) + حقيبتان مسجلتان (32 كجم لكل منهما)';

  @override
  String get flightDetailsCancellation => 'سياسة الإلغاء';

  @override
  String get flightDetailsConfirm => 'متابعة إلى الركاب';

  @override
  String get flightDetailsErrorCreating =>
      'تعذر إنشاء الحجز. يرجى المحاولة مرة أخرى.';

  @override
  String get passengersFormTitle => 'معلومات الركاب';

  @override
  String passengersFormPassenger(int number) {
    return 'الراكب $number';
  }

  @override
  String get passengersFormFirstName => 'الاسم الأول';

  @override
  String get passengersFormLastName => 'اسم العائلة';

  @override
  String get passengersFormEmail => 'البريد الإلكتروني';

  @override
  String get passengersFormPhone => 'رقم الهاتف';

  @override
  String get passengersFormDOB => 'تاريخ الميلاد';

  @override
  String get passengersFormGender => 'الجنس';

  @override
  String get passengersFormMale => 'ذكر';

  @override
  String get passengersFormFemale => 'أنثى';

  @override
  String get passengersFormDocument => 'وثيقة السفر';

  @override
  String get passengersFormPassport => 'جواز السفر';

  @override
  String get passengersFormDocumentIssue => 'بلد الإصدار';

  @override
  String get passengersFormSearchCountry => 'ابحث عن دولة…';

  @override
  String get passengersFormExpiry => 'تاريخ الانتهاء';

  @override
  String get passengersFormContinue => 'متابعة إلى الخدمات';

  @override
  String get servicesTitle => 'الخدمات الاختيارية';

  @override
  String get servicesEnhance => 'حسّن رحلتك';

  @override
  String get servicesSubtitle => 'أضف خدمات إضافية لجعل رحلتك أكثر راحة';

  @override
  String get servicesTotal => 'إجمالي الخدمات:';

  @override
  String get servicesCurrency => 'دينار أردني';

  @override
  String get servicesSkip => 'تخطي الخدمات';

  @override
  String get servicesContinue => 'متابعة لاختيار المقعد';

  @override
  String get servicesNoAvailable => 'لا توجد خدمات متاحة.';

  @override
  String get servicesLoadError => 'تعذر تحميل الخدمات.';

  @override
  String get servicesRetry => 'إعادة المحاولة';

  @override
  String get servicesErrorSaving => 'تعذر حفظ الخدمات. حاول مرة أخرى.';

  @override
  String get seatMapTitle => 'اختر مقعدك';

  @override
  String get seatMapAvailable => 'متاح';

  @override
  String get seatMapOccupied => 'محجوز';

  @override
  String get seatMapSelected => 'محدد';

  @override
  String get seatMapContinue => 'تأكيد اختيار المقعد';

  @override
  String get paymentTitle => 'الدفع';

  @override
  String get paymentBookingSummary => 'ملخص الحجز';

  @override
  String get paymentOrderDetails => 'تفاصيل الطلب';

  @override
  String get paymentFlightDetails => 'تفاصيل الرحلة';

  @override
  String get paymentPassengers => 'الركاب';

  @override
  String get paymentBaseFare => 'السعر الأساسي';

  @override
  String get paymentTaxes => 'الضرائب والرسوم';

  @override
  String get paymentServicesFee => 'الخدمات';

  @override
  String get paymentTotal => 'الإجمالي';

  @override
  String get paymentGrandTotal => 'الإجمالي النهائي';

  @override
  String get paymentStripeInfo => 'محمي بواسطة Stripe';

  @override
  String get paymentProceed => 'المتابعة إلى الدفع';

  @override
  String get paymentStart => 'بدء الدفع';

  @override
  String get paymentErrorTicketId => 'معرّف التذكرة مفقود — يرجى إعادة الحجز.';

  @override
  String get paymentErrorSession => 'تعذر إنشاء جلسة الدفع. حاول مرة أخرى.';

  @override
  String get paymentErrorOpen => 'تعذر فتح صفحة الدفع.';

  @override
  String get paymentCurrency => 'دينار أردني';

  @override
  String get paymentSuccessTitle => 'تم تأكيد الحجز!';

  @override
  String get paymentSuccessMessage =>
      'تم الدفع بنجاح وتم تأكيد حجزك. يمكنك عرض تذكرتك في تبويب التذاكر.';

  @override
  String get paymentSuccessGoHome => 'العودة للرئيسية';

  @override
  String get paymentSuccessViewTickets => 'عرض التذاكر';

  @override
  String get ticketsUpcoming => 'القادمة';

  @override
  String get ticketsPast => 'السابقة';

  @override
  String get ticketsNoUpcoming => 'لا توجد رحلات قادمة';

  @override
  String get ticketsNoPast => 'لا توجد رحلات سابقة';

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
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profilePersonalInfo => 'المعلومات الشخصية';

  @override
  String get profileFullName => 'الاسم الكامل';

  @override
  String get profileEmail => 'البريد الإلكتروني';

  @override
  String get profilePhone => 'رقم الهاتف';

  @override
  String get profileNationality => 'الجنسية';

  @override
  String get profileTravelDocs => 'وثائق السفر';

  @override
  String get profilePassport => 'رقم جواز السفر';

  @override
  String get profilePreferredClass => 'الدرجة المفضلة';

  @override
  String get profileLoyalty => 'المسافر الدائم';

  @override
  String get profileStats => 'إحصائيات السفر';

  @override
  String get profileFlights => 'الرحلات';

  @override
  String get profileMiles => 'الأميال';

  @override
  String get profileTier => 'المستوى';

  @override
  String get profilePhotoUpload => 'رفع الصورة: قريبًا في المرحلة 6';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsNotifications => 'الإشعارات';

  @override
  String get settingsFlightUpdates => 'تحديثات الرحلات';

  @override
  String get settingsFlightUpdatesDesc => 'تغيير البوابة، التأخير والإلغاء';

  @override
  String get settingsPriceAlerts => 'تنبيهات الأسعار';

  @override
  String get settingsPriceAlertsDesc => 'احصل على إشعار عند انخفاض الأسعار';

  @override
  String get settingsBookingReminders => 'تذكيرات الحجز';

  @override
  String get settingsBookingRemindersDesc => 'قبل 24 ساعة من المغادرة';

  @override
  String get settingsPromotions => 'العروض والتخفيضات';

  @override
  String get settingsPromotionsDesc => 'عروض وخصومات موسمية';

  @override
  String get settingsSmsAlerts => 'تنبيهات الرسائل';

  @override
  String get settingsSmsAlertsDesc => 'استلام التنبيهات عبر الرسائل النصية';

  @override
  String get settingsDisplay => 'العرض واللغة';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsCurrency => 'العملة';

  @override
  String get settingsDarkMode => 'الوضع الداكن';

  @override
  String get settingsDarkModeDesc => 'التبديل إلى الوضع الداكن';

  @override
  String get settingsPrivacy => 'الخصوصية والأمان';

  @override
  String get settingsChangePassword => 'تغيير كلمة المرور';

  @override
  String get settingsBiometric => 'تسجيل الدخول بالبصمة';

  @override
  String get settingsBiometricDesc => 'استخدام البصمة أو Face ID';

  @override
  String get settingsShareData => 'مشاركة بيانات الاستخدام';

  @override
  String get settingsShareDataDesc => 'ساعدنا على تحسين التطبيق';

  @override
  String get ticketsHotels => 'الفنادق';

  @override
  String get ticketsVehicles => 'المركبات';

  @override
  String get settingsAccount => 'الحساب';

  @override
  String get settingsDeleteAccount => 'حذف الحساب';

  @override
  String get settingsDeleteAccountDesc => 'حذف بياناتك بشكل دائم';

  @override
  String get settingsAppVersion => 'إصدار التطبيق';

  @override
  String get settingsLogout => 'تسجيل الخروج';

  @override
  String get settingsComingSoon => 'قريبًا في المرحلة 6';

  @override
  String get settingsSelectLanguage => 'اختر اللغة';

  @override
  String get settingsSelectCurrency => 'اختر العملة';

  @override
  String get hotelTitle => 'حجز فندق';

  @override
  String get hotelSearch => 'البحث عن فنادق';

  @override
  String get hotelWhere => 'إلى أين؟';

  @override
  String get hotelDestination => 'مدينة الوجهة أو اسم الفندق';

  @override
  String get hotelCheckIn => 'تسجيل الدخول';

  @override
  String get hotelCheckOut => 'تسجيل الخروج';

  @override
  String get hotelRooms => 'الغرف';

  @override
  String get hotelGuests => 'الضيوف';

  @override
  String get hotelEmptyMessage => 'اعثر على إقامتك المثالية';

  @override
  String get hotelEmptySubtitle => 'أدخل وجهة للبحث عن الفنادق';

  @override
  String hotelHotelsIn(int count, String destination) {
    return '$count فندق في $destination';
  }

  @override
  String hotelNights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ليال',
      one: 'ليلة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get hotelErrorDestination => 'يرجى إدخال وجهة';

  @override
  String get vanTitle => 'تأجير فان';

  @override
  String get vanFind => 'البحث عن المركبات';

  @override
  String get vanPickupLocation => 'مكان الاستلام';

  @override
  String get vanDropLocation => 'مكان التسليم';

  @override
  String get vanPickupDate => 'تاريخ الاستلام';

  @override
  String get vanReturnDate => 'تاريخ الإرجاع';

  @override
  String get vanEmptyMessage => 'اعثر على المركبة المثالية';

  @override
  String get vanEmptySubtitle => 'حدد المواقع لعرض المركبات المتاحة';

  @override
  String vanVehiclesAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مركبات متاحة',
      one: 'مركبة واحدة متاحة',
    );
    return '$_temp0';
  }

  @override
  String get vanNoVehicles => 'لا توجد مركبات في هذه الفئة';

  @override
  String get vanErrorPickup => 'يرجى اختيار مكان الاستلام';

  @override
  String get contactUsTitle => 'اتصل بنا';

  @override
  String get contactGetInTouch => 'تواصل معنا';

  @override
  String get contactCall => 'اتصل بنا';

  @override
  String get contactCallNumber => '+962 6 510 0000';

  @override
  String get contactEmail => 'راسلنا عبر البريد';

  @override
  String get contactEmailAddress => 'support@skytrip.com';

  @override
  String get contactChat => 'الدردشة المباشرة';

  @override
  String get contactChatAvailable => 'متاح 24/7';

  @override
  String get contactSendMessage => 'إرسال رسالة';

  @override
  String get contactSubject => 'الموضوع';

  @override
  String get contactMessage => 'الرسالة';

  @override
  String get contactSend => 'إرسال الرسالة';

  @override
  String get contactFaq => 'الأسئلة الشائعة';

  @override
  String contactOpening(String type) {
    return 'جاري فتح $type…';
  }

  @override
  String get contactSuccess => 'تم إرسال الرسالة! سنرد خلال 24 ساعة.';

  @override
  String get contactComing => 'الدردشة المباشرة: قريبًا في المرحلة 6';

  @override
  String get dialogCancel => 'إلغاء';

  @override
  String get dialogOk => 'موافق';

  @override
  String get dialogConfirm => 'تأكيد';

  @override
  String get dialogCannotCancel => 'إلغاء الحجز؟';

  @override
  String get dialogCancelBookingDesc =>
      'لديك حجز قيد التنفيذ. المغادرة الآن ستفقد جميع اختياراتك.';

  @override
  String get dialogKeepGoing => 'متابعة';

  @override
  String get dialogLogout => 'تسجيل الخروج';

  @override
  String get dialogLogoutConfirm => 'هل أنت متأكد من تسجيل الخروج؟';

  @override
  String get dialogDeleteAccount => 'حذف الحساب';

  @override
  String get dialogDeleteAccountConfirm =>
      'حذف جميع بياناتك بشكل دائم؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get drawerHotel => 'حجز فندق';

  @override
  String get drawerVanRental => 'تأجير فان';

  @override
  String get drawerSettings => 'الإعدادات';

  @override
  String get drawerContactUs => 'اتصل بنا';

  @override
  String get drawerAbout => 'حول التطبيق';

  @override
  String get drawerWelcome => 'مرحبًا';

  @override
  String drawerWelcomeName(String name) {
    return 'مرحبًا، $name';
  }

  @override
  String get drawerLogout => 'تسجيل الخروج';

  @override
  String get drawerBooking => 'الحجز';

  @override
  String get dialogDone => 'تم';

  @override
  String get paymentContinue => 'متابعة إلى الدفع';

  @override
  String profileEditLabel(String label) {
    return 'تعديل $label';
  }

  @override
  String profileLabelUpdated(String label) {
    return '$label محدث';
  }

  @override
  String get profileSave => 'حفظ';

  @override
  String get hotelBook => 'حجز';

  @override
  String get hotelConfirmBooking => 'تأكيد الحجز';

  @override
  String get hotelBooked => 'تم حجز الفندق!';

  @override
  String get vanRent => 'تأجير';

  @override
  String get vanConfirmRental => 'تأكيد التأجير';

  @override
  String get vanRentalConfirmed => 'تم تأكيد التأجير!';

  @override
  String get authGoogleSignIn => 'تسجيل الدخول بـ Google: قريبًا في المرحلة 6';

  @override
  String get settingsSave => 'حفظ الإعدادات';

  @override
  String get settingsSaved => 'تم حفظ الإعدادات بنجاح';

  @override
  String settingsErrorSaving(String error) {
    return 'خطأ في حفظ الإعدادات: $error';
  }

  @override
  String settingsFeatureComing(String feature) {
    return '$feature: قريبًا في المرحلة 6';
  }

  @override
  String get settingsAccountDeletion => 'حذف الحساب: TODO في المرحلة 6';

  @override
  String ticketDetail(String id) {
    return 'التذكرة $id: عرض التفاصيل TODO';
  }

  @override
  String get availableFlightsPerPerson => 'لكل راكب';

  @override
  String availableFlightsTotal(String currency, String price) {
    return 'الإجمالي: $currency $price';
  }

  @override
  String get ticketsFlightSingular => 'رحلة';

  @override
  String get ticketsFlightPlural => 'رحلات';

  @override
  String get ticketsNoHotelBookings => 'لا توجد حجوزات فنادق';

  @override
  String get ticketsNoVehicleBookings => 'لا توجد حجوزات مركبات';

  @override
  String get ticketsCheckIn => 'تسجيل الوصول';

  @override
  String get ticketsCheckOut => 'تسجيل المغادرة';

  @override
  String get ticketsGuests => 'ضيوف';

  @override
  String get hotelSelectDestination => 'اختر الوجهة';

  @override
  String get hotelDuration => 'المدة';

  @override
  String get hotelRoomType => 'نوع الغرفة';

  @override
  String hotelRoomsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count غرف',
      one: 'غرفة واحدة',
    );
    return '$_temp0';
  }

  @override
  String hotelGuestsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ضيوف',
      one: 'ضيف واحد',
    );
    return '$_temp0';
  }

  @override
  String vanPricePerDay(String currency, String price) {
    return '$currency $price/يوم';
  }

  @override
  String vanDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أيام',
      one: 'يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String get vanFeatures => 'المميزات';

  @override
  String get vanDuration => 'المدة';

  @override
  String get dialogTotal => 'الإجمالي';

  @override
  String get servicesFree => 'مجاني';

  @override
  String servicesPricePerPerson(String currency, String price) {
    return '$currency $price لكل راكب';
  }

  @override
  String get flightDetailsBookingCreating => 'جاري إنشاء الحجز...';

  @override
  String get flightDetailsPolicies => 'السياسات';

  @override
  String get flightDetailsDateChange => 'تغيير التاريخ';

  @override
  String get flightDetailsRefundableWithFee => 'قابل للاسترداد برسم';

  @override
  String get flightDetailsAllowedWithFee => 'مسموح برسم';

  @override
  String get flightDetailsChangeDate => 'تغيير التاريخ';

  @override
  String get profilePhotoUpcoming => 'رفع الصورة: قريبًا في المرحلة 6';
}
