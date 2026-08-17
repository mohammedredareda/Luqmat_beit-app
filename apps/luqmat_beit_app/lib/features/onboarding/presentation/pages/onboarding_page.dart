import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../../di/injection.dart';
import '../widgets/onboarding_slide.dart';
import '../widgets/page_dots_indicator.dart';

/// 3-slide first-launch introduction. The only state is "which page is
/// active," driven entirely by [PageView]/button taps — a plain
/// [StatefulWidget] with a local `int` is enough; there's no async work or
/// error state a Cubit/Freezed union would add value over.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const _pageCount = 3;

  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _isLastPage => _currentPage == _pageCount - 1;

  Future<void> _finish() async {
    await getIt<OnboardingStatusStore>().markSeen();
    if (mounted) context.go('/');
  }

  void _next() {
    if (_isLastPage) {
      _finish();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final slides = [
      (icon: Icons.soup_kitchen, title: l10n.onboardingSlide1Title, body: l10n.onboardingSlide1Body),
      (
        icon: Icons.delivery_dining,
        title: l10n.onboardingSlide2Title,
        body: l10n.onboardingSlide2Body,
      ),
      (icon: Icons.diversity_3, title: l10n.onboardingSlide3Title, body: l10n.onboardingSlide3Body),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  for (final slide in slides)
                    OnboardingSlide(icon: slide.icon, title: slide.title, body: slide.body),
                ],
              ),
            ),
            Padding(
              padding: AppSpace.screenPadding.add(const EdgeInsetsDirectional.only(bottom: AppSpace.xl)),
              child: Column(
                children: [
                  PageDotsIndicator(pageCount: _pageCount, currentPage: _currentPage),
                  const SizedBox(height: AppSpace.xl),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _next,
                      child: Text(_isLastPage ? l10n.onboardingStart : l10n.onboardingNext),
                    ),
                  ),
                  const SizedBox(height: AppSpace.s),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _isLastPage ? 0 : 1,
                    child: TextButton(
                      onPressed: _isLastPage ? null : _finish,
                      child: Text(l10n.onboardingSkip),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
