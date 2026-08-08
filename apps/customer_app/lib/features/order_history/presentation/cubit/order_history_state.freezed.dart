// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderHistoryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderEntity> orders) loaded,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderEntity> orders)? loaded,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderEntity> orders)? loaded,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderHistoryInitial value) initial,
    required TResult Function(OrderHistoryLoading value) loading,
    required TResult Function(OrderHistoryLoaded value) loaded,
    required TResult Function(OrderHistoryFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderHistoryInitial value)? initial,
    TResult? Function(OrderHistoryLoading value)? loading,
    TResult? Function(OrderHistoryLoaded value)? loaded,
    TResult? Function(OrderHistoryFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderHistoryInitial value)? initial,
    TResult Function(OrderHistoryLoading value)? loading,
    TResult Function(OrderHistoryLoaded value)? loaded,
    TResult Function(OrderHistoryFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderHistoryStateCopyWith<$Res> {
  factory $OrderHistoryStateCopyWith(
          OrderHistoryState value, $Res Function(OrderHistoryState) then) =
      _$OrderHistoryStateCopyWithImpl<$Res, OrderHistoryState>;
}

/// @nodoc
class _$OrderHistoryStateCopyWithImpl<$Res, $Val extends OrderHistoryState>
    implements $OrderHistoryStateCopyWith<$Res> {
  _$OrderHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderHistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OrderHistoryInitialImplCopyWith<$Res> {
  factory _$$OrderHistoryInitialImplCopyWith(_$OrderHistoryInitialImpl value,
          $Res Function(_$OrderHistoryInitialImpl) then) =
      __$$OrderHistoryInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrderHistoryInitialImplCopyWithImpl<$Res>
    extends _$OrderHistoryStateCopyWithImpl<$Res, _$OrderHistoryInitialImpl>
    implements _$$OrderHistoryInitialImplCopyWith<$Res> {
  __$$OrderHistoryInitialImplCopyWithImpl(_$OrderHistoryInitialImpl _value,
      $Res Function(_$OrderHistoryInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderHistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OrderHistoryInitialImpl implements OrderHistoryInitial {
  const _$OrderHistoryInitialImpl();

  @override
  String toString() {
    return 'OrderHistoryState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHistoryInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderEntity> orders) loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderEntity> orders)? loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderEntity> orders)? loaded,
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
    required TResult Function(OrderHistoryInitial value) initial,
    required TResult Function(OrderHistoryLoading value) loading,
    required TResult Function(OrderHistoryLoaded value) loaded,
    required TResult Function(OrderHistoryFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderHistoryInitial value)? initial,
    TResult? Function(OrderHistoryLoading value)? loading,
    TResult? Function(OrderHistoryLoaded value)? loaded,
    TResult? Function(OrderHistoryFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderHistoryInitial value)? initial,
    TResult Function(OrderHistoryLoading value)? loading,
    TResult Function(OrderHistoryLoaded value)? loaded,
    TResult Function(OrderHistoryFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class OrderHistoryInitial implements OrderHistoryState {
  const factory OrderHistoryInitial() = _$OrderHistoryInitialImpl;
}

/// @nodoc
abstract class _$$OrderHistoryLoadingImplCopyWith<$Res> {
  factory _$$OrderHistoryLoadingImplCopyWith(_$OrderHistoryLoadingImpl value,
          $Res Function(_$OrderHistoryLoadingImpl) then) =
      __$$OrderHistoryLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrderHistoryLoadingImplCopyWithImpl<$Res>
    extends _$OrderHistoryStateCopyWithImpl<$Res, _$OrderHistoryLoadingImpl>
    implements _$$OrderHistoryLoadingImplCopyWith<$Res> {
  __$$OrderHistoryLoadingImplCopyWithImpl(_$OrderHistoryLoadingImpl _value,
      $Res Function(_$OrderHistoryLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderHistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OrderHistoryLoadingImpl implements OrderHistoryLoading {
  const _$OrderHistoryLoadingImpl();

  @override
  String toString() {
    return 'OrderHistoryState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHistoryLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderEntity> orders) loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderEntity> orders)? loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderEntity> orders)? loaded,
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
    required TResult Function(OrderHistoryInitial value) initial,
    required TResult Function(OrderHistoryLoading value) loading,
    required TResult Function(OrderHistoryLoaded value) loaded,
    required TResult Function(OrderHistoryFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderHistoryInitial value)? initial,
    TResult? Function(OrderHistoryLoading value)? loading,
    TResult? Function(OrderHistoryLoaded value)? loaded,
    TResult? Function(OrderHistoryFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderHistoryInitial value)? initial,
    TResult Function(OrderHistoryLoading value)? loading,
    TResult Function(OrderHistoryLoaded value)? loaded,
    TResult Function(OrderHistoryFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OrderHistoryLoading implements OrderHistoryState {
  const factory OrderHistoryLoading() = _$OrderHistoryLoadingImpl;
}

/// @nodoc
abstract class _$$OrderHistoryLoadedImplCopyWith<$Res> {
  factory _$$OrderHistoryLoadedImplCopyWith(_$OrderHistoryLoadedImpl value,
          $Res Function(_$OrderHistoryLoadedImpl) then) =
      __$$OrderHistoryLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<OrderEntity> orders});
}

/// @nodoc
class __$$OrderHistoryLoadedImplCopyWithImpl<$Res>
    extends _$OrderHistoryStateCopyWithImpl<$Res, _$OrderHistoryLoadedImpl>
    implements _$$OrderHistoryLoadedImplCopyWith<$Res> {
  __$$OrderHistoryLoadedImplCopyWithImpl(_$OrderHistoryLoadedImpl _value,
      $Res Function(_$OrderHistoryLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_$OrderHistoryLoadedImpl(
      null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderEntity>,
    ));
  }
}

/// @nodoc

class _$OrderHistoryLoadedImpl implements OrderHistoryLoaded {
  const _$OrderHistoryLoadedImpl(final List<OrderEntity> orders)
      : _orders = orders;

  final List<OrderEntity> _orders;
  @override
  List<OrderEntity> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  String toString() {
    return 'OrderHistoryState.loaded(orders: $orders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHistoryLoadedImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  /// Create a copy of OrderHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderHistoryLoadedImplCopyWith<_$OrderHistoryLoadedImpl> get copyWith =>
      __$$OrderHistoryLoadedImplCopyWithImpl<_$OrderHistoryLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderEntity> orders) loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return loaded(orders);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderEntity> orders)? loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return loaded?.call(orders);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderEntity> orders)? loaded,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(orders);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderHistoryInitial value) initial,
    required TResult Function(OrderHistoryLoading value) loading,
    required TResult Function(OrderHistoryLoaded value) loaded,
    required TResult Function(OrderHistoryFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderHistoryInitial value)? initial,
    TResult? Function(OrderHistoryLoading value)? loading,
    TResult? Function(OrderHistoryLoaded value)? loaded,
    TResult? Function(OrderHistoryFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderHistoryInitial value)? initial,
    TResult Function(OrderHistoryLoading value)? loading,
    TResult Function(OrderHistoryLoaded value)? loaded,
    TResult Function(OrderHistoryFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class OrderHistoryLoaded implements OrderHistoryState {
  const factory OrderHistoryLoaded(final List<OrderEntity> orders) =
      _$OrderHistoryLoadedImpl;

  List<OrderEntity> get orders;

  /// Create a copy of OrderHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderHistoryLoadedImplCopyWith<_$OrderHistoryLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OrderHistoryFailureImplCopyWith<$Res> {
  factory _$$OrderHistoryFailureImplCopyWith(_$OrderHistoryFailureImpl value,
          $Res Function(_$OrderHistoryFailureImpl) then) =
      __$$OrderHistoryFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$OrderHistoryFailureImplCopyWithImpl<$Res>
    extends _$OrderHistoryStateCopyWithImpl<$Res, _$OrderHistoryFailureImpl>
    implements _$$OrderHistoryFailureImplCopyWith<$Res> {
  __$$OrderHistoryFailureImplCopyWithImpl(_$OrderHistoryFailureImpl _value,
      $Res Function(_$OrderHistoryFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$OrderHistoryFailureImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$OrderHistoryFailureImpl implements OrderHistoryFailure {
  const _$OrderHistoryFailureImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'OrderHistoryState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHistoryFailureImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of OrderHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderHistoryFailureImplCopyWith<_$OrderHistoryFailureImpl> get copyWith =>
      __$$OrderHistoryFailureImplCopyWithImpl<_$OrderHistoryFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<OrderEntity> orders) loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<OrderEntity> orders)? loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<OrderEntity> orders)? loaded,
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
    required TResult Function(OrderHistoryInitial value) initial,
    required TResult Function(OrderHistoryLoading value) loading,
    required TResult Function(OrderHistoryLoaded value) loaded,
    required TResult Function(OrderHistoryFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderHistoryInitial value)? initial,
    TResult? Function(OrderHistoryLoading value)? loading,
    TResult? Function(OrderHistoryLoaded value)? loaded,
    TResult? Function(OrderHistoryFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderHistoryInitial value)? initial,
    TResult Function(OrderHistoryLoading value)? loading,
    TResult Function(OrderHistoryLoaded value)? loaded,
    TResult Function(OrderHistoryFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class OrderHistoryFailure implements OrderHistoryState {
  const factory OrderHistoryFailure(final AppException exception) =
      _$OrderHistoryFailureImpl;

  AppException get exception;

  /// Create a copy of OrderHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderHistoryFailureImplCopyWith<_$OrderHistoryFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
