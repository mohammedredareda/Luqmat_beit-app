// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_details_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderDetailsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String orderId) loadRequested,
    required TResult Function() acceptPressed,
    required TResult Function(String reason) rejectPressed,
    required TResult Function() completePressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String orderId)? loadRequested,
    TResult? Function()? acceptPressed,
    TResult? Function(String reason)? rejectPressed,
    TResult? Function()? completePressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String orderId)? loadRequested,
    TResult Function()? acceptPressed,
    TResult Function(String reason)? rejectPressed,
    TResult Function()? completePressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadRequested value) loadRequested,
    required TResult Function(_AcceptPressed value) acceptPressed,
    required TResult Function(_RejectPressed value) rejectPressed,
    required TResult Function(_CompletePressed value) completePressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadRequested value)? loadRequested,
    TResult? Function(_AcceptPressed value)? acceptPressed,
    TResult? Function(_RejectPressed value)? rejectPressed,
    TResult? Function(_CompletePressed value)? completePressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadRequested value)? loadRequested,
    TResult Function(_AcceptPressed value)? acceptPressed,
    TResult Function(_RejectPressed value)? rejectPressed,
    TResult Function(_CompletePressed value)? completePressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDetailsEventCopyWith<$Res> {
  factory $OrderDetailsEventCopyWith(
          OrderDetailsEvent value, $Res Function(OrderDetailsEvent) then) =
      _$OrderDetailsEventCopyWithImpl<$Res, OrderDetailsEvent>;
}

/// @nodoc
class _$OrderDetailsEventCopyWithImpl<$Res, $Val extends OrderDetailsEvent>
    implements $OrderDetailsEventCopyWith<$Res> {
  _$OrderDetailsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadRequestedImplCopyWith<$Res> {
  factory _$$LoadRequestedImplCopyWith(
          _$LoadRequestedImpl value, $Res Function(_$LoadRequestedImpl) then) =
      __$$LoadRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class __$$LoadRequestedImplCopyWithImpl<$Res>
    extends _$OrderDetailsEventCopyWithImpl<$Res, _$LoadRequestedImpl>
    implements _$$LoadRequestedImplCopyWith<$Res> {
  __$$LoadRequestedImplCopyWithImpl(
      _$LoadRequestedImpl _value, $Res Function(_$LoadRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
  }) {
    return _then(_$LoadRequestedImpl(
      null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadRequestedImpl implements _LoadRequested {
  const _$LoadRequestedImpl(this.orderId);

  @override
  final String orderId;

  @override
  String toString() {
    return 'OrderDetailsEvent.loadRequested(orderId: $orderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadRequestedImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  /// Create a copy of OrderDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadRequestedImplCopyWith<_$LoadRequestedImpl> get copyWith =>
      __$$LoadRequestedImplCopyWithImpl<_$LoadRequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String orderId) loadRequested,
    required TResult Function() acceptPressed,
    required TResult Function(String reason) rejectPressed,
    required TResult Function() completePressed,
  }) {
    return loadRequested(orderId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String orderId)? loadRequested,
    TResult? Function()? acceptPressed,
    TResult? Function(String reason)? rejectPressed,
    TResult? Function()? completePressed,
  }) {
    return loadRequested?.call(orderId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String orderId)? loadRequested,
    TResult Function()? acceptPressed,
    TResult Function(String reason)? rejectPressed,
    TResult Function()? completePressed,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(orderId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadRequested value) loadRequested,
    required TResult Function(_AcceptPressed value) acceptPressed,
    required TResult Function(_RejectPressed value) rejectPressed,
    required TResult Function(_CompletePressed value) completePressed,
  }) {
    return loadRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadRequested value)? loadRequested,
    TResult? Function(_AcceptPressed value)? acceptPressed,
    TResult? Function(_RejectPressed value)? rejectPressed,
    TResult? Function(_CompletePressed value)? completePressed,
  }) {
    return loadRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadRequested value)? loadRequested,
    TResult Function(_AcceptPressed value)? acceptPressed,
    TResult Function(_RejectPressed value)? rejectPressed,
    TResult Function(_CompletePressed value)? completePressed,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(this);
    }
    return orElse();
  }
}

abstract class _LoadRequested implements OrderDetailsEvent {
  const factory _LoadRequested(final String orderId) = _$LoadRequestedImpl;

  String get orderId;

  /// Create a copy of OrderDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadRequestedImplCopyWith<_$LoadRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AcceptPressedImplCopyWith<$Res> {
  factory _$$AcceptPressedImplCopyWith(
          _$AcceptPressedImpl value, $Res Function(_$AcceptPressedImpl) then) =
      __$$AcceptPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AcceptPressedImplCopyWithImpl<$Res>
    extends _$OrderDetailsEventCopyWithImpl<$Res, _$AcceptPressedImpl>
    implements _$$AcceptPressedImplCopyWith<$Res> {
  __$$AcceptPressedImplCopyWithImpl(
      _$AcceptPressedImpl _value, $Res Function(_$AcceptPressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AcceptPressedImpl implements _AcceptPressed {
  const _$AcceptPressedImpl();

  @override
  String toString() {
    return 'OrderDetailsEvent.acceptPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AcceptPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String orderId) loadRequested,
    required TResult Function() acceptPressed,
    required TResult Function(String reason) rejectPressed,
    required TResult Function() completePressed,
  }) {
    return acceptPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String orderId)? loadRequested,
    TResult? Function()? acceptPressed,
    TResult? Function(String reason)? rejectPressed,
    TResult? Function()? completePressed,
  }) {
    return acceptPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String orderId)? loadRequested,
    TResult Function()? acceptPressed,
    TResult Function(String reason)? rejectPressed,
    TResult Function()? completePressed,
    required TResult orElse(),
  }) {
    if (acceptPressed != null) {
      return acceptPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadRequested value) loadRequested,
    required TResult Function(_AcceptPressed value) acceptPressed,
    required TResult Function(_RejectPressed value) rejectPressed,
    required TResult Function(_CompletePressed value) completePressed,
  }) {
    return acceptPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadRequested value)? loadRequested,
    TResult? Function(_AcceptPressed value)? acceptPressed,
    TResult? Function(_RejectPressed value)? rejectPressed,
    TResult? Function(_CompletePressed value)? completePressed,
  }) {
    return acceptPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadRequested value)? loadRequested,
    TResult Function(_AcceptPressed value)? acceptPressed,
    TResult Function(_RejectPressed value)? rejectPressed,
    TResult Function(_CompletePressed value)? completePressed,
    required TResult orElse(),
  }) {
    if (acceptPressed != null) {
      return acceptPressed(this);
    }
    return orElse();
  }
}

abstract class _AcceptPressed implements OrderDetailsEvent {
  const factory _AcceptPressed() = _$AcceptPressedImpl;
}

/// @nodoc
abstract class _$$RejectPressedImplCopyWith<$Res> {
  factory _$$RejectPressedImplCopyWith(
          _$RejectPressedImpl value, $Res Function(_$RejectPressedImpl) then) =
      __$$RejectPressedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String reason});
}

/// @nodoc
class __$$RejectPressedImplCopyWithImpl<$Res>
    extends _$OrderDetailsEventCopyWithImpl<$Res, _$RejectPressedImpl>
    implements _$$RejectPressedImplCopyWith<$Res> {
  __$$RejectPressedImplCopyWithImpl(
      _$RejectPressedImpl _value, $Res Function(_$RejectPressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_$RejectPressedImpl(
      null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RejectPressedImpl implements _RejectPressed {
  const _$RejectPressedImpl(this.reason);

  @override
  final String reason;

  @override
  String toString() {
    return 'OrderDetailsEvent.rejectPressed(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RejectPressedImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of OrderDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RejectPressedImplCopyWith<_$RejectPressedImpl> get copyWith =>
      __$$RejectPressedImplCopyWithImpl<_$RejectPressedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String orderId) loadRequested,
    required TResult Function() acceptPressed,
    required TResult Function(String reason) rejectPressed,
    required TResult Function() completePressed,
  }) {
    return rejectPressed(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String orderId)? loadRequested,
    TResult? Function()? acceptPressed,
    TResult? Function(String reason)? rejectPressed,
    TResult? Function()? completePressed,
  }) {
    return rejectPressed?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String orderId)? loadRequested,
    TResult Function()? acceptPressed,
    TResult Function(String reason)? rejectPressed,
    TResult Function()? completePressed,
    required TResult orElse(),
  }) {
    if (rejectPressed != null) {
      return rejectPressed(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadRequested value) loadRequested,
    required TResult Function(_AcceptPressed value) acceptPressed,
    required TResult Function(_RejectPressed value) rejectPressed,
    required TResult Function(_CompletePressed value) completePressed,
  }) {
    return rejectPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadRequested value)? loadRequested,
    TResult? Function(_AcceptPressed value)? acceptPressed,
    TResult? Function(_RejectPressed value)? rejectPressed,
    TResult? Function(_CompletePressed value)? completePressed,
  }) {
    return rejectPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadRequested value)? loadRequested,
    TResult Function(_AcceptPressed value)? acceptPressed,
    TResult Function(_RejectPressed value)? rejectPressed,
    TResult Function(_CompletePressed value)? completePressed,
    required TResult orElse(),
  }) {
    if (rejectPressed != null) {
      return rejectPressed(this);
    }
    return orElse();
  }
}

abstract class _RejectPressed implements OrderDetailsEvent {
  const factory _RejectPressed(final String reason) = _$RejectPressedImpl;

  String get reason;

  /// Create a copy of OrderDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RejectPressedImplCopyWith<_$RejectPressedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CompletePressedImplCopyWith<$Res> {
  factory _$$CompletePressedImplCopyWith(_$CompletePressedImpl value,
          $Res Function(_$CompletePressedImpl) then) =
      __$$CompletePressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompletePressedImplCopyWithImpl<$Res>
    extends _$OrderDetailsEventCopyWithImpl<$Res, _$CompletePressedImpl>
    implements _$$CompletePressedImplCopyWith<$Res> {
  __$$CompletePressedImplCopyWithImpl(
      _$CompletePressedImpl _value, $Res Function(_$CompletePressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CompletePressedImpl implements _CompletePressed {
  const _$CompletePressedImpl();

  @override
  String toString() {
    return 'OrderDetailsEvent.completePressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompletePressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String orderId) loadRequested,
    required TResult Function() acceptPressed,
    required TResult Function(String reason) rejectPressed,
    required TResult Function() completePressed,
  }) {
    return completePressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String orderId)? loadRequested,
    TResult? Function()? acceptPressed,
    TResult? Function(String reason)? rejectPressed,
    TResult? Function()? completePressed,
  }) {
    return completePressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String orderId)? loadRequested,
    TResult Function()? acceptPressed,
    TResult Function(String reason)? rejectPressed,
    TResult Function()? completePressed,
    required TResult orElse(),
  }) {
    if (completePressed != null) {
      return completePressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadRequested value) loadRequested,
    required TResult Function(_AcceptPressed value) acceptPressed,
    required TResult Function(_RejectPressed value) rejectPressed,
    required TResult Function(_CompletePressed value) completePressed,
  }) {
    return completePressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadRequested value)? loadRequested,
    TResult? Function(_AcceptPressed value)? acceptPressed,
    TResult? Function(_RejectPressed value)? rejectPressed,
    TResult? Function(_CompletePressed value)? completePressed,
  }) {
    return completePressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadRequested value)? loadRequested,
    TResult Function(_AcceptPressed value)? acceptPressed,
    TResult Function(_RejectPressed value)? rejectPressed,
    TResult Function(_CompletePressed value)? completePressed,
    required TResult orElse(),
  }) {
    if (completePressed != null) {
      return completePressed(this);
    }
    return orElse();
  }
}

abstract class _CompletePressed implements OrderDetailsEvent {
  const factory _CompletePressed() = _$CompletePressedImpl;
}
