import 'package:core/core.dart';

import '../../domain/entities/catering_request_entity.dart';
import '../../domain/repositories/catering_repository.dart';
import '../datasources/catering_mock_data_source.dart';

class CateringRepositoryImpl implements CateringRepository {
  CateringRepositoryImpl({CateringMockDataSource? dataSource})
      : _dataSource = dataSource ?? CateringMockDataSource();

  final CateringMockDataSource _dataSource;

  @override
  Future<Result<CateringRequestEntity>> getDraftRequest() {
    return guard(() => _dataSource.getDraftRequest());
  }

  @override
  Future<Result<void>> submitRequest(CateringRequestEntity request) {
    return guard(() => _dataSource.submitRequest(request));
  }
}
