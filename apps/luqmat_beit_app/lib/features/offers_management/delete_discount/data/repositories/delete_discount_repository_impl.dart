import 'package:core/core.dart';

import '../../../shared/data/datasources/discounts_remote_data_source.dart';
import '../../domain/repositories/delete_discount_repository.dart';

class DeleteDiscountRepositoryImpl implements DeleteDiscountRepository {
  DeleteDiscountRepositoryImpl(this._dataSource);

  final DiscountsRemoteDataSource _dataSource;

  @override
  Future<Result<void>> deleteDiscount(String discountId) {
    return guard(() => _dataSource.deleteDiscount(discountId));
  }
}
