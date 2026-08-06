import 'package:core/core.dart';

import '../entities/short_entity.dart';
import '../repositories/shorts_repository.dart';

class GetShorts {
  const GetShorts(this._repository);

  final ShortsRepository _repository;

  Future<Result<List<ShortEntity>>> call() => _repository.getShorts();
}
