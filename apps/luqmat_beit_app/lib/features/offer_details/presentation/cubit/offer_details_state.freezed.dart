// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offer_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OfferDetailsState {
  int get quantity => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int quantity) idle,
    required TResult Function(int quantity) submitting,
    required TResult Function(int quantity) addedToCart,
    required TResult Function(int quantity, AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int quantity)? idle,
    TResult? Function(int quantity)? submitting,
    TResult? Function(int quantity)? addedToCart,
    TResult? Function(int quantity, AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int quantity)? idle,
    TResult Function(int quantity)? submitting,
    TResult Function(int quantity)? addedToCart,
    TResult Function(int quantity, AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OfferDetailsIdle value) idle,
    required TResult Function(OfferDetailsSubmitting value) submitting,
    required TResult Function(OfferDetailsAddedToCart value) addedToCart,
    required TResult Function(OfferDetailsFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OfferDetailsIdle value)? idle,
    TResult? Function(OfferDetailsSubmitting value)? submitting,
    TResult? Function(OfferDetailsAddedToCart value)? addedToCart,
    TResult? Function(OfferDetailsFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OfferDetailsIdle value)? idle,
    TResult Function(OfferDetailsSubmitting value)? submitting,
    TResult Function(OfferDetailsAddedToCart value)? addedToCart,
    TResult Function(OfferDetailsFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfferDetailsStateCopyWith<OfferDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfferDetailsStateCopyWith<$Res> {
  factory $OfferDetailsStateCopyWith(
          OfferDetailsState value, $Res Function(OfferDetailsState) then) =
      _$OfferDetailsStateCopyWithImpl<$Res, OfferDetailsState>;
  @useResult
  $Res call({int quantity});
}

/// @nodoc
class _$OfferDetailsStateCopyWithImpl<$Res, $Val extends OfferDetailsState>
    implements $OfferDetailsStateCopyWith<$Res> {
  _$OfferDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfferDetailsIdleImplCopyWith<$Res>
    implements $OfferDetailsStateCopyWith<$Res> {
  factory _$$OfferDetailsIdleImplCopyWith(_$OfferDetailsIdleImpl value,
          $Res Function(_$OfferDetailsIdleImpl) then) =
      __$$OfferDetailsIdleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int quantity});
}

/// @nodoc
class __$$OfferDetailsIdleImplCopyWithImpl<$Res>
    extends _$OfferDetailsStateCopyWithImpl<$Res, _$OfferDetailsIdleImpl>
    implements _$$OfferDetailsIdleImplCopyWith<$Res> {
  __$$OfferDetailsIdleImplCopyWithImpl(_$OfferDetailsIdleImpl _value,
      $Res Function(_$OfferDetailsIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
  }) {
    return _then(_$OfferDetailsIdleImpl(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$OfferDetailsIdleImpl implements OfferDetailsIdle {
  const _$OfferDetailsIdleImpl({this.quantity = 1});

  @override
  @JsonKey()
  final int quantity;

  @override
  String toString() {
    return 'OfferDetailsState.idle(quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferDetailsIdleImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quantity);

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfferDetailsIdleImplCopyWith<_$OfferDetailsIdleImpl> get copyWith =>
      __$$OfferDetailsIdleImplCopyWithImpl<_$OfferDetailsIdleImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int quantity) idle,
    required TResult Function(int quantity) submitting,
    required TResult Function(int quantity) addedToCart,
    required TResult Function(int quantity, AppException exception) failure,
  }) {
    return idle(quantity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int quantity)? idle,
    TResult? Function(int quantity)? submitting,
    TResult? Function(int quantity)? addedToCart,
    TResult? Function(int quantity, AppException exception)? failure,
  }) {
    return idle?.call(quantity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int quantity)? idle,
    TResult Function(int quantity)? submitting,
    TResult Function(int quantity)? addedToCart,
    TResult Function(int quantity, AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(quantity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OfferDetailsIdle value) idle,
    required TResult Function(OfferDetailsSubmitting value) submitting,
    required TResult Function(OfferDetailsAddedToCart value) addedToCart,
    required TResult Function(OfferDetailsFailure value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OfferDetailsIdle value)? idle,
    TResult? Function(OfferDetailsSubmitting value)? submitting,
    TResult? Function(OfferDetailsAddedToCart value)? addedToCart,
    TResult? Function(OfferDetailsFailure value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OfferDetailsIdle value)? idle,
    TResult Function(OfferDetailsSubmitting value)? submitting,
    TResult Function(OfferDetailsAddedToCart value)? addedToCart,
    TResult Function(OfferDetailsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class OfferDetailsIdle implements OfferDetailsState {
  const factory OfferDetailsIdle({final int quantity}) = _$OfferDetailsIdleImpl;

  @override
  int get quantity;

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfferDetailsIdleImplCopyWith<_$OfferDetailsIdleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OfferDetailsSubmittingImplCopyWith<$Res>
    implements $OfferDetailsStateCopyWith<$Res> {
  factory _$$OfferDetailsSubmittingImplCopyWith(
          _$OfferDetailsSubmittingImpl value,
          $Res Function(_$OfferDetailsSubmittingImpl) then) =
      __$$OfferDetailsSubmittingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int quantity});
}

/// @nodoc
class __$$OfferDetailsSubmittingImplCopyWithImpl<$Res>
    extends _$OfferDetailsStateCopyWithImpl<$Res, _$OfferDetailsSubmittingImpl>
    implements _$$OfferDetailsSubmittingImplCopyWith<$Res> {
  __$$OfferDetailsSubmittingImplCopyWithImpl(
      _$OfferDetailsSubmittingImpl _value,
      $Res Function(_$OfferDetailsSubmittingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
  }) {
    return _then(_$OfferDetailsSubmittingImpl(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$OfferDetailsSubmittingImpl implements OfferDetailsSubmitting {
  const _$OfferDetailsSubmittingImpl({required this.quantity});

  @override
  final int quantity;

  @override
  String toString() {
    return 'OfferDetailsState.submitting(quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferDetailsSubmittingImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quantity);

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfferDetailsSubmittingImplCopyWith<_$OfferDetailsSubmittingImpl>
      get copyWith => __$$OfferDetailsSubmittingImplCopyWithImpl<
          _$OfferDetailsSubmittingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int quantity) idle,
    required TResult Function(int quantity) submitting,
    required TResult Function(int quantity) addedToCart,
    required TResult Function(int quantity, AppException exception) failure,
  }) {
    return submitting(quantity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int quantity)? idle,
    TResult? Function(int quantity)? submitting,
    TResult? Function(int quantity)? addedToCart,
    TResult? Function(int quantity, AppException exception)? failure,
  }) {
    return submitting?.call(quantity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int quantity)? idle,
    TResult Function(int quantity)? submitting,
    TResult Function(int quantity)? addedToCart,
    TResult Function(int quantity, AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(quantity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OfferDetailsIdle value) idle,
    required TResult Function(OfferDetailsSubmitting value) submitting,
    required TResult Function(OfferDetailsAddedToCart value) addedToCart,
    required TResult Function(OfferDetailsFailure value) failure,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OfferDetailsIdle value)? idle,
    TResult? Function(OfferDetailsSubmitting value)? submitting,
    TResult? Function(OfferDetailsAddedToCart value)? addedToCart,
    TResult? Function(OfferDetailsFailure value)? failure,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OfferDetailsIdle value)? idle,
    TResult Function(OfferDetailsSubmitting value)? submitting,
    TResult Function(OfferDetailsAddedToCart value)? addedToCart,
    TResult Function(OfferDetailsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class OfferDetailsSubmitting implements OfferDetailsState {
  const factory OfferDetailsSubmitting({required final int quantity}) =
      _$OfferDetailsSubmittingImpl;

  @override
  int get quantity;

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfferDetailsSubmittingImplCopyWith<_$OfferDetailsSubmittingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OfferDetailsAddedToCartImplCopyWith<$Res>
    implements $OfferDetailsStateCopyWith<$Res> {
  factory _$$OfferDetailsAddedToCartImplCopyWith(
          _$OfferDetailsAddedToCartImpl value,
          $Res Function(_$OfferDetailsAddedToCartImpl) then) =
      __$$OfferDetailsAddedToCartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int quantity});
}

/// @nodoc
class __$$OfferDetailsAddedToCartImplCopyWithImpl<$Res>
    extends _$OfferDetailsStateCopyWithImpl<$Res, _$OfferDetailsAddedToCartImpl>
    implements _$$OfferDetailsAddedToCartImplCopyWith<$Res> {
  __$$OfferDetailsAddedToCartImplCopyWithImpl(
      _$OfferDetailsAddedToCartImpl _value,
      $Res Function(_$OfferDetailsAddedToCartImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
  }) {
    return _then(_$OfferDetailsAddedToCartImpl(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$OfferDetailsAddedToCartImpl implements OfferDetailsAddedToCart {
  const _$OfferDetailsAddedToCartImpl({required this.quantity});

  @override
  final int quantity;

  @override
  String toString() {
    return 'OfferDetailsState.addedToCart(quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferDetailsAddedToCartImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quantity);

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfferDetailsAddedToCartImplCopyWith<_$OfferDetailsAddedToCartImpl>
      get copyWith => __$$OfferDetailsAddedToCartImplCopyWithImpl<
          _$OfferDetailsAddedToCartImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int quantity) idle,
    required TResult Function(int quantity) submitting,
    required TResult Function(int quantity) addedToCart,
    required TResult Function(int quantity, AppException exception) failure,
  }) {
    return addedToCart(quantity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int quantity)? idle,
    TResult? Function(int quantity)? submitting,
    TResult? Function(int quantity)? addedToCart,
    TResult? Function(int quantity, AppException exception)? failure,
  }) {
    return addedToCart?.call(quantity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int quantity)? idle,
    TResult Function(int quantity)? submitting,
    TResult Function(int quantity)? addedToCart,
    TResult Function(int quantity, AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (addedToCart != null) {
      return addedToCart(quantity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OfferDetailsIdle value) idle,
    required TResult Function(OfferDetailsSubmitting value) submitting,
    required TResult Function(OfferDetailsAddedToCart value) addedToCart,
    required TResult Function(OfferDetailsFailure value) failure,
  }) {
    return addedToCart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OfferDetailsIdle value)? idle,
    TResult? Function(OfferDetailsSubmitting value)? submitting,
    TResult? Function(OfferDetailsAddedToCart value)? addedToCart,
    TResult? Function(OfferDetailsFailure value)? failure,
  }) {
    return addedToCart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OfferDetailsIdle value)? idle,
    TResult Function(OfferDetailsSubmitting value)? submitting,
    TResult Function(OfferDetailsAddedToCart value)? addedToCart,
    TResult Function(OfferDetailsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (addedToCart != null) {
      return addedToCart(this);
    }
    return orElse();
  }
}

abstract class OfferDetailsAddedToCart implements OfferDetailsState {
  const factory OfferDetailsAddedToCart({required final int quantity}) =
      _$OfferDetailsAddedToCartImpl;

  @override
  int get quantity;

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfferDetailsAddedToCartImplCopyWith<_$OfferDetailsAddedToCartImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OfferDetailsFailureImplCopyWith<$Res>
    implements $OfferDetailsStateCopyWith<$Res> {
  factory _$$OfferDetailsFailureImplCopyWith(_$OfferDetailsFailureImpl value,
          $Res Function(_$OfferDetailsFailureImpl) then) =
      __$$OfferDetailsFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int quantity, AppException exception});
}

/// @nodoc
class __$$OfferDetailsFailureImplCopyWithImpl<$Res>
    extends _$OfferDetailsStateCopyWithImpl<$Res, _$OfferDetailsFailureImpl>
    implements _$$OfferDetailsFailureImplCopyWith<$Res> {
  __$$OfferDetailsFailureImplCopyWithImpl(_$OfferDetailsFailureImpl _value,
      $Res Function(_$OfferDetailsFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? exception = null,
  }) {
    return _then(_$OfferDetailsFailureImpl(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      exception: null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$OfferDetailsFailureImpl implements OfferDetailsFailure {
  const _$OfferDetailsFailureImpl(
      {required this.quantity, required this.exception});

  @override
  final int quantity;
  @override
  final AppException exception;

  @override
  String toString() {
    return 'OfferDetailsState.failure(quantity: $quantity, exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferDetailsFailureImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quantity, exception);

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfferDetailsFailureImplCopyWith<_$OfferDetailsFailureImpl> get copyWith =>
      __$$OfferDetailsFailureImplCopyWithImpl<_$OfferDetailsFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int quantity) idle,
    required TResult Function(int quantity) submitting,
    required TResult Function(int quantity) addedToCart,
    required TResult Function(int quantity, AppException exception) failure,
  }) {
    return failure(quantity, exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int quantity)? idle,
    TResult? Function(int quantity)? submitting,
    TResult? Function(int quantity)? addedToCart,
    TResult? Function(int quantity, AppException exception)? failure,
  }) {
    return failure?.call(quantity, exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int quantity)? idle,
    TResult Function(int quantity)? submitting,
    TResult Function(int quantity)? addedToCart,
    TResult Function(int quantity, AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(quantity, exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OfferDetailsIdle value) idle,
    required TResult Function(OfferDetailsSubmitting value) submitting,
    required TResult Function(OfferDetailsAddedToCart value) addedToCart,
    required TResult Function(OfferDetailsFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OfferDetailsIdle value)? idle,
    TResult? Function(OfferDetailsSubmitting value)? submitting,
    TResult? Function(OfferDetailsAddedToCart value)? addedToCart,
    TResult? Function(OfferDetailsFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OfferDetailsIdle value)? idle,
    TResult Function(OfferDetailsSubmitting value)? submitting,
    TResult Function(OfferDetailsAddedToCart value)? addedToCart,
    TResult Function(OfferDetailsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class OfferDetailsFailure implements OfferDetailsState {
  const factory OfferDetailsFailure(
      {required final int quantity,
      required final AppException exception}) = _$OfferDetailsFailureImpl;

  @override
  int get quantity;
  AppException get exception;

  /// Create a copy of OfferDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfferDetailsFailureImplCopyWith<_$OfferDetailsFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
