import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_menu_state.freezed.dart';

@freezed
class ViewMenuState with _$ViewMenuState {
  const factory ViewMenuState.initial() = ViewMenuInitial;
  const factory ViewMenuState.loading() = ViewMenuLoading;
  const factory ViewMenuState.loaded({
    required List<MealEntity> meals,
    required bool isSellingPaused,
    required bool hasMore,
    required bool isLoadingMore,
  }) = ViewMenuLoaded;
  const factory ViewMenuState.error(AppException exception) = ViewMenuError;
}
