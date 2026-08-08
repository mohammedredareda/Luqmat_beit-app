// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ResetPasswordState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResetPasswordInitial value) initial,
    required TResult Function(ResetPasswordSubmitting value) submitting,
    required TResult Function(ResetPasswordSuccess value) success,
    required TResult Function(ResetPasswordFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResetPasswordInitial value)? initial,
    TResult? Function(ResetPasswordSubmitting value)? submitting,
    TResult? Function(ResetPasswordSuccess value)? success,
    TResult? Function(ResetPasswordFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResetPasswordInitial value)? initial,
    TResult Function(ResetPasswordSubmitting value)? submitting,
    TResult Function(ResetPasswordSuccess value)? success,
    TResult Function(ResetPasswordFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordStateCopyWith<$Res> {
  factory $ResetPasswordStateCopyWith(
          ResetPasswordState value, $Res Function(ResetPasswordState) then) =
      _$ResetPasswordStateCopyWithImpl<$Res, ResetPasswordState>;
}

/// @nodoc
class _$ResetPasswordStateCopyWithImpl<$Res, $Val extends ResetPasswordState>
    implements $ResetPasswordStateCopyWith<$Res> {
  _$ResetPasswordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ResetPasswordInitialImplCopyWith<$Res> {
  factory _$$ResetPasswordInitialImplCopyWith(_$ResetPasswordInitialImpl value,
          $Res Function(_$ResetPasswordInitialImpl) then) =
      __$$ResetPasswordInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetPasswordInitialImplCopyWithImpl<$Res>
    extends _$ResetPasswordStateCopyWithImpl<$Res, _$ResetPasswordInitialImpl>
    implements _$$ResetPasswordInitialImplCopyWith<$Res> {
  __$$ResetPasswordInitialImplCopyWithImpl(_$ResetPasswordInitialImpl _value,
      $Res Function(_$ResetPasswordInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetPasswordInitialImpl implements ResetPasswordInitial {
  const _$ResetPasswordInitialImpl();

  @override
  String toString() {
    return 'ResetPasswordState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResetPasswordInitial value) initial,
    required TResult Function(ResetPasswordSubmitting value) submitting,
    required TResult Function(ResetPasswordSuccess value) success,
    required TResult Function(ResetPasswordFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResetPasswordInitial value)? initial,
    TResult? Function(ResetPasswordSubmitting value)? submitting,
    TResult? Function(ResetPasswordSuccess value)? success,
    TResult? Function(ResetPasswordFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResetPasswordInitial value)? initial,
    TResult Function(ResetPasswordSubmitting value)? submitting,
    TResult Function(ResetPasswordSuccess value)? success,
    TResult Function(ResetPasswordFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ResetPasswordInitial implements ResetPasswordState {
  const factory ResetPasswordInitial() = _$ResetPasswordInitialImpl;
}

/// @nodoc
abstract class _$$ResetPasswordSubmittingImplCopyWith<$Res> {
  factory _$$ResetPasswordSubmittingImplCopyWith(
          _$ResetPasswordSubmittingImpl value,
          $Res Function(_$ResetPasswordSubmittingImpl) then) =
      __$$ResetPasswordSubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetPasswordSubmittingImplCopyWithImpl<$Res>
    extends _$ResetPasswordStateCopyWithImpl<$Res,
        _$ResetPasswordSubmittingImpl>
    implements _$$ResetPasswordSubmittingImplCopyWith<$Res> {
  __$$ResetPasswordSubmittingImplCopyWithImpl(
      _$ResetPasswordSubmittingImpl _value,
      $Res Function(_$ResetPasswordSubmittingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetPasswordSubmittingImpl implements ResetPasswordSubmitting {
  const _$ResetPasswordSubmittingImpl();

  @override
  String toString() {
    return 'ResetPasswordState.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordSubmittingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function()? success,
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
    required TResult Function(ResetPasswordInitial value) initial,
    required TResult Function(ResetPasswordSubmitting value) submitting,
    required TResult Function(ResetPasswordSuccess value) success,
    required TResult Function(ResetPasswordFailure value) failure,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResetPasswordInitial value)? initial,
    TResult? Function(ResetPasswordSubmitting value)? submitting,
    TResult? Function(ResetPasswordSuccess value)? success,
    TResult? Function(ResetPasswordFailure value)? failure,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResetPasswordInitial value)? initial,
    TResult Function(ResetPasswordSubmitting value)? submitting,
    TResult Function(ResetPasswordSuccess value)? success,
    TResult Function(ResetPasswordFailure value)? failure,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class ResetPasswordSubmitting implements ResetPasswordState {
  const factory ResetPasswordSubmitting() = _$ResetPasswordSubmittingImpl;
}

/// @nodoc
abstract class _$$ResetPasswordSuccessImplCopyWith<$Res> {
  factory _$$ResetPasswordSuccessImplCopyWith(_$ResetPasswordSuccessImpl value,
          $Res Function(_$ResetPasswordSuccessImpl) then) =
      __$$ResetPasswordSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetPasswordSuccessImplCopyWithImpl<$Res>
    extends _$ResetPasswordStateCopyWithImpl<$Res, _$ResetPasswordSuccessImpl>
    implements _$$ResetPasswordSuccessImplCopyWith<$Res> {
  __$$ResetPasswordSuccessImplCopyWithImpl(_$ResetPasswordSuccessImpl _value,
      $Res Function(_$ResetPasswordSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetPasswordSuccessImpl implements ResetPasswordSuccess {
  const _$ResetPasswordSuccessImpl();

  @override
  String toString() {
    return 'ResetPasswordState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ResetPasswordInitial value) initial,
    required TResult Function(ResetPasswordSubmitting value) submitting,
    required TResult Function(ResetPasswordSuccess value) success,
    required TResult Function(ResetPasswordFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResetPasswordInitial value)? initial,
    TResult? Function(ResetPasswordSubmitting value)? submitting,
    TResult? Function(ResetPasswordSuccess value)? success,
    TResult? Function(ResetPasswordFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResetPasswordInitial value)? initial,
    TResult Function(ResetPasswordSubmitting value)? submitting,
    TResult Function(ResetPasswordSuccess value)? success,
    TResult Function(ResetPasswordFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ResetPasswordSuccess implements ResetPasswordState {
  const factory ResetPasswordSuccess() = _$ResetPasswordSuccessImpl;
}

/// @nodoc
abstract class _$$ResetPasswordFailureImplCopyWith<$Res> {
  factory _$$ResetPasswordFailureImplCopyWith(_$ResetPasswordFailureImpl value,
          $Res Function(_$ResetPasswordFailureImpl) then) =
      __$$ResetPasswordFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$ResetPasswordFailureImplCopyWithImpl<$Res>
    extends _$ResetPasswordStateCopyWithImpl<$Res, _$ResetPasswordFailureImpl>
    implements _$$ResetPasswordFailureImplCopyWith<$Res> {
  __$$ResetPasswordFailureImplCopyWithImpl(_$ResetPasswordFailureImpl _value,
      $Res Function(_$ResetPasswordFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$ResetPasswordFailureImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$ResetPasswordFailureImpl implements ResetPasswordFailure {
  const _$ResetPasswordFailureImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'ResetPasswordState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordFailureImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordFailureImplCopyWith<_$ResetPasswordFailureImpl>
      get copyWith =>
          __$$ResetPasswordFailureImplCopyWithImpl<_$ResetPasswordFailureImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function()? success,
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
    required TResult Function(ResetPasswordInitial value) initial,
    required TResult Function(ResetPasswordSubmitting value) submitting,
    required TResult Function(ResetPasswordSuccess value) success,
    required TResult Function(ResetPasswordFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ResetPasswordInitial value)? initial,
    TResult? Function(ResetPasswordSubmitting value)? submitting,
    TResult? Function(ResetPasswordSuccess value)? success,
    TResult? Function(ResetPasswordFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ResetPasswordInitial value)? initial,
    TResult Function(ResetPasswordSubmitting value)? submitting,
    TResult Function(ResetPasswordSuccess value)? success,
    TResult Function(ResetPasswordFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ResetPasswordFailure implements ResetPasswordState {
  const factory ResetPasswordFailure(final AppException exception) =
      _$ResetPasswordFailureImpl;

  AppException get exception;

  /// Create a copy of ResetPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPasswordFailureImplCopyWith<_$ResetPasswordFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
