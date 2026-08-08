import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luqmat_beit_app/router/app_router.dart';

void main() {
  group('resolveRedirect — unauthenticated', () {
    const session = SessionState.unauthenticated;

    test('any non-auth route redirects to /register', () {
      expect(resolveRedirect(session, '/'), '/register');
      expect(resolveRedirect(session, '/cook/menu'), '/register');
      expect(resolveRedirect(session, '/meal/42'), '/register');
    });

    test('auth routes stay put', () {
      for (final route in [
        '/login',
        '/register',
        '/otp-verification',
        '/forgot-password',
        '/reset-password',
      ]) {
        expect(resolveRedirect(session, route), isNull, reason: route);
      }
    });
  });

  group('resolveRedirect — authenticated customer', () {
    const session = SessionState(isAuthenticated: true, role: UserRole.customer);

    test('an auth route redirects home', () {
      expect(resolveRedirect(session, '/login'), '/');
      expect(resolveRedirect(session, '/register'), '/');
    });

    test('a cook route redirects home', () {
      expect(resolveRedirect(session, '/cook/menu'), '/');
      expect(resolveRedirect(session, '/cook/orders/1'), '/');
    });

    test('a customer route stays put', () {
      expect(resolveRedirect(session, '/'), isNull);
      expect(resolveRedirect(session, '/search'), isNull);
      expect(resolveRedirect(session, '/profile'), isNull);
    });
  });

  group('resolveRedirect — authenticated cook', () {
    const session = SessionState(isAuthenticated: true, role: UserRole.cook);

    test('an auth route redirects to the cook menu', () {
      expect(resolveRedirect(session, '/login'), '/cook/menu');
      expect(resolveRedirect(session, '/register'), '/cook/menu');
    });

    test('a customer route redirects to the cook menu', () {
      expect(resolveRedirect(session, '/'), '/cook/menu');
      expect(resolveRedirect(session, '/profile'), '/cook/menu');
    });

    test('a cook route stays put', () {
      expect(resolveRedirect(session, '/cook/menu'), isNull);
      expect(resolveRedirect(session, '/cook/orders/1'), isNull);
    });
  });
}
