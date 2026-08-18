import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../../../shared/widgets/customer_bottom_nav.dart';
import '../../domain/entities/short_entity.dart';
import '../../domain/usecases/get_shorts.dart';
import '../../domain/usecases/mark_short_viewed.dart';
import '../../domain/usecases/toggle_short_like.dart';
import '../cubit/shorts_feed_cubit.dart';
import '../cubit/shorts_feed_state.dart';
import '../widgets/short_comments_sheet.dart';
import '../widgets/short_slide.dart';

/// CU-26/27 — vertical, swipeable shorts feed backed by
/// `GET /user/customer/content/feed`. The bottom nav is overlaid on top of
/// the content (per the mockup's `<nav class="fixed bottom-0 ...">` over a
/// full-bleed `<main>`), not laid out below it.
class ShortsFeedPage extends StatelessWidget {
  const ShortsFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShortsFeedCubit(
        GetShorts(getIt()),
        ToggleShortLike(getIt()),
        MarkShortViewed(getIt()),
      )..loadShorts(),
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

class _ShortsPageView extends StatefulWidget {
  const _ShortsPageView({required this.shorts});

  final List<ShortEntity> shorts;

  @override
  State<_ShortsPageView> createState() => _ShortsPageViewState();
}

class _ShortsPageViewState extends State<_ShortsPageView> {
  final _pageController = PageController();
  int _activeIndex = 0;
  final Set<String> _viewedIds = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _markViewed(0));
  }

  void _markViewed(int index) {
    if (index < 0 || index >= widget.shorts.length) return;
    final id = widget.shorts[index].id;
    if (_viewedIds.add(id)) {
      context.read<ShortsFeedCubit>().markViewed(id);
    }
  }

  void _onPageChanged(int index) {
    setState(() => _activeIndex = index);
    _markViewed(index);
    // A vertical feed is effectively infinite scroll — start fetching the
    // next page a couple of slides before the customer actually runs out.
    if (index >= widget.shorts.length - 2) {
      context.read<ShortsFeedCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shorts.isEmpty) {
      return const EmptyState(
        icon: Icons.movie_filter,
        title: 'لا توجد فيديوهات بعد',
        message: 'تابع الطباخين لمشاهدة أحدث الفيديوهات هنا.',
      );
    }

    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: widget.shorts.length,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, index) {
        final short = widget.shorts[index];
        final cubit = context.read<ShortsFeedCubit>();
        return ShortSlide(
          short: short,
          isActive: index == _activeIndex,
          onLike: () => cubit.toggleLike(short.id),
          onComment: () => showShortCommentsSheet(
            context,
            shortId: short.id,
            onCommentPosted: () => cubit.incrementCommentCount(short.id),
          ),
          onShare: () {},
          onOrderMeal: short.mealId == null ? () {} : () => context.push('/meal/${short.mealId}'),
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
