// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(OrderEntity order, OrderActionStatus actionStatus)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(OrderEntity order, OrderActionStatus actionStatus)?
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(OrderEntity order, OrderActionStatus actionStatus)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderDetailsInitial value) initial,
    required TResult Function(OrderDetailsLoading value) loading,
    required TResult Function(OrderDetailsLoadError value) loadError,
    required TResult Function(OrderDetailsLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderDetailsInitial value)? initial,
    TResult? Function(OrderDetailsLoading value)? loading,
    TResult? Function(OrderDetailsLoadError value)? loadError,
    TResult? Function(OrderDetailsLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderDetailsInitial value)? initial,
    TResult Function(OrderDetailsLoading value)? loading,
    TResult Function(OrderDetailsLoadError value)? loadError,
    TResult Function(OrderDetailsLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDetailsStateCopyWith<$Res> {
  factory $OrderDetailsStateCopyWith(
          OrderDetailsState value, $Res Function(OrderDetailsState) then) =
      _$OrderDetailsStateCopyWithImpl<$Res, OrderDetailsState>;
}

/// @nodoc
class _$OrderDetailsStateCopyWithImpl<$Res, $Val extends OrderDetailsState>
    implements $OrderDetailsStateCopyWith<$Res> {
  _$OrderDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OrderDetailsInitialImplCopyWith<$Res> {
  factory _$$OrderDetailsInitialImplCopyWith(_$OrderDetailsInitialImpl value,
          $Res Function(_$OrderDetailsInitialImpl) then) =
      __$$OrderDetailsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrderDetailsInitialImplCopyWithImpl<$Res>
    extends _$OrderDetailsStateCopyWithImpl<$Res, _$OrderDetailsInitialImpl>
    implements _$$OrderDetailsInitialImplCopyWith<$Res> {
  __$$OrderDetailsInitialImplCopyWithImpl(_$OrderDetailsInitialImpl _value,
      $Res Function(_$OrderDetailsInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OrderDetailsInitialImpl implements OrderDetailsInitial {
  const _$OrderDetailsInitialImpl();

  @override
  String toString() {
    return 'OrderDetailsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDetailsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(OrderEntity order, OrderActionStatus actionStatus)
        loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(OrderEntity order, OrderActionStatus actionStatus)?
        loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(OrderEntity order, OrderActionStatus actionStatus)? loaded,
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
    required TResult Function(OrderDetailsInitial value) initial,
    required TResult Function(OrderDetailsLoading value) loading,
    required TResult Function(OrderDetailsLoadError value) loadError,
    required TResult Function(OrderDetailsLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderDetailsInitial value)? initial,
    TResult? Function(OrderDetailsLoading value)? loading,
    TResult? Function(OrderDetailsLoadError value)? loadError,
    TResult? Function(OrderDetailsLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderDetailsInitial value)? initial,
    TResult Function(OrderDetailsLoading value)? loading,
    TResult Function(OrderDetailsLoadError value)? loadError,
    TResult Function(OrderDetailsLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class OrderDetailsInitial implements OrderDetailsState {
  const factory OrderDetailsInitial() = _$OrderDetailsInitialImpl;
}

/// @nodoc
abstract class _$$OrderDetailsLoadingImplCopyWith<$Res> {
  factory _$$OrderDetailsLoadingImplCopyWith(_$OrderDetailsLoadingImpl value,
          $Res Function(_$OrderDetailsLoadingImpl) then) =
      __$$OrderDetailsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrderDetailsLoadingImplCopyWithImpl<$Res>
    extends _$OrderDetailsStateCopyWithImpl<$Res, _$OrderDetailsLoadingImpl>
    implements _$$OrderDetailsLoadingImplCopyWith<$Res> {
  __$$OrderDetailsLoadingImplCopyWithImpl(_$OrderDetailsLoadingImpl _value,
      $Res Function(_$OrderDetailsLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OrderDetailsLoadingImpl implements OrderDetailsLoading {
  const _$OrderDetailsLoadingImpl();

  @override
  String toString() {
    return 'OrderDetailsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDetailsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(OrderEntity order, OrderActionStatus actionStatus)
        loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(OrderEntity order, OrderActionStatus actionStatus)?
        loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(OrderEntity order, OrderActionStatus actionStatus)? loaded,
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
    required TResult Function(OrderDetailsInitial value) initial,
    required TResult Function(OrderDetailsLoading value) loading,
    required TResult Function(OrderDetailsLoadError value) loadError,
    required TResult Function(OrderDetailsLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderDetailsInitial value)? initial,
    TResult? Function(OrderDetailsLoading value)? loading,
    TResult? Function(OrderDetailsLoadError value)? loadError,
    TResult? Function(OrderDetailsLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderDetailsInitial value)? initial,
    TResult Function(OrderDetailsLoading value)? loading,
    TResult Function(OrderDetailsLoadError value)? loadError,
    TResult Function(OrderDetailsLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OrderDetailsLoading implements OrderDetailsState {
  const factory OrderDetailsLoading() = _$OrderDetailsLoadingImpl;
}

/// @nodoc
abstract class _$$OrderDetailsLoadErrorImplCopyWith<$Res> {
  factory _$$OrderDetailsLoadErrorImplCopyWith(
          _$OrderDetailsLoadErrorImpl value,
          $Res Function(_$OrderDetailsLoadErrorImpl) then) =
      __$$OrderDetailsLoadErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$OrderDetailsLoadErrorImplCopyWithImpl<$Res>
    extends _$OrderDetailsStateCopyWithImpl<$Res, _$OrderDetailsLoadErrorImpl>
    implements _$$OrderDetailsLoadErrorImplCopyWith<$Res> {
  __$$OrderDetailsLoadErrorImplCopyWithImpl(_$OrderDetailsLoadErrorImpl _value,
      $Res Function(_$OrderDetailsLoadErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$OrderDetailsLoadErrorImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$OrderDetailsLoadErrorImpl implements OrderDetailsLoadError {
  const _$OrderDetailsLoadErrorImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'OrderDetailsState.loadError(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDetailsLoadErrorImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDetailsLoadErrorImplCopyWith<_$OrderDetailsLoadErrorImpl>
      get copyWith => __$$OrderDetailsLoadErrorImplCopyWithImpl<
          _$OrderDetailsLoadErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(OrderEntity order, OrderActionStatus actionStatus)
        loaded,
  }) {
    return loadError(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(OrderEntity order, OrderActionStatus actionStatus)?
        loaded,
  }) {
    return loadError?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(OrderEntity order, OrderActionStatus actionStatus)? loaded,
    required TResult orElse(),
  }) {
    if (loadError != null) {
      return loadError(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderDetailsInitial value) initial,
    required TResult Function(OrderDetailsLoading value) loading,
    required TResult Function(OrderDetailsLoadError value) loadError,
    required TResult Function(OrderDetailsLoaded value) loaded,
  }) {
    return loadError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderDetailsInitial value)? initial,
    TResult? Function(OrderDetailsLoading value)? loading,
    TResult? Function(OrderDetailsLoadError value)? loadError,
    TResult? Function(OrderDetailsLoaded value)? loaded,
  }) {
    return loadError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderDetailsInitial value)? initial,
    TResult Function(OrderDetailsLoading value)? loading,
    TResult Function(OrderDetailsLoadError value)? loadError,
    TResult Function(OrderDetailsLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loadError != null) {
      return loadError(this);
    }
    return orElse();
  }
}

abstract class OrderDetailsLoadError implements OrderDetailsState {
  const factory OrderDetailsLoadError(final AppException exception) =
      _$OrderDetailsLoadErrorImpl;

  AppException get exception;

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDetailsLoadErrorImplCopyWith<_$OrderDetailsLoadErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OrderDetailsLoadedImplCopyWith<$Res> {
  factory _$$OrderDetailsLoadedImplCopyWith(_$OrderDetailsLoadedImpl value,
          $Res Function(_$OrderDetailsLoadedImpl) then) =
      __$$OrderDetailsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OrderEntity order, OrderActionStatus actionStatus});

  $OrderActionStatusCopyWith<$Res> get actionStatus;
}

/// @nodoc
class __$$OrderDetailsLoadedImplCopyWithImpl<$Res>
    extends _$OrderDetailsStateCopyWithImpl<$Res, _$OrderDetailsLoadedImpl>
    implements _$$OrderDetailsLoadedImplCopyWith<$Res> {
  __$$OrderDetailsLoadedImplCopyWithImpl(_$OrderDetailsLoadedImpl _value,
      $Res Function(_$OrderDetailsLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? actionStatus = null,
  }) {
    return _then(_$OrderDetailsLoadedImpl(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderEntity,
      actionStatus: null == actionStatus
          ? _value.actionStatus
          : actionStatus // ignore: cast_nullable_to_non_nullable
              as OrderActionStatus,
    ));
  }

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderActionStatusCopyWith<$Res> get actionStatus {
    return $OrderActionStatusCopyWith<$Res>(_value.actionStatus, (value) {
      return _then(_value.copyWith(actionStatus: value));
    });
  }
}

/// @nodoc

class _$OrderDetailsLoadedImpl implements OrderDetailsLoaded {
  const _$OrderDetailsLoadedImpl(
      {required this.order,
      this.actionStatus = const OrderActionStatus.idle()});

  @override
  final OrderEntity order;
  @override
  @JsonKey()
  final OrderActionStatus actionStatus;

  @override
  String toString() {
    return 'OrderDetailsState.loaded(order: $order, actionStatus: $actionStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDetailsLoadedImpl &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.actionStatus, actionStatus) ||
                other.actionStatus == actionStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, order, actionStatus);

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDetailsLoadedImplCopyWith<_$OrderDetailsLoadedImpl> get copyWith =>
      __$$OrderDetailsLoadedImplCopyWithImpl<_$OrderDetailsLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(OrderEntity order, OrderActionStatus actionStatus)
        loaded,
  }) {
    return loaded(order, actionStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(OrderEntity order, OrderActionStatus actionStatus)?
        loaded,
  }) {
    return loaded?.call(order, actionStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(OrderEntity order, OrderActionStatus actionStatus)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(order, actionStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderDetailsInitial value) initial,
    required TResult Function(OrderDetailsLoading value) loading,
    required TResult Function(OrderDetailsLoadError value) loadError,
    required TResult Function(OrderDetailsLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderDetailsInitial value)? initial,
    TResult? Function(OrderDetailsLoading value)? loading,
    TResult? Function(OrderDetailsLoadError value)? loadError,
    TResult? Function(OrderDetailsLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderDetailsInitial value)? initial,
    TResult Function(OrderDetailsLoading value)? loading,
    TResult Function(OrderDetailsLoadError value)? loadError,
    TResult Function(OrderDetailsLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class OrderDetailsLoaded implements OrderDetailsState {
  const factory OrderDetailsLoaded(
      {required final OrderEntity order,
      final OrderActionStatus actionStatus}) = _$OrderDetailsLoadedImpl;

  OrderEntity get order;
  OrderActionStatus get actionStatus;

  /// Create a copy of OrderDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderDetailsLoadedImplCopyWith<_$OrderDetailsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
