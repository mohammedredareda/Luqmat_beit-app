import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

/// Provides types from `packages/core` (which stays DI-framework-agnostic
/// and carries no injectable annotations of its own), plus the base `Dio`
/// instance and its `DioClient` wrapper. Nothing in the view_menu feature
/// consumes `DioClient` yet — it's backed by a fake repository for this
/// pass — but it's wired here for architecture completeness, so the
/// future Dio-backed repository swap needs no new DI plumbing.
@module
abstract class RegisterModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  LocalePreferenceStorage localePreferenceStorage(FlutterSecureStorage storage) =>
      SecureLocaleStorage(storage);

  @lazySingleton
  LocaleCubit localeCubit(LocalePreferenceStorage storage) => LocaleCubit(storage);

  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  DioClient dioClient(Dio dio) => DioClient(
        dio: dio,
        baseUrl: 'https://api.luqmatbeit.example/v1',
      );
}
