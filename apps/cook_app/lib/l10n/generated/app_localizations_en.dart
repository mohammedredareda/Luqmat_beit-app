// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get myMenuTitle => 'My Menu';

  @override
  String get myMenuSubtitle => 'Manage your dishes and their availability to customers.';

  @override
  String get saleStatusLabel => 'Sale Status';

  @override
  String get saleStatusActive => 'Active - ready to receive orders';

  @override
  String get saleStatusPaused => 'Paused - not available for orders';

  @override
  String get emptyMenuHeading => 'Your menu is empty';

  @override
  String get emptyMenuBody => 'Start by adding your kitchen\'s first meal so customers can see it.';

  @override
  String get addMealCta => 'Add Meal';

  @override
  String get outOfStockBadge => 'Out of stock';

  @override
  String get stopSellingDialogTitle => 'Stop selling?';

  @override
  String get stopSellingDialogBody => 'Customers won\'t be able to order any meal from your menu until you turn selling back on manually.';

  @override
  String get resumeSellingDialogTitle => 'Resume selling?';

  @override
  String get resumeSellingDialogBody => 'Customers will be able to order your available meals again.';

  @override
  String get confirmLabel => 'Confirm';

  @override
  String get cancelLabel => 'Cancel';

  @override
  String get navMenu => 'Menu';

  @override
  String get navOrders => 'Orders';

  @override
  String get navOffers => 'Offers';

  @override
  String get navAccount => 'Account';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get retryLabel => 'Retry';

  @override
  String get genericErrorMessage => 'Something went wrong. Please try again.';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get editMealTitle => 'Edit Meal';

  @override
  String get deleteMealTitle => 'Delete Meal';

  @override
  String get addMealTitle => 'Add Meal';

  @override
  String get mealImagePickerHint => 'Add a photo for the meal';

  @override
  String get changeMealImageCta => 'Change photo';

  @override
  String get basicInfoSectionTitle => 'Basic Info';

  @override
  String get mealNameLabel => 'Meal name';

  @override
  String get mealNameHint => 'e.g. Grilled Chicken Kabsa';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get descriptionHint => 'Write an appetizing description of the ingredients and how it\'s prepared...';

  @override
  String get categorySectionTitle => 'Category';

  @override
  String get categoryMainDishes => 'Main dishes';

  @override
  String get categoryPastries => 'Pastries';

  @override
  String get categoryDesserts => 'Desserts';

  @override
  String get categoryAppetizers => 'Appetizers';

  @override
  String get categoryBeverages => 'Beverages';

  @override
  String get preorderTimeLabel => 'Pre-order time';

  @override
  String get preorderHoursUnit => 'hours';

  @override
  String get pricingSectionTitle => 'Pricing & Options';

  @override
  String get sellWithVariationsToggle => 'Sell with options';

  @override
  String get priceLabel => 'Price';

  @override
  String get currencySuffix => 'SYP';

  @override
  String get variationSizeHint => 'Size (e.g. Small)';

  @override
  String get addVariationCta => 'Add another option';

  @override
  String get validationRequiredField => 'This field is required';

  @override
  String get validationZeroVariations => 'Add at least one option';

  @override
  String get validationNonPositivePrice => 'Price must be greater than zero';

  @override
  String get validationImageTooLarge => 'Image exceeds 10 MB';

  @override
  String get availabilitySectionTitle => 'Available for order';

  @override
  String get availabilityHelperText => 'Show this meal to customers in the menu';

  @override
  String get saveMealChangesCta => 'Save Changes';

  @override
  String get deleteMealConfirmTitle => 'Delete meal?';

  @override
  String get deleteMealConfirmBody => 'This will hide the meal from your menu. It won\'t appear to new customers, and customers with pending orders for this meal will be notified.';

  @override
  String get confirmDeleteCta => 'Confirm Delete';

  @override
  String get startingFromLabel => 'Starting from';

  @override
  String get offersTitle => 'Offers';

  @override
  String get offersSubtitle => 'Manage discounts and bundles to attract more customers';

  @override
  String get emptyOffersHeading => 'No offers or discounts yet';

  @override
  String get emptyOffersBody => 'Create your first offer or discount to attract more customers';

  @override
  String get addOfferOrDiscountCta => 'Add New Offer';

  @override
  String offerExpiresInLabel(int days) {
    return 'Expires in $days days';
  }

  @override
  String get offerExpiredLabel => 'Expired';

  @override
  String get offerBadgeLabel => 'Bundle offer';

  @override
  String discountBadgeLabel(String percentage) {
    return '$percentage% off';
  }

  @override
  String get selectOfferTypeSheetTitle => 'Choose offer type';

  @override
  String get createOfferOptionTitle => 'Create Offer';

  @override
  String get createOfferOptionBody => 'Create promotional bundles for a selection of meals.';

  @override
  String get createDiscountOptionTitle => 'Create Discount';

  @override
  String get createDiscountOptionBody => 'Create percentage or fixed-amount discounts.';

  @override
  String get selectMealPopupTitle => 'Select Meal';

  @override
  String get selectMealSearchHint => 'Search for a meal...';

  @override
  String get selectMealAvailableLabel => 'Meals available for offer';

  @override
  String get selectMealEmptyResults => 'No matching results';

  @override
  String get selectSellingOptionDialogTitle => 'Choose selling option';

  @override
  String get mealNameFieldLabel => 'Meal name';

  @override
  String get sellingOptionsListLabel => 'Selling options';

  @override
  String get confirmSellingOptionCta => 'Confirm';

  @override
  String get createOfferTitle => 'Create New Offer';

  @override
  String get editOfferTitle => 'Edit Offer';

  @override
  String get offerImagePickerHint => 'Add a photo for the offer (optional)';

  @override
  String get changeOfferImageCta => 'Change photo';

  @override
  String get offerNameLabel => 'Offer name';

  @override
  String get offerNameHint => 'e.g. Family Lunch Offer';

  @override
  String get offerDescriptionLabel => 'Offer description (optional)';

  @override
  String get offerDescriptionHint => 'Write an appealing description of your offer...';

  @override
  String get includedMealsSectionTitle => 'Included meals';

  @override
  String includedMealsCountLabel(int count) {
    return '$count meals';
  }

  @override
  String get includedMealsEmptyBody => 'You haven\'t added any meals to this offer yet';

  @override
  String get addDishCta => 'Add Dish';

  @override
  String get offerTotalPriceLabel => 'Total offer price';

  @override
  String get offerDurationDaysLabel => 'Number of days';

  @override
  String get offerStatusSectionTitle => 'Offer status';

  @override
  String get offerStatusHelperText => 'Activate the offer to show it to customers immediately';

  @override
  String get saveOfferCta => 'Save Offer';

  @override
  String get saveOfferChangesCta => 'Save Changes';

  @override
  String get deleteOfferTitle => 'Delete Offer';

  @override
  String get remainingDaysLabel => 'Time remaining';

  @override
  String remainingDaysValue(int days) {
    return '$days days left';
  }

  @override
  String get updateDurationLabel => 'Update duration (days)';

  @override
  String get validationZeroMeals => 'Add at least one dish';

  @override
  String get createDiscountTitle => 'Create New Discount';

  @override
  String get editDiscountTitle => 'Edit Discount';

  @override
  String get editDiscountSubtitle => 'Update your discount settings';

  @override
  String get selectMealFieldLabel => 'Select meal';

  @override
  String get discountTargetMealLabel => 'Target product';

  @override
  String get discountPercentageLabel => 'Discount percentage';

  @override
  String get discountPriceAfterLabel => 'Price after discount';

  @override
  String get discountPricesAfterPerOptionLabel => 'Prices after discount (by selling option)';

  @override
  String get restrictionTypeLabel => 'Restriction type';

  @override
  String get restrictionByDurationLabel => 'By duration';

  @override
  String get restrictionByUsageLabel => 'By usage';

  @override
  String get usageLimitFieldLabel => 'Maximum usage count';

  @override
  String get usageLimitHint => 'e.g. 50';

  @override
  String get remainingUsageLabel => 'Remaining uses';

  @override
  String remainingUsageValue(int count) {
    return '$count uses left';
  }

  @override
  String get updateUsageLimitLabel => 'Update limit (uses)';

  @override
  String get saveDiscountCta => 'Save Discount';

  @override
  String get saveDiscountChangesCta => 'Save Changes';

  @override
  String get deleteDiscountTitle => 'Delete Discount';

  @override
  String get validationPercentageOutOfRange => 'Percentage must be between 0 and 100';

  @override
  String get validationMealRequired => 'Please select a meal';

  @override
  String get validationRestrictionRequired => 'Please set the duration or usage count';

  @override
  String get deleteOfferConfirmTitle => 'Delete offer?';

  @override
  String get deleteOfferConfirmBody => 'This offer will be permanently deleted and will no longer appear to customers';

  @override
  String get deleteDiscountConfirmTitle => 'Delete discount?';

  @override
  String get deleteDiscountConfirmBody => 'This discount will be permanently deleted and will no longer apply to the meal';

  @override
  String get filterAllLabel => 'All';

  @override
  String get filterActiveLabel => 'Active';

  @override
  String get filterExpiredLabel => 'Expired';

  @override
  String get discountDetailsSectionTitle => 'Discount Details';

  @override
  String get validityTypeLabel => 'Validity Type';

  @override
  String get createRestrictionByDurationLabel => 'By days';

  @override
  String get createRestrictionByUsageLabel => 'Usage count';

  @override
  String discountPricesAfterCaption(String percentage) {
    return 'These prices are calculated based on the discount percentage ($percentage%) set above';
  }

  @override
  String get daysUnitSuffix => 'days';

  @override
  String get usesUnitSuffix => 'uses';

  @override
  String get selectMealAddCta => 'Add';

  @override
  String profileRatingLabel(String rating, int count) {
    return '$rating ($count reviews)';
  }

  @override
  String get completedOrdersStatLabel => 'Completed Orders';

  @override
  String get totalMealsStatLabel => 'Total Meals';

  @override
  String get phoneNumberStatLabel => 'Phone Number';

  @override
  String get aboutMeSectionTitle => 'About Me';

  @override
  String get availabilityHoursSectionTitle => 'Availability Hours';

  @override
  String get addressSectionTitle => 'Address';

  @override
  String get editProfileCta => 'Edit Profile';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get changePhotoCta => 'Change Photo';

  @override
  String get cropAvatarTitle => 'Crop Photo';

  @override
  String get cropAvatarHint => 'Drag to move, pinch to zoom, and choose what appears inside the frame';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get bioLabel => 'About Me';

  @override
  String get bioHint => 'Write a short bio about yourself and your cooking experience...';

  @override
  String get addressLabel => 'Address';

  @override
  String get addressHint => 'Enter your address in detail';

  @override
  String get availabilityDaysFieldLabel => 'Availability Days';

  @override
  String get availabilityHoursFieldLabel => 'Availability Hours';

  @override
  String get saveProfileChangesCta => 'Save Changes';

  @override
  String get weekdaySunday => 'Sunday';

  @override
  String get weekdayMonday => 'Monday';

  @override
  String get weekdayTuesday => 'Tuesday';

  @override
  String get weekdayWednesday => 'Wednesday';

  @override
  String get weekdayThursday => 'Thursday';

  @override
  String get weekdayFriday => 'Friday';

  @override
  String get weekdaySaturday => 'Saturday';

  @override
  String get availabilityFromLabel => 'From';

  @override
  String get availabilityToLabel => 'To';

  @override
  String get amLabel => 'AM';

  @override
  String get pmLabel => 'PM';

  @override
  String get validationZeroAvailabilityDays => 'Select at least one day';

  @override
  String get validationInvalidAvailabilityRange => 'End time must be after start time';

  @override
  String get myOrdersTitle => 'My Orders';

  @override
  String get myOrdersSubtitle => 'Manage and track the status of your current and past orders.';

  @override
  String get orderDetailsTitle => 'Order Details';

  @override
  String get ordersTabNew => 'New';

  @override
  String get ordersTabInProgress => 'In Progress';

  @override
  String get ordersTabCompleted => 'Completed';

  @override
  String get ordersTabRejected => 'Rejected';

  @override
  String get orderStatusPending => 'Pending';

  @override
  String get orderStatusPreparing => 'Preparing';

  @override
  String get orderStatusDone => 'Done';

  @override
  String get orderStatusRejected => 'Rejected';

  @override
  String get orderStatusCancelled => 'Cancelled';

  @override
  String orderNumberLabel(String id) {
    return 'Order #$id';
  }

  @override
  String moreItemsLabel(int count) {
    return '+ $count more items';
  }

  @override
  String get customerLabel => 'Customer';

  @override
  String get deliveryMethodLabel => 'Delivery Method';

  @override
  String get pickupMethodValue => 'Pickup from home';

  @override
  String get deliveryMethodValue => 'Delivery';

  @override
  String get orderItemsSectionTitle => 'Order Items';

  @override
  String quantityLabel(int count) {
    return 'Quantity: $count';
  }

  @override
  String get returnedItemBadge => 'Returned';

  @override
  String itemNoteLabel(String note) {
    return 'Note: $note';
  }

  @override
  String get orderSummaryTitle => 'Order Summary';

  @override
  String get subtotalLabel => 'Subtotal';

  @override
  String get discountLabel => 'Discount';

  @override
  String get totalLabel => 'Total';

  @override
  String get orderDetailsCta => 'Details';

  @override
  String get acceptOrderCta => 'Accept Order';

  @override
  String get rejectOrderCta => 'Reject';

  @override
  String get markPreparedCta => 'Mark as Prepared';

  @override
  String get preparingDoneBannerBody => 'By tapping \"Mark as Prepared\", the customer will be notified to come pick up the order.';

  @override
  String rejectOrderDialogTitle(String id) {
    return 'Reject order #$id?';
  }

  @override
  String get rejectOrderConfirmCta => 'Reject Order';

  @override
  String get rejectionReasonLabel => 'Rejection reason';

  @override
  String get rejectionReasonHint => 'Write the reason for rejecting this order...';

  @override
  String get rejectionReasonRequiredError => 'Please enter a rejection reason';

  @override
  String get orderExpiredOnAcceptMessage => 'Sorry, the order timeout has expired and the order was cancelled automatically.';

  @override
  String get orderCancelledAutomaticallyBanner => 'This order was automatically cancelled because the response window expired.';

  @override
  String get orderAcceptedSuccessMessage => 'Order accepted successfully';

  @override
  String get orderRejectedSuccessMessage => 'Order rejected';

  @override
  String get orderCompletedSuccessMessage => 'Order marked as ready successfully';

  @override
  String get okLabel => 'OK';

  @override
  String get emptyOrdersPendingHeading => 'No new orders';

  @override
  String get emptyOrdersPendingBody => 'New orders will appear here once they arrive.';

  @override
  String get emptyOrdersPreparingHeading => 'No orders in progress';

  @override
  String get emptyOrdersPreparingBody => 'Orders you accept will appear here while you prepare them.';

  @override
  String get emptyOrdersDoneHeading => 'No completed orders yet';

  @override
  String get emptyOrdersDoneBody => 'Orders you\'ve finished preparing will appear here.';

  @override
  String get emptyOrdersRejectedHeading => 'No rejected orders';

  @override
  String get emptyOrdersRejectedBody => 'Orders you reject will appear here.';

  @override
  String get orderCardNewBadge => 'New order';

  @override
  String get timeAgoJustNow => 'Just now';

  @override
  String timeAgoMinutesAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String timeAgoHoursAgo(int hours) {
    return '$hours hr ago';
  }

  @override
  String timeAgoDaysAgo(int days) {
    return '$days days ago';
  }

  @override
  String get endOfListNewLabel => 'No more new orders.';

  @override
  String get endOfListInProgressLabel => 'No more orders in progress.';

  @override
  String get endOfListCompletedLabel => 'No more completed orders.';

  @override
  String get endOfListRejectedLabel => 'No more rejected orders.';

  @override
  String selectedOptionLabel(String label) {
    return 'Option: $label';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get accountSettingsSectionTitle => 'Account Settings';

  @override
  String get changePhoneNumberRowTitle => 'Change Phone Number';

  @override
  String get changePasswordRowTitle => 'Change Password';

  @override
  String get preferencesSectionTitle => 'Preferences';

  @override
  String get languageLabel => 'Language';

  @override
  String get arabicLanguageOption => 'Arabic';

  @override
  String get englishLanguageOption => 'English';

  @override
  String get darkModeLabel => 'Dark Mode';

  @override
  String get logoutConfirmTitle => 'Log out?';

  @override
  String get logoutConfirmBody => 'You\'ll be logged out of the app. You can log back in at any time.';

  @override
  String get logoutCta => 'Log Out';

  @override
  String get loginTitle => 'Log In';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get changePasswordHeading => 'Update Security Info';

  @override
  String get changePasswordDescription => 'Please enter your current password, then set a new strong password.';

  @override
  String get currentPasswordLabel => 'Current Password';

  @override
  String get currentPasswordIncorrectError => 'The current password is incorrect';

  @override
  String get newPasswordLabel => 'New Password';

  @override
  String get confirmNewPasswordLabel => 'Confirm New Password';

  @override
  String get passwordMismatchError => 'Passwords don\'t match';

  @override
  String get passwordComplexityError => 'Must be at least 8 characters with an uppercase letter, a lowercase letter, a digit, and a symbol';

  @override
  String get updatePasswordCta => 'Update Password';

  @override
  String get passwordUpdatedSuccessMessage => 'Password updated successfully';

  @override
  String get passwordStrengthHint => 'Must contain at least 8 characters';

  @override
  String get passwordStrengthWeak => 'Weak - add numbers and symbols';

  @override
  String get passwordStrengthMedium => 'Medium - could be stronger';

  @override
  String get passwordStrengthGood => 'Good - add more symbols';

  @override
  String get passwordStrengthVeryStrong => 'Very strong';

  @override
  String get changePhoneNumberTitle => 'Change Phone Number';

  @override
  String get changePhoneNumberHeading => 'Update Phone Number';

  @override
  String get changePhoneNumberDescription => 'Please enter your new phone number, we\'ll send you a verification code to confirm.';

  @override
  String get newPhoneNumberLabel => 'New Phone Number';

  @override
  String get newPhoneNumberHelper => 'Make sure to enter the number correctly to receive the code';

  @override
  String get sendVerificationCodeCta => 'Send Verification Code';

  @override
  String get phoneNumberInvalidError => 'Please enter a valid 9-digit phone number';

  @override
  String get otpVerificationTitle => 'Verification Code';

  @override
  String get otpSentHeading => 'Verification Code Sent';

  @override
  String get otpSentDescription => 'We\'ve sent a 4-digit code to your new phone number';

  @override
  String get resendCodePrompt => 'Didn\'t receive the code?';

  @override
  String get resendCodeCta => 'Resend';

  @override
  String get verifyCta => 'Verify';

  @override
  String get otpIncorrectError => 'The code is incorrect, please try again';
}
