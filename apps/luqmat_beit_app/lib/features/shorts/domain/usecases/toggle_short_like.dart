import 'package:core/core.dart';

import '../repositories/shorts_repository.dart';

class ToggleShortLike {
  const ToggleShortLike(this._repository);

  final ShortsRepository _repository;

  Future<Result<bool>> call(String shortId) => _repository.toggleReact(shortId);
}
