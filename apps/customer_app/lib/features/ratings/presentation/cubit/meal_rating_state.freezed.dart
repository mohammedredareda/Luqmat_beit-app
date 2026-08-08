// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_rating_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MealRatingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)
        loaded,
    required TResult Function() submitted,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult? Function()? submitted,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult Function()? submitted,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MealRatingInitial value) initial,
    required TResult Function(MealRatingLoading value) loading,
    required TResult Function(MealRatingLoaded value) loaded,
    required TResult Function(MealRatingSubmitted value) submitted,
    required TResult Function(MealRatingFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MealRatingInitial value)? initial,
    TResult? Function(MealRatingLoading value)? loading,
    TResult? Function(MealRatingLoaded value)? loaded,
    TResult? Function(MealRatingSubmitted value)? submitted,
    TResult? Function(MealRatingFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MealRatingInitial value)? initial,
    TResult Function(MealRatingLoading value)? loading,
    TResult Function(MealRatingLoaded value)? loaded,
    TResult Function(MealRatingSubmitted value)? submitted,
    TResult Function(MealRatingFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealRatingStateCopyWith<$Res> {
  factory $MealRatingStateCopyWith(
          MealRatingState value, $Res Function(MealRatingState) then) =
      _$MealRatingStateCopyWithImpl<$Res, MealRatingState>;
}

/// @nodoc
class _$MealRatingStateCopyWithImpl<$Res, $Val extends MealRatingState>
    implements $MealRatingStateCopyWith<$Res> {
  _$MealRatingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealRatingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MealRatingInitialImplCopyWith<$Res> {
  factory _$$MealRatingInitialImplCopyWith(_$MealRatingInitialImpl value,
          $Res Function(_$MealRatingInitialImpl) then) =
      __$$MealRatingInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MealRatingInitialImplCopyWithImpl<$Res>
    extends _$MealRatingStateCopyWithImpl<$Res, _$MealRatingInitialImpl>
    implements _$$MealRatingInitialImplCopyWith<$Res> {
  __$$MealRatingInitialImplCopyWithImpl(_$MealRatingInitialImpl _value,
      $Res Function(_$MealRatingInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealRatingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MealRatingInitialImpl implements MealRatingInitial {
  const _$MealRatingInitialImpl();

  @override
  String toString() {
    return 'MealRatingState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MealRatingInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)
        loaded,
    required TResult Function() submitted,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult? Function()? submitted,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult Function()? submitted,
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
    required TResult Function(MealRatingInitial value) initial,
    required TResult Function(MealRatingLoading value) loading,
    required TResult Function(MealRatingLoaded value) loaded,
    required TResult Function(MealRatingSubmitted value) submitted,
    required TResult Function(MealRatingFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MealRatingInitial value)? initial,
    TResult? Function(MealRatingLoading value)? loading,
    TResult? Function(MealRatingLoaded value)? loaded,
    TResult? Function(MealRatingSubmitted value)? submitted,
    TResult? Function(MealRatingFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MealRatingInitial value)? initial,
    TResult Function(MealRatingLoading value)? loading,
    TResult Function(MealRatingLoaded value)? loaded,
    TResult Function(MealRatingSubmitted value)? submitted,
    TResult Function(MealRatingFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MealRatingInitial implements MealRatingState {
  const factory MealRatingInitial() = _$MealRatingInitialImpl;
}

/// @nodoc
abstract class _$$MealRatingLoadingImplCopyWith<$Res> {
  factory _$$MealRatingLoadingImplCopyWith(_$MealRatingLoadingImpl value,
          $Res Function(_$MealRatingLoadingImpl) then) =
      __$$MealRatingLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MealRatingLoadingImplCopyWithImpl<$Res>
    extends _$MealRatingStateCopyWithImpl<$Res, _$MealRatingLoadingImpl>
    implements _$$MealRatingLoadingImplCopyWith<$Res> {
  __$$MealRatingLoadingImplCopyWithImpl(_$MealRatingLoadingImpl _value,
      $Res Function(_$MealRatingLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealRatingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MealRatingLoadingImpl implements MealRatingLoading {
  const _$MealRatingLoadingImpl();

  @override
  String toString() {
    return 'MealRatingState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MealRatingLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)
        loaded,
    required TResult Function() submitted,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult? Function()? submitted,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult Function()? submitted,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MealRatingInitial value) initial,
    required TResult Function(MealRatingLoading value) loading,
    required TResult Function(MealRatingLoaded value) loaded,
    required TResult Function(MealRatingSubmitted value) submitted,
    required TResult Function(MealRatingFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MealRatingInitial value)? initial,
    TResult? Function(MealRatingLoading value)? loading,
    TResult? Function(MealRatingLoaded value)? loaded,
    TResult? Function(MealRatingSubmitted value)? submitted,
    TResult? Function(MealRatingFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MealRatingInitial value)? initial,
    TResult Function(MealRatingLoading value)? loading,
    TResult Function(MealRatingLoaded value)? loaded,
    TResult Function(MealRatingSubmitted value)? submitted,
    TResult Function(MealRatingFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MealRatingLoading implements MealRatingState {
  const factory MealRatingLoading() = _$MealRatingLoadingImpl;
}

/// @nodoc
abstract class _$$MealRatingLoadedImplCopyWith<$Res> {
  factory _$$MealRatingLoadedImplCopyWith(_$MealRatingLoadedImpl value,
          $Res Function(_$MealRatingLoadedImpl) then) =
      __$$MealRatingLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {OrderEntity order,
      int stars,
      String review,
      bool isSubmitting,
      AppException? submitError});
}

/// @nodoc
class __$$MealRatingLoadedImplCopyWithImpl<$Res>
    extends _$MealRatingStateCopyWithImpl<$Res, _$MealRatingLoadedImpl>
    implements _$$MealRatingLoadedImplCopyWith<$Res> {
  __$$MealRatingLoadedImplCopyWithImpl(_$MealRatingLoadedImpl _value,
      $Res Function(_$MealRatingLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealRatingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? stars = null,
    Object? review = null,
    Object? isSubmitting = null,
    Object? submitError = freezed,
  }) {
    return _then(_$MealRatingLoadedImpl(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderEntity,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      review: null == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      submitError: freezed == submitError
          ? _value.submitError
          : submitError // ignore: cast_nullable_to_non_nullable
              as AppException?,
    ));
  }
}

/// @nodoc

class _$MealRatingLoadedImpl implements MealRatingLoaded {
  const _$MealRatingLoadedImpl(
      {required this.order,
      this.stars = 0,
      this.review = '',
      this.isSubmitting = false,
      this.submitError});

  @override
  final OrderEntity order;
  @override
  @JsonKey()
  final int stars;
  @override
  @JsonKey()
  final String review;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final AppException? submitError;

  @override
  String toString() {
    return 'MealRatingState.loaded(order: $order, stars: $stars, review: $review, isSubmitting: $isSubmitting, submitError: $submitError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealRatingLoadedImpl &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.stars, stars) || other.stars == stars) &&
            (identical(other.review, review) || other.review == review) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.submitError, submitError) ||
                other.submitError == submitError));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, order, stars, review, isSubmitting, submitError);

  /// Create a copy of MealRatingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealRatingLoadedImplCopyWith<_$MealRatingLoadedImpl> get copyWith =>
      __$$MealRatingLoadedImplCopyWithImpl<_$MealRatingLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)
        loaded,
    required TResult Function() submitted,
    required TResult Function(AppException exception) failure,
  }) {
    return loaded(order, stars, review, isSubmitting, submitError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult? Function()? submitted,
    TResult? Function(AppException exception)? failure,
  }) {
    return loaded?.call(order, stars, review, isSubmitting, submitError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult Function()? submitted,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(order, stars, review, isSubmitting, submitError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MealRatingInitial value) initial,
    required TResult Function(MealRatingLoading value) loading,
    required TResult Function(MealRatingLoaded value) loaded,
    required TResult Function(MealRatingSubmitted value) submitted,
    required TResult Function(MealRatingFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MealRatingInitial value)? initial,
    TResult? Function(MealRatingLoading value)? loading,
    TResult? Function(MealRatingLoaded value)? loaded,
    TResult? Function(MealRatingSubmitted value)? submitted,
    TResult? Function(MealRatingFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MealRatingInitial value)? initial,
    TResult Function(MealRatingLoading value)? loading,
    TResult Function(MealRatingLoaded value)? loaded,
    TResult Function(MealRatingSubmitted value)? submitted,
    TResult Function(MealRatingFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class MealRatingLoaded implements MealRatingState {
  const factory MealRatingLoaded(
      {required final OrderEntity order,
      final int stars,
      final String review,
      final bool isSubmitting,
      final AppException? submitError}) = _$MealRatingLoadedImpl;

  OrderEntity get order;
  int get stars;
  String get review;
  bool get isSubmitting;
  AppException? get submitError;

  /// Create a copy of MealRatingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealRatingLoadedImplCopyWith<_$MealRatingLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MealRatingSubmittedImplCopyWith<$Res> {
  factory _$$MealRatingSubmittedImplCopyWith(_$MealRatingSubmittedImpl value,
          $Res Function(_$MealRatingSubmittedImpl) then) =
      __$$MealRatingSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MealRatingSubmittedImplCopyWithImpl<$Res>
    extends _$MealRatingStateCopyWithImpl<$Res, _$MealRatingSubmittedImpl>
    implements _$$MealRatingSubmittedImplCopyWith<$Res> {
  __$$MealRatingSubmittedImplCopyWithImpl(_$MealRatingSubmittedImpl _value,
      $Res Function(_$MealRatingSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealRatingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MealRatingSubmittedImpl implements MealRatingSubmitted {
  const _$MealRatingSubmittedImpl();

  @override
  String toString() {
    return 'MealRatingState.submitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealRatingSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)
        loaded,
    required TResult Function() submitted,
    required TResult Function(AppException exception) failure,
  }) {
    return submitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult? Function()? submitted,
    TResult? Function(AppException exception)? failure,
  }) {
    return submitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult Function()? submitted,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MealRatingInitial value) initial,
    required TResult Function(MealRatingLoading value) loading,
    required TResult Function(MealRatingLoaded value) loaded,
    required TResult Function(MealRatingSubmitted value) submitted,
    required TResult Function(MealRatingFailure value) failure,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MealRatingInitial value)? initial,
    TResult? Function(MealRatingLoading value)? loading,
    TResult? Function(MealRatingLoaded value)? loaded,
    TResult? Function(MealRatingSubmitted value)? submitted,
    TResult? Function(MealRatingFailure value)? failure,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MealRatingInitial value)? initial,
    TResult Function(MealRatingLoading value)? loading,
    TResult Function(MealRatingLoaded value)? loaded,
    TResult Function(MealRatingSubmitted value)? submitted,
    TResult Function(MealRatingFailure value)? failure,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }
}

abstract class MealRatingSubmitted implements MealRatingState {
  const factory MealRatingSubmitted() = _$MealRatingSubmittedImpl;
}

/// @nodoc
abstract class _$$MealRatingFailureImplCopyWith<$Res> {
  factory _$$MealRatingFailureImplCopyWith(_$MealRatingFailureImpl value,
          $Res Function(_$MealRatingFailureImpl) then) =
      __$$MealRatingFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$MealRatingFailureImplCopyWithImpl<$Res>
    extends _$MealRatingStateCopyWithImpl<$Res, _$MealRatingFailureImpl>
    implements _$$MealRatingFailureImplCopyWith<$Res> {
  __$$MealRatingFailureImplCopyWithImpl(_$MealRatingFailureImpl _value,
      $Res Function(_$MealRatingFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealRatingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$MealRatingFailureImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$MealRatingFailureImpl implements MealRatingFailure {
  const _$MealRatingFailureImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'MealRatingState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealRatingFailureImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of MealRatingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealRatingFailureImplCopyWith<_$MealRatingFailureImpl> get copyWith =>
      __$$MealRatingFailureImplCopyWithImpl<_$MealRatingFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)
        loaded,
    required TResult Function() submitted,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult? Function()? submitted,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OrderEntity order, int stars, String review,
            bool isSubmitting, AppException? submitError)?
        loaded,
    TResult Function()? submitted,
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
    required TResult Function(MealRatingInitial value) initial,
    required TResult Function(MealRatingLoading value) loading,
    required TResult Function(MealRatingLoaded value) loaded,
    required TResult Function(MealRatingSubmitted value) submitted,
    required TResult Function(MealRatingFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MealRatingInitial value)? initial,
    TResult? Function(MealRatingLoading value)? loading,
    TResult? Function(MealRatingLoaded value)? loaded,
    TResult? Function(MealRatingSubmitted value)? submitted,
    TResult? Function(MealRatingFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MealRatingInitial value)? initial,
    TResult Function(MealRatingLoading value)? loading,
    TResult Function(MealRatingLoaded value)? loaded,
    TResult Function(MealRatingSubmitted value)? submitted,
    TResult Function(MealRatingFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class MealRatingFailure implements MealRatingState {
  const factory MealRatingFailure(final AppException exception) =
      _$MealRatingFailureImpl;

  AppException get exception;

  /// Create a copy of MealRatingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealRatingFailureImplCopyWith<_$MealRatingFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
