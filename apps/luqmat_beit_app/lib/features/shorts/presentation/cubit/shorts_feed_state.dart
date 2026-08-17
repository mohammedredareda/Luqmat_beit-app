import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/short_entity.dart';

part 'shorts_feed_state.freezed.dart';

/// Single fetch-and-display flow (CU-26/27): load the feed, swipe, like,
/// share, order — no UI-distinct alternative/exception flows beyond a plain
/// load failure, hence a Cubit rather than a Bloc. Pagination lives on the
/// cubit itself (`items`/`cursor`/`hasMore`), same convention as
/// `SearchCubit` — this state only signals loading/error/loaded shape.
@freezed
sealed class ShortsFeedState with _$ShortsFeedState {
  const factory ShortsFeedState.initial() = ShortsFeedInitial;
  const factory ShortsFeedState.loading() = ShortsFeedLoading;
  const factory ShortsFeedState.loaded(List<ShortEntity> shorts) = ShortsFeedLoaded;
  const factory ShortsFeedState.failure(AppException exception) = ShortsFeedFailure;
}
