import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/user_entity.dart';
import '../../network/jwt_payload.dart';
import '../../storage/secure_token_storage.dart';
import '../../storage/user_profile_cache.dart';
import 'session_state.dart';

/// The single source of truth the app's router redirect gates entire route
/// trees on — both *whether* there's a session and, since the app is
/// role-routed (customer vs. cook shell), *what role* it belongs to.
///
/// The initial state is derived once, synchronously relative to `runApp()`
/// — see [resolveInitialState], called from `configureDependencies()` after
/// awaiting a storage read, same as before this carried a role — so the
/// router's very first redirect decision never races an async lookup.
class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this._storage, this._profileCache, {required SessionState initialState})
      : super(initialState);

  final SecureTokenStorage _storage;
  final UserProfileCache _profileCache;

  /// Flips the session to authenticated. The token itself is expected to
  /// already be persisted by whichever datasource made the login/verify
  /// call (it's the only layer that sees the raw response) — this re-reads
  /// it to derive role, and to reject outright if it's already expired.
  /// `accessToken`/`refreshToken` remain accepted for callers (e.g. tests)
  /// that still want this cubit to own the write.
  Future<void> logIn({String? accessToken, String? refreshToken}) async {
    if (accessToken != null) {
      await _storage.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken ?? '',
      );
    }
    final token = accessToken ?? await _storage.readAccessToken();
    emit(_deriveState(token));
  }

  Future<void> logOut() async {
    await _storage.clear();
    await _profileCache.clear();
    emit(SessionState.unauthenticated);
  }

  /// Called once at app boot, with the token already read from storage
  /// (before `runApp()`) — judges a restored session by the exact same
  /// rule [logIn] uses for a fresh one, including expiry. A stale-but
  /// -present token is treated as no session at all, not silently trusted
  /// until the next API call happens to come back 401.
  static SessionState resolveInitialState(String? token) => _deriveState(token);

  static SessionState _deriveState(String? token) {
    if (token == null || token.isEmpty || isJwtExpired(token)) {
      return SessionState.unauthenticated;
    }
    final claims = decodeJwtPayload(token);
    final role = (claims['role'] ?? '').toString().toUpperCase() == 'COOK'
        ? UserRole.cook
        : UserRole.customer;
    return SessionState(isAuthenticated: true, role: role);
  }
}
