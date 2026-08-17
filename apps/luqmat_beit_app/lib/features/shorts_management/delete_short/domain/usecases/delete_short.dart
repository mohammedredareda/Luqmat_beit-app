import 'package:core/core.dart';

import '../repositories/delete_short_repository.dart';

class DeleteShort {
  DeleteShort(this._repository);

  final DeleteShortRepository _repository;

  Future<Result<void>> call(String shortId) => _repository.deleteShort(shortId);
}
