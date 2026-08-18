import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/short_comment_entity.dart';
import '../../domain/usecases/add_short_comment.dart';
import '../../domain/usecases/get_short_comments.dart';
import 'short_comments_state.dart';

/// One instance per open comments sheet (CU-27's comment action) — a plain
/// fetch-and-post flow, so a Cubit rather than a Bloc.
class ShortCommentsCubit extends Cubit<ShortCommentsState>
    with PaginationStateMixin<ShortCommentEntity> {
  ShortCommentsCubit(this._shortId, this._getShortComments, this._addShortComment)
      : super(const ShortCommentsState.initial());

  final String _shortId;
  final GetShortComments _getShortComments;
  final AddShortComment _addShortComment;

  Future<void> load() async {
    resetPagination();
    emit(const ShortCommentsState.loading());
    final result = await _getShortComments(_shortId);
    if (isClosed) return;
    result.fold(
      (page) {
        items = page.items;
        cursor = page.nextCursor;
        hasMore = page.hasMore;
        emit(ShortCommentsState.loaded(items));
      },
      (exception) => emit(ShortCommentsState.failure(exception)),
    );
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore || state is! ShortCommentsLoaded) return;
    isLoadingMore = true;

    final result = await _getShortComments(_shortId, cursor: cursor);
    if (isClosed) return;
    result.fold(
      (page) {
        appendPage(page);
        emit(ShortCommentsState.loaded(items));
      },
      (exception) {
        isLoadingMore = false;
        hasMore = false;
      },
    );
  }

  Future<bool> addComment(String text) async {
    final current = state;
    if (current is! ShortCommentsLoaded || text.trim().isEmpty) return false;
    emit(ShortCommentsState.loaded(items, isPosting: true));

    final result = await _addShortComment(_shortId, text.trim());
    if (isClosed) return false;
    return result.fold(
      (comment) {
        items = [comment, ...items];
        emit(ShortCommentsState.loaded(items));
        return true;
      },
      (exception) {
        emit(ShortCommentsState.loaded(items));
        return false;
      },
    );
  }
}
