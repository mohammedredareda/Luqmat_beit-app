import 'package:core/core.dart';

import '../../../data/datasources/meal_remote_data_source.dart';
import '../../../data/models/selling_option_model.dart';
import '../../../domain/meal_form_submission.dart';
import '../../domain/repositories/edit_meal_repository.dart';

class EditMealRepositoryImpl implements EditMealRepository {
  EditMealRepositoryImpl(this._dataSource);

  final MealRemoteDataSource _dataSource;

  @override
  Future<Result<MealEntity>> getMeal(String mealId) {
    return guard(() async {
      final model = await _dataSource.getMealById(mealId);
      if (model == null) throw const NotFoundException('Meal not found');
      return model.toEntity();
    });
  }

  @override
  Future<Result<MealEntity>> updateMeal(
    String mealId,
    MealFormSubmission submission, {
    required bool isStopped,
  }) {
    return guard(() async {
      final existing = await _dataSource.getMealById(mealId);
      if (existing == null) throw const NotFoundException('Meal not found');

      final updated = existing.copyWith(
        name: submission.name,
        description: submission.description,
        imageUrl: submission.imagePath,
        price: submission.price,
        clearPrice: submission.price == null,
        sellingOptions: [
          for (var i = 0; i < submission.sellingOptions.length; i++)
            SellingOptionModel(
              id: 'option-${DateTime.now().microsecondsSinceEpoch}-$i',
              label: submission.sellingOptions[i].label,
              price: submission.sellingOptions[i].price,
            ),
        ],
        categoryIds: submission.categoryIds,
        preorderHours: submission.preorderHours,
        isStopped: isStopped,
      );

      var saved = await _dataSource.updateMeal(updated);

      // `PUT .../meals/{id}` has no active/stopped field — a status change
      // is a separate call to the per-meal toggle endpoint, only made when
      // the requested state actually differs from what the server has now.
      if (saved.isStopped != isStopped) {
        final isActive = await _dataSource.toggleMealStatus(mealId);
        saved = saved.copyWith(isStopped: !isActive);
      }

      return saved.toEntity();
    });
  }
}
