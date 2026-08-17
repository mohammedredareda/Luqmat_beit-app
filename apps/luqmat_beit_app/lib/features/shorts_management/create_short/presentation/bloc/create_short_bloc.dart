import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/domain/short_form_submission.dart';
import '../../../shared/domain/short_form_validator.dart';
import '../../../shared/presentation/bloc/short_submit_status.dart';
import '../../domain/usecases/create_short.dart';
import 'create_short_event.dart';
import 'create_short_state.dart';

/// Cook-side Create Short — mirrors mockup `_3`'s single-screen form
/// (video, description, optional linked meal via the reused
/// `showSelectMealPopup`).
class CreateShortBloc extends Bloc<CreateShortEvent, CreateShortState> {
  CreateShortBloc(this._createShort) : super(const CreateShortState()) {
    on<CreateShortEvent>((event, emit) => event.when(
          videoPicked: (path, sizeBytes) async =>
              emit(state.copyWith(videoPath: path, videoSizeBytes: sizeBytes)),
          descriptionChanged: (value) async => emit(state.copyWith(description: value)),
          mealSelected: (meal) async => emit(state.copyWith(selectedMeal: meal)),
          // `copyWith(selectedMeal: null)` would be a no-op under Freezed's
          // generated copyWith (null means "keep current"), so the meal is
          // cleared via a fresh constructor call instead.
          mealRemoved: () async => emit(CreateShortState(
                videoPath: state.videoPath,
                videoSizeBytes: state.videoSizeBytes,
                description: state.description,
                submitStatus: state.submitStatus,
              )),
          submitPressed: () => _submit(emit),
        ));
  }

  final CreateShort _createShort;

  Future<void> _submit(Emitter<CreateShortState> emit) async {
    final errors = validateShortForm(
      videoPath: state.videoPath,
      description: state.description,
    );

    if (errors.isNotEmpty) {
      emit(state.copyWith(submitStatus: ShortSubmitStatus.validationFailure(errors)));
      return;
    }

    emit(state.copyWith(submitStatus: const ShortSubmitStatus.submitting()));

    final meal = state.selectedMeal;
    final submission = ShortFormSubmission(
      videoPath: state.videoPath!,
      description: state.description,
      mealId: meal?.id,
      mealName: meal?.name,
      mealImageUrl: meal?.imageUrl,
    );

    final result = await _createShort(submission);
    result.fold(
      (short) => emit(state.copyWith(submitStatus: ShortSubmitStatus.success(short))),
      (exception) => emit(state.copyWith(submitStatus: ShortSubmitStatus.failure(exception))),
    );
  }
}
