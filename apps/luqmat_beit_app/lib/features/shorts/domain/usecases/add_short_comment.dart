import 'package:core/core.dart';

import '../entities/short_comment_entity.dart';
import '../repositories/shorts_repository.dart';

class AddShortComment {
  const AddShortComment(this._repository);

  final ShortsRepository _repository;

  Future<Result<ShortCommentEntity>> call(String shortId, String text) =>
      _repository.addComment(shortId, text);
}
