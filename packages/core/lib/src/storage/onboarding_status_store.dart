import 'package:hive_flutter/hive_flutter.dart';

import 'local_cache_box.dart';

/// Whether the user has completed the onboarding slides — checked once by
/// the splash screen to decide whether to show them again.
class OnboardingStatusStore {
  static const _key = 'has_seen_onboarding';

  Box get _box => LocalCacheBox.box(LocalCacheBoxNames.onboarding);

  bool hasSeenOnboarding() => (_box.get(_key) as bool?) ?? false;

  Future<void> markSeen() => _box.put(_key, true);
}
