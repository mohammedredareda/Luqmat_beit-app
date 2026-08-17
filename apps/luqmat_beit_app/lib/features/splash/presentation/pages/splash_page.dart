import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../di/injection.dart';
import '../../../../shared/widgets/circle_badge.dart';

/// First screen shown on cold start. Plays a fixed fade-in animation, then
/// decides — synchronously, no fetch involved — whether to show onboarding
/// (first launch) or fall through to the normal session-gated router flow.
/// A plain [StatefulWidget] is enough here: there's no async data to
/// represent as UI-distinct states, just one flag read and one navigation
/// call, so a Cubit/Freezed state union would be ceremony with nothing to
/// branch on.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Kick the fade/slide-in on the first frame rather than in initState
    // itself, so the initial (invisible) frame actually paints first.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _visible = true);
    });
    _scheduleNavigation();
  }

  Future<void> _scheduleNavigation() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final hasSeenOnboarding = getIt<OnboardingStatusStore>().hasSeenOnboarding();
    context.go(hasSeenOnboarding ? '/' : '/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSlide(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
              offset: _visible ? Offset.zero : const Offset(0, 0.06),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOut,
                opacity: _visible ? 1 : 0,
                child: CircleBadge(
                  size: 128,
                  child: Image.asset(
                    'assets/images/logo/luqmat_beit_logo.png',
                    width: 64,
                    height: 64,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.l),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
              opacity: _visible ? 1 : 0,
              child: Text('Luqmat Beit', style: textTheme.displaySmall, textAlign: TextAlign.center),
            ),
            const SizedBox(height: AppSpace.s),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeOut,
              opacity: _visible ? 1 : 0,
              child: Text(
                'أطيب أكل بيت، لعندك',
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: AppSpace.xxl),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeOut,
              opacity: _visible ? 1 : 0,
              child: _LoadingPill(color: scheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}

/// Purely decorative "still loading" cue — no percentage/text, per the
/// splash mockup.
class _LoadingPill extends StatefulWidget {
  const _LoadingPill({required this.color});

  final Color color;

  @override
  State<_LoadingPill> createState() => _LoadingPillState();
}

class _LoadingPillState extends State<_LoadingPill> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.3, end: 1.0).animate(_controller),
      child: Container(
        width: 48,
        height: 4,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
      ),
    );
  }
}
