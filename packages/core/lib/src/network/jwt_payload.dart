import 'dart:convert';

/// Best-effort decode of a JWT's payload (claims) segment — no signature
/// verification, just claim extraction. Used where the backend returns a
/// bare token with no accompanying user object, so callers can pull an id/
/// role/etc. out of the token itself. Returns `{}` if the token isn't a
/// well-formed 3-part JWT.
Map<String, dynamic> decodeJwtPayload(String token) {
  final parts = token.split('.');
  if (parts.length != 3) return const {};
  try {
    var payload = parts[1];
    payload += '=' * ((4 - payload.length % 4) % 4);
    final decoded = utf8.decode(base64Url.decode(payload));
    final map = jsonDecode(decoded);
    return map is Map<String, dynamic> ? map : const {};
  } catch (_) {
    return const {};
  }
}

/// Reads a JWT's `exp` claim (Unix seconds) and reports whether it's already
/// in the past. A token with no `exp` claim (or an unparseable one) is
/// treated as expired — fail closed, since the alternative is silently
/// trusting a token we can't actually verify a lifetime for.
bool isJwtExpired(String token) {
  final exp = decodeJwtPayload(token)['exp'];
  if (exp is! int) return true;
  final expiresAt = DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true);
  return DateTime.now().toUtc().isAfter(expiresAt);
}
