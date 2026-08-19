import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/short_comment_entity.dart';

part 'short_comments_state.freezed.dart';

@freezed
sealed class ShortCommentsState with _$ShortCommentsState {
  const factory ShortCommentsState.initial() = ShortCommentsInitial;
  const factory ShortCommentsState.loading() = ShortCommentsLoading;
  const factory ShortCommentsState.loaded(
    List<ShortCommentEntity> comments, {
    @Default(false) bool isPosting,
  }) = ShortCommentsLoaded;
  const factory ShortCommentsState.failure(AppException exception) =
      ShortCommentsFailure;
}
