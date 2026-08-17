import 'package:core/core.dart';

import '../repositories/shorts_repository.dart';

class MarkShortViewed {
  const MarkShortViewed(this._repository);

  final ShortsRepository _repository;

  Future<Result<void>> call(String shortId) => _repository.markViewed(shortId);
}
