import 'package:core/core.dart';

import '../entities/short_comment_entity.dart';
import '../entities/short_entity.dart';

abstract class ShortsRepository {
  Future<Result<PaginatedResult<ShortEntity>>> getFeed({String? cursor});

  Future<Result<void>> markViewed(String shortId);

  /// Returns the new liked state (server-confirmed, not assumed).
  Future<Result<bool>> toggleReact(String shortId);

  Future<Result<PaginatedResult<ShortCommentEntity>>> getComments(
    String shortId, {
    String? cursor,
  });

  Future<Result<ShortCommentEntity>> addComment(String shortId, String text);
}
