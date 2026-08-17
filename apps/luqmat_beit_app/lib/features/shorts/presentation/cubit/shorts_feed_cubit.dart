import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_shorts.dart';
import '../../domain/usecases/toggle_short_like.dart';
import 'shorts_feed_state.dart';

class ShortsFeedCubit extends Cubit<ShortsFeedState> {
  ShortsFeedCubit(this._getShorts, this._toggleShortLike)
      : super(const ShortsFeedState.initial());

  final GetShorts _getShorts;
  final ToggleShortLike _toggleShortLike;

  Future<void> loadShorts() async {
    emit(const ShortsFeedState.loading());
    final result = await _getShorts();
    if (isClosed) return;
    result.fold(
      (shorts) => emit(ShortsFeedState.loaded(shorts)),
      (exception) => emit(ShortsFeedState.failure(exception)),
    );
  }

  Future<void> toggleLike(String shortId) async {
    final current = state;
    if (current is! ShortsFeedLoaded) return;

    // Optimistic update — mirrors what a real like button needs regardless
    // of backend latency.
    final updated = [
      for (final short in current.shorts)
        if (short.id == shortId)
          short.copyWith(
            isLiked: !short.isLiked,
            likeCount: short.isLiked ? short.likeCount - 1 : short.likeCount + 1,
          )
        else
          short,
    ];
    emit(ShortsFeedState.loaded(updated));

    final result = await _toggleShortLike(shortId);
    if (isClosed) return;
    result.fold(
      (_) {},
      (exception) {
        // Revert on failure.
        final reverted = state;
        if (reverted is ShortsFeedLoaded) {
          emit(ShortsFeedState.loaded(current.shorts));
        }
      },
    );
  }
}
