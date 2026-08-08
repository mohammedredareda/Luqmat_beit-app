import 'package:core/core.dart';

import '../entities/catering_request_entity.dart';
import '../repositories/catering_repository.dart';

class SubmitCateringRequest {
  const SubmitCateringRequest(this._repository);

  final CateringRepository _repository;

  Future<Result<void>> call(CateringRequestEntity request) =>
      _repository.submitRequest(request);
}
