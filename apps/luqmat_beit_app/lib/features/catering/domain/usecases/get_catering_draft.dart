import 'package:core/core.dart';

import '../entities/catering_request_entity.dart';
import '../repositories/catering_repository.dart';

class GetCateringDraft {
  const GetCateringDraft(this._repository);

  final CateringRepository _repository;

  Future<Result<CateringRequestEntity>> call() => _repository.getDraftRequest();
}
