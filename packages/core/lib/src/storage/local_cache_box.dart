import 'package:hive_flutter/hive_flutter.dart';

/// Hive box names — the offline-readable cache backing the notification
/// reliability rule ("always visible in-app regardless of push outcome")
/// and the cart snapshot. Values are stored as plain JSON maps, so no
/// custom TypeAdapter/codegen is needed.
abstract final class LocalCacheBoxNames {
  static const notifications = 'notifications_box';
  static const cartSnapshot = 'cart_snapshot_box';
  static const localePreference = 'locale_preference_box';
  static const userProfile = 'user_profile_box';
  static const favorites = 'favorites_box';
  static const onboarding = 'onboarding_box';
}

class LocalCacheBox {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox(LocalCacheBoxNames.notifications),
      Hive.openBox(LocalCacheBoxNames.cartSnapshot),
      Hive.openBox(LocalCacheBoxNames.localePreference),
      Hive.openBox(LocalCacheBoxNames.userProfile),
      Hive.openBox(LocalCacheBoxNames.favorites),
      Hive.openBox(LocalCacheBoxNames.onboarding),
    ]);
  }

  static Box box(String name) => Hive.box(name);
}
