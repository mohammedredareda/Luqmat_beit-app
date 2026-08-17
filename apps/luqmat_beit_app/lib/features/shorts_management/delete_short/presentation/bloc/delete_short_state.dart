import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_short_state.freezed.dart';

@freezed
class DeleteShortState with _$DeleteShortState {
  const factory DeleteShortState.initial() = DeleteShortInitial;
  const factory DeleteShortState.submitting() = DeleteShortSubmitting;
  const factory DeleteShortState.success(String shortId) = DeleteShortSuccess;
  const factory DeleteShortState.failure(AppException exception) = DeleteShortFailure;
}
