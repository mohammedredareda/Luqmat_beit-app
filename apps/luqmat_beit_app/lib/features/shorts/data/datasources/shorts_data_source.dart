import 'package:core/core.dart';

import '../../domain/entities/short_comment_entity.dart';
import '../../domain/entities/short_entity.dart';

abstract class ShortsDataSource {
  Future<PaginatedResult<ShortEntity>> getFeed({String? cursor});

  Future<void> markViewed(String shortId);

  Future<bool> toggleReact(String shortId);

  Future<PaginatedResult<ShortCommentEntity>> getComments(
    String shortId, {
    String? cursor,
  });

  Future<ShortCommentEntity> addComment(String shortId, String text);
}
