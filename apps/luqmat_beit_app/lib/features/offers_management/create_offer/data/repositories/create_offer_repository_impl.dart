import 'package:core/core.dart';

import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import '../../../shared/data/datasources/offers_remote_data_source.dart';
import '../../../shared/data/models/offer_meal_model.dart';
import '../../../shared/data/models/offer_model.dart';
import '../../../shared/domain/offer_form_submission.dart';
import '../../domain/repositories/create_offer_repository.dart';

class CreateOfferRepositoryImpl implements CreateOfferRepository {
  CreateOfferRepositoryImpl(this._dataSource);

  final OffersRemoteDataSource _dataSource;

  @override
  Future<Result<OfferEntity>> createOffer(OfferFormSubmission submission) {
    return guard(() async {
      final now = DateTime.now();
      final model = OfferModel(
        id: 'offer-${now.microsecondsSinceEpoch}',
        cookId: currentCookId,
        name: submission.name,
        description: submission.description,
        totalPrice: submission.totalPrice,
        durationDays: submission.durationDays,
        status: submission.isActive ? OfferStatus.active : OfferStatus.deleted,
        createdAt: now,
        expiryTime: now.add(Duration(days: submission.durationDays)),
        imageUrl: submission.imagePath,
        includedMeals: [
          for (final meal in submission.includedMeals)
            OfferMealModel(
              mealId: meal.mealId,
              mealName: meal.mealName,
              mealImageUrl: meal.mealImageUrl,
              sellingOptionId: meal.sellingOptionId,
              sellingOptionLabel: meal.sellingOptionLabel,
              unitPrice: meal.unitPrice,
              quantity: meal.quantity,
            ),
        ],
      );
      // TODO(CK-23): notify followers on create (not on edit)
      final created = await _dataSource.createOffer(model);
      return created.toEntity();
    });
  }
}
