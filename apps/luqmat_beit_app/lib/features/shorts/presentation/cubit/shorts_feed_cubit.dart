import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chef_profile/domain/usecases/toggle_follow_chef.dart';
import '../../domain/entities/short_entity.dart';
import '../../domain/usecases/get_shorts.dart';
import '../../domain/usecases/mark_short_viewed.dart';
import '../../domain/usecases/toggle_short_like.dart';
import 'shorts_feed_state.dart';

class ShortsFeedCubit extends Cubit<ShortsFeedState>
    with PaginationStateMixin<ShortEntity> {
  ShortsFeedCubit(
    this._getShorts,
    this._toggleShortLike,
    this._markShortViewed,
    this._toggleFollowChef,
  ) : super(const ShortsFeedState.initial());

  final GetShorts _getShorts;
  final ToggleShortLike _toggleShortLike;
  final MarkShortViewed _markShortViewed;
  final ToggleFollowChef _toggleFollowChef;

  Future<void> loadShorts() async {
    resetPagination();
    emit(const ShortsFeedState.loading());
    final result = await _getShorts();
    if (isClosed) return;
    result.fold(
      (page) {
        items = page.items;
        cursor = page.nextCursor;
        hasMore = page.hasMore;
        emit(ShortsFeedState.loaded(items));
      },
      (exception) => emit(ShortsFeedState.failure(exception)),
    );
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore || state is! ShortsFeedLoaded) return;
    isLoadingMore = true;

    final result = await _getShorts(cursor: cursor);
    if (isClosed) return;
    result.fold(
      (page) {
        appendPage(page);
        emit(ShortsFeedState.loaded(items));
      },
      (exception) {
        // A failed load-more shouldn't blow away the feed the customer is
        // mid-scroll through — just stop trying for this session.
        isLoadingMore = false;
        hasMore = false;
      },
    );
  }

  /// Fire-and-forget: a view is a passive analytics signal, not worth
  /// blocking the swipe over.
  void markViewed(String shortId) => _markShortViewed(shortId);

  Future<void> toggleLike(String shortId) async {
    final current = state;
    if (current is! ShortsFeedLoaded) return;

    // Optimistic update — reverted below if the call fails.
    final optimistic = [
      for (final short in current.shorts)
        if (short.id == shortId)
          short.copyWith(
            isLiked: !short.isLiked,
            likeCount:
                short.isLiked ? short.likeCount - 1 : short.likeCount + 1,
          )
        else
          short,
    ];
    items = optimistic;
    emit(ShortsFeedState.loaded(optimistic));

    final result = await _toggleShortLike(shortId);
    if (isClosed) return;
    result.fold(
      (reacted) {
        // Reconcile with the server-confirmed state rather than trusting
        // the optimistic flip — a stale double-tap could otherwise land
        // the UI out of sync with what the backend actually recorded.
        final reconciled = [
          for (final short in items)
            if (short.id == shortId)
              short.copyWith(isLiked: reacted)
            else
              short,
        ];
        items = reconciled;
        if (!isClosed) emit(ShortsFeedState.loaded(reconciled));
      },
      (exception) {
        items = current.shorts;
        emit(ShortsFeedState.loaded(current.shorts));
      },
    );
  }

  /// Follows/unfollows the cook behind [cookId] — shares the same
  /// `/user/customer/follow` endpoint as the chef profile screen. Flips the
  /// local flag optimistically (reverted on failure); every short by that
  /// cook updates together so scrolling to another one of their shorts
  /// doesn't show a stale, inconsistent state.
  Future<void> toggleFollow(String cookId) async {
    final current = state;
    if (current is! ShortsFeedLoaded) return;

    final wasFollowing =
        current.shorts.firstWhere((s) => s.cookId == cookId).isFollowing;
    final optimistic = [
      for (final short in current.shorts)
        if (short.cookId == cookId)
          short.copyWith(isFollowing: !wasFollowing)
        else
          short,
    ];
    items = optimistic;
    emit(ShortsFeedState.loaded(optimistic));

    final result = await _toggleFollowChef(cookId, wasFollowing: wasFollowing);
    if (isClosed) return;
    result.fold(
      (_) {},
      (exception) {
        items = current.shorts;
        emit(ShortsFeedState.loaded(current.shorts));
      },
    );
  }

  /// Called after a comment is posted from the comments sheet, so the
  /// visible count on the slide updates without a full feed reload.
  void incrementCommentCount(String shortId) {
    final current = state;
    if (current is! ShortsFeedLoaded) return;
    final updated = [
      for (final short in current.shorts)
        if (short.id == shortId)
          short.copyWith(commentCount: short.commentCount + 1)
        else
          short,
    ];
    items = updated;
    emit(ShortsFeedState.loaded(updated));
  }
}
