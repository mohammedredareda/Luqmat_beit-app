import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../auth/auth_session_repository.dart';
import '../auth/auth_session_repository_impl.dart';
import '../l10n/locale_cubit.dart';
import '../location/location_repository.dart';
import '../location/location_repository_impl.dart';
import '../network/api_client.dart';
import '../network/dio_client.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/logging_interceptor.dart';
import '../storage/onboarding_status_store.dart';
import '../storage/secure_token_storage.dart';
import '../storage/user_profile_cache.dart';
import '../storage/favorites_cache.dart';
import '../blocs/auth/session_cubit.dart';
import '../blocs/connectivity/connectivity_cubit.dart';

/// Registers everything `core` provides into the app's [GetIt] instance.
///
/// NOTE — deviation from the architecture doc's "get_it + injectable
/// (codegen)" recommendation: this repo registers dependencies by hand
/// instead. Injectable's codegen chain (build_runner + analyzer-pinned
/// versions) proved fragile against the Flutter/Dart SDK versions
/// available in this environment; manual get_it registration is the same
/// DI story with strictly less moving parts, at the cost of writing this
/// one file by hand as new services are added. Revisit if the project
/// later needs injectable's environment-scoped registration.
Future<void> registerCoreDependencies(
  GetIt getIt, {
  required String baseUrl,
  Duration connectTimeout = const Duration(seconds: 60),
  Duration receiveTimeout = const Duration(seconds: 60),
}) async {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<SecureTokenStorage>(
    () => SecureTokenStorage(getIt()),
  );

  getIt.registerLazySingleton<UserProfileCache>(() => UserProfileCache());
  getIt.registerLazySingleton<FavoritesCache>(() => FavoritesCache());

  getIt.registerLazySingleton<ApiClient>(
    () => DioClient(
      dio: Dio(),
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      interceptors: [
        AuthInterceptor(
          getToken: () => getIt<SecureTokenStorage>().readAccessToken(),
          // A 401 means the stored token is no longer valid. Route through
          // SessionCubit (not just clearing storage) so its stream emits and
          // the router's redirect immediately kicks the user to /register.
          // ApiClient is lazily created, so by the time any request actually
          // fires, SessionCubit (registered right after this call) is
          // already available in getIt.
          onUnauthorized: () => getIt<SessionCubit>().logOut(),
        ),
        LoggingInterceptor(enabled: kDebugMode),
      ],
    ),
  );

  getIt.registerLazySingleton<LocaleCubit>(() => LocaleCubit());
  getIt.registerLazySingleton<ConnectivityCubit>(() => ConnectivityCubit());
  getIt.registerLazySingleton<OnboardingStatusStore>(() => OnboardingStatusStore());

  // Login/OTP/reset-password are identical across roles — shared here so
  // neither app reimplements the same API calls. Registration stays
  // per-app (each app's own AuthRepository) since its fields differ.
  getIt.registerLazySingleton<AuthSessionRepository>(
    () => AuthSessionRepositoryImpl(
      getIt<ApiClient>(),
      getIt<SecureTokenStorage>(),
      getIt<UserProfileCache>(),
    ),
  );

  getIt.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl());
}
