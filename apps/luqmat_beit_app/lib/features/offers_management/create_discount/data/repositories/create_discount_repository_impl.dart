import 'package:core/core.dart';

import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import '../../../shared/data/datasources/discounts_remote_data_source.dart';
import '../../../shared/data/models/discount_model.dart';
import '../../../shared/domain/discount_form_submission.dart';
import '../../domain/repositories/create_discount_repository.dart';

class CreateDiscountRepositoryImpl implements CreateDiscountRepository {
  CreateDiscountRepositoryImpl(this._dataSource);

  final DiscountsRemoteDataSource _dataSource;

  @override
  Future<Result<DiscountEntity>> createDiscount(DiscountFormSubmission submission) {
    return guard(() async {
      final now = DateTime.now();
      final model = DiscountModel(
        id: 'discount-${now.microsecondsSinceEpoch}',
        cookId: currentCookId,
        mealId: submission.mealId,
        mealName: submission.mealName,
        mealImageUrl: submission.mealImageUrl,
        mealBasePrice: submission.mealBasePrice,
        discountPercentage: submission.discountPercentage,
        discountDurationDays: submission.discountDurationDays,
        usageNumberLimit: submission.usageNumberLimit,
        usageCount: 0,
        createdAt: now,
        expiryTime: now.add(Duration(days: submission.discountDurationDays)),
      );
      // TODO(CK-23): notify followers on create (not on edit)
      final created = await _dataSource.createDiscount(model);
      return created.toEntity();
    });
  }
}
