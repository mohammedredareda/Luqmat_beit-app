import 'package:flutter/material.dart';

/// Pagination dots for [OnboardingPage] — the active dot grows into a pill
/// and turns primary-colored, matching the onboarding mockup.
class PageDotsIndicator extends StatelessWidget {
  const PageDotsIndicator({super.key, required this.pageCount, required this.currentPage});

  final int pageCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < pageCount; i++)
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: i == currentPage ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == currentPage ? scheme.primary : scheme.outline,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
      ],
    );
  }
}
