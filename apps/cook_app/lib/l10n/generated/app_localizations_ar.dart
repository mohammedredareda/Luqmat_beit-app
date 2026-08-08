// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get myMenuTitle => 'قائمتي';

  @override
  String get myMenuSubtitle => 'إدارة أطباقك وتوفرها للعملاء.';

  @override
  String get saleStatusLabel => 'حالة البيع';

  @override
  String get saleStatusActive => 'مفعّل - جاهز لاستقبال الطلبات';

  @override
  String get saleStatusPaused => 'متوقف - غير متاح للطلبات';

  @override
  String get emptyMenuHeading => 'قائمتك فارغة';

  @override
  String get emptyMenuBody => 'ابدأ بإضافة أول وجبة لمطبخك ليراها الزبائن.';

  @override
  String get addMealCta => 'إضافة وجبة';

  @override
  String get outOfStockBadge => 'نفدت الكمية';

  @override
  String get stopSellingDialogTitle => 'إيقاف البيع؟';

  @override
  String get stopSellingDialogBody =>
      'لن يتمكن الزبائن من طلب أي وجبة من قائمتك حتى تُعيد تفعيل البيع يدويًا.';

  @override
  String get resumeSellingDialogTitle => 'تفعيل البيع؟';

  @override
  String get resumeSellingDialogBody =>
      'سيتمكن الزبائن من طلب وجباتك المتاحة مجددًا.';

  @override
  String get confirmLabel => 'تأكيد';

  @override
  String get cancelLabel => 'إلغاء';

  @override
  String get navMenu => 'القائمة';

  @override
  String get navOrders => 'الطلبات';

  @override
  String get navOffers => 'العروض';

  @override
  String get navAccount => 'حسابي';

  @override
  String get comingSoon => 'قريباً';

  @override
  String get retryLabel => 'إعادة المحاولة';

  @override
  String get genericErrorMessage => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get editMealTitle => 'تعديل الوجبة';

  @override
  String get deleteMealTitle => 'حذف الوجبة';

  @override
  String get addMealTitle => 'إضافة وجبة';

  @override
  String get mealImagePickerHint => 'أضف صورة للوجبة';

  @override
  String get changeMealImageCta => 'تغيير الصورة';

  @override
  String get basicInfoSectionTitle => 'المعلومات الأساسية';

  @override
  String get mealNameLabel => 'اسم الوجبة';

  @override
  String get mealNameHint => 'مثال: ورق عنب باللحمة';

  @override
  String get descriptionLabel => 'الوصف';

  @override
  String get descriptionHint =>
      'اكتب وصفاً شهياً لمكونات الوجبة وطريقة التحضير...';

  @override
  String get categorySectionTitle => 'التصنيف';

  @override
  String get categoryMainDishes => 'وجبات رئيسية';

  @override
  String get categoryPastries => 'معجنات';

  @override
  String get categoryDesserts => 'حلويات';

  @override
  String get categoryAppetizers => 'مقبلات';

  @override
  String get categoryBeverages => 'مشروبات';

  @override
  String get preorderTimeLabel => 'الطلب المسبق';

  @override
  String get preorderHoursUnit => 'ساعة';

  @override
  String get pricingSectionTitle => 'التسعير والخيارات';

  @override
  String get sellWithVariationsToggle => 'خيارات بيع';

  @override
  String get priceLabel => 'السعر';

  @override
  String get currencySuffix => 'ل.س';

  @override
  String get variationSizeHint => 'الحجم (مثال: صغير)';

  @override
  String get addVariationCta => 'إضافة خيار آخر';

  @override
  String get validationRequiredField => 'هذا الحقل مطلوب';

  @override
  String get validationZeroVariations => 'أضف خياراً واحداً على الأقل';

  @override
  String get validationNonPositivePrice => 'يجب أن يكون السعر أكبر من صفر';

  @override
  String get validationImageTooLarge => 'حجم الصورة يتجاوز 10 ميجابايت';

  @override
  String get availabilitySectionTitle => 'متاح للطلب';

  @override
  String get availabilityHelperText => 'إظهار الوجبة للعملاء في القائمة';

  @override
  String get saveMealChangesCta => 'حفظ التعديلات';

  @override
  String get deleteMealConfirmTitle => 'حذف الوجبة؟';

  @override
  String get deleteMealConfirmBody =>
      'هذا الإجراء سيقوم بإخفاء الوجبة من قائمتك. لن تظهر للعملاء الجدد، وسيتم إشعار العملاء الذين لديهم طلبات مسبقة لهذه الوجبة.';

  @override
  String get confirmDeleteCta => 'تأكيد الحذف';

  @override
  String get startingFromLabel => 'يبدأ من';

  @override
  String get offersTitle => 'العروض';

  @override
  String get offersSubtitle => 'إدارة الخصومات والباقات لجذب المزيد من الزبائن';

  @override
  String get emptyOffersHeading => 'لا توجد عروض أو خصومات بعد';

  @override
  String get emptyOffersBody => 'أنشئ أول عرض أو خصم لجذب المزيد من الزبائن';

  @override
  String get addOfferOrDiscountCta => 'إضافة عرض جديد';

  @override
  String offerExpiresInLabel(int days) {
    return 'ينتهي في $days يوم';
  }

  @override
  String get offerExpiredLabel => 'منتهي';

  @override
  String get offerBadgeLabel => 'عرض باقة';

  @override
  String discountBadgeLabel(String percentage) {
    return 'خصم $percentage٪';
  }

  @override
  String get selectOfferTypeSheetTitle => 'اختيار نوع العرض';

  @override
  String get createOfferOptionTitle => 'إنشاء عرض';

  @override
  String get createOfferOptionBody =>
      'إنشاء عروض ترويجية لمجموعة مختارة من الوجبات.';

  @override
  String get createDiscountOptionTitle => 'إنشاء خصم';

  @override
  String get createDiscountOptionBody =>
      'إنشاء خصومات بنسبة مئوية أو قيمة ثابتة.';

  @override
  String get selectMealPopupTitle => 'اختيار الوجبة';

  @override
  String get selectMealSearchHint => 'ابحث عن وجبة...';

  @override
  String get selectMealAvailableLabel => 'الوجبات المتاحة للعرض';

  @override
  String get selectMealEmptyResults => 'لا توجد نتائج مطابقة';

  @override
  String get selectSellingOptionDialogTitle => 'اختر خيار البيع';

  @override
  String get mealNameFieldLabel => 'اسم الوجبة';

  @override
  String get sellingOptionsListLabel => 'خيارات البيع';

  @override
  String get confirmSellingOptionCta => 'تأكيد';

  @override
  String get createOfferTitle => 'إنشاء عرض جديد';

  @override
  String get editOfferTitle => 'تعديل العرض';

  @override
  String get offerImagePickerHint => 'أضف صورة للعرض (اختياري)';

  @override
  String get changeOfferImageCta => 'تغيير الصورة';

  @override
  String get offerNameLabel => 'اسم العرض';

  @override
  String get offerNameHint => 'مثال: عرض الغداء العائلي';

  @override
  String get offerDescriptionLabel => 'وصف العرض (اختياري)';

  @override
  String get offerDescriptionHint => 'اكتب وصفاً جذاباً لعرضك...';

  @override
  String get includedMealsSectionTitle => 'الوجبات المشمولة';

  @override
  String includedMealsCountLabel(int count) {
    return '$count وجبات';
  }

  @override
  String get includedMealsEmptyBody => 'لم تقم بإضافة أي وجبات لهذا العرض بعد';

  @override
  String get addDishCta => 'إضافة طبق';

  @override
  String get offerTotalPriceLabel => 'سعر العرض الإجمالي';

  @override
  String get offerDurationDaysLabel => 'عدد الأيام';

  @override
  String get offerStatusSectionTitle => 'حالة العرض';

  @override
  String get offerStatusHelperText => 'تفعيل العرض ليظهر للعملاء فوراً';

  @override
  String get saveOfferCta => 'حفظ العرض';

  @override
  String get saveOfferChangesCta => 'حفظ التغييرات';

  @override
  String get deleteOfferTitle => 'حذف العرض';

  @override
  String get remainingDaysLabel => 'المدة المتبقية';

  @override
  String remainingDaysValue(int days) {
    return 'متبقي $days يوم';
  }

  @override
  String get updateDurationLabel => 'تحديث المدة (أيام)';

  @override
  String get validationZeroMeals => 'أضف طبقاً واحداً على الأقل';

  @override
  String get createDiscountTitle => 'إنشاء خصم جديد';

  @override
  String get editDiscountTitle => 'تعديل الخصم';

  @override
  String get editDiscountSubtitle => 'قم بتحديث إعدادات الخصم الخاص بك';

  @override
  String get selectMealFieldLabel => 'اختر الوجبة';

  @override
  String get discountTargetMealLabel => 'المنتج المستهدف';

  @override
  String get discountPercentageLabel => 'نسبة الخصم';

  @override
  String get discountPriceAfterLabel => 'السعر بعد الخصم';

  @override
  String get discountPricesAfterPerOptionLabel =>
      'الأسعار بعد الخصم (حسب خيارات البيع)';

  @override
  String get restrictionTypeLabel => 'تحديد نوع القيد';

  @override
  String get restrictionByDurationLabel => 'حسب المدة';

  @override
  String get restrictionByUsageLabel => 'حسب الاستخدام';

  @override
  String get usageLimitFieldLabel => 'أقصى عدد للاستخدام';

  @override
  String get usageLimitHint => 'مثال: 50';

  @override
  String get remainingUsageLabel => 'الاستخدامات المتبقية';

  @override
  String remainingUsageValue(int count) {
    return 'متبقي $count مرة';
  }

  @override
  String get updateUsageLimitLabel => 'تحديث الحد (مرات)';

  @override
  String get saveDiscountCta => 'حفظ الخصم';

  @override
  String get saveDiscountChangesCta => 'حفظ التعديلات';

  @override
  String get deleteDiscountTitle => 'حذف الخصم';

  @override
  String get validationPercentageOutOfRange => 'النسبة يجب أن تكون بين 0 و 100';

  @override
  String get validationMealRequired => 'يرجى اختيار وجبة';

  @override
  String get validationRestrictionRequired =>
      'يرجى تحديد المدة أو عدد الاستخدامات';

  @override
  String get deleteOfferConfirmTitle => 'حذف العرض؟';

  @override
  String get deleteOfferConfirmBody =>
      'سيتم حذف هذا العرض نهائياً ولن يظهر للعملاء بعد الآن';

  @override
  String get deleteDiscountConfirmTitle => 'حذف الخصم؟';

  @override
  String get deleteDiscountConfirmBody =>
      'سيتم حذف هذا الخصم نهائياً ولن يُطبق على الوجبة بعد الآن';

  @override
  String get filterAllLabel => 'الكل';

  @override
  String get filterActiveLabel => 'نشط';

  @override
  String get filterExpiredLabel => 'منتهي';

  @override
  String get discountDetailsSectionTitle => 'تفاصيل الخصم';

  @override
  String get validityTypeLabel => 'نوع الصلاحية';

  @override
  String get createRestrictionByDurationLabel => 'المدة بالأيام';

  @override
  String get createRestrictionByUsageLabel => 'عدد مرات الاستخدام';

  @override
  String discountPricesAfterCaption(String percentage) {
    return 'يتم احتساب هذه الأسعار بناءً على نسبة الخصم ($percentage٪) المحددة أعلاه';
  }

  @override
  String get daysUnitSuffix => 'يوم';

  @override
  String get usesUnitSuffix => 'مرة';

  @override
  String get selectMealAddCta => 'إضافة';

  @override
  String profileRatingLabel(String rating, int count) {
    return '$rating ($count تقييم)';
  }

  @override
  String get completedOrdersStatLabel => 'الطلبات المكتملة';

  @override
  String get totalMealsStatLabel => 'إجمالي الوجبات';

  @override
  String get phoneNumberStatLabel => 'رقم الهاتف';

  @override
  String get statsComingSoonLabel => 'الإحصائيات قريباً';

  @override
  String get aboutMeSectionTitle => 'نبذة عني';

  @override
  String get availabilityHoursSectionTitle => 'أوقات التوفر';

  @override
  String get addressSectionTitle => 'العنوان';

  @override
  String get editProfileCta => 'تعديل الملف الشخصي';

  @override
  String get editProfileTitle => 'تعديل الملف الشخصي';

  @override
  String get changePhotoCta => 'تغيير الصورة';

  @override
  String get cropAvatarTitle => 'قص الصورة';

  @override
  String get cropAvatarHint =>
      'اسحب للتحريك وقرّب/بعّد لتحديد الجزء الذي سيظهر داخل الإطار';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get fullNameHint => 'أدخل اسمك الكامل';

  @override
  String get bioLabel => 'نبذة عني';

  @override
  String get bioHint => 'اكتب نبذة مختصرة عنك وعن خبرتك في الطبخ...';

  @override
  String get addressLabel => 'العنوان';

  @override
  String get addressHint => 'أدخل عنوانك بالتفصيل';

  @override
  String get availabilityDaysFieldLabel => 'أيام التوفر';

  @override
  String get availabilityHoursFieldLabel => 'ساعات التوفر';

  @override
  String get saveProfileChangesCta => 'حفظ التغييرات';

  @override
  String get weekdaySunday => 'الأحد';

  @override
  String get weekdayMonday => 'الاثنين';

  @override
  String get weekdayTuesday => 'الثلاثاء';

  @override
  String get weekdayWednesday => 'الأربعاء';

  @override
  String get weekdayThursday => 'الخميس';

  @override
  String get weekdayFriday => 'الجمعة';

  @override
  String get weekdaySaturday => 'السبت';

  @override
  String get availabilityFromLabel => 'من';

  @override
  String get availabilityToLabel => 'إلى';

  @override
  String get amLabel => 'ص';

  @override
  String get pmLabel => 'م';

  @override
  String get validationZeroAvailabilityDays => 'اختر يوماً واحداً على الأقل';

  @override
  String get validationInvalidAvailabilityRange =>
      'وقت الانتهاء يجب أن يكون بعد وقت البدء';

  @override
  String get myOrdersTitle => 'طلباتي';

  @override
  String get myOrdersSubtitle => 'إدارة وتتبع مسار الطلبات الحالية والسابقة.';

  @override
  String get orderDetailsTitle => 'تفاصيل الطلب';

  @override
  String get ordersTabNew => 'طلب جديد';

  @override
  String get ordersTabInProgress => 'قيد التحضير';

  @override
  String get ordersTabCompleted => 'منجز';

  @override
  String get ordersTabRejected => 'مرفوض';

  @override
  String get orderStatusPending => 'قيد الانتظار';

  @override
  String get orderStatusPreparing => 'قيد التحضير';

  @override
  String get orderStatusDone => 'منجز';

  @override
  String get orderStatusRejected => 'مرفوض';

  @override
  String get orderStatusCancelled => 'ملغى';

  @override
  String orderNumberLabel(String id) {
    return 'طلب #$id';
  }

  @override
  String moreItemsLabel(int count) {
    return '+ $count عنصر إضافي';
  }

  @override
  String get customerLabel => 'العميل';

  @override
  String get deliveryMethodLabel => 'طريقة الاستلام';

  @override
  String get pickupMethodValue => 'استلام من المنزل';

  @override
  String get deliveryMethodValue => 'توصيل';

  @override
  String get orderItemsSectionTitle => 'عناصر الطلب';

  @override
  String quantityLabel(int count) {
    return 'الكمية: $count';
  }

  @override
  String get returnedItemBadge => 'مسترجع';

  @override
  String itemNoteLabel(String note) {
    return 'ملاحظة: $note';
  }

  @override
  String get orderSummaryTitle => 'ملخص الطلب';

  @override
  String get subtotalLabel => 'المجموع الفرعي';

  @override
  String get discountLabel => 'الخصم';

  @override
  String get totalLabel => 'الإجمالي';

  @override
  String get orderDetailsCta => 'التفاصيل';

  @override
  String get acceptOrderCta => 'قبول الطلب';

  @override
  String get rejectOrderCta => 'رفض';

  @override
  String get markPreparedCta => 'تم التحضير';

  @override
  String get preparingDoneBannerBody =>
      'بالضغط على «تم التحضير»، سيتم إرسال إشعار للعميل للقدوم لاستلام الطلب.';

  @override
  String rejectOrderDialogTitle(String id) {
    return 'رفض الطلب #$id؟';
  }

  @override
  String get rejectOrderConfirmCta => 'رفض الطلب';

  @override
  String get rejectionReasonLabel => 'سبب الرفض';

  @override
  String get rejectionReasonHint => 'اكتب سبب رفض هذا الطلب...';

  @override
  String get rejectionReasonRequiredError => 'يرجى كتابة سبب الرفض';

  @override
  String get orderExpiredOnAcceptMessage =>
      'عذراً، لقد انتهت مهلة الطلب وتم إلغاؤه تلقائياً.';

  @override
  String get orderCancelledAutomaticallyBanner =>
      'تم إلغاء هذا الطلب تلقائياً بسبب انتهاء مهلة الاستجابة.';

  @override
  String get orderAcceptedSuccessMessage => 'تم قبول الطلب بنجاح';

  @override
  String get orderRejectedSuccessMessage => 'تم رفض الطلب';

  @override
  String get orderCompletedSuccessMessage => 'تم تحديد الطلب كجاهز بنجاح';

  @override
  String get okLabel => 'حسناً';

  @override
  String get emptyOrdersPendingHeading => 'لا توجد طلبات جديدة';

  @override
  String get emptyOrdersPendingBody =>
      'ستظهر الطلبات الجديدة هنا بمجرد وصولها.';

  @override
  String get emptyOrdersPreparingHeading => 'لا توجد طلبات قيد التحضير';

  @override
  String get emptyOrdersPreparingBody =>
      'الطلبات التي تقبلها ستظهر هنا أثناء تحضيرها.';

  @override
  String get emptyOrdersDoneHeading => 'لا توجد طلبات منجزة بعد';

  @override
  String get emptyOrdersDoneBody => 'الطلبات التي تُنهي تحضيرها ستظهر هنا.';

  @override
  String get emptyOrdersRejectedHeading => 'لا توجد طلبات مرفوضة';

  @override
  String get emptyOrdersRejectedBody => 'الطلبات التي ترفضها ستظهر هنا.';

  @override
  String get orderCardNewBadge => 'طلب جديد';

  @override
  String get timeAgoJustNow => 'الآن';

  @override
  String timeAgoMinutesAgo(int minutes) {
    return 'منذ $minutes دقيقة';
  }

  @override
  String timeAgoHoursAgo(int hours) {
    return 'منذ $hours ساعة';
  }

  @override
  String timeAgoDaysAgo(int days) {
    return 'منذ $days يوم';
  }

  @override
  String get endOfListNewLabel => 'لا توجد طلبات جديدة أخرى.';

  @override
  String get endOfListInProgressLabel => 'لا توجد طلبات أخرى قيد التحضير.';

  @override
  String get endOfListCompletedLabel => 'لا توجد طلبات منجزة أخرى.';

  @override
  String get endOfListRejectedLabel => 'لا توجد طلبات مرفوضة أخرى.';

  @override
  String selectedOptionLabel(String label) {
    return 'الخيار: $label';
  }

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get accountSettingsSectionTitle => 'إعدادات الحساب';

  @override
  String get changePhoneNumberRowTitle => 'تغيير رقم الهاتف';

  @override
  String get changePasswordRowTitle => 'تغيير كلمة المرور';

  @override
  String get preferencesSectionTitle => 'التفضيلات';

  @override
  String get languageLabel => 'اللغة';

  @override
  String get arabicLanguageOption => 'العربية';

  @override
  String get englishLanguageOption => 'الإنجليزية';

  @override
  String get darkModeLabel => 'الوضع الداكن';

  @override
  String get logoutConfirmTitle => 'تسجيل الخروج؟';

  @override
  String get logoutConfirmBody =>
      'سيتم تسجيل خروجك من التطبيق. يمكنك تسجيل الدخول مرة أخرى في أي وقت.';

  @override
  String get logoutCta => 'تسجيل الخروج';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get changePasswordTitle => 'تغيير كلمة المرور';

  @override
  String get changePasswordHeading => 'تحديث بيانات الأمان';

  @override
  String get changePasswordDescription =>
      'يرجى إدخال كلمة المرور الحالية ثم تعيين كلمة مرور جديدة قوية.';

  @override
  String get currentPasswordLabel => 'كلمة المرور الحالية';

  @override
  String get currentPasswordIncorrectError => 'كلمة المرور الحالية غير صحيحة';

  @override
  String get newPasswordLabel => 'كلمة المرور الجديدة';

  @override
  String get confirmNewPasswordLabel => 'تأكيد كلمة المرور الجديدة';

  @override
  String get passwordMismatchError => 'كلمات المرور غير متطابقة';

  @override
  String get passwordComplexityError =>
      'يجب أن تحتوي على 8 أحرف على الأقل مع حرف كبير وصغير ورقم ورمز';

  @override
  String get updatePasswordCta => 'تحديث كلمة المرور';

  @override
  String get passwordUpdatedSuccessMessage => 'تم تحديث كلمة المرور بنجاح';

  @override
  String get passwordStrengthHint => 'يجب أن تحتوي على 8 أحرف على الأقل';

  @override
  String get passwordStrengthWeak => 'ضعيفة - أضف أرقام ورموز';

  @override
  String get passwordStrengthMedium => 'متوسطة - يمكن أن تكون أقوى';

  @override
  String get passwordStrengthGood => 'جيدة - أضف المزيد من الرموز';

  @override
  String get passwordStrengthVeryStrong => 'قوية جداً';

  @override
  String get changePhoneNumberTitle => 'تغيير رقم الهاتف';

  @override
  String get changePhoneNumberHeading => 'تحديث رقم الهاتف';

  @override
  String get changePhoneNumberDescription =>
      'يرجى إدخال رقم الهاتف الجديد، سنرسل لك رمز تحقق للتأكيد.';

  @override
  String get newPhoneNumberLabel => 'رقم الهاتف الجديد';

  @override
  String get newPhoneNumberHelper =>
      'تأكد من إدخال الرقم بشكل صحيح لتلقي الرمز';

  @override
  String get sendVerificationCodeCta => 'إرسال رمز التحقق';

  @override
  String get phoneNumberInvalidError =>
      'يرجى إدخال رقم هاتف صحيح مكون من 9 أرقام';

  @override
  String get otpVerificationTitle => 'رمز التحقق';

  @override
  String get otpSentHeading => 'تم إرسال رمز التحقق';

  @override
  String get otpSentDescription =>
      'لقد قمنا بإرسال رمز مكون من 4 أرقام إلى رقم هاتفك الجديد';

  @override
  String get resendCodePrompt => 'لم تستلم الرمز؟';

  @override
  String get resendCodeCta => 'إعادة الإرسال';

  @override
  String get verifyCta => 'تحقق';

  @override
  String get otpIncorrectError => 'الرمز غير صحيح، يرجى المحاولة مرة أخرى';
}
