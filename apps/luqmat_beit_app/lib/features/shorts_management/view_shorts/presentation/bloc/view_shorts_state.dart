import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/entities/short_management_entity.dart';

part 'view_shorts_state.freezed.dart';

@freezed
class ViewShortsState with _$ViewShortsState {
  const factory ViewShortsState.initial() = ViewShortsInitial;
  const factory ViewShortsState.loading() = ViewShortsLoading;
  const factory ViewShortsState.loaded({
    required List<ShortManagementEntity> items,
    required bool hasMore,
    required bool isLoadingMore,
  }) = ViewShortsLoaded;
  const factory ViewShortsState.error(AppException exception) = ViewShortsError;
}
