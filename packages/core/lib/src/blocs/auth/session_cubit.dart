import 'package:flutter_bloc/flutter_bloc.dart';

import '../../storage/secure_token_storage.dart';

/// Whether a session token is currently persisted — the single source of
/// truth `app_router.dart`'s redirect logic gates entire route trees on.
/// `initiallyAuthenticated` is read once from secure storage before
/// `runApp()` so the very first route decision has no async race.
class SessionCubit extends Cubit<bool> {
  SessionCubit(this._storage, {required bool initiallyAuthenticated})
      : super(initiallyAuthenticated);

  final SecureTokenStorage _storage;

  /// Flips the session flag to authenticated. The token itself is expected
  /// to already be persisted by whichever datasource made the login/verify
  /// call (it's the only layer that sees the raw response) — this just
  /// notifies the router. `accessToken`/`refreshToken` remain accepted for
  /// callers (e.g. tests) that still want this cubit to own the write.
  Future<void> logIn({String? accessToken, String? refreshToken}) async {
    if (accessToken != null) {
      await _storage.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken ?? '',
      );
    }
    emit(true);
  }

  Future<void> logOut() async {
    await _storage.clear();
    emit(false);
  }
}
