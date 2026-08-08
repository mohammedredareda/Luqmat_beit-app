import 'package:core/core.dart';

import '../../../data/datasources/fake_meal_remote_data_source.dart';
import '../../../data/models/selling_option_model.dart';
import '../../../domain/meal_form_submission.dart';
import '../../domain/repositories/edit_meal_repository.dart';

class EditMealRepositoryImpl implements EditMealRepository {
  EditMealRepositoryImpl(this._dataSource);

  final FakeMealRemoteDataSource _dataSource;

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

      final saved = await _dataSource.updateMeal(updated);
      return saved.toEntity();
    });
  }
}
