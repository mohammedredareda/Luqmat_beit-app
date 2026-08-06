import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// The shared "centered card with a header photo" shell used by every auth
/// screen in the mockups (registration/forgot/reset password) — header
/// image + gradient + floating back button, then a scrollable form area.
class AuthCardScaffold extends StatelessWidget {
  const AuthCardScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.formChildren,
    this.showBackButton = true,
  });

  final String title;
  final String subtitle;
  final List<Widget> formChildren;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpace.l,
              vertical: AppSpace.xl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Material(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                clipBehavior: Clip.antiAlias,
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 140,
                          decoration: BoxDecoration(color: scheme.surfaceContainerLow),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [scheme.surface, scheme.surface.withValues(alpha: 0)],
                              ),
                            ),
                          ),
                        ),
                        if (showBackButton)
                          PositionedDirectional(
                            top: AppSpace.m,
                            end: AppSpace.m,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).maybePop(),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: scheme.surface.withValues(alpha: 0.8),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.arrow_forward, color: scheme.primary),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.all(AppSpace.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              Text(
                                title,
                                textAlign: TextAlign.center,
                                style: textTheme.headlineSmall?.copyWith(color: scheme.primary),
                              ),
                              const SizedBox(height: AppSpace.xs),
                              Text(
                                subtitle,
                                textAlign: TextAlign.center,
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.inkMutedLight),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpace.xl),
                          ...formChildren,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
