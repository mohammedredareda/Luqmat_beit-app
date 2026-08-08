import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_offer_event.freezed.dart';

@freezed
class EditOfferEvent with _$EditOfferEvent {
  const factory EditOfferEvent.started(String offerId) = _Started;
  const factory EditOfferEvent.retryLoadPressed() = _RetryLoadPressed;
  const factory EditOfferEvent.nameChanged(String value) = _NameChanged;
  const factory EditOfferEvent.descriptionChanged(String value) = _DescriptionChanged;
  const factory EditOfferEvent.imagePicked(String path, int sizeBytes) = _ImagePicked;
  const factory EditOfferEvent.totalPriceChanged(String value) = _TotalPriceChanged;
  const factory EditOfferEvent.durationDaysChanged(String value) = _DurationDaysChanged;
  const factory EditOfferEvent.activeToggled(bool isActive) = _ActiveToggled;
  const factory EditOfferEvent.mealAdded(MealEntity meal, SellingOptionEntity? sellingOption) =
      _MealAdded;
  const factory EditOfferEvent.mealRemoved(String mealId) = _MealRemoved;
  const factory EditOfferEvent.mealQuantityIncremented(String mealId) = _MealQuantityIncremented;
  const factory EditOfferEvent.mealQuantityDecremented(String mealId) = _MealQuantityDecremented;
  const factory EditOfferEvent.mealSellingOptionChanged(
    String mealId,
    SellingOptionEntity option,
  ) = _MealSellingOptionChanged;
  const factory EditOfferEvent.submitPressed() = _SubmitPressed;
}
