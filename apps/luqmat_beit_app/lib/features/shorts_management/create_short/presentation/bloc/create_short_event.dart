import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_short_event.freezed.dart';

@freezed
class CreateShortEvent with _$CreateShortEvent {
  const factory CreateShortEvent.videoPicked(String path, int sizeBytes) = _VideoPicked;
  const factory CreateShortEvent.descriptionChanged(String value) = _DescriptionChanged;
  const factory CreateShortEvent.mealSelected(MealEntity meal) = _MealSelected;
  const factory CreateShortEvent.mealRemoved() = _MealRemoved;
  const factory CreateShortEvent.submitPressed() = _SubmitPressed;
}
