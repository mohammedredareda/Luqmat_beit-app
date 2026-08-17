import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_state.freezed.dart';

/// A single rich form state (not a branching union) — Registration is one
/// continuous form-filling flow; [registerAsCook] toggles whether the
/// cook-only fields (availability day/time range, description) are shown
/// and required, matching the shared mockup's "التسجيل كطباخة" checkbox
/// rather than routing to a separate screen per role.
@freezed
abstract class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    @Default('') String fullName,
    @Default('') String phone,
    @Default('') String password,
    @Default('') String address,
    @Default(false) bool registerAsCook,
    @Default('') String description,
    @Default(Weekday.sat) Weekday startDay,
    @Default(Weekday.thu) Weekday endDay,
    @Default(TimeOfDay(hour: 10, minute: 0)) TimeOfDay startTime,
    @Default(TimeOfDay(hour: 20, minute: 0)) TimeOfDay endTime,
    DetectedLocationEntity? detectedLocation,
    @Default(false) bool isDetectingLocation,
    @Default(false) bool isSubmitting,
    String? locationError,
    String? submitError,
    @Default(false) bool success,
  }) = _RegistrationState;

  factory RegistrationState.initial() => const RegistrationState();
}
