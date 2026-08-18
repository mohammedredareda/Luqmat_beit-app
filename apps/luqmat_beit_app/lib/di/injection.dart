import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

// Auth
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';

// ── Customer feature repositories/datasources ─────────────────────────────
import '../features/cart/data/datasources/cart_remote_data_source.dart';
import '../features/cart/data/repositories/cart_repository_impl.dart';
import '../features/cart/domain/repositories/cart_repository.dart';
import '../features/categories/data/datasources/categories_remote_data_source.dart';
import '../features/categories/data/repositories/categories_repository_impl.dart';
import '../features/categories/domain/repositories/categories_repository.dart';
import '../features/chef_profile/data/datasources/chef_remote_data_source.dart';
import '../features/chef_profile/data/repositories/chef_repository_impl.dart';
import '../features/chef_profile/domain/repositories/chef_repository.dart';
import '../features/delivery/data/repositories/delivery_repository_impl.dart';
import '../features/delivery/domain/repositories/delivery_repository.dart';
import '../features/favorites/data/datasources/favorites_local_data_source.dart';
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
// `ShortsRemoteDataSource` is declared independently in both `shorts`
// (customer) and `shorts_management` (cook) — same name, different classes
// — so both imports need a prefix to disambiguate (same pattern as
// `GetCookProfile` below).
import '../features/shorts/data/datasources/shorts_remote_data_source.dart'
    as customer_shorts;
import '../features/shorts/data/repositories/shorts_repository_impl.dart';
import '../features/shorts/domain/repositories/shorts_repository.dart';

// ── Cook feature data sources (each holds an in-memory "backend" — must be
// shared singletons so every feature reading/writing through it sees the
// same data). ────────────────────────────────────────────────────────────
import '../features/meal_management/data/datasources/meal_remote_data_source.dart';
import '../features/shorts_management/shared/data/datasources/shorts_remote_data_source.dart'
    as cook_shorts;
import '../features/offers_management/shared/data/datasources/discounts_remote_data_source.dart';
import '../features/offers_management/shared/data/datasources/offers_remote_data_source.dart';
import '../features/offers_management/shared/data/datasources/promotions_remote_data_source.dart';
import '../features/order_management/data/datasources/order_remote_data_source.dart';
import '../features/cook_profile/data/datasources/cook_profile_remote_data_source.dart';
import '../features/cook_profile/change_password/data/datasources/password_remote_data_source.dart';
import '../features/cook_profile/change_phone_number/data/datasources/phone_change_remote_data_source.dart';

// ── Cook feature repositories ──────────────────────────────────────────────
import '../features/meal_management/create_meal/domain/repositories/create_meal_repository.dart';
import '../features/meal_management/create_meal/data/repositories/create_meal_repository_impl.dart';
import '../features/meal_management/delete_meal/domain/repositories/delete_meal_repository.dart';
import '../features/meal_management/delete_meal/data/repositories/delete_meal_repository_impl.dart';
import '../features/meal_management/edit_meal/domain/repositories/edit_meal_repository.dart';
import '../features/meal_management/edit_meal/data/repositories/edit_meal_repository_impl.dart';
import '../features/meal_management/view_menu/domain/repositories/view_menu_repository.dart';
import '../features/meal_management/view_menu/data/repositories/view_menu_repository_impl.dart';
import '../features/offers_management/create_discount/domain/repositories/create_discount_repository.dart';
import '../features/offers_management/create_discount/data/repositories/create_discount_repository_impl.dart';
import '../features/offers_management/create_offer/domain/repositories/create_offer_repository.dart';
import '../features/offers_management/create_offer/data/repositories/create_offer_repository_impl.dart';
import '../features/offers_management/delete_discount/domain/repositories/delete_discount_repository.dart';
import '../features/offers_management/delete_discount/data/repositories/delete_discount_repository_impl.dart';
import '../features/offers_management/delete_offer/domain/repositories/delete_offer_repository.dart';
import '../features/offers_management/delete_offer/data/repositories/delete_offer_repository_impl.dart';
import '../features/offers_management/edit_discount/domain/repositories/edit_discount_repository.dart';
import '../features/offers_management/edit_discount/data/repositories/edit_discount_repository_impl.dart';
import '../features/offers_management/edit_offer/domain/repositories/edit_offer_repository.dart';
import '../features/offers_management/edit_offer/data/repositories/edit_offer_repository_impl.dart';
import '../features/offers_management/shared/domain/repositories/selectable_meals_repository.dart';
import '../features/offers_management/shared/data/repositories/selectable_meals_repository_impl.dart';
import '../features/offers_management/view_offers/domain/repositories/view_offers_repository.dart';
import '../features/offers_management/view_offers/data/repositories/view_offers_repository_impl.dart';
import '../features/order_management/order_details/domain/repositories/order_details_repository.dart';
import '../features/order_management/order_details/data/repositories/order_details_repository_impl.dart';
import '../features/order_management/view_orders/domain/repositories/view_orders_repository.dart';
import '../features/order_management/view_orders/data/repositories/view_orders_repository_impl.dart';
import '../features/shorts_management/create_short/domain/repositories/create_short_repository.dart';
import '../features/shorts_management/create_short/data/repositories/create_short_repository_impl.dart';
import '../features/shorts_management/delete_short/domain/repositories/delete_short_repository.dart';
import '../features/shorts_management/delete_short/data/repositories/delete_short_repository_impl.dart';
import '../features/shorts_management/view_shorts/domain/repositories/view_shorts_repository.dart';
import '../features/shorts_management/view_shorts/data/repositories/view_shorts_repository_impl.dart';
import '../features/cook_profile/change_password/domain/repositories/change_password_repository.dart';
import '../features/cook_profile/change_password/data/repositories/change_password_repository_impl.dart';
import '../features/cook_profile/change_phone_number/domain/repositories/change_phone_number_repository.dart';
import '../features/cook_profile/change_phone_number/data/repositories/change_phone_number_repository_impl.dart';
import '../features/cook_profile/edit_profile/domain/repositories/edit_profile_repository.dart';
import '../features/cook_profile/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import '../features/cook_profile/view_profile/domain/repositories/view_profile_repository.dart';
import '../features/cook_profile/view_profile/data/repositories/view_profile_repository_impl.dart';

// Use cases directly resolved from a widget (not just constructed inline
// inside a Bloc factory below) need their own registration.
import '../features/offers_management/shared/domain/usecases/lookup_meal.dart';

// Use cases constructed inline per-Bloc below.
import '../features/meal_management/create_meal/domain/usecases/create_meal.dart';
import '../features/meal_management/delete_meal/domain/usecases/delete_meal.dart';
import '../features/meal_management/edit_meal/domain/usecases/get_meal.dart';
import '../features/meal_management/edit_meal/domain/usecases/update_meal.dart';
import '../features/meal_management/view_menu/domain/usecases/get_my_meals.dart';
import '../features/meal_management/view_menu/domain/usecases/set_selling_paused.dart';
import '../features/offers_management/create_discount/domain/usecases/create_discount.dart';
import '../features/offers_management/create_offer/domain/usecases/create_offer.dart';
import '../features/offers_management/delete_discount/domain/usecases/delete_discount.dart';
import '../features/offers_management/delete_offer/domain/usecases/delete_offer.dart';
import '../features/offers_management/edit_discount/domain/usecases/get_discount.dart';
import '../features/offers_management/edit_discount/domain/usecases/update_discount.dart';
import '../features/offers_management/edit_offer/domain/usecases/get_offer.dart';
import '../features/offers_management/edit_offer/domain/usecases/update_offer.dart';
import '../features/offers_management/shared/domain/usecases/get_selectable_meals.dart';
import '../features/offers_management/view_offers/domain/usecases/get_offers_feed.dart';
import '../features/order_management/order_details/domain/usecases/accept_order.dart';
import '../features/order_management/order_details/domain/usecases/complete_order.dart';
import '../features/order_management/order_details/domain/usecases/get_order.dart';
import '../features/order_management/order_details/domain/usecases/reject_order.dart';
import '../features/order_management/view_orders/domain/usecases/get_orders.dart';
import '../features/shorts_management/create_short/domain/usecases/create_short.dart';
import '../features/shorts_management/delete_short/domain/usecases/delete_short.dart';
import '../features/shorts_management/view_shorts/domain/usecases/get_my_shorts.dart';
import '../features/cook_profile/change_password/domain/usecases/change_password.dart';
import '../features/cook_profile/change_phone_number/domain/usecases/request_phone_change.dart';
import '../features/cook_profile/change_phone_number/domain/usecases/resend_phone_change_code.dart';
import '../features/cook_profile/change_phone_number/domain/usecases/verify_phone_change_otp.dart';
import '../features/cook_profile/edit_profile/domain/usecases/update_cook_profile.dart';
// `GetCookProfile` is declared independently in both edit_profile and
// view_profile (same name, different repository dependency) — import with
// prefixes to disambiguate rather than registering either in GetIt.
import '../features/cook_profile/edit_profile/domain/usecases/get_cook_profile.dart'
    as edit_profile_uc;
import '../features/cook_profile/view_profile/domain/usecases/get_cook_profile.dart'
    as view_profile_uc;

// Blocs / Cubits
import '../features/meal_management/create_meal/presentation/bloc/create_meal_bloc.dart';
import '../features/meal_management/delete_meal/presentation/bloc/delete_meal_cubit.dart';
import '../features/meal_management/edit_meal/presentation/bloc/edit_meal_bloc.dart';
import '../features/meal_management/view_menu/presentation/bloc/stop_selling_cubit.dart';
import '../features/meal_management/view_menu/presentation/bloc/view_menu_cubit.dart';
import '../features/offers_management/create_discount/presentation/bloc/create_discount_bloc.dart';
import '../features/offers_management/create_offer/presentation/bloc/create_offer_bloc.dart';
import '../features/offers_management/delete_discount/presentation/bloc/delete_discount_cubit.dart';
import '../features/offers_management/delete_offer/presentation/bloc/delete_offer_cubit.dart';
import '../features/offers_management/edit_discount/presentation/bloc/edit_discount_bloc.dart';
import '../features/offers_management/edit_offer/presentation/bloc/edit_offer_bloc.dart';
import '../features/offers_management/shared/presentation/bloc/select_meal_cubit.dart';
import '../features/offers_management/view_offers/presentation/bloc/view_offers_cubit.dart';
import '../features/order_management/order_details/presentation/bloc/order_details_bloc.dart';
import '../features/order_management/view_orders/presentation/bloc/view_orders_cubit.dart';
import '../features/shorts_management/create_short/presentation/bloc/create_short_bloc.dart';
import '../features/shorts_management/delete_short/presentation/bloc/delete_short_cubit.dart';
import '../features/shorts_management/view_shorts/presentation/bloc/view_shorts_cubit.dart';
import '../features/cook_profile/change_password/presentation/bloc/change_password_cubit.dart';
import '../features/cook_profile/change_phone_number/presentation/bloc/change_phone_number_bloc.dart';
import '../features/cook_profile/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import '../features/cook_profile/view_profile/presentation/bloc/profile_cubit.dart';

final getIt = GetIt.instance;

/// Override at build/run time with `--dart-define=API_BASE_URL=...` (e.g.
/// to point at a local backend instead). Defaults to the hosted backend on
/// Render — note Render's free tier spins down on idle, so the first
/// request after a while can take 30-60s to respond (cold start), which can
/// look like a hang/timeout rather than a normal loading state.
const _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8080',
);

/// Wires every repository behind its domain interface for both the customer
/// and cook shells — one container for the whole app (see `router/app_router.dart`
/// for how the same session decides which shell's routes are reachable).
/// Features with a real backend endpoint (see
/// AI_INSTRUCTIONS/Loqmet Beit.postman_collection.json) use an
/// `XRemoteDataSource` backed by `ApiClient`; features with no matching
/// endpoint yet stay on their mock/fake datasource.
///
/// Use cases for the cook-side features are deliberately NOT registered
/// individually — they're cheap, stateless wrappers around a repository
/// call, so each Bloc/Cubit factory below constructs its own inline. The one
/// exception is [LookupMeal], which two page widgets resolve directly via
/// `getIt<LookupMeal>()`.
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
      apiClient: getIt<ApiClient>(),
      session: getIt<AuthSessionRepository>(),
      profileCache: getIt<UserProfileCache>(),
    ),
  );

  // Read once, synchronously ahead of runApp(), so the router's very first
  // redirect decision (which role's shell, or /login) never races an
  // async storage read.
  final existingToken = await getIt<SecureTokenStorage>().readAccessToken();
  getIt.registerLazySingleton<SessionCubit>(
    () => SessionCubit(
      getIt(),
      getIt(),
      initialState: SessionCubit.resolveInitialState(existingToken),
    ),
  );

  // ══ Shared infra (used by both roles) ══════════════════════════════════
  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(CategoriesRemoteDataSource(getIt<ApiClient>())),
  );

  // ══ Customer-side repositories ═══════════════════════════════════════
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(dataSource: HomeRemoteDataSource(getIt<ApiClient>())),
  );
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(dataSource: SearchRemoteDataSource(getIt<ApiClient>())),
  );
  getIt.registerLazySingleton<ChefRepository>(
    () => ChefRepositoryImpl(dataSource: ChefRemoteDataSource(getIt<ApiClient>())),
  );
  // No GET endpoint to list favorites/follows — FavoritesLocalDataSource
  // reads a local mirror kept in sync by meal_details/chef_profile's own
  // favorite/follow toggles (see FavoritesCache).
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(
      dataSource: FavoritesLocalDataSource(getIt<ApiClient>(), getIt<FavoritesCache>()),
    ),
  );
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
      dataSource: ProfileRemoteDataSource(
        getIt<ApiClient>(),
        getIt<SecureTokenStorage>(),
        getIt<UserProfileCache>(),
      ),
    ),
  );
  getIt.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(
      dataSource: OrdersRemoteDataSource(getIt<ApiClient>(), getIt<UserProfileCache>()),
    ),
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
  getIt.registerLazySingleton<ShortsRepository>(
    () => ShortsRepositoryImpl(
      dataSource: customer_shorts.ShortsRemoteDataSource(getIt<ApiClient>()),
    ),
  );

  // ══ Cook-side data sources (shared in-memory "backend" state) ═════════
  getIt.registerLazySingleton(() => MealRemoteDataSource(getIt<ApiClient>()));
  getIt.registerLazySingleton(() => OffersRemoteDataSource(getIt<ApiClient>()));
  getIt.registerLazySingleton(() => DiscountsRemoteDataSource(getIt<ApiClient>()));
  getIt.registerLazySingleton(() => PromotionsRemoteDataSource(getIt<ApiClient>()));
  getIt.registerLazySingleton(() => OrderRemoteDataSource(getIt<ApiClient>()));
  getIt.registerLazySingleton(() => CookProfileRemoteDataSource(getIt<ApiClient>()));
  getIt.registerLazySingleton(() => PasswordRemoteDataSource(getIt<ApiClient>()));
  getIt.registerLazySingleton(() => PhoneChangeRemoteDataSource(getIt<ApiClient>()));
  // Real Content endpoints (create/delete); list still stays local — see
  // ShortsRemoteDataSource's doc comment.
  getIt.registerLazySingleton(() => cook_shorts.ShortsRemoteDataSource(getIt<ApiClient>()));

  // ══ Cook-side repositories ═════════════════════════════════════════
  getIt.registerLazySingleton<CreateMealRepository>(
    () => CreateMealRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<DeleteMealRepository>(
    () => DeleteMealRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<EditMealRepository>(
    () => EditMealRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ViewMenuRepository>(
    () => ViewMenuRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<CreateDiscountRepository>(
    () => CreateDiscountRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<CreateOfferRepository>(
    () => CreateOfferRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<DeleteDiscountRepository>(
    () => DeleteDiscountRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<DeleteOfferRepository>(
    () => DeleteOfferRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<EditDiscountRepository>(
    () => EditDiscountRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<EditOfferRepository>(
    () => EditOfferRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<SelectableMealsRepository>(
    () => SelectableMealsRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ViewOffersRepository>(
    () => ViewOffersRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<OrderDetailsRepository>(
    () => OrderDetailsRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ViewOrdersRepository>(
    () => ViewOrdersRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ChangePasswordRepository>(
    () => ChangePasswordRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ChangePhoneNumberRepository>(
    () => ChangePhoneNumberRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<EditProfileRepository>(
    () => EditProfileRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ViewProfileRepository>(
    () => ViewProfileRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<CreateShortRepository>(
    () => CreateShortRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<DeleteShortRepository>(
    () => DeleteShortRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ViewShortsRepository>(
    () => ViewShortsRepositoryImpl(getIt()),
  );

  // ══ Cook-side use cases resolved directly by a widget ═════════════════
  getIt.registerLazySingleton(() => LookupMeal(getIt()));

  // ══ Cook-side Blocs / Cubits (factories — each construct their own use
  // cases) ════════════════════════════════════════════════════════════
  getIt.registerFactory(
    () => CreateMealBloc(CreateMeal(getIt())),
  );
  getIt.registerFactory(
    () => DeleteMealCubit(DeleteMeal(getIt())),
  );
  getIt.registerFactory(
    () => EditMealBloc(GetMeal(getIt()), UpdateMeal(getIt())),
  );
  getIt.registerFactory(
    () => StopSellingCubit(SetSellingPaused(getIt())),
  );
  getIt.registerFactory(
    () => ViewMenuCubit(GetMyMeals(getIt())),
  );
  getIt.registerFactory(
    () => CreateDiscountBloc(CreateDiscount(getIt())),
  );
  getIt.registerFactory(
    () => CreateOfferBloc(CreateOffer(getIt())),
  );
  getIt.registerFactory(
    () => DeleteDiscountCubit(DeleteDiscount(getIt())),
  );
  getIt.registerFactory(
    () => DeleteOfferCubit(DeleteOffer(getIt())),
  );
  getIt.registerFactory(
    () => EditDiscountBloc(GetDiscount(getIt()), UpdateDiscount(getIt())),
  );
  getIt.registerFactory(
    () => EditOfferBloc(GetOffer(getIt()), UpdateOffer(getIt())),
  );
  getIt.registerFactory(
    () => SelectMealCubit(GetSelectableMeals(getIt())),
  );
  getIt.registerFactory(
    () => ViewOffersCubit(GetOffersFeed(getIt())),
  );
  getIt.registerFactory(
    () => OrderDetailsBloc(
      GetOrder(getIt()),
      AcceptOrder(getIt()),
      RejectOrder(getIt()),
      CompleteOrder(getIt()),
    ),
  );
  getIt.registerFactory(
    () => ViewOrdersCubit(GetOrders(getIt())),
  );
  getIt.registerFactory(
    () => ChangePasswordCubit(ChangePassword(getIt())),
  );
  getIt.registerFactory(
    () => ChangePhoneNumberBloc(
      RequestPhoneChange(getIt()),
      VerifyPhoneChangeOtp(getIt()),
      ResendPhoneChangeCode(getIt()),
    ),
  );
  getIt.registerFactory(
    () => EditProfileBloc(
      edit_profile_uc.GetCookProfile(getIt()),
      UpdateCookProfile(getIt()),
      DetectCurrentLocation(getIt()),
    ),
  );
  getIt.registerFactory(
    () => ProfileCubit(view_profile_uc.GetCookProfile(getIt())),
  );
  getIt.registerFactory(
    () => CreateShortBloc(CreateShort(getIt())),
  );
  getIt.registerFactory(
    () => DeleteShortCubit(DeleteShort(getIt())),
  );
  getIt.registerFactory(
    () => ViewShortsCubit(GetMyShorts(getIt())),
  );
}
