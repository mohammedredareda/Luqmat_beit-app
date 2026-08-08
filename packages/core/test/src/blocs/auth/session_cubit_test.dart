import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

/// Builds a syntactically-valid JWT (header.payload.signature) carrying the
/// given claims — no real signing, since [SessionCubit] never verifies a
/// signature, only reads claims.
String _fakeJwt(Map<String, dynamic> claims) {
  String encode(Map<String, dynamic> map) =>
      base64Url.encode(utf8.encode(jsonEncode(map))).replaceAll('=', '');
  final header = encode({'alg': 'HS256', 'typ': 'JWT'});
  final payload = encode(claims);
  return '$header.$payload.fake-signature';
}

int _secondsFromNow(Duration offset) =>
    DateTime.now().toUtc().add(offset).millisecondsSinceEpoch ~/ 1000;

void main() {
  group('SessionCubit.resolveInitialState', () {
    test('no stored token resolves to unauthenticated', () {
      expect(SessionCubit.resolveInitialState(null), SessionState.unauthenticated);
    });

    test('a valid, non-expired cook token resolves to authenticated cook', () {
      final token = _fakeJwt({
        'sub': 1,
        'role': 'COOK',
        'exp': _secondsFromNow(const Duration(hours: 1)),
      });

      final state = SessionCubit.resolveInitialState(token);

      expect(state.isAuthenticated, isTrue);
      expect(state.role, UserRole.cook);
    });

    test('a valid, non-expired customer token resolves to authenticated customer', () {
      final token = _fakeJwt({
        'sub': 2,
        'role': 'CUSTOMER',
        'exp': _secondsFromNow(const Duration(hours: 1)),
      });

      final state = SessionCubit.resolveInitialState(token);

      expect(state.isAuthenticated, isTrue);
      expect(state.role, UserRole.customer);
    });

    test('an expired token is rejected outright, not trusted until a 401', () {
      final token = _fakeJwt({
        'sub': 1,
        'role': 'COOK',
        'exp': _secondsFromNow(const Duration(hours: -1)),
      });

      expect(SessionCubit.resolveInitialState(token), SessionState.unauthenticated);
    });

    test('a token with no exp claim is rejected (fail closed)', () {
      final token = _fakeJwt({'sub': 1, 'role': 'COOK'});

      expect(SessionCubit.resolveInitialState(token), SessionState.unauthenticated);
    });

    test('a malformed token is rejected', () {
      expect(SessionCubit.resolveInitialState('not-a-jwt'), SessionState.unauthenticated);
    });
  });
}
