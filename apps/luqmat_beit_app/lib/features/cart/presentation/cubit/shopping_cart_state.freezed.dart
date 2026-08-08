// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shopping_cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShoppingCartState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartEntity cart, double deliveryFee) loaded,
    required TResult Function() empty,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartEntity cart, double deliveryFee)? loaded,
    TResult? Function()? empty,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartEntity cart, double deliveryFee)? loaded,
    TResult Function()? empty,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShoppingCartInitial value) initial,
    required TResult Function(ShoppingCartLoading value) loading,
    required TResult Function(ShoppingCartLoaded value) loaded,
    required TResult Function(ShoppingCartEmpty value) empty,
    required TResult Function(ShoppingCartFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShoppingCartInitial value)? initial,
    TResult? Function(ShoppingCartLoading value)? loading,
    TResult? Function(ShoppingCartLoaded value)? loaded,
    TResult? Function(ShoppingCartEmpty value)? empty,
    TResult? Function(ShoppingCartFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShoppingCartInitial value)? initial,
    TResult Function(ShoppingCartLoading value)? loading,
    TResult Function(ShoppingCartLoaded value)? loaded,
    TResult Function(ShoppingCartEmpty value)? empty,
    TResult Function(ShoppingCartFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingCartStateCopyWith<$Res> {
  factory $ShoppingCartStateCopyWith(
          ShoppingCartState value, $Res Function(ShoppingCartState) then) =
      _$ShoppingCartStateCopyWithImpl<$Res, ShoppingCartState>;
}

/// @nodoc
class _$ShoppingCartStateCopyWithImpl<$Res, $Val extends ShoppingCartState>
    implements $ShoppingCartStateCopyWith<$Res> {
  _$ShoppingCartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShoppingCartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ShoppingCartInitialImplCopyWith<$Res> {
  factory _$$ShoppingCartInitialImplCopyWith(_$ShoppingCartInitialImpl value,
          $Res Function(_$ShoppingCartInitialImpl) then) =
      __$$ShoppingCartInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShoppingCartInitialImplCopyWithImpl<$Res>
    extends _$ShoppingCartStateCopyWithImpl<$Res, _$ShoppingCartInitialImpl>
    implements _$$ShoppingCartInitialImplCopyWith<$Res> {
  __$$ShoppingCartInitialImplCopyWithImpl(_$ShoppingCartInitialImpl _value,
      $Res Function(_$ShoppingCartInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShoppingCartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShoppingCartInitialImpl implements ShoppingCartInitial {
  const _$ShoppingCartInitialImpl();

  @override
  String toString() {
    return 'ShoppingCartState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingCartInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartEntity cart, double deliveryFee) loaded,
    required TResult Function() empty,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartEntity cart, double deliveryFee)? loaded,
    TResult? Function()? empty,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartEntity cart, double deliveryFee)? loaded,
    TResult Function()? empty,
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
    required TResult Function(ShoppingCartInitial value) initial,
    required TResult Function(ShoppingCartLoading value) loading,
    required TResult Function(ShoppingCartLoaded value) loaded,
    required TResult Function(ShoppingCartEmpty value) empty,
    required TResult Function(ShoppingCartFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShoppingCartInitial value)? initial,
    TResult? Function(ShoppingCartLoading value)? loading,
    TResult? Function(ShoppingCartLoaded value)? loaded,
    TResult? Function(ShoppingCartEmpty value)? empty,
    TResult? Function(ShoppingCartFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShoppingCartInitial value)? initial,
    TResult Function(ShoppingCartLoading value)? loading,
    TResult Function(ShoppingCartLoaded value)? loaded,
    TResult Function(ShoppingCartEmpty value)? empty,
    TResult Function(ShoppingCartFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ShoppingCartInitial implements ShoppingCartState {
  const factory ShoppingCartInitial() = _$ShoppingCartInitialImpl;
}

/// @nodoc
abstract class _$$ShoppingCartLoadingImplCopyWith<$Res> {
  factory _$$ShoppingCartLoadingImplCopyWith(_$ShoppingCartLoadingImpl value,
          $Res Function(_$ShoppingCartLoadingImpl) then) =
      __$$ShoppingCartLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShoppingCartLoadingImplCopyWithImpl<$Res>
    extends _$ShoppingCartStateCopyWithImpl<$Res, _$ShoppingCartLoadingImpl>
    implements _$$ShoppingCartLoadingImplCopyWith<$Res> {
  __$$ShoppingCartLoadingImplCopyWithImpl(_$ShoppingCartLoadingImpl _value,
      $Res Function(_$ShoppingCartLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShoppingCartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShoppingCartLoadingImpl implements ShoppingCartLoading {
  const _$ShoppingCartLoadingImpl();

  @override
  String toString() {
    return 'ShoppingCartState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingCartLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartEntity cart, double deliveryFee) loaded,
    required TResult Function() empty,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartEntity cart, double deliveryFee)? loaded,
    TResult? Function()? empty,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartEntity cart, double deliveryFee)? loaded,
    TResult Function()? empty,
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
    required TResult Function(ShoppingCartInitial value) initial,
    required TResult Function(ShoppingCartLoading value) loading,
    required TResult Function(ShoppingCartLoaded value) loaded,
    required TResult Function(ShoppingCartEmpty value) empty,
    required TResult Function(ShoppingCartFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShoppingCartInitial value)? initial,
    TResult? Function(ShoppingCartLoading value)? loading,
    TResult? Function(ShoppingCartLoaded value)? loaded,
    TResult? Function(ShoppingCartEmpty value)? empty,
    TResult? Function(ShoppingCartFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShoppingCartInitial value)? initial,
    TResult Function(ShoppingCartLoading value)? loading,
    TResult Function(ShoppingCartLoaded value)? loaded,
    TResult Function(ShoppingCartEmpty value)? empty,
    TResult Function(ShoppingCartFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ShoppingCartLoading implements ShoppingCartState {
  const factory ShoppingCartLoading() = _$ShoppingCartLoadingImpl;
}

/// @nodoc
abstract class _$$ShoppingCartLoadedImplCopyWith<$Res> {
  factory _$$ShoppingCartLoadedImplCopyWith(_$ShoppingCartLoadedImpl value,
          $Res Function(_$ShoppingCartLoadedImpl) then) =
      __$$ShoppingCartLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CartEntity cart, double deliveryFee});
}

/// @nodoc
class __$$ShoppingCartLoadedImplCopyWithImpl<$Res>
    extends _$ShoppingCartStateCopyWithImpl<$Res, _$ShoppingCartLoadedImpl>
    implements _$$ShoppingCartLoadedImplCopyWith<$Res> {
  __$$ShoppingCartLoadedImplCopyWithImpl(_$ShoppingCartLoadedImpl _value,
      $Res Function(_$ShoppingCartLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShoppingCartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cart = null,
    Object? deliveryFee = null,
  }) {
    return _then(_$ShoppingCartLoadedImpl(
      null == cart
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as CartEntity,
      deliveryFee: null == deliveryFee
          ? _value.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$ShoppingCartLoadedImpl implements ShoppingCartLoaded {
  const _$ShoppingCartLoadedImpl(this.cart, {required this.deliveryFee});

  @override
  final CartEntity cart;
  @override
  final double deliveryFee;

  @override
  String toString() {
    return 'ShoppingCartState.loaded(cart: $cart, deliveryFee: $deliveryFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingCartLoadedImpl &&
            (identical(other.cart, cart) || other.cart == cart) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cart, deliveryFee);

  /// Create a copy of ShoppingCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingCartLoadedImplCopyWith<_$ShoppingCartLoadedImpl> get copyWith =>
      __$$ShoppingCartLoadedImplCopyWithImpl<_$ShoppingCartLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartEntity cart, double deliveryFee) loaded,
    required TResult Function() empty,
    required TResult Function(AppException exception) failure,
  }) {
    return loaded(cart, deliveryFee);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartEntity cart, double deliveryFee)? loaded,
    TResult? Function()? empty,
    TResult? Function(AppException exception)? failure,
  }) {
    return loaded?.call(cart, deliveryFee);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartEntity cart, double deliveryFee)? loaded,
    TResult Function()? empty,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(cart, deliveryFee);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShoppingCartInitial value) initial,
    required TResult Function(ShoppingCartLoading value) loading,
    required TResult Function(ShoppingCartLoaded value) loaded,
    required TResult Function(ShoppingCartEmpty value) empty,
    required TResult Function(ShoppingCartFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShoppingCartInitial value)? initial,
    TResult? Function(ShoppingCartLoading value)? loading,
    TResult? Function(ShoppingCartLoaded value)? loaded,
    TResult? Function(ShoppingCartEmpty value)? empty,
    TResult? Function(ShoppingCartFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShoppingCartInitial value)? initial,
    TResult Function(ShoppingCartLoading value)? loading,
    TResult Function(ShoppingCartLoaded value)? loaded,
    TResult Function(ShoppingCartEmpty value)? empty,
    TResult Function(ShoppingCartFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ShoppingCartLoaded implements ShoppingCartState {
  const factory ShoppingCartLoaded(final CartEntity cart,
      {required final double deliveryFee}) = _$ShoppingCartLoadedImpl;

  CartEntity get cart;
  double get deliveryFee;

  /// Create a copy of ShoppingCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShoppingCartLoadedImplCopyWith<_$ShoppingCartLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShoppingCartEmptyImplCopyWith<$Res> {
  factory _$$ShoppingCartEmptyImplCopyWith(_$ShoppingCartEmptyImpl value,
          $Res Function(_$ShoppingCartEmptyImpl) then) =
      __$$ShoppingCartEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShoppingCartEmptyImplCopyWithImpl<$Res>
    extends _$ShoppingCartStateCopyWithImpl<$Res, _$ShoppingCartEmptyImpl>
    implements _$$ShoppingCartEmptyImplCopyWith<$Res> {
  __$$ShoppingCartEmptyImplCopyWithImpl(_$ShoppingCartEmptyImpl _value,
      $Res Function(_$ShoppingCartEmptyImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShoppingCartState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShoppingCartEmptyImpl implements ShoppingCartEmpty {
  const _$ShoppingCartEmptyImpl();

  @override
  String toString() {
    return 'ShoppingCartState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShoppingCartEmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartEntity cart, double deliveryFee) loaded,
    required TResult Function() empty,
    required TResult Function(AppException exception) failure,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartEntity cart, double deliveryFee)? loaded,
    TResult? Function()? empty,
    TResult? Function(AppException exception)? failure,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartEntity cart, double deliveryFee)? loaded,
    TResult Function()? empty,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShoppingCartInitial value) initial,
    required TResult Function(ShoppingCartLoading value) loading,
    required TResult Function(ShoppingCartLoaded value) loaded,
    required TResult Function(ShoppingCartEmpty value) empty,
    required TResult Function(ShoppingCartFailure value) failure,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShoppingCartInitial value)? initial,
    TResult? Function(ShoppingCartLoading value)? loading,
    TResult? Function(ShoppingCartLoaded value)? loaded,
    TResult? Function(ShoppingCartEmpty value)? empty,
    TResult? Function(ShoppingCartFailure value)? failure,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShoppingCartInitial value)? initial,
    TResult Function(ShoppingCartLoading value)? loading,
    TResult Function(ShoppingCartLoaded value)? loaded,
    TResult Function(ShoppingCartEmpty value)? empty,
    TResult Function(ShoppingCartFailure value)? failure,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class ShoppingCartEmpty implements ShoppingCartState {
  const factory ShoppingCartEmpty() = _$ShoppingCartEmptyImpl;
}

/// @nodoc
abstract class _$$ShoppingCartFailureImplCopyWith<$Res> {
  factory _$$ShoppingCartFailureImplCopyWith(_$ShoppingCartFailureImpl value,
          $Res Function(_$ShoppingCartFailureImpl) then) =
      __$$ShoppingCartFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$ShoppingCartFailureImplCopyWithImpl<$Res>
    extends _$ShoppingCartStateCopyWithImpl<$Res, _$ShoppingCartFailureImpl>
    implements _$$ShoppingCartFailureImplCopyWith<$Res> {
  __$$ShoppingCartFailureImplCopyWithImpl(_$ShoppingCartFailureImpl _value,
      $Res Function(_$ShoppingCartFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShoppingCartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$ShoppingCartFailureImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$ShoppingCartFailureImpl implements ShoppingCartFailure {
  const _$ShoppingCartFailureImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'ShoppingCartState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingCartFailureImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of ShoppingCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingCartFailureImplCopyWith<_$ShoppingCartFailureImpl> get copyWith =>
      __$$ShoppingCartFailureImplCopyWithImpl<_$ShoppingCartFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CartEntity cart, double deliveryFee) loaded,
    required TResult Function() empty,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CartEntity cart, double deliveryFee)? loaded,
    TResult? Function()? empty,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CartEntity cart, double deliveryFee)? loaded,
    TResult Function()? empty,
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
    required TResult Function(ShoppingCartInitial value) initial,
    required TResult Function(ShoppingCartLoading value) loading,
    required TResult Function(ShoppingCartLoaded value) loaded,
    required TResult Function(ShoppingCartEmpty value) empty,
    required TResult Function(ShoppingCartFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShoppingCartInitial value)? initial,
    TResult? Function(ShoppingCartLoading value)? loading,
    TResult? Function(ShoppingCartLoaded value)? loaded,
    TResult? Function(ShoppingCartEmpty value)? empty,
    TResult? Function(ShoppingCartFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShoppingCartInitial value)? initial,
    TResult Function(ShoppingCartLoading value)? loading,
    TResult Function(ShoppingCartLoaded value)? loaded,
    TResult Function(ShoppingCartEmpty value)? empty,
    TResult Function(ShoppingCartFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ShoppingCartFailure implements ShoppingCartState {
  const factory ShoppingCartFailure(final AppException exception) =
      _$ShoppingCartFailureImpl;

  AppException get exception;

  /// Create a copy of ShoppingCartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShoppingCartFailureImplCopyWith<_$ShoppingCartFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
