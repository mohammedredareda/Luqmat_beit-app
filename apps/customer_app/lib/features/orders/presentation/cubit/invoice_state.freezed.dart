// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InvoiceState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OrderEntity order) loaded,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OrderEntity order)? loaded,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OrderEntity order)? loaded,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InvoiceInitial value) initial,
    required TResult Function(InvoiceLoading value) loading,
    required TResult Function(InvoiceLoaded value) loaded,
    required TResult Function(InvoiceFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InvoiceInitial value)? initial,
    TResult? Function(InvoiceLoading value)? loading,
    TResult? Function(InvoiceLoaded value)? loaded,
    TResult? Function(InvoiceFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvoiceInitial value)? initial,
    TResult Function(InvoiceLoading value)? loading,
    TResult Function(InvoiceLoaded value)? loaded,
    TResult Function(InvoiceFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceStateCopyWith<$Res> {
  factory $InvoiceStateCopyWith(
          InvoiceState value, $Res Function(InvoiceState) then) =
      _$InvoiceStateCopyWithImpl<$Res, InvoiceState>;
}

/// @nodoc
class _$InvoiceStateCopyWithImpl<$Res, $Val extends InvoiceState>
    implements $InvoiceStateCopyWith<$Res> {
  _$InvoiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InvoiceInitialImplCopyWith<$Res> {
  factory _$$InvoiceInitialImplCopyWith(_$InvoiceInitialImpl value,
          $Res Function(_$InvoiceInitialImpl) then) =
      __$$InvoiceInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvoiceInitialImplCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res, _$InvoiceInitialImpl>
    implements _$$InvoiceInitialImplCopyWith<$Res> {
  __$$InvoiceInitialImplCopyWithImpl(
      _$InvoiceInitialImpl _value, $Res Function(_$InvoiceInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InvoiceInitialImpl implements InvoiceInitial {
  const _$InvoiceInitialImpl();

  @override
  String toString() {
    return 'InvoiceState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvoiceInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OrderEntity order) loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OrderEntity order)? loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OrderEntity order)? loaded,
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
    required TResult Function(InvoiceInitial value) initial,
    required TResult Function(InvoiceLoading value) loading,
    required TResult Function(InvoiceLoaded value) loaded,
    required TResult Function(InvoiceFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InvoiceInitial value)? initial,
    TResult? Function(InvoiceLoading value)? loading,
    TResult? Function(InvoiceLoaded value)? loaded,
    TResult? Function(InvoiceFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvoiceInitial value)? initial,
    TResult Function(InvoiceLoading value)? loading,
    TResult Function(InvoiceLoaded value)? loaded,
    TResult Function(InvoiceFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class InvoiceInitial implements InvoiceState {
  const factory InvoiceInitial() = _$InvoiceInitialImpl;
}

/// @nodoc
abstract class _$$InvoiceLoadingImplCopyWith<$Res> {
  factory _$$InvoiceLoadingImplCopyWith(_$InvoiceLoadingImpl value,
          $Res Function(_$InvoiceLoadingImpl) then) =
      __$$InvoiceLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvoiceLoadingImplCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res, _$InvoiceLoadingImpl>
    implements _$$InvoiceLoadingImplCopyWith<$Res> {
  __$$InvoiceLoadingImplCopyWithImpl(
      _$InvoiceLoadingImpl _value, $Res Function(_$InvoiceLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InvoiceLoadingImpl implements InvoiceLoading {
  const _$InvoiceLoadingImpl();

  @override
  String toString() {
    return 'InvoiceState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvoiceLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OrderEntity order) loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OrderEntity order)? loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OrderEntity order)? loaded,
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
    required TResult Function(InvoiceInitial value) initial,
    required TResult Function(InvoiceLoading value) loading,
    required TResult Function(InvoiceLoaded value) loaded,
    required TResult Function(InvoiceFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InvoiceInitial value)? initial,
    TResult? Function(InvoiceLoading value)? loading,
    TResult? Function(InvoiceLoaded value)? loaded,
    TResult? Function(InvoiceFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvoiceInitial value)? initial,
    TResult Function(InvoiceLoading value)? loading,
    TResult Function(InvoiceLoaded value)? loaded,
    TResult Function(InvoiceFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class InvoiceLoading implements InvoiceState {
  const factory InvoiceLoading() = _$InvoiceLoadingImpl;
}

/// @nodoc
abstract class _$$InvoiceLoadedImplCopyWith<$Res> {
  factory _$$InvoiceLoadedImplCopyWith(
          _$InvoiceLoadedImpl value, $Res Function(_$InvoiceLoadedImpl) then) =
      __$$InvoiceLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OrderEntity order});
}

/// @nodoc
class __$$InvoiceLoadedImplCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res, _$InvoiceLoadedImpl>
    implements _$$InvoiceLoadedImplCopyWith<$Res> {
  __$$InvoiceLoadedImplCopyWithImpl(
      _$InvoiceLoadedImpl _value, $Res Function(_$InvoiceLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
  }) {
    return _then(_$InvoiceLoadedImpl(
      null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderEntity,
    ));
  }
}

/// @nodoc

class _$InvoiceLoadedImpl implements InvoiceLoaded {
  const _$InvoiceLoadedImpl(this.order);

  @override
  final OrderEntity order;

  @override
  String toString() {
    return 'InvoiceState.loaded(order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceLoadedImpl &&
            (identical(other.order, order) || other.order == order));
  }

  @override
  int get hashCode => Object.hash(runtimeType, order);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceLoadedImplCopyWith<_$InvoiceLoadedImpl> get copyWith =>
      __$$InvoiceLoadedImplCopyWithImpl<_$InvoiceLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OrderEntity order) loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return loaded(order);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OrderEntity order)? loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return loaded?.call(order);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OrderEntity order)? loaded,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(order);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InvoiceInitial value) initial,
    required TResult Function(InvoiceLoading value) loading,
    required TResult Function(InvoiceLoaded value) loaded,
    required TResult Function(InvoiceFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InvoiceInitial value)? initial,
    TResult? Function(InvoiceLoading value)? loading,
    TResult? Function(InvoiceLoaded value)? loaded,
    TResult? Function(InvoiceFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvoiceInitial value)? initial,
    TResult Function(InvoiceLoading value)? loading,
    TResult Function(InvoiceLoaded value)? loaded,
    TResult Function(InvoiceFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class InvoiceLoaded implements InvoiceState {
  const factory InvoiceLoaded(final OrderEntity order) = _$InvoiceLoadedImpl;

  OrderEntity get order;

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceLoadedImplCopyWith<_$InvoiceLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvoiceFailureImplCopyWith<$Res> {
  factory _$$InvoiceFailureImplCopyWith(_$InvoiceFailureImpl value,
          $Res Function(_$InvoiceFailureImpl) then) =
      __$$InvoiceFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$InvoiceFailureImplCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res, _$InvoiceFailureImpl>
    implements _$$InvoiceFailureImplCopyWith<$Res> {
  __$$InvoiceFailureImplCopyWithImpl(
      _$InvoiceFailureImpl _value, $Res Function(_$InvoiceFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$InvoiceFailureImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$InvoiceFailureImpl implements InvoiceFailure {
  const _$InvoiceFailureImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'InvoiceState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceFailureImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceFailureImplCopyWith<_$InvoiceFailureImpl> get copyWith =>
      __$$InvoiceFailureImplCopyWithImpl<_$InvoiceFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(OrderEntity order) loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(OrderEntity order)? loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(OrderEntity order)? loaded,
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
    required TResult Function(InvoiceInitial value) initial,
    required TResult Function(InvoiceLoading value) loading,
    required TResult Function(InvoiceLoaded value) loaded,
    required TResult Function(InvoiceFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InvoiceInitial value)? initial,
    TResult? Function(InvoiceLoading value)? loading,
    TResult? Function(InvoiceLoaded value)? loaded,
    TResult? Function(InvoiceFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvoiceInitial value)? initial,
    TResult Function(InvoiceLoading value)? loading,
    TResult Function(InvoiceLoaded value)? loaded,
    TResult Function(InvoiceFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class InvoiceFailure implements InvoiceState {
  const factory InvoiceFailure(final AppException exception) =
      _$InvoiceFailureImpl;

  AppException get exception;

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceFailureImplCopyWith<_$InvoiceFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
