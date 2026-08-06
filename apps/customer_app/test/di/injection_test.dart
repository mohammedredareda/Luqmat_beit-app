import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:customer_app/di/injection.dart';
import 'package:customer_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:customer_app/features/auth/domain/repositories/location_repository.dart';
import 'package:customer_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:customer_app/features/catering/domain/repositories/catering_repository.dart';
import 'package:customer_app/features/chef_profile/domain/repositories/chef_repository.dart';
import 'package:customer_app/features/delivery/domain/repositories/delivery_repository.dart';
import 'package:customer_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:customer_app/features/home/domain/repositories/home_repository.dart';
import 'package:customer_app/features/meal_details/domain/repositories/meal_details_repository.dart';
import 'package:customer_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:customer_app/features/order_history/domain/repositories/order_history_repository.dart';
import 'package:customer_app/features/orders/domain/repositories/orders_repository.dart';
import 'package:customer_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:customer_app/features/ratings/domain/repositories/ratings_repository.dart';
import 'package:customer_app/features/search/domain/repositories/search_repository.dart';
import 'package:customer_app/features/shorts/domain/repositories/shorts_repository.dart';

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

  test('every repository resolves from the DI container', () {
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
    expect(getIt<CateringRepository>(), isNotNull);
    expect(getIt<ShortsRepository>(), isNotNull);
  });
}
