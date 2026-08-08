import 'dart:io';

import 'package:core/core.dart';
import 'package:hive/hive.dart';

/// `LocaleCubit` persists via a Hive box — `Hive.initFlutter()` needs a
/// working `path_provider` platform channel that doesn't exist under
/// `flutter test`, so tests use the plain `hive` package's `Hive.init`
/// with an explicit temp directory instead.
Future<void> initHiveForTest() async {
  Hive.init(Directory.systemTemp.createTempSync('cook_app_test_hive_').path);
  await Hive.openBox(LocalCacheBoxNames.notifications);
  await Hive.openBox(LocalCacheBoxNames.cartSnapshot);
  await Hive.openBox(LocalCacheBoxNames.localePreference);
}
