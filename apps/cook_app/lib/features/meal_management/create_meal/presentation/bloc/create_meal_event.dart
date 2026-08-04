import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_meal_event.freezed.dart';

@freezed
class CreateMealEvent with _$CreateMealEvent {
  const factory CreateMealEvent.nameChanged(String value) = _NameChanged;
  const factory CreateMealEvent.descriptionChanged(String value) = _DescriptionChanged;
  const factory CreateMealEvent.categoryToggled(String categoryId) = _CategoryToggled;
  const factory CreateMealEvent.preorderHoursChanged(String value) = _PreorderHoursChanged;
  const factory CreateMealEvent.variationsToggled(bool enabled) = _VariationsToggled;
  const factory CreateMealEvent.priceChanged(String value) = _PriceChanged;
  const factory CreateMealEvent.variationAdded() = _VariationAdded;
  const factory CreateMealEvent.variationRemoved(String localId) = _VariationRemoved;
  const factory CreateMealEvent.variationLabelChanged(String localId, String value) =
      _VariationLabelChanged;
  const factory CreateMealEvent.variationPriceChanged(String localId, String value) =
      _VariationPriceChanged;
  const factory CreateMealEvent.imagePicked(String path, int sizeBytes) = _ImagePicked;
  const factory CreateMealEvent.submitPressed() = _SubmitPressed;
}
