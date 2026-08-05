import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/data/datasources/fake_discounts_remote_data_source.dart';
import '../../domain/repositories/delete_discount_repository.dart';

@LazySingleton(as: DeleteDiscountRepository)
class DeleteDiscountRepositoryImpl implements DeleteDiscountRepository {
  DeleteDiscountRepositoryImpl(this._dataSource);

  final FakeDiscountsRemoteDataSource _dataSource;

  @override
  Future<Result<void>> deleteDiscount(String discountId) {
    return guard(() => _dataSource.deleteDiscount(discountId));
  }
}
