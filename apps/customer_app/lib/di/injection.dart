import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../features/auth/data/datasources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/data/repositories/location_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/repositories/location_repository.dart';
import '../features/cart/data/datasources/cart_remote_data_source.dart';
import '../features/cart/data/repositories/cart_repository_impl.dart';
import '../features/cart/domain/repositories/cart_repository.dart';
import '../features/catering/data/repositories/catering_repository_impl.dart';
import '../features/catering/domain/repositories/catering_repository.dart';
import '../features/chef_profile/data/datasources/chef_remote_data_source.dart';
import '../features/chef_profile/data/repositories/chef_repository_impl.dart';
import '../features/chef_profile/domain/repositories/chef_repository.dart';
import '../features/delivery/data/repositories/delivery_repository_impl.dart';
import '../features/delivery/domain/repositories/delivery_repository.dart';
import '../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../features/favorites/domain/repositories/favorites_repository.dart';
import '../features/home/data/datasources/home_remote_data_source.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/meal_details/data/datasources/meal_details_remote_data_source.dart';
import '../features/meal_details/data/repositories/meal_details_repository_impl.dart';
import '../features/meal_details/domain/repositories/meal_details_repository.dart';
import '../features/notifications/data/repositories/notifications_repository_impl.dart';
import '../features/notifications/domain/repositories/notifications_repository.dart';
import '../features/order_history/data/datasources/order_history_remote_data_source.dart';
import '../features/order_history/data/repositories/order_history_repository_impl.dart';
import '../features/order_history/domain/repositories/order_history_repository.dart';
import '../features/orders/data/datasources/orders_remote_data_source.dart';
import '../features/orders/data/repositories/orders_repository_impl.dart';
import '../features/orders/domain/repositories/orders_repository.dart';
import '../features/profile/data/datasources/profile_remote_data_source.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/repositories/profile_repository.dart';
import '../features/ratings/data/datasources/ratings_remote_data_source.dart';
import '../features/ratings/data/repositories/ratings_repository_impl.dart';
import '../features/ratings/domain/repositories/ratings_repository.dart';
import '../features/search/data/datasources/search_remote_data_source.dart';
import '../features/search/data/repositories/search_repository_impl.dart';
import '../features/search/domain/repositories/search_repository.dart';
import '../features/shorts/data/repositories/shorts_repository_impl.dart';
import '../features/shorts/domain/repositories/shorts_repository.dart';

final getIt = GetIt.instance;

/// Override at build/run time with `--dart-define=API_BASE_URL=...` (e.g.
/// to point at a local backend instead). Defaults to the hosted backend on
/// Render — note Render's free tier spins down on idle, so the first
/// request after a while can take 30-60s to respond (cold start), which can
/// look like a hang/timeout rather than a normal loading state.
const _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://loqmet-beit-api.onrender.com',
);

/// Wires every repository behind its domain interface. Features with a real
/// backend endpoint (see AI_INSTRUCTIONS/Loqmet Beit.postman_collection.json)
/// use an `XRemoteDataSource` backed by `ApiClient`; features with no
/// matching endpoint yet stay on their mock datasource (see the
/// `TODO(backend)` comment on each one).
Future<void> configureDependencies() async {
  await registerCoreDependencies(
    getIt,
    baseUrl: _apiBaseUrl,
    // Render's free tier can take 30-60s to wake from a cold start — the
    // previous 15s default made that look like a network failure.
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      dataSource: AuthRemoteDataSource(getIt<ApiClient>(), getIt<SecureTokenStorage>()),
    ),
  );
  getIt.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl());

  // Read once, synchronously ahead of runApp(), so the router's very first
  // redirect decision (registration vs. straight into the app) never races
  // an async storage read.
  final existingToken = await getIt<SecureTokenStorage>().readAccessToken();
  getIt.registerLazySingleton<SessionCubit>(
    () => SessionCubit(getIt(), initiallyAuthenticated: existingToken != null),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(dataSource: HomeRemoteDataSource(getIt<ApiClient>())),
  );
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(dataSource: SearchRemoteDataSource(getIt<ApiClient>())),
  );
  getIt.registerLazySingleton<ChefRepository>(
    () => ChefRepositoryImpl(dataSource: ChefRemoteDataSource(getIt<ApiClient>())),
  );
  // TODO(backend): no GET endpoint to list favorites/follows — stays mocked.
  getIt.registerLazySingleton<FavoritesRepository>(() => FavoritesRepositoryImpl());
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(dataSource: CartRemoteDataSource(getIt<ApiClient>())),
  );
  // Depends on CartRepository so "Add to Cart" on Meal Details lands in the
  // same cart the Cart screen reads from — registered after it.
  getIt.registerLazySingleton<MealDetailsRepository>(
    () => MealDetailsRepositoryImpl(
      cartRepository: getIt<CartRepository>(),
      dataSource: MealDetailsRemoteDataSource(getIt<ApiClient>()),
    ),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      dataSource: ProfileRemoteDataSource(getIt<ApiClient>(), getIt<SecureTokenStorage>()),
    ),
  );
  getIt.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(dataSource: OrdersRemoteDataSource(getIt<ApiClient>())),
  );
  getIt.registerLazySingleton<OrderHistoryRepository>(
    () => OrderHistoryRepositoryImpl(
      dataSource: OrderHistoryRemoteDataSource(getIt<ApiClient>()),
    ),
  );
  // TODO(backend): no accept/confirm-receipt/report-issue endpoints — stays mocked.
  getIt.registerLazySingleton<DeliveryRepository>(() => DeliveryRepositoryImpl());
  getIt.registerLazySingleton<RatingsRepository>(
    () => RatingsRepositoryImpl(dataSource: RatingsRemoteDataSource(getIt<ApiClient>())),
  );
  // TODO(backend): no notification push/sync endpoint — stays local-cache-only.
  getIt.registerLazySingleton<NotificationsRepository>(() => NotificationsRepositoryImpl());
  // TODO(backend): no catering endpoint — stays mocked.
  getIt.registerLazySingleton<CateringRepository>(() => CateringRepositoryImpl());
  // TODO(backend): no shorts endpoint — stays mocked.
  getIt.registerLazySingleton<ShortsRepository>(() => ShortsRepositoryImpl());
}
