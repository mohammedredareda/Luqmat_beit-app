import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/detected_location_entity.dart';

part 'registration_state.freezed.dart';

/// A single rich form state (not a branching union) — Registration is one
/// continuous form-filling flow; location detection and submit are two
/// independent async sub-actions tracked as flags on the same state rather
/// than separate pages/screens.
@freezed
abstract class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    @Default('') String fullName,
    @Default('') String phone,
    @Default('') String password,
    @Default('') String address,
    DetectedLocationEntity? detectedLocation,
    @Default(false) bool isDetectingLocation,
    @Default(false) bool isSubmitting,
    String? locationError,
    String? submitError,
    @Default(false) bool success,
  }) = _RegistrationState;

  factory RegistrationState.initial() => const RegistrationState();
}
