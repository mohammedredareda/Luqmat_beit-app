import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

// Data sources (each holds an in-memory "backend" — must be shared
// singletons so every feature reading/writing through it sees the same
// data).
import '../features/meal_management/data/datasources/fake_meal_remote_data_source.dart';
import '../features/offers_management/shared/data/datasources/fake_discounts_remote_data_source.dart';
import '../features/offers_management/shared/data/datasources/fake_offers_remote_data_source.dart';
import '../features/order_management/data/datasources/fake_order_remote_data_source.dart';
import '../features/profile/data/datasources/fake_cook_profile_remote_data_source.dart';
import '../features/profile/change_password/data/datasources/fake_password_remote_data_source.dart';
import '../features/profile/change_phone_number/data/datasources/fake_phone_change_remote_data_source.dart';

// Repositories
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
import '../features/profile/change_password/domain/repositories/change_password_repository.dart';
import '../features/profile/change_password/data/repositories/change_password_repository_impl.dart';
import '../features/profile/change_phone_number/domain/repositories/change_phone_number_repository.dart';
import '../features/profile/change_phone_number/data/repositories/change_phone_number_repository_impl.dart';
import '../features/profile/edit_profile/domain/repositories/edit_profile_repository.dart';
import '../features/profile/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import '../features/profile/view_profile/domain/repositories/view_profile_repository.dart';
import '../features/profile/view_profile/data/repositories/view_profile_repository_impl.dart';

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
import '../features/profile/change_password/domain/usecases/change_password.dart';
import '../features/profile/change_phone_number/domain/usecases/request_phone_change.dart';
import '../features/profile/change_phone_number/domain/usecases/resend_phone_change_code.dart';
import '../features/profile/change_phone_number/domain/usecases/verify_phone_change_otp.dart';
import '../features/profile/edit_profile/domain/usecases/update_cook_profile.dart';
// `GetCookProfile` is declared independently in both edit_profile and
// view_profile (same name, different repository dependency) — import with
// prefixes to disambiguate rather than registering either in GetIt.
import '../features/profile/edit_profile/domain/usecases/get_cook_profile.dart'
    as edit_profile_uc;
import '../features/profile/view_profile/domain/usecases/get_cook_profile.dart'
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
import '../features/profile/change_password/presentation/bloc/change_password_cubit.dart';
import '../features/profile/change_phone_number/presentation/bloc/change_phone_number_bloc.dart';
import '../features/profile/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import '../features/profile/view_profile/presentation/bloc/profile_cubit.dart';

final getIt = GetIt.instance;

/// Manual `GetIt` registration — matches `packages/core`'s
/// `registerCoreDependencies` approach (see its doc comment): `injectable`'s
/// codegen chain (build_runner + analyzer-pinned versions) proved fragile
/// against the Flutter/Dart SDK versions available in this environment, so
/// this file replaces it entirely rather than fighting version pins.
///
/// Use cases are deliberately NOT registered individually — they're cheap,
/// stateless wrappers around a repository call, so each Bloc/Cubit factory
/// below constructs its own inline. The one exception is [LookupMeal],
/// which two page widgets resolve directly via `getIt<LookupMeal>()`.
void configureDependencies() {
  // ── Data sources (shared in-memory "backend" state) ──────────────────
  getIt.registerLazySingleton(() => FakeMealRemoteDataSource());
  getIt.registerLazySingleton(() => FakeDiscountsRemoteDataSource());
  getIt.registerLazySingleton(() => FakeOffersRemoteDataSource());
  getIt.registerLazySingleton(() => FakeOrderRemoteDataSource());
  getIt.registerLazySingleton(() => FakeCookProfileRemoteDataSource());
  getIt.registerLazySingleton(() => FakePasswordRemoteDataSource());
  getIt.registerLazySingleton(
    () => FakePhoneChangeRemoteDataSource(getIt()),
  );

  // ── Repositories ───────────────────────────────────────────────────
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
    () => ViewOffersRepositoryImpl(getIt(), getIt()),
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

  // ── Use cases resolved directly by a widget ───────────────────────
  getIt.registerLazySingleton(() => LookupMeal(getIt()));

  // ── `core` ─────────────────────────────────────────────────────────
  getIt.registerLazySingleton<LocaleCubit>(() => LocaleCubit());

  // ── Blocs / Cubits (factories — each construct their own use cases) ─
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
    ),
  );
  getIt.registerFactory(
    () => ProfileCubit(view_profile_uc.GetCookProfile(getIt())),
  );
}
