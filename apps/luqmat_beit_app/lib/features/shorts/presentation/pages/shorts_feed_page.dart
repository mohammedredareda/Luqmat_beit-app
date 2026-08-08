import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../../../shared/widgets/customer_bottom_nav.dart';
import '../../domain/entities/short_entity.dart';
import '../../domain/usecases/get_shorts.dart';
import '../../domain/usecases/toggle_short_like.dart';
import '../cubit/shorts_feed_cubit.dart';
import '../cubit/shorts_feed_state.dart';
import '../widgets/short_slide.dart';

/// CU-26/27 — vertical, swipeable shorts feed. No real video backend
/// exists yet, so each slide renders a full-bleed still image (the meal's
/// `imageUrl`) as a placeholder "video frame" inside a vertical `PageView`,
/// with the like/comment/share/order overlay from
/// `shorts_feed_u17/code.html` layered on top. The bottom nav is overlaid
/// on top of the content (per the mockup's `<nav class="fixed bottom-0 ...">`
/// over a full-bleed `<main>`), not laid out below it.
class ShortsFeedPage extends StatelessWidget {
  const ShortsFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShortsFeedCubit(GetShorts(getIt()), ToggleShortLike(getIt()))
        ..loadShorts(),
      child: const _ShortsFeedView(),
    );
  }
}

class _ShortsFeedView extends StatelessWidget {
  const _ShortsFeedView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: BlocBuilder<ShortsFeedCubit, ShortsFeedState>(
              builder: (context, state) {
                return switch (state) {
                  ShortsFeedInitial() || ShortsFeedLoading() => const _ShortsLoadingSkeleton(),
                  ShortsFeedFailure(:final exception) => EmptyState(
                      icon: Icons.wifi_off,
                      title: 'تعذر تحميل الفيديوهات',
                      message: exception.message,
                      actionLabel: 'إعادة المحاولة',
                      onAction: () => context.read<ShortsFeedCubit>().loadShorts(),
                    ),
                  ShortsFeedLoaded(:final shorts) => _ShortsPageView(shorts: shorts),
                };
              },
            ),
          ),
          // Bottom nav overlaid over the full-bleed feed, matching the
          // mockup's `fixed bottom-0` nav sitting above the video content.
          const PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            child: CustomerBottomNav(currentTab: CustomerNavTab.shorts),
          ),
        ],
      ),
    );
  }
}

class _ShortsPageView extends StatelessWidget {
  const _ShortsPageView({required this.shorts});

  final List<ShortEntity> shorts;

  @override
  Widget build(BuildContext context) {
    if (shorts.isEmpty) {
      return const EmptyState(
        icon: Icons.movie_filter,
        title: 'لا توجد فيديوهات بعد',
        message: 'تابع الطباخين لمشاهدة أحدث الفيديوهات هنا.',
      );
    }

    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: shorts.length,
      itemBuilder: (context, index) {
        final short = shorts[index];
        return ShortSlide(
          short: short,
          onLike: () => context.read<ShortsFeedCubit>().toggleLike(short.id),
          onComment: () {},
          onShare: () {},
          onOrderMeal: () => context.push('/meal/${short.mealId}'),
        );
      },
    );
  }
}

class _ShortsLoadingSkeleton extends StatelessWidget {
  const _ShortsLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.black,
      child: Center(
        child: LoadingSkeleton(height: double.infinity, width: double.infinity),
      ),
    );
  }
}
