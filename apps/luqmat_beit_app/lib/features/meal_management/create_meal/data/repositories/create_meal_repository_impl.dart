import 'package:core/core.dart';

import '../../../data/datasources/meal_remote_data_source.dart';
import '../../../data/models/meal_model.dart';
import '../../../data/models/selling_option_model.dart';
import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import '../../../domain/meal_form_submission.dart';
import '../../domain/repositories/create_meal_repository.dart';

class CreateMealRepositoryImpl implements CreateMealRepository {
  CreateMealRepositoryImpl(this._dataSource);

  final MealRemoteDataSource _dataSource;

  @override
  Future<Result<MealEntity>> createMeal(MealFormSubmission submission) {
    return guard(() async {
      final model = MealModel(
        id: 'meal-${DateTime.now().microsecondsSinceEpoch}',
        cookId: currentCookId,
        name: submission.name,
        description: submission.description,
        imageUrl: submission.imagePath,
        isStopped: false,
        price: submission.price,
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
      );
      final created = await _dataSource.createMeal(model);
      return created.toEntity();
    });
  }
}
