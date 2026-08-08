// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_acceptance_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DeliveryAcceptanceEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String orderId) started,
    required TResult Function() confirmReceiptRequested,
    required TResult Function() reportIssueToggled,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() reportIssueSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String orderId)? started,
    TResult? Function()? confirmReceiptRequested,
    TResult? Function()? reportIssueToggled,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? reportIssueSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String orderId)? started,
    TResult Function()? confirmReceiptRequested,
    TResult Function()? reportIssueToggled,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? reportIssueSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DeliveryAcceptanceStarted value) started,
    required TResult Function(ConfirmReceiptRequested value)
        confirmReceiptRequested,
    required TResult Function(ReportIssueToggled value) reportIssueToggled,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(ReportIssueSubmitted value) reportIssueSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeliveryAcceptanceStarted value)? started,
    TResult? Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult? Function(ReportIssueToggled value)? reportIssueToggled,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(ReportIssueSubmitted value)? reportIssueSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeliveryAcceptanceStarted value)? started,
    TResult Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult Function(ReportIssueToggled value)? reportIssueToggled,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(ReportIssueSubmitted value)? reportIssueSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryAcceptanceEventCopyWith<$Res> {
  factory $DeliveryAcceptanceEventCopyWith(DeliveryAcceptanceEvent value,
          $Res Function(DeliveryAcceptanceEvent) then) =
      _$DeliveryAcceptanceEventCopyWithImpl<$Res, DeliveryAcceptanceEvent>;
}

/// @nodoc
class _$DeliveryAcceptanceEventCopyWithImpl<$Res,
        $Val extends DeliveryAcceptanceEvent>
    implements $DeliveryAcceptanceEventCopyWith<$Res> {
  _$DeliveryAcceptanceEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliveryAcceptanceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DeliveryAcceptanceStartedImplCopyWith<$Res> {
  factory _$$DeliveryAcceptanceStartedImplCopyWith(
          _$DeliveryAcceptanceStartedImpl value,
          $Res Function(_$DeliveryAcceptanceStartedImpl) then) =
      __$$DeliveryAcceptanceStartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class __$$DeliveryAcceptanceStartedImplCopyWithImpl<$Res>
    extends _$DeliveryAcceptanceEventCopyWithImpl<$Res,
        _$DeliveryAcceptanceStartedImpl>
    implements _$$DeliveryAcceptanceStartedImplCopyWith<$Res> {
  __$$DeliveryAcceptanceStartedImplCopyWithImpl(
      _$DeliveryAcceptanceStartedImpl _value,
      $Res Function(_$DeliveryAcceptanceStartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeliveryAcceptanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
  }) {
    return _then(_$DeliveryAcceptanceStartedImpl(
      null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeliveryAcceptanceStartedImpl implements DeliveryAcceptanceStarted {
  const _$DeliveryAcceptanceStartedImpl(this.orderId);

  @override
  final String orderId;

  @override
  String toString() {
    return 'DeliveryAcceptanceEvent.started(orderId: $orderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryAcceptanceStartedImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  /// Create a copy of DeliveryAcceptanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryAcceptanceStartedImplCopyWith<_$DeliveryAcceptanceStartedImpl>
      get copyWith => __$$DeliveryAcceptanceStartedImplCopyWithImpl<
          _$DeliveryAcceptanceStartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String orderId) started,
    required TResult Function() confirmReceiptRequested,
    required TResult Function() reportIssueToggled,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() reportIssueSubmitted,
  }) {
    return started(orderId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String orderId)? started,
    TResult? Function()? confirmReceiptRequested,
    TResult? Function()? reportIssueToggled,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? reportIssueSubmitted,
  }) {
    return started?.call(orderId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String orderId)? started,
    TResult Function()? confirmReceiptRequested,
    TResult Function()? reportIssueToggled,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? reportIssueSubmitted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(orderId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DeliveryAcceptanceStarted value) started,
    required TResult Function(ConfirmReceiptRequested value)
        confirmReceiptRequested,
    required TResult Function(ReportIssueToggled value) reportIssueToggled,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(ReportIssueSubmitted value) reportIssueSubmitted,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeliveryAcceptanceStarted value)? started,
    TResult? Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult? Function(ReportIssueToggled value)? reportIssueToggled,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(ReportIssueSubmitted value)? reportIssueSubmitted,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeliveryAcceptanceStarted value)? started,
    TResult Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult Function(ReportIssueToggled value)? reportIssueToggled,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(ReportIssueSubmitted value)? reportIssueSubmitted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class DeliveryAcceptanceStarted implements DeliveryAcceptanceEvent {
  const factory DeliveryAcceptanceStarted(final String orderId) =
      _$DeliveryAcceptanceStartedImpl;

  String get orderId;

  /// Create a copy of DeliveryAcceptanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryAcceptanceStartedImplCopyWith<_$DeliveryAcceptanceStartedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmReceiptRequestedImplCopyWith<$Res> {
  factory _$$ConfirmReceiptRequestedImplCopyWith(
          _$ConfirmReceiptRequestedImpl value,
          $Res Function(_$ConfirmReceiptRequestedImpl) then) =
      __$$ConfirmReceiptRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConfirmReceiptRequestedImplCopyWithImpl<$Res>
    extends _$DeliveryAcceptanceEventCopyWithImpl<$Res,
        _$ConfirmReceiptRequestedImpl>
    implements _$$ConfirmReceiptRequestedImplCopyWith<$Res> {
  __$$ConfirmReceiptRequestedImplCopyWithImpl(
      _$ConfirmReceiptRequestedImpl _value,
      $Res Function(_$ConfirmReceiptRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeliveryAcceptanceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConfirmReceiptRequestedImpl implements ConfirmReceiptRequested {
  const _$ConfirmReceiptRequestedImpl();

  @override
  String toString() {
    return 'DeliveryAcceptanceEvent.confirmReceiptRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmReceiptRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String orderId) started,
    required TResult Function() confirmReceiptRequested,
    required TResult Function() reportIssueToggled,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() reportIssueSubmitted,
  }) {
    return confirmReceiptRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String orderId)? started,
    TResult? Function()? confirmReceiptRequested,
    TResult? Function()? reportIssueToggled,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? reportIssueSubmitted,
  }) {
    return confirmReceiptRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String orderId)? started,
    TResult Function()? confirmReceiptRequested,
    TResult Function()? reportIssueToggled,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? reportIssueSubmitted,
    required TResult orElse(),
  }) {
    if (confirmReceiptRequested != null) {
      return confirmReceiptRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DeliveryAcceptanceStarted value) started,
    required TResult Function(ConfirmReceiptRequested value)
        confirmReceiptRequested,
    required TResult Function(ReportIssueToggled value) reportIssueToggled,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(ReportIssueSubmitted value) reportIssueSubmitted,
  }) {
    return confirmReceiptRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeliveryAcceptanceStarted value)? started,
    TResult? Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult? Function(ReportIssueToggled value)? reportIssueToggled,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(ReportIssueSubmitted value)? reportIssueSubmitted,
  }) {
    return confirmReceiptRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeliveryAcceptanceStarted value)? started,
    TResult Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult Function(ReportIssueToggled value)? reportIssueToggled,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(ReportIssueSubmitted value)? reportIssueSubmitted,
    required TResult orElse(),
  }) {
    if (confirmReceiptRequested != null) {
      return confirmReceiptRequested(this);
    }
    return orElse();
  }
}

abstract class ConfirmReceiptRequested implements DeliveryAcceptanceEvent {
  const factory ConfirmReceiptRequested() = _$ConfirmReceiptRequestedImpl;
}

/// @nodoc
abstract class _$$ReportIssueToggledImplCopyWith<$Res> {
  factory _$$ReportIssueToggledImplCopyWith(_$ReportIssueToggledImpl value,
          $Res Function(_$ReportIssueToggledImpl) then) =
      __$$ReportIssueToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReportIssueToggledImplCopyWithImpl<$Res>
    extends _$DeliveryAcceptanceEventCopyWithImpl<$Res,
        _$ReportIssueToggledImpl>
    implements _$$ReportIssueToggledImplCopyWith<$Res> {
  __$$ReportIssueToggledImplCopyWithImpl(_$ReportIssueToggledImpl _value,
      $Res Function(_$ReportIssueToggledImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeliveryAcceptanceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReportIssueToggledImpl implements ReportIssueToggled {
  const _$ReportIssueToggledImpl();

  @override
  String toString() {
    return 'DeliveryAcceptanceEvent.reportIssueToggled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReportIssueToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String orderId) started,
    required TResult Function() confirmReceiptRequested,
    required TResult Function() reportIssueToggled,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() reportIssueSubmitted,
  }) {
    return reportIssueToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String orderId)? started,
    TResult? Function()? confirmReceiptRequested,
    TResult? Function()? reportIssueToggled,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? reportIssueSubmitted,
  }) {
    return reportIssueToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String orderId)? started,
    TResult Function()? confirmReceiptRequested,
    TResult Function()? reportIssueToggled,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? reportIssueSubmitted,
    required TResult orElse(),
  }) {
    if (reportIssueToggled != null) {
      return reportIssueToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DeliveryAcceptanceStarted value) started,
    required TResult Function(ConfirmReceiptRequested value)
        confirmReceiptRequested,
    required TResult Function(ReportIssueToggled value) reportIssueToggled,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(ReportIssueSubmitted value) reportIssueSubmitted,
  }) {
    return reportIssueToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeliveryAcceptanceStarted value)? started,
    TResult? Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult? Function(ReportIssueToggled value)? reportIssueToggled,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(ReportIssueSubmitted value)? reportIssueSubmitted,
  }) {
    return reportIssueToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeliveryAcceptanceStarted value)? started,
    TResult Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult Function(ReportIssueToggled value)? reportIssueToggled,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(ReportIssueSubmitted value)? reportIssueSubmitted,
    required TResult orElse(),
  }) {
    if (reportIssueToggled != null) {
      return reportIssueToggled(this);
    }
    return orElse();
  }
}

abstract class ReportIssueToggled implements DeliveryAcceptanceEvent {
  const factory ReportIssueToggled() = _$ReportIssueToggledImpl;
}

/// @nodoc
abstract class _$$ReasonChangedImplCopyWith<$Res> {
  factory _$$ReasonChangedImplCopyWith(
          _$ReasonChangedImpl value, $Res Function(_$ReasonChangedImpl) then) =
      __$$ReasonChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String reason});
}

/// @nodoc
class __$$ReasonChangedImplCopyWithImpl<$Res>
    extends _$DeliveryAcceptanceEventCopyWithImpl<$Res, _$ReasonChangedImpl>
    implements _$$ReasonChangedImplCopyWith<$Res> {
  __$$ReasonChangedImplCopyWithImpl(
      _$ReasonChangedImpl _value, $Res Function(_$ReasonChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeliveryAcceptanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_$ReasonChangedImpl(
      null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ReasonChangedImpl implements ReasonChanged {
  const _$ReasonChangedImpl(this.reason);

  @override
  final String reason;

  @override
  String toString() {
    return 'DeliveryAcceptanceEvent.reasonChanged(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReasonChangedImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of DeliveryAcceptanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReasonChangedImplCopyWith<_$ReasonChangedImpl> get copyWith =>
      __$$ReasonChangedImplCopyWithImpl<_$ReasonChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String orderId) started,
    required TResult Function() confirmReceiptRequested,
    required TResult Function() reportIssueToggled,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() reportIssueSubmitted,
  }) {
    return reasonChanged(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String orderId)? started,
    TResult? Function()? confirmReceiptRequested,
    TResult? Function()? reportIssueToggled,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? reportIssueSubmitted,
  }) {
    return reasonChanged?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String orderId)? started,
    TResult Function()? confirmReceiptRequested,
    TResult Function()? reportIssueToggled,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? reportIssueSubmitted,
    required TResult orElse(),
  }) {
    if (reasonChanged != null) {
      return reasonChanged(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DeliveryAcceptanceStarted value) started,
    required TResult Function(ConfirmReceiptRequested value)
        confirmReceiptRequested,
    required TResult Function(ReportIssueToggled value) reportIssueToggled,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(ReportIssueSubmitted value) reportIssueSubmitted,
  }) {
    return reasonChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeliveryAcceptanceStarted value)? started,
    TResult? Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult? Function(ReportIssueToggled value)? reportIssueToggled,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(ReportIssueSubmitted value)? reportIssueSubmitted,
  }) {
    return reasonChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeliveryAcceptanceStarted value)? started,
    TResult Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult Function(ReportIssueToggled value)? reportIssueToggled,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(ReportIssueSubmitted value)? reportIssueSubmitted,
    required TResult orElse(),
  }) {
    if (reasonChanged != null) {
      return reasonChanged(this);
    }
    return orElse();
  }
}

abstract class ReasonChanged implements DeliveryAcceptanceEvent {
  const factory ReasonChanged(final String reason) = _$ReasonChangedImpl;

  String get reason;

  /// Create a copy of DeliveryAcceptanceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReasonChangedImplCopyWith<_$ReasonChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReportIssueSubmittedImplCopyWith<$Res> {
  factory _$$ReportIssueSubmittedImplCopyWith(_$ReportIssueSubmittedImpl value,
          $Res Function(_$ReportIssueSubmittedImpl) then) =
      __$$ReportIssueSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReportIssueSubmittedImplCopyWithImpl<$Res>
    extends _$DeliveryAcceptanceEventCopyWithImpl<$Res,
        _$ReportIssueSubmittedImpl>
    implements _$$ReportIssueSubmittedImplCopyWith<$Res> {
  __$$ReportIssueSubmittedImplCopyWithImpl(_$ReportIssueSubmittedImpl _value,
      $Res Function(_$ReportIssueSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeliveryAcceptanceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReportIssueSubmittedImpl implements ReportIssueSubmitted {
  const _$ReportIssueSubmittedImpl();

  @override
  String toString() {
    return 'DeliveryAcceptanceEvent.reportIssueSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportIssueSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String orderId) started,
    required TResult Function() confirmReceiptRequested,
    required TResult Function() reportIssueToggled,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() reportIssueSubmitted,
  }) {
    return reportIssueSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String orderId)? started,
    TResult? Function()? confirmReceiptRequested,
    TResult? Function()? reportIssueToggled,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? reportIssueSubmitted,
  }) {
    return reportIssueSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String orderId)? started,
    TResult Function()? confirmReceiptRequested,
    TResult Function()? reportIssueToggled,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? reportIssueSubmitted,
    required TResult orElse(),
  }) {
    if (reportIssueSubmitted != null) {
      return reportIssueSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DeliveryAcceptanceStarted value) started,
    required TResult Function(ConfirmReceiptRequested value)
        confirmReceiptRequested,
    required TResult Function(ReportIssueToggled value) reportIssueToggled,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(ReportIssueSubmitted value) reportIssueSubmitted,
  }) {
    return reportIssueSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeliveryAcceptanceStarted value)? started,
    TResult? Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult? Function(ReportIssueToggled value)? reportIssueToggled,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(ReportIssueSubmitted value)? reportIssueSubmitted,
  }) {
    return reportIssueSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeliveryAcceptanceStarted value)? started,
    TResult Function(ConfirmReceiptRequested value)? confirmReceiptRequested,
    TResult Function(ReportIssueToggled value)? reportIssueToggled,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(ReportIssueSubmitted value)? reportIssueSubmitted,
    required TResult orElse(),
  }) {
    if (reportIssueSubmitted != null) {
      return reportIssueSubmitted(this);
    }
    return orElse();
  }
}

abstract class ReportIssueSubmitted implements DeliveryAcceptanceEvent {
  const factory ReportIssueSubmitted() = _$ReportIssueSubmittedImpl;
}
