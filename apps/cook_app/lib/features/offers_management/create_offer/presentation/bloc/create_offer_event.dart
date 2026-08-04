import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_offer_event.freezed.dart';

@freezed
class CreateOfferEvent with _$CreateOfferEvent {
  const factory CreateOfferEvent.nameChanged(String value) = _NameChanged;
  const factory CreateOfferEvent.descriptionChanged(String value) = _DescriptionChanged;
  const factory CreateOfferEvent.imagePicked(String path, int sizeBytes) = _ImagePicked;
  const factory CreateOfferEvent.totalPriceChanged(String value) = _TotalPriceChanged;
  const factory CreateOfferEvent.durationDaysChanged(String value) = _DurationDaysChanged;
  const factory CreateOfferEvent.activeToggled(bool isActive) = _ActiveToggled;
  const factory CreateOfferEvent.mealAdded(MealEntity meal, SellingOptionEntity? sellingOption) =
      _MealAdded;
  const factory CreateOfferEvent.mealRemoved(String mealId) = _MealRemoved;
  const factory CreateOfferEvent.mealQuantityIncremented(String mealId) =
      _MealQuantityIncremented;
  const factory CreateOfferEvent.mealQuantityDecremented(String mealId) =
      _MealQuantityDecremented;
  const factory CreateOfferEvent.mealSellingOptionChanged(
    String mealId,
    SellingOptionEntity option,
  ) = _MealSellingOptionChanged;
  const factory CreateOfferEvent.submitPressed() = _SubmitPressed;
}
