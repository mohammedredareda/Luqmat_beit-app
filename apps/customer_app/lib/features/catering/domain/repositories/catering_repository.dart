import 'package:core/core.dart';

import '../entities/catering_request_entity.dart';

abstract class CateringRepository {
  Future<Result<CateringRequestEntity>> getDraftRequest();
  Future<Result<void>> submitRequest(CateringRequestEntity request);
}
