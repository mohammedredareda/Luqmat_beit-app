import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:cook_app/shared/current_cook_id.dart';
import '../../../shared/data/datasources/fake_discounts_remote_data_source.dart';
import '../../../shared/data/models/discount_model.dart';
import '../../../shared/domain/discount_form_submission.dart';
import '../../domain/repositories/create_discount_repository.dart';

@LazySingleton(as: CreateDiscountRepository)
class CreateDiscountRepositoryImpl implements CreateDiscountRepository {
  CreateDiscountRepositoryImpl(this._dataSource);

  final FakeDiscountsRemoteDataSource _dataSource;

  @override
  Future<Result<DiscountEntity>> createDiscount(DiscountFormSubmission submission) {
    return guard(() async {
      final model = DiscountModel(
        id: 'discount-${DateTime.now().microsecondsSinceEpoch}',
        cookId: currentCookId,
        mealId: submission.mealId,
        mealName: submission.mealName,
        mealImageUrl: submission.mealImageUrl,
        mealBasePrice: submission.mealBasePrice,
        percentage: submission.percentage,
        mode: submission.mode,
        durationDays: submission.durationDays,
        usageLimit: submission.usageLimit,
        usageCount: 0,
        isActive: true,
        createdAt: DateTime.now(),
      );
      // TODO(CK-23): notify followers on create (not on edit)
      final created = await _dataSource.createDiscount(model);
      return created.toEntity();
    });
  }
}
