import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_meal_event.freezed.dart';

@freezed
class EditMealEvent with _$EditMealEvent {
  const factory EditMealEvent.started(String mealId) = _Started;
  const factory EditMealEvent.retryLoadPressed() = _RetryLoadPressed;
  const factory EditMealEvent.nameChanged(String value) = _NameChanged;
  const factory EditMealEvent.descriptionChanged(String value) = _DescriptionChanged;
  const factory EditMealEvent.categoryToggled(String categoryId) = _CategoryToggled;
  const factory EditMealEvent.preorderHoursChanged(String value) = _PreorderHoursChanged;
  const factory EditMealEvent.variationsToggled(bool enabled) = _VariationsToggled;
  const factory EditMealEvent.priceChanged(String value) = _PriceChanged;
  const factory EditMealEvent.variationAdded() = _VariationAdded;
  const factory EditMealEvent.variationRemoved(String localId) = _VariationRemoved;
  const factory EditMealEvent.variationLabelChanged(String localId, String value) =
      _VariationLabelChanged;
  const factory EditMealEvent.variationPriceChanged(String localId, String value) =
      _VariationPriceChanged;
  const factory EditMealEvent.imagePicked(String path, int sizeBytes) = _ImagePicked;
  const factory EditMealEvent.availabilityToggled(bool isAvailable) = _AvailabilityToggled;
  const factory EditMealEvent.submitPressed() = _SubmitPressed;
}
