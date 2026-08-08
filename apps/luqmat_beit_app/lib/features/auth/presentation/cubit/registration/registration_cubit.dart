import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/format_availability_duration.dart';
import '../../../domain/usecases/register.dart';
import 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this._register, this._detectCurrentLocation)
      : super(RegistrationState.initial());

  final Register _register;
  final DetectCurrentLocation _detectCurrentLocation;

  void fullNameChanged(String value) => emit(state.copyWith(fullName: value));
  void phoneChanged(String value) => emit(state.copyWith(phone: value));
  void passwordChanged(String value) => emit(state.copyWith(password: value));
  void addressChanged(String value) => emit(state.copyWith(address: value));
  void registerAsCookChanged(bool value) => emit(state.copyWith(registerAsCook: value));
  void descriptionChanged(String value) => emit(state.copyWith(description: value));
  void startDayChanged(Weekday value) => emit(state.copyWith(startDay: value));
  void endDayChanged(Weekday value) => emit(state.copyWith(endDay: value));
  void startTimeChanged(TimeOfDay value) => emit(state.copyWith(startTime: value));
  void endTimeChanged(TimeOfDay value) => emit(state.copyWith(endTime: value));

  Future<void> detectLocation() async {
    emit(state.copyWith(isDetectingLocation: true, locationError: null));
    final result = await _detectCurrentLocation();
    result.fold(
      (location) => emit(state.copyWith(
        isDetectingLocation: false,
        detectedLocation: location,
        // Only pre-fill the address if the user hasn't already typed one —
        // the field stays fully editable either way, per the mockup.
        address: state.address.trim().isEmpty ? location.formattedAddress : state.address,
      )),
      (exception) => emit(state.copyWith(
        isDetectingLocation: false,
        locationError: exception.message,
      )),
    );
  }

  Future<void> submit() async {
    final phoneError = PhoneValidator.errorMessage(state.phone.trim());
    final passwordError = PasswordValidator.errorMessage(state.password);
    if (state.fullName.trim().isEmpty) {
      emit(state.copyWith(submitError: 'الرجاء إدخال الاسم الكامل.'));
      return;
    }
    if (phoneError != null) {
      emit(state.copyWith(submitError: phoneError));
      return;
    }
    if (passwordError != null) {
      emit(state.copyWith(submitError: passwordError));
      return;
    }
    if (state.address.trim().isEmpty) {
      emit(state.copyWith(submitError: 'الرجاء إدخال العنوان التفصيلي.'));
      return;
    }
    if (state.registerAsCook && state.description.trim().isEmpty) {
      emit(state.copyWith(submitError: 'الرجاء إدخال نبذة قصيرة عن خبرتك.'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, submitError: null));
    final result = await _register(
      role: state.registerAsCook ? UserRole.cook : UserRole.customer,
      name: state.fullName.trim(),
      phone: state.phone.trim(),
      password: state.password,
      address: state.address.trim(),
      description: state.registerAsCook ? state.description.trim() : null,
      availabilityDuration: state.registerAsCook
          ? formatAvailabilityDuration(
              startDay: state.startDay,
              endDay: state.endDay,
              startTime: state.startTime,
              endTime: state.endTime,
            )
          : null,
      latitude: state.detectedLocation?.latitude,
      longitude: state.detectedLocation?.longitude,
    );
    result.fold(
      (_) => emit(state.copyWith(isSubmitting: false, success: true)),
      (exception) => emit(state.copyWith(isSubmitting: false, submitError: exception.message)),
    );
  }
}
