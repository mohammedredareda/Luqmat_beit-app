import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

/// In-memory stand-in for [OnboardingStatusStore] — avoids real Hive disk
/// I/O inside a `testWidgets` FakeAsync zone, which doesn't reliably
/// complete within `pumpAndSettle`.
class _FakeOnboardingStatusStore implements OnboardingStatusStore {
  bool _seen = false;

  @override
  bool hasSeenOnboarding() => _seen;

  @override
  Future<void> markSeen() async => _seen = true;
}

GoRouter _buildRouter() => GoRouter(
  initialLocation: '/onboarding',
  routes: [
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
  late AppLocalizations l10n;
  late _FakeOnboardingStatusStore store;

  setUp(() async {
    await getIt.reset();
    store = _FakeOnboardingStatusStore();
    getIt.registerLazySingleton<OnboardingStatusStore>(() => store);
    l10n = await AppLocalizations.delegate.load(const Locale('ar'));
  });

  testWidgets('Next advances through all 3 slides', (tester) async {
    await tester.pumpWidget(_wrap(_buildRouter()));
    await tester.pumpAndSettle();

    expect(find.text(l10n.onboardingSlide1Title), findsOneWidget);
    expect(find.text(l10n.onboardingNext), findsOneWidget);

    await tester.tap(find.text(l10n.onboardingNext));
    await tester.pumpAndSettle();
    expect(find.text(l10n.onboardingSlide2Title), findsOneWidget);

    await tester.tap(find.text(l10n.onboardingNext));
    await tester.pumpAndSettle();
    expect(find.text(l10n.onboardingSlide3Title), findsOneWidget);
    expect(find.text(l10n.onboardingStart), findsOneWidget);
  });

  testWidgets('Skip is disabled on the last page', (tester) async {
    await tester.pumpWidget(_wrap(_buildRouter()));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.onboardingNext));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.onboardingNext));
    await tester.pumpAndSettle();

    final skipButton = tester.widget<TextButton>(
      find.widgetWithText(TextButton, l10n.onboardingSkip),
    );
    expect(skipButton.onPressed, isNull);
  });

  testWidgets('finishing marks onboarding as seen and navigates home', (tester) async {
    await tester.pumpWidget(_wrap(_buildRouter()));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.onboardingNext));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.onboardingNext));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.onboardingStart));
    await tester.pumpAndSettle();

    expect(store.hasSeenOnboarding(), isTrue);
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('Skip immediately marks onboarding as seen and navigates home', (tester) async {
    await tester.pumpWidget(_wrap(_buildRouter()));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.onboardingSkip));
    await tester.pumpAndSettle();

    expect(store.hasSeenOnboarding(), isTrue);
    expect(find.text('home'), findsOneWidget);
  });
}
