import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/presentation/bloc/short_submit_status.dart';

part 'create_short_state.freezed.dart';

@freezed
class CreateShortState with _$CreateShortState {
  const factory CreateShortState({
    String? videoPath,
    int? videoSizeBytes,
    @Default('') String description,
    MealEntity? selectedMeal,
    @Default(ShortSubmitStatus.idle()) ShortSubmitStatus submitStatus,
  }) = _CreateShortState;
}
