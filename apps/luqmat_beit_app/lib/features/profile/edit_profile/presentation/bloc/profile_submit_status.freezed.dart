// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_submit_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileSubmitStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(Map<String, List<String>> fieldErrors)
        validationFailure,
    required TResult Function(CustomerProfileEntity profile) success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult? Function(CustomerProfileEntity profile)? success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult Function(CustomerProfileEntity profile)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileSubmitIdle value) idle,
    required TResult Function(ProfileSubmitSubmitting value) submitting,
    required TResult Function(ProfileSubmitValidationFailure value)
        validationFailure,
    required TResult Function(ProfileSubmitSuccess value) success,
    required TResult Function(ProfileSubmitFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileSubmitIdle value)? idle,
    TResult? Function(ProfileSubmitSubmitting value)? submitting,
    TResult? Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult? Function(ProfileSubmitSuccess value)? success,
    TResult? Function(ProfileSubmitFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileSubmitIdle value)? idle,
    TResult Function(ProfileSubmitSubmitting value)? submitting,
    TResult Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult Function(ProfileSubmitSuccess value)? success,
    TResult Function(ProfileSubmitFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileSubmitStatusCopyWith<$Res> {
  factory $ProfileSubmitStatusCopyWith(
          ProfileSubmitStatus value, $Res Function(ProfileSubmitStatus) then) =
      _$ProfileSubmitStatusCopyWithImpl<$Res, ProfileSubmitStatus>;
}

/// @nodoc
class _$ProfileSubmitStatusCopyWithImpl<$Res, $Val extends ProfileSubmitStatus>
    implements $ProfileSubmitStatusCopyWith<$Res> {
  _$ProfileSubmitStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProfileSubmitIdleImplCopyWith<$Res> {
  factory _$$ProfileSubmitIdleImplCopyWith(_$ProfileSubmitIdleImpl value,
          $Res Function(_$ProfileSubmitIdleImpl) then) =
      __$$ProfileSubmitIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProfileSubmitIdleImplCopyWithImpl<$Res>
    extends _$ProfileSubmitStatusCopyWithImpl<$Res, _$ProfileSubmitIdleImpl>
    implements _$$ProfileSubmitIdleImplCopyWith<$Res> {
  __$$ProfileSubmitIdleImplCopyWithImpl(_$ProfileSubmitIdleImpl _value,
      $Res Function(_$ProfileSubmitIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProfileSubmitIdleImpl implements ProfileSubmitIdle {
  const _$ProfileSubmitIdleImpl();

  @override
  String toString() {
    return 'ProfileSubmitStatus.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProfileSubmitIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(Map<String, List<String>> fieldErrors)
        validationFailure,
    required TResult Function(CustomerProfileEntity profile) success,
    required TResult Function(AppException exception) failure,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult? Function(CustomerProfileEntity profile)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult Function(CustomerProfileEntity profile)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileSubmitIdle value) idle,
    required TResult Function(ProfileSubmitSubmitting value) submitting,
    required TResult Function(ProfileSubmitValidationFailure value)
        validationFailure,
    required TResult Function(ProfileSubmitSuccess value) success,
    required TResult Function(ProfileSubmitFailure value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileSubmitIdle value)? idle,
    TResult? Function(ProfileSubmitSubmitting value)? submitting,
    TResult? Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult? Function(ProfileSubmitSuccess value)? success,
    TResult? Function(ProfileSubmitFailure value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileSubmitIdle value)? idle,
    TResult Function(ProfileSubmitSubmitting value)? submitting,
    TResult Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult Function(ProfileSubmitSuccess value)? success,
    TResult Function(ProfileSubmitFailure value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class ProfileSubmitIdle implements ProfileSubmitStatus {
  const factory ProfileSubmitIdle() = _$ProfileSubmitIdleImpl;
}

/// @nodoc
abstract class _$$ProfileSubmitSubmittingImplCopyWith<$Res> {
  factory _$$ProfileSubmitSubmittingImplCopyWith(
          _$ProfileSubmitSubmittingImpl value,
          $Res Function(_$ProfileSubmitSubmittingImpl) then) =
      __$$ProfileSubmitSubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProfileSubmitSubmittingImplCopyWithImpl<$Res>
    extends _$ProfileSubmitStatusCopyWithImpl<$Res,
        _$ProfileSubmitSubmittingImpl>
    implements _$$ProfileSubmitSubmittingImplCopyWith<$Res> {
  __$$ProfileSubmitSubmittingImplCopyWithImpl(
      _$ProfileSubmitSubmittingImpl _value,
      $Res Function(_$ProfileSubmitSubmittingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProfileSubmitSubmittingImpl implements ProfileSubmitSubmitting {
  const _$ProfileSubmitSubmittingImpl();

  @override
  String toString() {
    return 'ProfileSubmitStatus.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileSubmitSubmittingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(Map<String, List<String>> fieldErrors)
        validationFailure,
    required TResult Function(CustomerProfileEntity profile) success,
    required TResult Function(AppException exception) failure,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult? Function(CustomerProfileEntity profile)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult Function(CustomerProfileEntity profile)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileSubmitIdle value) idle,
    required TResult Function(ProfileSubmitSubmitting value) submitting,
    required TResult Function(ProfileSubmitValidationFailure value)
        validationFailure,
    required TResult Function(ProfileSubmitSuccess value) success,
    required TResult Function(ProfileSubmitFailure value) failure,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileSubmitIdle value)? idle,
    TResult? Function(ProfileSubmitSubmitting value)? submitting,
    TResult? Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult? Function(ProfileSubmitSuccess value)? success,
    TResult? Function(ProfileSubmitFailure value)? failure,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileSubmitIdle value)? idle,
    TResult Function(ProfileSubmitSubmitting value)? submitting,
    TResult Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult Function(ProfileSubmitSuccess value)? success,
    TResult Function(ProfileSubmitFailure value)? failure,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class ProfileSubmitSubmitting implements ProfileSubmitStatus {
  const factory ProfileSubmitSubmitting() = _$ProfileSubmitSubmittingImpl;
}

/// @nodoc
abstract class _$$ProfileSubmitValidationFailureImplCopyWith<$Res> {
  factory _$$ProfileSubmitValidationFailureImplCopyWith(
          _$ProfileSubmitValidationFailureImpl value,
          $Res Function(_$ProfileSubmitValidationFailureImpl) then) =
      __$$ProfileSubmitValidationFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, List<String>> fieldErrors});
}

/// @nodoc
class __$$ProfileSubmitValidationFailureImplCopyWithImpl<$Res>
    extends _$ProfileSubmitStatusCopyWithImpl<$Res,
        _$ProfileSubmitValidationFailureImpl>
    implements _$$ProfileSubmitValidationFailureImplCopyWith<$Res> {
  __$$ProfileSubmitValidationFailureImplCopyWithImpl(
      _$ProfileSubmitValidationFailureImpl _value,
      $Res Function(_$ProfileSubmitValidationFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldErrors = null,
  }) {
    return _then(_$ProfileSubmitValidationFailureImpl(
      null == fieldErrors
          ? _value._fieldErrors
          : fieldErrors // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc

class _$ProfileSubmitValidationFailureImpl
    implements ProfileSubmitValidationFailure {
  const _$ProfileSubmitValidationFailureImpl(
      final Map<String, List<String>> fieldErrors)
      : _fieldErrors = fieldErrors;

  final Map<String, List<String>> _fieldErrors;
  @override
  Map<String, List<String>> get fieldErrors {
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fieldErrors);
  }

  @override
  String toString() {
    return 'ProfileSubmitStatus.validationFailure(fieldErrors: $fieldErrors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileSubmitValidationFailureImpl &&
            const DeepCollectionEquality()
                .equals(other._fieldErrors, _fieldErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_fieldErrors));

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileSubmitValidationFailureImplCopyWith<
          _$ProfileSubmitValidationFailureImpl>
      get copyWith => __$$ProfileSubmitValidationFailureImplCopyWithImpl<
          _$ProfileSubmitValidationFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(Map<String, List<String>> fieldErrors)
        validationFailure,
    required TResult Function(CustomerProfileEntity profile) success,
    required TResult Function(AppException exception) failure,
  }) {
    return validationFailure(fieldErrors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult? Function(CustomerProfileEntity profile)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return validationFailure?.call(fieldErrors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult Function(CustomerProfileEntity profile)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (validationFailure != null) {
      return validationFailure(fieldErrors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileSubmitIdle value) idle,
    required TResult Function(ProfileSubmitSubmitting value) submitting,
    required TResult Function(ProfileSubmitValidationFailure value)
        validationFailure,
    required TResult Function(ProfileSubmitSuccess value) success,
    required TResult Function(ProfileSubmitFailure value) failure,
  }) {
    return validationFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileSubmitIdle value)? idle,
    TResult? Function(ProfileSubmitSubmitting value)? submitting,
    TResult? Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult? Function(ProfileSubmitSuccess value)? success,
    TResult? Function(ProfileSubmitFailure value)? failure,
  }) {
    return validationFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileSubmitIdle value)? idle,
    TResult Function(ProfileSubmitSubmitting value)? submitting,
    TResult Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult Function(ProfileSubmitSuccess value)? success,
    TResult Function(ProfileSubmitFailure value)? failure,
    required TResult orElse(),
  }) {
    if (validationFailure != null) {
      return validationFailure(this);
    }
    return orElse();
  }
}

abstract class ProfileSubmitValidationFailure implements ProfileSubmitStatus {
  const factory ProfileSubmitValidationFailure(
          final Map<String, List<String>> fieldErrors) =
      _$ProfileSubmitValidationFailureImpl;

  Map<String, List<String>> get fieldErrors;

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileSubmitValidationFailureImplCopyWith<
          _$ProfileSubmitValidationFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProfileSubmitSuccessImplCopyWith<$Res> {
  factory _$$ProfileSubmitSuccessImplCopyWith(_$ProfileSubmitSuccessImpl value,
          $Res Function(_$ProfileSubmitSuccessImpl) then) =
      __$$ProfileSubmitSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CustomerProfileEntity profile});
}

/// @nodoc
class __$$ProfileSubmitSuccessImplCopyWithImpl<$Res>
    extends _$ProfileSubmitStatusCopyWithImpl<$Res, _$ProfileSubmitSuccessImpl>
    implements _$$ProfileSubmitSuccessImplCopyWith<$Res> {
  __$$ProfileSubmitSuccessImplCopyWithImpl(_$ProfileSubmitSuccessImpl _value,
      $Res Function(_$ProfileSubmitSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
  }) {
    return _then(_$ProfileSubmitSuccessImpl(
      null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as CustomerProfileEntity,
    ));
  }
}

/// @nodoc

class _$ProfileSubmitSuccessImpl implements ProfileSubmitSuccess {
  const _$ProfileSubmitSuccessImpl(this.profile);

  @override
  final CustomerProfileEntity profile;

  @override
  String toString() {
    return 'ProfileSubmitStatus.success(profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileSubmitSuccessImpl &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile);

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileSubmitSuccessImplCopyWith<_$ProfileSubmitSuccessImpl>
      get copyWith =>
          __$$ProfileSubmitSuccessImplCopyWithImpl<_$ProfileSubmitSuccessImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(Map<String, List<String>> fieldErrors)
        validationFailure,
    required TResult Function(CustomerProfileEntity profile) success,
    required TResult Function(AppException exception) failure,
  }) {
    return success(profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult? Function(CustomerProfileEntity profile)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult Function(CustomerProfileEntity profile)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileSubmitIdle value) idle,
    required TResult Function(ProfileSubmitSubmitting value) submitting,
    required TResult Function(ProfileSubmitValidationFailure value)
        validationFailure,
    required TResult Function(ProfileSubmitSuccess value) success,
    required TResult Function(ProfileSubmitFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileSubmitIdle value)? idle,
    TResult? Function(ProfileSubmitSubmitting value)? submitting,
    TResult? Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult? Function(ProfileSubmitSuccess value)? success,
    TResult? Function(ProfileSubmitFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileSubmitIdle value)? idle,
    TResult Function(ProfileSubmitSubmitting value)? submitting,
    TResult Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult Function(ProfileSubmitSuccess value)? success,
    TResult Function(ProfileSubmitFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ProfileSubmitSuccess implements ProfileSubmitStatus {
  const factory ProfileSubmitSuccess(final CustomerProfileEntity profile) =
      _$ProfileSubmitSuccessImpl;

  CustomerProfileEntity get profile;

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileSubmitSuccessImplCopyWith<_$ProfileSubmitSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProfileSubmitFailureImplCopyWith<$Res> {
  factory _$$ProfileSubmitFailureImplCopyWith(_$ProfileSubmitFailureImpl value,
          $Res Function(_$ProfileSubmitFailureImpl) then) =
      __$$ProfileSubmitFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$ProfileSubmitFailureImplCopyWithImpl<$Res>
    extends _$ProfileSubmitStatusCopyWithImpl<$Res, _$ProfileSubmitFailureImpl>
    implements _$$ProfileSubmitFailureImplCopyWith<$Res> {
  __$$ProfileSubmitFailureImplCopyWithImpl(_$ProfileSubmitFailureImpl _value,
      $Res Function(_$ProfileSubmitFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$ProfileSubmitFailureImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$ProfileSubmitFailureImpl implements ProfileSubmitFailure {
  const _$ProfileSubmitFailureImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'ProfileSubmitStatus.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileSubmitFailureImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileSubmitFailureImplCopyWith<_$ProfileSubmitFailureImpl>
      get copyWith =>
          __$$ProfileSubmitFailureImplCopyWithImpl<_$ProfileSubmitFailureImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(Map<String, List<String>> fieldErrors)
        validationFailure,
    required TResult Function(CustomerProfileEntity profile) success,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult? Function(CustomerProfileEntity profile)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult Function(CustomerProfileEntity profile)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProfileSubmitIdle value) idle,
    required TResult Function(ProfileSubmitSubmitting value) submitting,
    required TResult Function(ProfileSubmitValidationFailure value)
        validationFailure,
    required TResult Function(ProfileSubmitSuccess value) success,
    required TResult Function(ProfileSubmitFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProfileSubmitIdle value)? idle,
    TResult? Function(ProfileSubmitSubmitting value)? submitting,
    TResult? Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult? Function(ProfileSubmitSuccess value)? success,
    TResult? Function(ProfileSubmitFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProfileSubmitIdle value)? idle,
    TResult Function(ProfileSubmitSubmitting value)? submitting,
    TResult Function(ProfileSubmitValidationFailure value)? validationFailure,
    TResult Function(ProfileSubmitSuccess value)? success,
    TResult Function(ProfileSubmitFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ProfileSubmitFailure implements ProfileSubmitStatus {
  const factory ProfileSubmitFailure(final AppException exception) =
      _$ProfileSubmitFailureImpl;

  AppException get exception;

  /// Create a copy of ProfileSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileSubmitFailureImplCopyWith<_$ProfileSubmitFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
