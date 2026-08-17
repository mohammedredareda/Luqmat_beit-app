import 'package:core/core.dart';

import '../entities/short_comment_entity.dart';
import '../repositories/shorts_repository.dart';

class GetShortComments {
  const GetShortComments(this._repository);

  final ShortsRepository _repository;

  Future<Result<PaginatedResult<ShortCommentEntity>>> call(
    String shortId, {
    String? cursor,
  }) =>
      _repository.getComments(shortId, cursor: cursor);
}
