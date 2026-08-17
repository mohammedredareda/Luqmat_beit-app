import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
    Locale('en')
  ];

  /// AppBar title on the My Menu dashboard
  ///
  /// In ar, this message translates to:
  /// **'قائمتي'**
  String get myMenuTitle;

  /// No description provided for @myMenuSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة أطباقك وتوفرها للعملاء.'**
  String get myMenuSubtitle;

  /// No description provided for @saleStatusLabel.
  ///
  /// In ar, this message translates to:
  /// **'حالة البيع'**
  String get saleStatusLabel;

  /// No description provided for @saleStatusActive.
  ///
  /// In ar, this message translates to:
  /// **'مفعّل - جاهز لاستقبال الطلبات'**
  String get saleStatusActive;

  /// No description provided for @saleStatusPaused.
  ///
  /// In ar, this message translates to:
  /// **'متوقف - غير متاح للطلبات'**
  String get saleStatusPaused;

  /// No description provided for @emptyMenuHeading.
  ///
  /// In ar, this message translates to:
  /// **'قائمتك فارغة'**
  String get emptyMenuHeading;

  /// No description provided for @emptyMenuBody.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ بإضافة أول وجبة لمطبخك ليراها الزبائن.'**
  String get emptyMenuBody;

  /// No description provided for @addMealCta.
  ///
  /// In ar, this message translates to:
  /// **'إضافة وجبة'**
  String get addMealCta;

  /// No description provided for @outOfStockBadge.
  ///
  /// In ar, this message translates to:
  /// **'نفدت الكمية'**
  String get outOfStockBadge;

  /// No description provided for @stopSellingDialogTitle.
  ///
  /// In ar, this message translates to:
  /// **'إيقاف البيع؟'**
  String get stopSellingDialogTitle;

  /// No description provided for @stopSellingDialogBody.
  ///
  /// In ar, this message translates to:
  /// **'لن يتمكن الزبائن من طلب أي وجبة من قائمتك حتى تُعيد تفعيل البيع يدويًا.'**
  String get stopSellingDialogBody;

  /// No description provided for @resumeSellingDialogTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل البيع؟'**
  String get resumeSellingDialogTitle;

  /// No description provided for @resumeSellingDialogBody.
  ///
  /// In ar, this message translates to:
  /// **'سيتمكن الزبائن من طلب وجباتك المتاحة مجددًا.'**
  String get resumeSellingDialogBody;

  /// No description provided for @confirmLabel.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirmLabel;

  /// No description provided for @cancelLabel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancelLabel;

  /// No description provided for @navMenu.
  ///
  /// In ar, this message translates to:
  /// **'القائمة'**
  String get navMenu;

  /// No description provided for @navOrders.
  ///
  /// In ar, this message translates to:
  /// **'الطلبات'**
  String get navOrders;

  /// No description provided for @navOffers.
  ///
  /// In ar, this message translates to:
  /// **'العروض'**
  String get navOffers;

  /// No description provided for @navShorts.
  ///
  /// In ar, this message translates to:
  /// **'الشورتس'**
  String get navShorts;

  /// No description provided for @navAccount.
  ///
  /// In ar, this message translates to:
  /// **'حسابي'**
  String get navAccount;

  /// No description provided for @comingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً'**
  String get comingSoon;

  /// No description provided for @retryLabel.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retryLabel;

  /// No description provided for @genericErrorMessage.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ ما. حاول مرة أخرى.'**
  String get genericErrorMessage;

  /// No description provided for @notificationsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notificationsTitle;

  /// No description provided for @editMealTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الوجبة'**
  String get editMealTitle;

  /// No description provided for @deleteMealTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف الوجبة'**
  String get deleteMealTitle;

  /// No description provided for @addMealTitle.
  ///
  /// In ar, this message translates to:
  /// **'إضافة وجبة'**
  String get addMealTitle;

  /// No description provided for @mealImagePickerHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف صورة للوجبة'**
  String get mealImagePickerHint;

  /// No description provided for @changeMealImageCta.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الصورة'**
  String get changeMealImageCta;

  /// No description provided for @basicInfoSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'المعلومات الأساسية'**
  String get basicInfoSectionTitle;

  /// No description provided for @mealNameLabel.
  ///
  /// In ar, this message translates to:
  /// **'اسم الوجبة'**
  String get mealNameLabel;

  /// No description provided for @mealNameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: ورق عنب باللحمة'**
  String get mealNameHint;

  /// No description provided for @descriptionLabel.
  ///
  /// In ar, this message translates to:
  /// **'الوصف'**
  String get descriptionLabel;

  /// No description provided for @descriptionHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب وصفاً شهياً لمكونات الوجبة وطريقة التحضير...'**
  String get descriptionHint;

  /// No description provided for @categorySectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'التصنيف'**
  String get categorySectionTitle;

  /// No description provided for @categoryMainDishes.
  ///
  /// In ar, this message translates to:
  /// **'وجبات رئيسية'**
  String get categoryMainDishes;

  /// No description provided for @categoryPastries.
  ///
  /// In ar, this message translates to:
  /// **'معجنات'**
  String get categoryPastries;

  /// No description provided for @categoryDesserts.
  ///
  /// In ar, this message translates to:
  /// **'حلويات'**
  String get categoryDesserts;

  /// No description provided for @categoryAppetizers.
  ///
  /// In ar, this message translates to:
  /// **'مقبلات'**
  String get categoryAppetizers;

  /// No description provided for @categoryBeverages.
  ///
  /// In ar, this message translates to:
  /// **'مشروبات'**
  String get categoryBeverages;

  /// No description provided for @preorderTimeLabel.
  ///
  /// In ar, this message translates to:
  /// **'الطلب المسبق'**
  String get preorderTimeLabel;

  /// No description provided for @preorderHoursUnit.
  ///
  /// In ar, this message translates to:
  /// **'ساعة'**
  String get preorderHoursUnit;

  /// No description provided for @pricingSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'التسعير والخيارات'**
  String get pricingSectionTitle;

  /// No description provided for @sellWithVariationsToggle.
  ///
  /// In ar, this message translates to:
  /// **'خيارات بيع'**
  String get sellWithVariationsToggle;

  /// No description provided for @priceLabel.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get priceLabel;

  /// No description provided for @currencySuffix.
  ///
  /// In ar, this message translates to:
  /// **'ل.س'**
  String get currencySuffix;

  /// No description provided for @variationSizeHint.
  ///
  /// In ar, this message translates to:
  /// **'الحجم (مثال: صغير)'**
  String get variationSizeHint;

  /// No description provided for @addVariationCta.
  ///
  /// In ar, this message translates to:
  /// **'إضافة خيار آخر'**
  String get addVariationCta;

  /// No description provided for @validationRequiredField.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get validationRequiredField;

  /// No description provided for @validationZeroVariations.
  ///
  /// In ar, this message translates to:
  /// **'أضف خياراً واحداً على الأقل'**
  String get validationZeroVariations;

  /// No description provided for @validationNonPositivePrice.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن يكون السعر أكبر من صفر'**
  String get validationNonPositivePrice;

  /// No description provided for @validationImageTooLarge.
  ///
  /// In ar, this message translates to:
  /// **'حجم الصورة يتجاوز 10 ميجابايت'**
  String get validationImageTooLarge;

  /// No description provided for @availabilitySectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'متاح للطلب'**
  String get availabilitySectionTitle;

  /// No description provided for @availabilityHelperText.
  ///
  /// In ar, this message translates to:
  /// **'إظهار الوجبة للعملاء في القائمة'**
  String get availabilityHelperText;

  /// No description provided for @saveMealChangesCta.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التعديلات'**
  String get saveMealChangesCta;

  /// No description provided for @deleteMealConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف الوجبة؟'**
  String get deleteMealConfirmTitle;

  /// No description provided for @deleteMealConfirmBody.
  ///
  /// In ar, this message translates to:
  /// **'هذا الإجراء سيقوم بإخفاء الوجبة من قائمتك. لن تظهر للعملاء الجدد، وسيتم إشعار العملاء الذين لديهم طلبات مسبقة لهذه الوجبة.'**
  String get deleteMealConfirmBody;

  /// No description provided for @confirmDeleteCta.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الحذف'**
  String get confirmDeleteCta;

  /// No description provided for @startingFromLabel.
  ///
  /// In ar, this message translates to:
  /// **'يبدأ من'**
  String get startingFromLabel;

  /// No description provided for @offersTitle.
  ///
  /// In ar, this message translates to:
  /// **'العروض'**
  String get offersTitle;

  /// No description provided for @offersSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة الخصومات والباقات لجذب المزيد من الزبائن'**
  String get offersSubtitle;

  /// No description provided for @emptyOffersHeading.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد عروض أو خصومات بعد'**
  String get emptyOffersHeading;

  /// No description provided for @emptyOffersBody.
  ///
  /// In ar, this message translates to:
  /// **'أنشئ أول عرض أو خصم لجذب المزيد من الزبائن'**
  String get emptyOffersBody;

  /// No description provided for @addOfferOrDiscountCta.
  ///
  /// In ar, this message translates to:
  /// **'إضافة عرض جديد'**
  String get addOfferOrDiscountCta;

  /// No description provided for @offerExpiresInLabel.
  ///
  /// In ar, this message translates to:
  /// **'ينتهي في {days} يوم'**
  String offerExpiresInLabel(int days);

  /// No description provided for @offerExpiredLabel.
  ///
  /// In ar, this message translates to:
  /// **'منتهي'**
  String get offerExpiredLabel;

  /// No description provided for @discountUsesRemainingLabel.
  ///
  /// In ar, this message translates to:
  /// **'متبقي {count} استخدام'**
  String discountUsesRemainingLabel(int count);

  /// No description provided for @offerNoLimitLabel.
  ///
  /// In ar, this message translates to:
  /// **'بدون حد'**
  String get offerNoLimitLabel;

  /// No description provided for @offerBadgeLabel.
  ///
  /// In ar, this message translates to:
  /// **'عرض باقة'**
  String get offerBadgeLabel;

  /// No description provided for @discountBadgeLabel.
  ///
  /// In ar, this message translates to:
  /// **'خصم {percentage}٪'**
  String discountBadgeLabel(String percentage);

  /// No description provided for @discountBadgeGenericLabel.
  ///
  /// In ar, this message translates to:
  /// **'خصم'**
  String get discountBadgeGenericLabel;

  /// No description provided for @selectOfferTypeSheetTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختيار نوع العرض'**
  String get selectOfferTypeSheetTitle;

  /// No description provided for @createOfferOptionTitle.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء عرض'**
  String get createOfferOptionTitle;

  /// No description provided for @createOfferOptionBody.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء عروض ترويجية لمجموعة مختارة من الوجبات.'**
  String get createOfferOptionBody;

  /// No description provided for @createDiscountOptionTitle.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء خصم'**
  String get createDiscountOptionTitle;

  /// No description provided for @createDiscountOptionBody.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء خصومات بنسبة مئوية أو قيمة ثابتة.'**
  String get createDiscountOptionBody;

  /// No description provided for @selectMealPopupTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختيار الوجبة'**
  String get selectMealPopupTitle;

  /// No description provided for @selectMealSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن وجبة...'**
  String get selectMealSearchHint;

  /// No description provided for @selectMealAvailableLabel.
  ///
  /// In ar, this message translates to:
  /// **'الوجبات المتاحة للعرض'**
  String get selectMealAvailableLabel;

  /// No description provided for @selectMealEmptyResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج مطابقة'**
  String get selectMealEmptyResults;

  /// No description provided for @selectSellingOptionDialogTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر خيار البيع'**
  String get selectSellingOptionDialogTitle;

  /// No description provided for @mealNameFieldLabel.
  ///
  /// In ar, this message translates to:
  /// **'اسم الوجبة'**
  String get mealNameFieldLabel;

  /// No description provided for @sellingOptionsListLabel.
  ///
  /// In ar, this message translates to:
  /// **'خيارات البيع'**
  String get sellingOptionsListLabel;

  /// No description provided for @confirmSellingOptionCta.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirmSellingOptionCta;

  /// No description provided for @createOfferTitle.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء عرض جديد'**
  String get createOfferTitle;

  /// No description provided for @editOfferTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل العرض'**
  String get editOfferTitle;

  /// No description provided for @offerImagePickerHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف صورة للعرض (اختياري)'**
  String get offerImagePickerHint;

  /// No description provided for @changeOfferImageCta.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الصورة'**
  String get changeOfferImageCta;

  /// No description provided for @offerNameLabel.
  ///
  /// In ar, this message translates to:
  /// **'اسم العرض'**
  String get offerNameLabel;

  /// No description provided for @offerNameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: عرض الغداء العائلي'**
  String get offerNameHint;

  /// No description provided for @offerDescriptionLabel.
  ///
  /// In ar, this message translates to:
  /// **'وصف العرض (اختياري)'**
  String get offerDescriptionLabel;

  /// No description provided for @offerDescriptionHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب وصفاً جذاباً لعرضك...'**
  String get offerDescriptionHint;

  /// No description provided for @includedMealsSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'الوجبات المشمولة'**
  String get includedMealsSectionTitle;

  /// No description provided for @includedMealsCountLabel.
  ///
  /// In ar, this message translates to:
  /// **'{count} وجبات'**
  String includedMealsCountLabel(int count);

  /// No description provided for @includedMealsEmptyBody.
  ///
  /// In ar, this message translates to:
  /// **'لم تقم بإضافة أي وجبات لهذا العرض بعد'**
  String get includedMealsEmptyBody;

  /// No description provided for @addDishCta.
  ///
  /// In ar, this message translates to:
  /// **'إضافة طبق'**
  String get addDishCta;

  /// No description provided for @offerTotalPriceLabel.
  ///
  /// In ar, this message translates to:
  /// **'سعر العرض الإجمالي'**
  String get offerTotalPriceLabel;

  /// No description provided for @offerDurationDaysLabel.
  ///
  /// In ar, this message translates to:
  /// **'عدد الأيام'**
  String get offerDurationDaysLabel;

  /// No description provided for @offerStatusSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'حالة العرض'**
  String get offerStatusSectionTitle;

  /// No description provided for @offerStatusHelperText.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل العرض ليظهر للعملاء فوراً'**
  String get offerStatusHelperText;

  /// No description provided for @createOfferCta.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء'**
  String get createOfferCta;

  /// No description provided for @saveOfferChangesCta.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التغييرات'**
  String get saveOfferChangesCta;

  /// No description provided for @deleteOfferTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف العرض'**
  String get deleteOfferTitle;

  /// No description provided for @remainingDaysLabel.
  ///
  /// In ar, this message translates to:
  /// **'المدة المتبقية'**
  String get remainingDaysLabel;

  /// No description provided for @remainingDaysValue.
  ///
  /// In ar, this message translates to:
  /// **'متبقي {days} يوم'**
  String remainingDaysValue(int days);

  /// No description provided for @updateDurationLabel.
  ///
  /// In ar, this message translates to:
  /// **'تحديث المدة (أيام)'**
  String get updateDurationLabel;

  /// No description provided for @validationZeroMeals.
  ///
  /// In ar, this message translates to:
  /// **'أضف طبقاً واحداً على الأقل'**
  String get validationZeroMeals;

  /// No description provided for @createDiscountTitle.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء خصم جديد'**
  String get createDiscountTitle;

  /// No description provided for @editDiscountTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الخصم'**
  String get editDiscountTitle;

  /// No description provided for @editDiscountSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'قم بتحديث إعدادات الخصم الخاص بك'**
  String get editDiscountSubtitle;

  /// No description provided for @selectMealFieldLabel.
  ///
  /// In ar, this message translates to:
  /// **'اختر الوجبة'**
  String get selectMealFieldLabel;

  /// No description provided for @discountTargetMealLabel.
  ///
  /// In ar, this message translates to:
  /// **'المنتج المستهدف'**
  String get discountTargetMealLabel;

  /// No description provided for @discountPercentageLabel.
  ///
  /// In ar, this message translates to:
  /// **'نسبة الخصم'**
  String get discountPercentageLabel;

  /// No description provided for @discountPriceAfterLabel.
  ///
  /// In ar, this message translates to:
  /// **'السعر بعد الخصم'**
  String get discountPriceAfterLabel;

  /// No description provided for @discountPricesAfterPerOptionLabel.
  ///
  /// In ar, this message translates to:
  /// **'الأسعار بعد الخصم (حسب خيارات البيع)'**
  String get discountPricesAfterPerOptionLabel;

  /// No description provided for @restrictionTypeLabel.
  ///
  /// In ar, this message translates to:
  /// **'تحديد نوع القيد'**
  String get restrictionTypeLabel;

  /// No description provided for @restrictionByDurationLabel.
  ///
  /// In ar, this message translates to:
  /// **'حسب المدة'**
  String get restrictionByDurationLabel;

  /// No description provided for @restrictionByUsageLabel.
  ///
  /// In ar, this message translates to:
  /// **'حسب الاستخدام'**
  String get restrictionByUsageLabel;

  /// No description provided for @usageLimitFieldLabel.
  ///
  /// In ar, this message translates to:
  /// **'أقصى عدد للاستخدام'**
  String get usageLimitFieldLabel;

  /// No description provided for @usageLimitHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: 50'**
  String get usageLimitHint;

  /// No description provided for @remainingUsageLabel.
  ///
  /// In ar, this message translates to:
  /// **'الاستخدامات المتبقية'**
  String get remainingUsageLabel;

  /// No description provided for @remainingUsageValue.
  ///
  /// In ar, this message translates to:
  /// **'متبقي {count} مرة'**
  String remainingUsageValue(int count);

  /// No description provided for @updateUsageLimitLabel.
  ///
  /// In ar, this message translates to:
  /// **'تحديث الحد (مرات)'**
  String get updateUsageLimitLabel;

  /// No description provided for @saveDiscountCta.
  ///
  /// In ar, this message translates to:
  /// **'حفظ الخصم'**
  String get saveDiscountCta;

  /// No description provided for @saveDiscountChangesCta.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التعديلات'**
  String get saveDiscountChangesCta;

  /// No description provided for @deleteDiscountTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف الخصم'**
  String get deleteDiscountTitle;

  /// No description provided for @validationPercentageOutOfRange.
  ///
  /// In ar, this message translates to:
  /// **'النسبة يجب أن تكون بين 0 و 100'**
  String get validationPercentageOutOfRange;

  /// No description provided for @validationMealRequired.
  ///
  /// In ar, this message translates to:
  /// **'يرجى اختيار وجبة'**
  String get validationMealRequired;

  /// No description provided for @validationRestrictionRequired.
  ///
  /// In ar, this message translates to:
  /// **'يرجى تحديد المدة أو عدد الاستخدامات'**
  String get validationRestrictionRequired;

  /// No description provided for @deleteOfferConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف العرض؟'**
  String get deleteOfferConfirmTitle;

  /// No description provided for @deleteOfferConfirmBody.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حذف هذا العرض نهائياً ولن يظهر للعملاء بعد الآن'**
  String get deleteOfferConfirmBody;

  /// No description provided for @deleteDiscountConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف الخصم؟'**
  String get deleteDiscountConfirmTitle;

  /// No description provided for @deleteDiscountConfirmBody.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حذف هذا الخصم نهائياً ولن يُطبق على الوجبة بعد الآن'**
  String get deleteDiscountConfirmBody;

  /// No description provided for @filterAllLabel.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get filterAllLabel;

  /// No description provided for @filterActiveLabel.
  ///
  /// In ar, this message translates to:
  /// **'نشط'**
  String get filterActiveLabel;

  /// No description provided for @filterExpiredLabel.
  ///
  /// In ar, this message translates to:
  /// **'منتهي'**
  String get filterExpiredLabel;

  /// No description provided for @discountDetailsSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الخصم'**
  String get discountDetailsSectionTitle;

  /// No description provided for @validityTypeLabel.
  ///
  /// In ar, this message translates to:
  /// **'نوع الصلاحية'**
  String get validityTypeLabel;

  /// No description provided for @createRestrictionByDurationLabel.
  ///
  /// In ar, this message translates to:
  /// **'المدة بالأيام'**
  String get createRestrictionByDurationLabel;

  /// No description provided for @createRestrictionByUsageLabel.
  ///
  /// In ar, this message translates to:
  /// **'عدد مرات الاستخدام'**
  String get createRestrictionByUsageLabel;

  /// No description provided for @discountPricesAfterCaption.
  ///
  /// In ar, this message translates to:
  /// **'يتم احتساب هذه الأسعار بناءً على نسبة الخصم ({percentage}٪) المحددة أعلاه'**
  String discountPricesAfterCaption(String percentage);

  /// No description provided for @daysUnitSuffix.
  ///
  /// In ar, this message translates to:
  /// **'يوم'**
  String get daysUnitSuffix;

  /// No description provided for @usesUnitSuffix.
  ///
  /// In ar, this message translates to:
  /// **'مرة'**
  String get usesUnitSuffix;

  /// No description provided for @selectMealAddCta.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get selectMealAddCta;

  /// No description provided for @profileRatingLabel.
  ///
  /// In ar, this message translates to:
  /// **'{rating} ({count} تقييم)'**
  String profileRatingLabel(String rating, int count);

  /// No description provided for @completedOrdersStatLabel.
  ///
  /// In ar, this message translates to:
  /// **'الطلبات المكتملة'**
  String get completedOrdersStatLabel;

  /// No description provided for @totalMealsStatLabel.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الوجبات'**
  String get totalMealsStatLabel;

  /// No description provided for @phoneNumberStatLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phoneNumberStatLabel;

  /// No description provided for @statsComingSoonLabel.
  ///
  /// In ar, this message translates to:
  /// **'الإحصائيات قريباً'**
  String get statsComingSoonLabel;

  /// No description provided for @aboutMeSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'نبذة عني'**
  String get aboutMeSectionTitle;

  /// No description provided for @availabilityHoursSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'أوقات التوفر'**
  String get availabilityHoursSectionTitle;

  /// No description provided for @addressSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get addressSectionTitle;

  /// No description provided for @editProfileCta.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الملف الشخصي'**
  String get editProfileCta;

  /// No description provided for @editProfileTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الملف الشخصي'**
  String get editProfileTitle;

  /// No description provided for @changePhotoCta.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الصورة'**
  String get changePhotoCta;

  /// No description provided for @cropAvatarTitle.
  ///
  /// In ar, this message translates to:
  /// **'قص الصورة'**
  String get cropAvatarTitle;

  /// No description provided for @cropAvatarHint.
  ///
  /// In ar, this message translates to:
  /// **'اسحب للتحريك وقرّب/بعّد لتحديد الجزء الذي سيظهر داخل الإطار'**
  String get cropAvatarHint;

  /// No description provided for @fullNameLabel.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get fullNameLabel;

  /// No description provided for @fullNameHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسمك الكامل'**
  String get fullNameHint;

  /// No description provided for @bioLabel.
  ///
  /// In ar, this message translates to:
  /// **'نبذة عني'**
  String get bioLabel;

  /// No description provided for @bioHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب نبذة مختصرة عنك وعن خبرتك في الطبخ...'**
  String get bioHint;

  /// No description provided for @addressLabel.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get addressLabel;

  /// No description provided for @addressHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخل عنوانك بالتفصيل'**
  String get addressHint;

  /// No description provided for @detectLocationCta.
  ///
  /// In ar, this message translates to:
  /// **'تحديد'**
  String get detectLocationCta;

  /// No description provided for @detectedLocationHint.
  ///
  /// In ar, this message translates to:
  /// **'سيتم تحديد الموقع تلقائياً'**
  String get detectedLocationHint;

  /// No description provided for @availabilityDaysFieldLabel.
  ///
  /// In ar, this message translates to:
  /// **'أيام التوفر'**
  String get availabilityDaysFieldLabel;

  /// No description provided for @availabilityHoursFieldLabel.
  ///
  /// In ar, this message translates to:
  /// **'ساعات التوفر'**
  String get availabilityHoursFieldLabel;

  /// No description provided for @saveProfileChangesCta.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التغييرات'**
  String get saveProfileChangesCta;

  /// No description provided for @weekdaySunday.
  ///
  /// In ar, this message translates to:
  /// **'الأحد'**
  String get weekdaySunday;

  /// No description provided for @weekdayMonday.
  ///
  /// In ar, this message translates to:
  /// **'الاثنين'**
  String get weekdayMonday;

  /// No description provided for @weekdayTuesday.
  ///
  /// In ar, this message translates to:
  /// **'الثلاثاء'**
  String get weekdayTuesday;

  /// No description provided for @weekdayWednesday.
  ///
  /// In ar, this message translates to:
  /// **'الأربعاء'**
  String get weekdayWednesday;

  /// No description provided for @weekdayThursday.
  ///
  /// In ar, this message translates to:
  /// **'الخميس'**
  String get weekdayThursday;

  /// No description provided for @weekdayFriday.
  ///
  /// In ar, this message translates to:
  /// **'الجمعة'**
  String get weekdayFriday;

  /// No description provided for @weekdaySaturday.
  ///
  /// In ar, this message translates to:
  /// **'السبت'**
  String get weekdaySaturday;

  /// No description provided for @availabilityFromLabel.
  ///
  /// In ar, this message translates to:
  /// **'من'**
  String get availabilityFromLabel;

  /// No description provided for @availabilityToLabel.
  ///
  /// In ar, this message translates to:
  /// **'إلى'**
  String get availabilityToLabel;

  /// No description provided for @amLabel.
  ///
  /// In ar, this message translates to:
  /// **'ص'**
  String get amLabel;

  /// No description provided for @pmLabel.
  ///
  /// In ar, this message translates to:
  /// **'م'**
  String get pmLabel;

  /// No description provided for @validationZeroAvailabilityDays.
  ///
  /// In ar, this message translates to:
  /// **'اختر يوماً واحداً على الأقل'**
  String get validationZeroAvailabilityDays;

  /// No description provided for @validationInvalidAvailabilityRange.
  ///
  /// In ar, this message translates to:
  /// **'وقت الانتهاء يجب أن يكون بعد وقت البدء'**
  String get validationInvalidAvailabilityRange;

  /// No description provided for @myOrdersTitle.
  ///
  /// In ar, this message translates to:
  /// **'طلباتي'**
  String get myOrdersTitle;

  /// No description provided for @myOrdersSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة وتتبع مسار الطلبات الحالية والسابقة.'**
  String get myOrdersSubtitle;

  /// No description provided for @orderDetailsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الطلب'**
  String get orderDetailsTitle;

  /// No description provided for @ordersTabNew.
  ///
  /// In ar, this message translates to:
  /// **'طلب جديد'**
  String get ordersTabNew;

  /// No description provided for @ordersTabInProgress.
  ///
  /// In ar, this message translates to:
  /// **'قيد التحضير'**
  String get ordersTabInProgress;

  /// No description provided for @ordersTabCompleted.
  ///
  /// In ar, this message translates to:
  /// **'منجز'**
  String get ordersTabCompleted;

  /// No description provided for @ordersTabRejected.
  ///
  /// In ar, this message translates to:
  /// **'مرفوض'**
  String get ordersTabRejected;

  /// No description provided for @orderStatusPending.
  ///
  /// In ar, this message translates to:
  /// **'قيد الانتظار'**
  String get orderStatusPending;

  /// No description provided for @orderStatusPreparing.
  ///
  /// In ar, this message translates to:
  /// **'قيد التحضير'**
  String get orderStatusPreparing;

  /// No description provided for @orderStatusDone.
  ///
  /// In ar, this message translates to:
  /// **'منجز'**
  String get orderStatusDone;

  /// No description provided for @orderStatusRejected.
  ///
  /// In ar, this message translates to:
  /// **'مرفوض'**
  String get orderStatusRejected;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In ar, this message translates to:
  /// **'ملغى'**
  String get orderStatusCancelled;

  /// No description provided for @orderNumberLabel.
  ///
  /// In ar, this message translates to:
  /// **'طلب #{id}'**
  String orderNumberLabel(String id);

  /// No description provided for @estimatedPrepTimeLabel.
  ///
  /// In ar, this message translates to:
  /// **'الوقت المتوقع: {minutes} دقيقة'**
  String estimatedPrepTimeLabel(int minutes);

  /// No description provided for @moreItemsLabel.
  ///
  /// In ar, this message translates to:
  /// **'+ {count} عنصر إضافي'**
  String moreItemsLabel(int count);

  /// No description provided for @customerLabel.
  ///
  /// In ar, this message translates to:
  /// **'العميل'**
  String get customerLabel;

  /// No description provided for @deliveryMethodLabel.
  ///
  /// In ar, this message translates to:
  /// **'طريقة الاستلام'**
  String get deliveryMethodLabel;

  /// No description provided for @pickupMethodValue.
  ///
  /// In ar, this message translates to:
  /// **'استلام من المنزل'**
  String get pickupMethodValue;

  /// No description provided for @deliveryMethodValue.
  ///
  /// In ar, this message translates to:
  /// **'توصيل'**
  String get deliveryMethodValue;

  /// No description provided for @orderItemsSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'عناصر الطلب'**
  String get orderItemsSectionTitle;

  /// No description provided for @quantityLabel.
  ///
  /// In ar, this message translates to:
  /// **'الكمية: {count}'**
  String quantityLabel(int count);

  /// No description provided for @returnedItemBadge.
  ///
  /// In ar, this message translates to:
  /// **'مسترجع'**
  String get returnedItemBadge;

  /// No description provided for @itemNoteLabel.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظة: {note}'**
  String itemNoteLabel(String note);

  /// No description provided for @orderSummaryTitle.
  ///
  /// In ar, this message translates to:
  /// **'ملخص الطلب'**
  String get orderSummaryTitle;

  /// No description provided for @subtotalLabel.
  ///
  /// In ar, this message translates to:
  /// **'المجموع الفرعي'**
  String get subtotalLabel;

  /// No description provided for @discountLabel.
  ///
  /// In ar, this message translates to:
  /// **'الخصم'**
  String get discountLabel;

  /// No description provided for @totalLabel.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي'**
  String get totalLabel;

  /// No description provided for @orderDetailsCta.
  ///
  /// In ar, this message translates to:
  /// **'التفاصيل'**
  String get orderDetailsCta;

  /// No description provided for @acceptOrderCta.
  ///
  /// In ar, this message translates to:
  /// **'قبول الطلب'**
  String get acceptOrderCta;

  /// No description provided for @rejectOrderCta.
  ///
  /// In ar, this message translates to:
  /// **'رفض'**
  String get rejectOrderCta;

  /// No description provided for @markPreparedCta.
  ///
  /// In ar, this message translates to:
  /// **'تم التحضير'**
  String get markPreparedCta;

  /// No description provided for @preparingDoneBannerBody.
  ///
  /// In ar, this message translates to:
  /// **'بالضغط على «تم التحضير»، سيتم إرسال إشعار للعميل للقدوم لاستلام الطلب.'**
  String get preparingDoneBannerBody;

  /// No description provided for @rejectOrderDialogTitle.
  ///
  /// In ar, this message translates to:
  /// **'رفض الطلب #{id}؟'**
  String rejectOrderDialogTitle(String id);

  /// No description provided for @rejectOrderConfirmCta.
  ///
  /// In ar, this message translates to:
  /// **'رفض الطلب'**
  String get rejectOrderConfirmCta;

  /// No description provided for @rejectionReasonLabel.
  ///
  /// In ar, this message translates to:
  /// **'سبب الرفض (اختياري)'**
  String get rejectionReasonLabel;

  /// No description provided for @rejectionReasonHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتب سبب رفض هذا الطلب...'**
  String get rejectionReasonHint;

  /// No description provided for @rejectionReasonRequiredError.
  ///
  /// In ar, this message translates to:
  /// **'يرجى كتابة سبب الرفض'**
  String get rejectionReasonRequiredError;

  /// No description provided for @orderExpiredOnAcceptMessage.
  ///
  /// In ar, this message translates to:
  /// **'عذراً، لقد انتهت مهلة الطلب وتم إلغاؤه تلقائياً.'**
  String get orderExpiredOnAcceptMessage;

  /// No description provided for @orderCancelledAutomaticallyBanner.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء هذا الطلب تلقائياً بسبب انتهاء مهلة الاستجابة.'**
  String get orderCancelledAutomaticallyBanner;

  /// No description provided for @orderAcceptedSuccessMessage.
  ///
  /// In ar, this message translates to:
  /// **'تم قبول الطلب بنجاح'**
  String get orderAcceptedSuccessMessage;

  /// No description provided for @orderRejectedSuccessMessage.
  ///
  /// In ar, this message translates to:
  /// **'تم رفض الطلب'**
  String get orderRejectedSuccessMessage;

  /// No description provided for @orderCompletedSuccessMessage.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديد الطلب كجاهز بنجاح'**
  String get orderCompletedSuccessMessage;

  /// No description provided for @okLabel.
  ///
  /// In ar, this message translates to:
  /// **'حسناً'**
  String get okLabel;

  /// No description provided for @emptyOrdersPendingHeading.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات جديدة'**
  String get emptyOrdersPendingHeading;

  /// No description provided for @emptyOrdersPendingBody.
  ///
  /// In ar, this message translates to:
  /// **'ستظهر الطلبات الجديدة هنا بمجرد وصولها.'**
  String get emptyOrdersPendingBody;

  /// No description provided for @emptyOrdersPreparingHeading.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات قيد التحضير'**
  String get emptyOrdersPreparingHeading;

  /// No description provided for @emptyOrdersPreparingBody.
  ///
  /// In ar, this message translates to:
  /// **'الطلبات التي تقبلها ستظهر هنا أثناء تحضيرها.'**
  String get emptyOrdersPreparingBody;

  /// No description provided for @emptyOrdersDoneHeading.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات منجزة بعد'**
  String get emptyOrdersDoneHeading;

  /// No description provided for @emptyOrdersDoneBody.
  ///
  /// In ar, this message translates to:
  /// **'الطلبات التي تُنهي تحضيرها ستظهر هنا.'**
  String get emptyOrdersDoneBody;

  /// No description provided for @emptyOrdersRejectedHeading.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات مرفوضة'**
  String get emptyOrdersRejectedHeading;

  /// No description provided for @emptyOrdersRejectedBody.
  ///
  /// In ar, this message translates to:
  /// **'الطلبات التي ترفضها ستظهر هنا.'**
  String get emptyOrdersRejectedBody;

  /// No description provided for @orderCardNewBadge.
  ///
  /// In ar, this message translates to:
  /// **'طلب جديد'**
  String get orderCardNewBadge;

  /// No description provided for @timeAgoJustNow.
  ///
  /// In ar, this message translates to:
  /// **'الآن'**
  String get timeAgoJustNow;

  /// No description provided for @timeAgoMinutesAgo.
  ///
  /// In ar, this message translates to:
  /// **'منذ {minutes} دقيقة'**
  String timeAgoMinutesAgo(int minutes);

  /// No description provided for @timeAgoHoursAgo.
  ///
  /// In ar, this message translates to:
  /// **'منذ {hours} ساعة'**
  String timeAgoHoursAgo(int hours);

  /// No description provided for @timeAgoDaysAgo.
  ///
  /// In ar, this message translates to:
  /// **'منذ {days} يوم'**
  String timeAgoDaysAgo(int days);

  /// No description provided for @endOfListNewLabel.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات جديدة أخرى.'**
  String get endOfListNewLabel;

  /// No description provided for @endOfListInProgressLabel.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات أخرى قيد التحضير.'**
  String get endOfListInProgressLabel;

  /// No description provided for @endOfListCompletedLabel.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات منجزة أخرى.'**
  String get endOfListCompletedLabel;

  /// No description provided for @endOfListRejectedLabel.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات مرفوضة أخرى.'**
  String get endOfListRejectedLabel;

  /// No description provided for @selectedOptionLabel.
  ///
  /// In ar, this message translates to:
  /// **'الخيار: {label}'**
  String selectedOptionLabel(String label);

  /// No description provided for @settingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settingsTitle;

  /// No description provided for @accountSettingsSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات الحساب'**
  String get accountSettingsSectionTitle;

  /// No description provided for @changePhoneNumberRowTitle.
  ///
  /// In ar, this message translates to:
  /// **'تغيير رقم الهاتف'**
  String get changePhoneNumberRowTitle;

  /// No description provided for @changePasswordRowTitle.
  ///
  /// In ar, this message translates to:
  /// **'تغيير كلمة المرور'**
  String get changePasswordRowTitle;

  /// No description provided for @preferencesSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'التفضيلات'**
  String get preferencesSectionTitle;

  /// No description provided for @languageLabel.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get languageLabel;

  /// No description provided for @arabicLanguageOption.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabicLanguageOption;

  /// No description provided for @englishLanguageOption.
  ///
  /// In ar, this message translates to:
  /// **'الإنجليزية'**
  String get englishLanguageOption;

  /// No description provided for @darkModeLabel.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الداكن'**
  String get darkModeLabel;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج؟'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmBody.
  ///
  /// In ar, this message translates to:
  /// **'سيتم تسجيل خروجك من التطبيق. يمكنك تسجيل الدخول مرة أخرى في أي وقت.'**
  String get logoutConfirmBody;

  /// No description provided for @logoutCta.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logoutCta;

  /// No description provided for @loginTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get loginTitle;

  /// No description provided for @changePasswordTitle.
  ///
  /// In ar, this message translates to:
  /// **'تغيير كلمة المرور'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordHeading.
  ///
  /// In ar, this message translates to:
  /// **'تحديث بيانات الأمان'**
  String get changePasswordHeading;

  /// No description provided for @changePasswordDescription.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال كلمة المرور الحالية ثم تعيين كلمة مرور جديدة قوية.'**
  String get changePasswordDescription;

  /// No description provided for @currentPasswordLabel.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الحالية'**
  String get currentPasswordLabel;

  /// No description provided for @currentPasswordIncorrectError.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الحالية غير صحيحة'**
  String get currentPasswordIncorrectError;

  /// No description provided for @newPasswordLabel.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الجديدة'**
  String get newPasswordLabel;

  /// No description provided for @confirmNewPasswordLabel.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور الجديدة'**
  String get confirmNewPasswordLabel;

  /// No description provided for @passwordMismatchError.
  ///
  /// In ar, this message translates to:
  /// **'كلمات المرور غير متطابقة'**
  String get passwordMismatchError;

  /// No description provided for @passwordComplexityError.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تحتوي على 8 أحرف على الأقل مع حرف كبير وصغير ورقم ورمز'**
  String get passwordComplexityError;

  /// No description provided for @updatePasswordCta.
  ///
  /// In ar, this message translates to:
  /// **'تحديث كلمة المرور'**
  String get updatePasswordCta;

  /// No description provided for @passwordUpdatedSuccessMessage.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث كلمة المرور بنجاح'**
  String get passwordUpdatedSuccessMessage;

  /// No description provided for @passwordStrengthHint.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تحتوي على 8 أحرف على الأقل'**
  String get passwordStrengthHint;

  /// No description provided for @passwordStrengthWeak.
  ///
  /// In ar, this message translates to:
  /// **'ضعيفة - أضف أرقام ورموز'**
  String get passwordStrengthWeak;

  /// No description provided for @passwordStrengthMedium.
  ///
  /// In ar, this message translates to:
  /// **'متوسطة - يمكن أن تكون أقوى'**
  String get passwordStrengthMedium;

  /// No description provided for @passwordStrengthGood.
  ///
  /// In ar, this message translates to:
  /// **'جيدة - أضف المزيد من الرموز'**
  String get passwordStrengthGood;

  /// No description provided for @passwordStrengthVeryStrong.
  ///
  /// In ar, this message translates to:
  /// **'قوية جداً'**
  String get passwordStrengthVeryStrong;

  /// No description provided for @changePhoneNumberTitle.
  ///
  /// In ar, this message translates to:
  /// **'تغيير رقم الهاتف'**
  String get changePhoneNumberTitle;

  /// No description provided for @changePhoneNumberHeading.
  ///
  /// In ar, this message translates to:
  /// **'تحديث رقم الهاتف'**
  String get changePhoneNumberHeading;

  /// No description provided for @changePhoneNumberDescription.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال رقم الهاتف الجديد، سنرسل لك رمز تحقق للتأكيد.'**
  String get changePhoneNumberDescription;

  /// No description provided for @newPhoneNumberLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف الجديد'**
  String get newPhoneNumberLabel;

  /// No description provided for @newPhoneNumberHelper.
  ///
  /// In ar, this message translates to:
  /// **'تأكد من إدخال الرقم بشكل صحيح لتلقي الرمز'**
  String get newPhoneNumberHelper;

  /// No description provided for @sendVerificationCodeCta.
  ///
  /// In ar, this message translates to:
  /// **'إرسال رمز التحقق'**
  String get sendVerificationCodeCta;

  /// No description provided for @phoneNumberInvalidError.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال رقم هاتف صحيح مكون من 9 أرقام'**
  String get phoneNumberInvalidError;

  /// No description provided for @otpVerificationTitle.
  ///
  /// In ar, this message translates to:
  /// **'رمز التحقق'**
  String get otpVerificationTitle;

  /// No description provided for @otpSentHeading.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال رمز التحقق'**
  String get otpSentHeading;

  /// No description provided for @otpSentDescription.
  ///
  /// In ar, this message translates to:
  /// **'لقد قمنا بإرسال رمز مكون من 4 أرقام إلى رقم هاتفك الجديد'**
  String get otpSentDescription;

  /// No description provided for @resendCodePrompt.
  ///
  /// In ar, this message translates to:
  /// **'لم تستلم الرمز؟'**
  String get resendCodePrompt;

  /// No description provided for @resendCodeCta.
  ///
  /// In ar, this message translates to:
  /// **'إعادة الإرسال'**
  String get resendCodeCta;

  /// No description provided for @verifyCta.
  ///
  /// In ar, this message translates to:
  /// **'تحقق'**
  String get verifyCta;

  /// No description provided for @otpIncorrectError.
  ///
  /// In ar, this message translates to:
  /// **'الرمز غير صحيح، يرجى المحاولة مرة أخرى'**
  String get otpIncorrectError;

  /// No description provided for @onboardingSlide1Title.
  ///
  /// In ar, this message translates to:
  /// **'أشهى الأطباق البيتية'**
  String get onboardingSlide1Title;

  /// No description provided for @onboardingSlide1Body.
  ///
  /// In ar, this message translates to:
  /// **'تذوق طعم البيت في كل وجبة، محضرة بعناية وحب من طهاة محليين شغوفين.'**
  String get onboardingSlide1Body;

  /// No description provided for @onboardingSlide2Title.
  ///
  /// In ar, this message translates to:
  /// **'توصيل دافئ وسريع'**
  String get onboardingSlide2Title;

  /// No description provided for @onboardingSlide2Body.
  ///
  /// In ar, this message translates to:
  /// **'تصلك وجباتك طازجة ودافئة، وكأنها خرجت للتو من فرن مطبخك الخاص.'**
  String get onboardingSlide2Body;

  /// No description provided for @onboardingSlide3Title.
  ///
  /// In ar, this message translates to:
  /// **'شارك متعة الطعم'**
  String get onboardingSlide3Title;

  /// No description provided for @onboardingSlide3Body.
  ///
  /// In ar, this message translates to:
  /// **'اكتشف نكهات جديدة وشارك التجربة مع عائلتك وأصدقائك في كل مناسبة.'**
  String get onboardingSlide3Body;

  /// No description provided for @onboardingNext.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الآن'**
  String get onboardingStart;

  /// No description provided for @onboardingSkip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get onboardingSkip;

  /// No description provided for @myShortsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الشورتس'**
  String get myShortsTitle;

  /// No description provided for @myShortsBannerTitle.
  ///
  /// In ar, this message translates to:
  /// **'معرض شورتاتي'**
  String get myShortsBannerTitle;

  /// No description provided for @myShortsBannerBody.
  ///
  /// In ar, this message translates to:
  /// **'شاركي مقاطع فيديو قصيرة لوصفاتك، طرق التحضير، أو لقطات شهية من مطبخك لجذب المزيد من الزبائن.'**
  String get myShortsBannerBody;

  /// No description provided for @emptyShortsHeading.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مقاطع بعد'**
  String get emptyShortsHeading;

  /// No description provided for @emptyShortsBody.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ بمشاركة أول مقطع فيديو قصير لجذب المزيد من الزبائن.'**
  String get emptyShortsBody;

  /// No description provided for @createShortTitle.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء مقطع جديد'**
  String get createShortTitle;

  /// No description provided for @videoPickerHint.
  ///
  /// In ar, this message translates to:
  /// **'اضغطي هنا لاختيار أو تسجيل فيديو'**
  String get videoPickerHint;

  /// No description provided for @videoMaxDurationHint.
  ///
  /// In ar, this message translates to:
  /// **'الحد الأقصى 60 ثانية'**
  String get videoMaxDurationHint;

  /// No description provided for @videoSelectedLabel.
  ///
  /// In ar, this message translates to:
  /// **'تم اختيار الفيديو'**
  String get videoSelectedLabel;

  /// No description provided for @shortDescriptionLabel.
  ///
  /// In ar, this message translates to:
  /// **'الوصف'**
  String get shortDescriptionLabel;

  /// No description provided for @shortDescriptionHint.
  ///
  /// In ar, this message translates to:
  /// **'اكتبي وصفاً جذاباً لمقطعك... يشجع الزبائن على تذوق وجبتك'**
  String get shortDescriptionHint;

  /// No description provided for @linkedMealSectionTitle.
  ///
  /// In ar, this message translates to:
  /// **'الوجبة المرتبطة'**
  String get linkedMealSectionTitle;

  /// No description provided for @linkedMealOptionalHint.
  ///
  /// In ar, this message translates to:
  /// **'اختياري - يمكنك ربط مقطعك بوجبة من قائمتك'**
  String get linkedMealOptionalHint;

  /// No description provided for @chooseMealCta.
  ///
  /// In ar, this message translates to:
  /// **'اختر وجبة'**
  String get chooseMealCta;

  /// No description provided for @publishShortCta.
  ///
  /// In ar, this message translates to:
  /// **'نشر المقطع'**
  String get publishShortCta;

  /// No description provided for @deleteShortConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'هل أنتِ متأكدة من حذف هذا المقطع؟'**
  String get deleteShortConfirmTitle;

  /// No description provided for @deleteShortConfirmBody.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن التراجع عن هذا الإجراء'**
  String get deleteShortConfirmBody;

  /// No description provided for @validationVideoRequired.
  ///
  /// In ar, this message translates to:
  /// **'يرجى اختيار فيديو'**
  String get validationVideoRequired;

  /// No description provided for @validationDescriptionTooLong.
  ///
  /// In ar, this message translates to:
  /// **'الوصف يتجاوز الحد الأقصى المسموح به'**
  String get validationDescriptionTooLong;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
