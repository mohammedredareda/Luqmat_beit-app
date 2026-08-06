// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_acceptance_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeliveryAcceptanceEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryAcceptanceEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeliveryAcceptanceEvent()';
}


}

/// @nodoc
class $DeliveryAcceptanceEventCopyWith<$Res>  {
$DeliveryAcceptanceEventCopyWith(DeliveryAcceptanceEvent _, $Res Function(DeliveryAcceptanceEvent) __);
}


/// Adds pattern-matching-related methods to [DeliveryAcceptanceEvent].
extension DeliveryAcceptanceEventPatterns on DeliveryAcceptanceEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DeliveryAcceptanceStarted value)?  started,TResult Function( ConfirmReceiptRequested value)?  confirmReceiptRequested,TResult Function( ReportIssueToggled value)?  reportIssueToggled,TResult Function( ReasonChanged value)?  reasonChanged,TResult Function( ReportIssueSubmitted value)?  reportIssueSubmitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DeliveryAcceptanceStarted() when started != null:
return started(_that);case ConfirmReceiptRequested() when confirmReceiptRequested != null:
return confirmReceiptRequested(_that);case ReportIssueToggled() when reportIssueToggled != null:
return reportIssueToggled(_that);case ReasonChanged() when reasonChanged != null:
return reasonChanged(_that);case ReportIssueSubmitted() when reportIssueSubmitted != null:
return reportIssueSubmitted(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DeliveryAcceptanceStarted value)  started,required TResult Function( ConfirmReceiptRequested value)  confirmReceiptRequested,required TResult Function( ReportIssueToggled value)  reportIssueToggled,required TResult Function( ReasonChanged value)  reasonChanged,required TResult Function( ReportIssueSubmitted value)  reportIssueSubmitted,}){
final _that = this;
switch (_that) {
case DeliveryAcceptanceStarted():
return started(_that);case ConfirmReceiptRequested():
return confirmReceiptRequested(_that);case ReportIssueToggled():
return reportIssueToggled(_that);case ReasonChanged():
return reasonChanged(_that);case ReportIssueSubmitted():
return reportIssueSubmitted(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DeliveryAcceptanceStarted value)?  started,TResult? Function( ConfirmReceiptRequested value)?  confirmReceiptRequested,TResult? Function( ReportIssueToggled value)?  reportIssueToggled,TResult? Function( ReasonChanged value)?  reasonChanged,TResult? Function( ReportIssueSubmitted value)?  reportIssueSubmitted,}){
final _that = this;
switch (_that) {
case DeliveryAcceptanceStarted() when started != null:
return started(_that);case ConfirmReceiptRequested() when confirmReceiptRequested != null:
return confirmReceiptRequested(_that);case ReportIssueToggled() when reportIssueToggled != null:
return reportIssueToggled(_that);case ReasonChanged() when reasonChanged != null:
return reasonChanged(_that);case ReportIssueSubmitted() when reportIssueSubmitted != null:
return reportIssueSubmitted(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String orderId)?  started,TResult Function()?  confirmReceiptRequested,TResult Function()?  reportIssueToggled,TResult Function( String reason)?  reasonChanged,TResult Function()?  reportIssueSubmitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DeliveryAcceptanceStarted() when started != null:
return started(_that.orderId);case ConfirmReceiptRequested() when confirmReceiptRequested != null:
return confirmReceiptRequested();case ReportIssueToggled() when reportIssueToggled != null:
return reportIssueToggled();case ReasonChanged() when reasonChanged != null:
return reasonChanged(_that.reason);case ReportIssueSubmitted() when reportIssueSubmitted != null:
return reportIssueSubmitted();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String orderId)  started,required TResult Function()  confirmReceiptRequested,required TResult Function()  reportIssueToggled,required TResult Function( String reason)  reasonChanged,required TResult Function()  reportIssueSubmitted,}) {final _that = this;
switch (_that) {
case DeliveryAcceptanceStarted():
return started(_that.orderId);case ConfirmReceiptRequested():
return confirmReceiptRequested();case ReportIssueToggled():
return reportIssueToggled();case ReasonChanged():
return reasonChanged(_that.reason);case ReportIssueSubmitted():
return reportIssueSubmitted();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String orderId)?  started,TResult? Function()?  confirmReceiptRequested,TResult? Function()?  reportIssueToggled,TResult? Function( String reason)?  reasonChanged,TResult? Function()?  reportIssueSubmitted,}) {final _that = this;
switch (_that) {
case DeliveryAcceptanceStarted() when started != null:
return started(_that.orderId);case ConfirmReceiptRequested() when confirmReceiptRequested != null:
return confirmReceiptRequested();case ReportIssueToggled() when reportIssueToggled != null:
return reportIssueToggled();case ReasonChanged() when reasonChanged != null:
return reasonChanged(_that.reason);case ReportIssueSubmitted() when reportIssueSubmitted != null:
return reportIssueSubmitted();case _:
  return null;

}
}

}

/// @nodoc


class DeliveryAcceptanceStarted implements DeliveryAcceptanceEvent {
  const DeliveryAcceptanceStarted(this.orderId);
  

 final  String orderId;

/// Create a copy of DeliveryAcceptanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryAcceptanceStartedCopyWith<DeliveryAcceptanceStarted> get copyWith => _$DeliveryAcceptanceStartedCopyWithImpl<DeliveryAcceptanceStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryAcceptanceStarted&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'DeliveryAcceptanceEvent.started(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $DeliveryAcceptanceStartedCopyWith<$Res> implements $DeliveryAcceptanceEventCopyWith<$Res> {
  factory $DeliveryAcceptanceStartedCopyWith(DeliveryAcceptanceStarted value, $Res Function(DeliveryAcceptanceStarted) _then) = _$DeliveryAcceptanceStartedCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class _$DeliveryAcceptanceStartedCopyWithImpl<$Res>
    implements $DeliveryAcceptanceStartedCopyWith<$Res> {
  _$DeliveryAcceptanceStartedCopyWithImpl(this._self, this._then);

  final DeliveryAcceptanceStarted _self;
  final $Res Function(DeliveryAcceptanceStarted) _then;

/// Create a copy of DeliveryAcceptanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(DeliveryAcceptanceStarted(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ConfirmReceiptRequested implements DeliveryAcceptanceEvent {
  const ConfirmReceiptRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmReceiptRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeliveryAcceptanceEvent.confirmReceiptRequested()';
}


}




/// @nodoc


class ReportIssueToggled implements DeliveryAcceptanceEvent {
  const ReportIssueToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportIssueToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeliveryAcceptanceEvent.reportIssueToggled()';
}


}




/// @nodoc


class ReasonChanged implements DeliveryAcceptanceEvent {
  const ReasonChanged(this.reason);
  

 final  String reason;

/// Create a copy of DeliveryAcceptanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReasonChangedCopyWith<ReasonChanged> get copyWith => _$ReasonChangedCopyWithImpl<ReasonChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReasonChanged&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'DeliveryAcceptanceEvent.reasonChanged(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $ReasonChangedCopyWith<$Res> implements $DeliveryAcceptanceEventCopyWith<$Res> {
  factory $ReasonChangedCopyWith(ReasonChanged value, $Res Function(ReasonChanged) _then) = _$ReasonChangedCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$ReasonChangedCopyWithImpl<$Res>
    implements $ReasonChangedCopyWith<$Res> {
  _$ReasonChangedCopyWithImpl(this._self, this._then);

  final ReasonChanged _self;
  final $Res Function(ReasonChanged) _then;

/// Create a copy of DeliveryAcceptanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(ReasonChanged(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ReportIssueSubmitted implements DeliveryAcceptanceEvent {
  const ReportIssueSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportIssueSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeliveryAcceptanceEvent.reportIssueSubmitted()';
}


}




// dart format on
