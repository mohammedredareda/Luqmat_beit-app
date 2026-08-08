// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offer_submit_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OfferSubmitStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(Map<String, List<String>> fieldErrors)
        validationFailure,
    required TResult Function(OfferEntity offer) success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult? Function(OfferEntity offer)? success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult Function(OfferEntity offer)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OfferSubmitIdle value) idle,
    required TResult Function(OfferSubmitSubmitting value) submitting,
    required TResult Function(OfferSubmitValidationFailure value)
        validationFailure,
    required TResult Function(OfferSubmitSuccess value) success,
    required TResult Function(OfferSubmitFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OfferSubmitIdle value)? idle,
    TResult? Function(OfferSubmitSubmitting value)? submitting,
    TResult? Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult? Function(OfferSubmitSuccess value)? success,
    TResult? Function(OfferSubmitFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OfferSubmitIdle value)? idle,
    TResult Function(OfferSubmitSubmitting value)? submitting,
    TResult Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult Function(OfferSubmitSuccess value)? success,
    TResult Function(OfferSubmitFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfferSubmitStatusCopyWith<$Res> {
  factory $OfferSubmitStatusCopyWith(
          OfferSubmitStatus value, $Res Function(OfferSubmitStatus) then) =
      _$OfferSubmitStatusCopyWithImpl<$Res, OfferSubmitStatus>;
}

/// @nodoc
class _$OfferSubmitStatusCopyWithImpl<$Res, $Val extends OfferSubmitStatus>
    implements $OfferSubmitStatusCopyWith<$Res> {
  _$OfferSubmitStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OfferSubmitIdleImplCopyWith<$Res> {
  factory _$$OfferSubmitIdleImplCopyWith(_$OfferSubmitIdleImpl value,
          $Res Function(_$OfferSubmitIdleImpl) then) =
      __$$OfferSubmitIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OfferSubmitIdleImplCopyWithImpl<$Res>
    extends _$OfferSubmitStatusCopyWithImpl<$Res, _$OfferSubmitIdleImpl>
    implements _$$OfferSubmitIdleImplCopyWith<$Res> {
  __$$OfferSubmitIdleImplCopyWithImpl(
      _$OfferSubmitIdleImpl _value, $Res Function(_$OfferSubmitIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OfferSubmitIdleImpl implements OfferSubmitIdle {
  const _$OfferSubmitIdleImpl();

  @override
  String toString() {
    return 'OfferSubmitStatus.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OfferSubmitIdleImpl);
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
    required TResult Function(OfferEntity offer) success,
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
    TResult? Function(OfferEntity offer)? success,
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
    TResult Function(OfferEntity offer)? success,
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
    required TResult Function(OfferSubmitIdle value) idle,
    required TResult Function(OfferSubmitSubmitting value) submitting,
    required TResult Function(OfferSubmitValidationFailure value)
        validationFailure,
    required TResult Function(OfferSubmitSuccess value) success,
    required TResult Function(OfferSubmitFailure value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OfferSubmitIdle value)? idle,
    TResult? Function(OfferSubmitSubmitting value)? submitting,
    TResult? Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult? Function(OfferSubmitSuccess value)? success,
    TResult? Function(OfferSubmitFailure value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OfferSubmitIdle value)? idle,
    TResult Function(OfferSubmitSubmitting value)? submitting,
    TResult Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult Function(OfferSubmitSuccess value)? success,
    TResult Function(OfferSubmitFailure value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class OfferSubmitIdle implements OfferSubmitStatus {
  const factory OfferSubmitIdle() = _$OfferSubmitIdleImpl;
}

/// @nodoc
abstract class _$$OfferSubmitSubmittingImplCopyWith<$Res> {
  factory _$$OfferSubmitSubmittingImplCopyWith(
          _$OfferSubmitSubmittingImpl value,
          $Res Function(_$OfferSubmitSubmittingImpl) then) =
      __$$OfferSubmitSubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OfferSubmitSubmittingImplCopyWithImpl<$Res>
    extends _$OfferSubmitStatusCopyWithImpl<$Res, _$OfferSubmitSubmittingImpl>
    implements _$$OfferSubmitSubmittingImplCopyWith<$Res> {
  __$$OfferSubmitSubmittingImplCopyWithImpl(_$OfferSubmitSubmittingImpl _value,
      $Res Function(_$OfferSubmitSubmittingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OfferSubmitSubmittingImpl implements OfferSubmitSubmitting {
  const _$OfferSubmitSubmittingImpl();

  @override
  String toString() {
    return 'OfferSubmitStatus.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferSubmitSubmittingImpl);
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
    required TResult Function(OfferEntity offer) success,
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
    TResult? Function(OfferEntity offer)? success,
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
    TResult Function(OfferEntity offer)? success,
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
    required TResult Function(OfferSubmitIdle value) idle,
    required TResult Function(OfferSubmitSubmitting value) submitting,
    required TResult Function(OfferSubmitValidationFailure value)
        validationFailure,
    required TResult Function(OfferSubmitSuccess value) success,
    required TResult Function(OfferSubmitFailure value) failure,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OfferSubmitIdle value)? idle,
    TResult? Function(OfferSubmitSubmitting value)? submitting,
    TResult? Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult? Function(OfferSubmitSuccess value)? success,
    TResult? Function(OfferSubmitFailure value)? failure,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OfferSubmitIdle value)? idle,
    TResult Function(OfferSubmitSubmitting value)? submitting,
    TResult Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult Function(OfferSubmitSuccess value)? success,
    TResult Function(OfferSubmitFailure value)? failure,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class OfferSubmitSubmitting implements OfferSubmitStatus {
  const factory OfferSubmitSubmitting() = _$OfferSubmitSubmittingImpl;
}

/// @nodoc
abstract class _$$OfferSubmitValidationFailureImplCopyWith<$Res> {
  factory _$$OfferSubmitValidationFailureImplCopyWith(
          _$OfferSubmitValidationFailureImpl value,
          $Res Function(_$OfferSubmitValidationFailureImpl) then) =
      __$$OfferSubmitValidationFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, List<String>> fieldErrors});
}

/// @nodoc
class __$$OfferSubmitValidationFailureImplCopyWithImpl<$Res>
    extends _$OfferSubmitStatusCopyWithImpl<$Res,
        _$OfferSubmitValidationFailureImpl>
    implements _$$OfferSubmitValidationFailureImplCopyWith<$Res> {
  __$$OfferSubmitValidationFailureImplCopyWithImpl(
      _$OfferSubmitValidationFailureImpl _value,
      $Res Function(_$OfferSubmitValidationFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldErrors = null,
  }) {
    return _then(_$OfferSubmitValidationFailureImpl(
      null == fieldErrors
          ? _value._fieldErrors
          : fieldErrors // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc

class _$OfferSubmitValidationFailureImpl
    implements OfferSubmitValidationFailure {
  const _$OfferSubmitValidationFailureImpl(
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
    return 'OfferSubmitStatus.validationFailure(fieldErrors: $fieldErrors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferSubmitValidationFailureImpl &&
            const DeepCollectionEquality()
                .equals(other._fieldErrors, _fieldErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_fieldErrors));

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfferSubmitValidationFailureImplCopyWith<
          _$OfferSubmitValidationFailureImpl>
      get copyWith => __$$OfferSubmitValidationFailureImplCopyWithImpl<
          _$OfferSubmitValidationFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(Map<String, List<String>> fieldErrors)
        validationFailure,
    required TResult Function(OfferEntity offer) success,
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
    TResult? Function(OfferEntity offer)? success,
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
    TResult Function(OfferEntity offer)? success,
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
    required TResult Function(OfferSubmitIdle value) idle,
    required TResult Function(OfferSubmitSubmitting value) submitting,
    required TResult Function(OfferSubmitValidationFailure value)
        validationFailure,
    required TResult Function(OfferSubmitSuccess value) success,
    required TResult Function(OfferSubmitFailure value) failure,
  }) {
    return validationFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OfferSubmitIdle value)? idle,
    TResult? Function(OfferSubmitSubmitting value)? submitting,
    TResult? Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult? Function(OfferSubmitSuccess value)? success,
    TResult? Function(OfferSubmitFailure value)? failure,
  }) {
    return validationFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OfferSubmitIdle value)? idle,
    TResult Function(OfferSubmitSubmitting value)? submitting,
    TResult Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult Function(OfferSubmitSuccess value)? success,
    TResult Function(OfferSubmitFailure value)? failure,
    required TResult orElse(),
  }) {
    if (validationFailure != null) {
      return validationFailure(this);
    }
    return orElse();
  }
}

abstract class OfferSubmitValidationFailure implements OfferSubmitStatus {
  const factory OfferSubmitValidationFailure(
          final Map<String, List<String>> fieldErrors) =
      _$OfferSubmitValidationFailureImpl;

  Map<String, List<String>> get fieldErrors;

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfferSubmitValidationFailureImplCopyWith<
          _$OfferSubmitValidationFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OfferSubmitSuccessImplCopyWith<$Res> {
  factory _$$OfferSubmitSuccessImplCopyWith(_$OfferSubmitSuccessImpl value,
          $Res Function(_$OfferSubmitSuccessImpl) then) =
      __$$OfferSubmitSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OfferEntity offer});
}

/// @nodoc
class __$$OfferSubmitSuccessImplCopyWithImpl<$Res>
    extends _$OfferSubmitStatusCopyWithImpl<$Res, _$OfferSubmitSuccessImpl>
    implements _$$OfferSubmitSuccessImplCopyWith<$Res> {
  __$$OfferSubmitSuccessImplCopyWithImpl(_$OfferSubmitSuccessImpl _value,
      $Res Function(_$OfferSubmitSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offer = null,
  }) {
    return _then(_$OfferSubmitSuccessImpl(
      null == offer
          ? _value.offer
          : offer // ignore: cast_nullable_to_non_nullable
              as OfferEntity,
    ));
  }
}

/// @nodoc

class _$OfferSubmitSuccessImpl implements OfferSubmitSuccess {
  const _$OfferSubmitSuccessImpl(this.offer);

  @override
  final OfferEntity offer;

  @override
  String toString() {
    return 'OfferSubmitStatus.success(offer: $offer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferSubmitSuccessImpl &&
            (identical(other.offer, offer) || other.offer == offer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, offer);

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfferSubmitSuccessImplCopyWith<_$OfferSubmitSuccessImpl> get copyWith =>
      __$$OfferSubmitSuccessImplCopyWithImpl<_$OfferSubmitSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(Map<String, List<String>> fieldErrors)
        validationFailure,
    required TResult Function(OfferEntity offer) success,
    required TResult Function(AppException exception) failure,
  }) {
    return success(offer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? submitting,
    TResult? Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult? Function(OfferEntity offer)? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call(offer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? submitting,
    TResult Function(Map<String, List<String>> fieldErrors)? validationFailure,
    TResult Function(OfferEntity offer)? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(offer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OfferSubmitIdle value) idle,
    required TResult Function(OfferSubmitSubmitting value) submitting,
    required TResult Function(OfferSubmitValidationFailure value)
        validationFailure,
    required TResult Function(OfferSubmitSuccess value) success,
    required TResult Function(OfferSubmitFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OfferSubmitIdle value)? idle,
    TResult? Function(OfferSubmitSubmitting value)? submitting,
    TResult? Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult? Function(OfferSubmitSuccess value)? success,
    TResult? Function(OfferSubmitFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OfferSubmitIdle value)? idle,
    TResult Function(OfferSubmitSubmitting value)? submitting,
    TResult Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult Function(OfferSubmitSuccess value)? success,
    TResult Function(OfferSubmitFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class OfferSubmitSuccess implements OfferSubmitStatus {
  const factory OfferSubmitSuccess(final OfferEntity offer) =
      _$OfferSubmitSuccessImpl;

  OfferEntity get offer;

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfferSubmitSuccessImplCopyWith<_$OfferSubmitSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OfferSubmitFailureImplCopyWith<$Res> {
  factory _$$OfferSubmitFailureImplCopyWith(_$OfferSubmitFailureImpl value,
          $Res Function(_$OfferSubmitFailureImpl) then) =
      __$$OfferSubmitFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$OfferSubmitFailureImplCopyWithImpl<$Res>
    extends _$OfferSubmitStatusCopyWithImpl<$Res, _$OfferSubmitFailureImpl>
    implements _$$OfferSubmitFailureImplCopyWith<$Res> {
  __$$OfferSubmitFailureImplCopyWithImpl(_$OfferSubmitFailureImpl _value,
      $Res Function(_$OfferSubmitFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$OfferSubmitFailureImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$OfferSubmitFailureImpl implements OfferSubmitFailure {
  const _$OfferSubmitFailureImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'OfferSubmitStatus.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferSubmitFailureImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfferSubmitFailureImplCopyWith<_$OfferSubmitFailureImpl> get copyWith =>
      __$$OfferSubmitFailureImplCopyWithImpl<_$OfferSubmitFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() submitting,
    required TResult Function(Map<String, List<String>> fieldErrors)
        validationFailure,
    required TResult Function(OfferEntity offer) success,
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
    TResult? Function(OfferEntity offer)? success,
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
    TResult Function(OfferEntity offer)? success,
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
    required TResult Function(OfferSubmitIdle value) idle,
    required TResult Function(OfferSubmitSubmitting value) submitting,
    required TResult Function(OfferSubmitValidationFailure value)
        validationFailure,
    required TResult Function(OfferSubmitSuccess value) success,
    required TResult Function(OfferSubmitFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OfferSubmitIdle value)? idle,
    TResult? Function(OfferSubmitSubmitting value)? submitting,
    TResult? Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult? Function(OfferSubmitSuccess value)? success,
    TResult? Function(OfferSubmitFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OfferSubmitIdle value)? idle,
    TResult Function(OfferSubmitSubmitting value)? submitting,
    TResult Function(OfferSubmitValidationFailure value)? validationFailure,
    TResult Function(OfferSubmitSuccess value)? success,
    TResult Function(OfferSubmitFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class OfferSubmitFailure implements OfferSubmitStatus {
  const factory OfferSubmitFailure(final AppException exception) =
      _$OfferSubmitFailureImpl;

  AppException get exception;

  /// Create a copy of OfferSubmitStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfferSubmitFailureImplCopyWith<_$OfferSubmitFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
