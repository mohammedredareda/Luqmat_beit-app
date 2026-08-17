import 'package:core/core.dart';

import '../../../shared/data/datasources/offers_remote_data_source.dart';
import '../../../shared/data/models/offer_meal_model.dart';
import '../../../shared/domain/offer_form_submission.dart';
import '../../domain/repositories/edit_offer_repository.dart';

class EditOfferRepositoryImpl implements EditOfferRepository {
  EditOfferRepositoryImpl(this._dataSource);

  final OffersRemoteDataSource _dataSource;

  @override
  Future<
      Result<
          ({
            OfferEntity offer,
            String? imageUrl,
            List<OfferMealSnapshot> mealDrafts,
          })>> getOffer(String offerId) {
    return guard(() async {
      final model = await _dataSource.getOfferById(offerId);
      if (model == null) throw const NotFoundException('Offer not found');
      return (
        offer: model.toEntity(),
        imageUrl: model.imageUrl,
        mealDrafts: [
          for (final m in model.includedMeals)
            (
              mealId: m.mealId,
              mealName: m.mealName,
              mealImageUrl: m.mealImageUrl,
              sellingOptionId: m.sellingOptionId,
              sellingOptionLabel: m.sellingOptionLabel,
              unitPrice: m.unitPrice,
              quantity: m.quantity,
            ),
        ],
      );
    });
  }

  @override
  Future<Result<OfferEntity>> updateOffer(String offerId, OfferFormSubmission submission) {
    return guard(() async {
      final existing = await _dataSource.getOfferById(offerId);
      if (existing == null) throw const NotFoundException('Offer not found');

      final updated = existing.copyWith(
        name: submission.name,
        description: submission.description,
        totalPrice: submission.totalPrice,
        durationDays: submission.durationDays,
        expiryTime: existing.createdAt.add(Duration(days: submission.durationDays)),
        status: submission.isActive ? OfferStatus.active : OfferStatus.deleted,
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

      final saved = await _dataSource.updateOffer(updated);
      return saved.toEntity();
    });
  }
}
