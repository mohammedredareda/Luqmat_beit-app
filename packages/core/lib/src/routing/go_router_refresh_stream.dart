import 'dart:async';

import 'package:flutter/foundation.dart';

/// Bridges a `Stream` (here, `SessionCubit`'s state stream) into the
/// `Listenable` go_router's `refreshListenable` expects — the standard
/// go_router pattern for re-running `redirect` whenever auth state changes,
/// not just on navigation.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
