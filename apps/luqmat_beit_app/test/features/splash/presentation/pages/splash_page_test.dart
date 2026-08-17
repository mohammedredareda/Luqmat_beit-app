import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:luqmat_beit_app/features/splash/presentation/pages/splash_page.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

/// In-memory stand-in for [OnboardingStatusStore] — avoids real Hive disk
/// I/O inside a `testWidgets` FakeAsync zone, which doesn't reliably
/// complete within `pump`/`pumpAndSettle`.
class _FakeOnboardingStatusStore implements OnboardingStatusStore {
  _FakeOnboardingStatusStore({bool seen = false}) : _seen = seen;

  bool _seen;

  @override
  bool hasSeenOnboarding() => _seen;

  @override
  Future<void> markSeen() async => _seen = true;
}

GoRouter _buildRouter() => GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingPage()),
    GoRoute(path: '/', builder: (context, state) => const Scaffold(body: Text('home'))),
  ],
);

Widget _wrap(GoRouter router) => MaterialApp.router(
  theme: AppTheme.light,
  locale: const Locale('ar'),
  supportedLocales: const [Locale('ar'), Locale('en')],
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  routerConfig: router,
);

void main() {
  setUp(() async {
    await getIt.reset();
  });

  // Note: deliberately uses tester.pump() with explicit durations rather
  // than pumpAndSettle() — the splash page's loading pill runs a repeating
  // AnimationController that never settles.
  testWidgets('navigates to /onboarding when onboarding has not been seen yet', (tester) async {
    getIt.registerLazySingleton<OnboardingStatusStore>(() => _FakeOnboardingStatusStore());

    await tester.pumpWidget(_wrap(_buildRouter()));

    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    // The outgoing SplashPage's default MaterialPage exit transition keeps
    // it in the tree briefly after navigation — advance past it so the
    // Navigator has actually swapped pages by the time we assert.
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(OnboardingPage), findsOneWidget);
  });

  testWidgets('navigates straight to / when onboarding was already seen', (tester) async {
    getIt.registerLazySingleton<OnboardingStatusStore>(
      () => _FakeOnboardingStatusStore(seen: true),
    );

    await tester.pumpWidget(_wrap(_buildRouter()));

    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(SplashPage), findsNothing);
    expect(find.text('home'), findsOneWidget);
  });
}
