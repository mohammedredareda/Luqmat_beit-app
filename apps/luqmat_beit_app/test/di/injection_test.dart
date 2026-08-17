import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:luqmat_beit_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:luqmat_beit_app/features/chef_profile/domain/repositories/chef_repository.dart';
import 'package:luqmat_beit_app/features/cook_profile/change_password/domain/repositories/change_password_repository.dart';
import 'package:luqmat_beit_app/features/cook_profile/change_phone_number/domain/repositories/change_phone_number_repository.dart';
import 'package:luqmat_beit_app/features/cook_profile/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:luqmat_beit_app/features/cook_profile/view_profile/domain/repositories/view_profile_repository.dart';
import 'package:luqmat_beit_app/features/delivery/domain/repositories/delivery_repository.dart';
import 'package:luqmat_beit_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:luqmat_beit_app/features/home/domain/repositories/home_repository.dart';
import 'package:luqmat_beit_app/features/meal_details/domain/repositories/meal_details_repository.dart';
import 'package:luqmat_beit_app/features/meal_management/create_meal/domain/repositories/create_meal_repository.dart';
import 'package:luqmat_beit_app/features/meal_management/delete_meal/domain/repositories/delete_meal_repository.dart';
import 'package:luqmat_beit_app/features/meal_management/edit_meal/domain/repositories/edit_meal_repository.dart';
import 'package:luqmat_beit_app/features/meal_management/view_menu/domain/repositories/view_menu_repository.dart';
import 'package:luqmat_beit_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:luqmat_beit_app/features/offers_management/create_discount/domain/repositories/create_discount_repository.dart';
import 'package:luqmat_beit_app/features/offers_management/create_offer/domain/repositories/create_offer_repository.dart';
import 'package:luqmat_beit_app/features/offers_management/delete_discount/domain/repositories/delete_discount_repository.dart';
import 'package:luqmat_beit_app/features/offers_management/delete_offer/domain/repositories/delete_offer_repository.dart';
import 'package:luqmat_beit_app/features/offers_management/edit_discount/domain/repositories/edit_discount_repository.dart';
import 'package:luqmat_beit_app/features/offers_management/edit_offer/domain/repositories/edit_offer_repository.dart';
import 'package:luqmat_beit_app/features/offers_management/shared/domain/repositories/selectable_meals_repository.dart';
import 'package:luqmat_beit_app/features/offers_management/shared/domain/usecases/lookup_meal.dart';
import 'package:luqmat_beit_app/features/offers_management/view_offers/domain/repositories/view_offers_repository.dart';
import 'package:luqmat_beit_app/features/order_history/domain/repositories/order_history_repository.dart';
import 'package:luqmat_beit_app/features/order_management/order_details/domain/repositories/order_details_repository.dart';
import 'package:luqmat_beit_app/features/order_management/view_orders/domain/repositories/view_orders_repository.dart';
import 'package:luqmat_beit_app/features/orders/domain/repositories/orders_repository.dart';
import 'package:luqmat_beit_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:luqmat_beit_app/features/ratings/domain/repositories/ratings_repository.dart';
import 'package:luqmat_beit_app/features/search/domain/repositories/search_repository.dart';
import 'package:luqmat_beit_app/features/shorts/domain/repositories/shorts_repository.dart';

/// Every repository interface must resolve from [getIt] without throwing.
/// This is the test that would have caught the `MealDetailsRepositoryImpl`
/// constructor-parameter-name/`CartRepository` wiring mismatch: registration
/// alone (lazy) doesn't run the factory closure, so a broken dependency only
/// surfaces the moment something actually resolves the type — exactly what
/// this test forces for every repository, not just the ones a manual click
/// path happens to touch.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // configureDependencies() reads a token from flutter_secure_storage to
  // decide the initial session state — no platform implementation exists
  // under `flutter test`, so stub the channel to report "no token" (a
  // fresh install), same as `MissingPluginException` should mean deep-down.
  const channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
  TestWidgetsFlutterBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
    channel,
    (call) async => call.method == 'read' ? null : null,
  );

  setUpAll(() async {
    await configureDependencies();
  });

  test('every customer-side repository resolves from the DI container', () {
    expect(getIt<AuthRepository>(), isNotNull);
    expect(getIt<LocationRepository>(), isNotNull);
    expect(getIt<HomeRepository>(), isNotNull);
    expect(getIt<SearchRepository>(), isNotNull);
    expect(getIt<ChefRepository>(), isNotNull);
    expect(getIt<FavoritesRepository>(), isNotNull);
    expect(getIt<CartRepository>(), isNotNull);
    expect(getIt<MealDetailsRepository>(), isNotNull);
    expect(getIt<OrdersRepository>(), isNotNull);
    expect(getIt<ProfileRepository>(), isNotNull);
    expect(getIt<OrderHistoryRepository>(), isNotNull);
    expect(getIt<DeliveryRepository>(), isNotNull);
    expect(getIt<RatingsRepository>(), isNotNull);
    expect(getIt<NotificationsRepository>(), isNotNull);
    expect(getIt<ShortsRepository>(), isNotNull);
  });

  test('every cook-side repository resolves from the DI container', () {
    expect(getIt<CreateMealRepository>(), isNotNull);
    expect(getIt<DeleteMealRepository>(), isNotNull);
    expect(getIt<EditMealRepository>(), isNotNull);
    expect(getIt<ViewMenuRepository>(), isNotNull);
    expect(getIt<CreateDiscountRepository>(), isNotNull);
    expect(getIt<CreateOfferRepository>(), isNotNull);
    expect(getIt<DeleteDiscountRepository>(), isNotNull);
    expect(getIt<DeleteOfferRepository>(), isNotNull);
    expect(getIt<EditDiscountRepository>(), isNotNull);
    expect(getIt<EditOfferRepository>(), isNotNull);
    expect(getIt<SelectableMealsRepository>(), isNotNull);
    expect(getIt<ViewOffersRepository>(), isNotNull);
    expect(getIt<OrderDetailsRepository>(), isNotNull);
    expect(getIt<ViewOrdersRepository>(), isNotNull);
    expect(getIt<ChangePasswordRepository>(), isNotNull);
    expect(getIt<ChangePhoneNumberRepository>(), isNotNull);
    expect(getIt<EditProfileRepository>(), isNotNull);
    expect(getIt<ViewProfileRepository>(), isNotNull);
    expect(getIt<LookupMeal>(), isNotNull);
  });

  test('SessionCubit resolves and starts unauthenticated with no stored token', () {
    expect(getIt<SessionCubit>().state, SessionState.unauthenticated);
  });
}
