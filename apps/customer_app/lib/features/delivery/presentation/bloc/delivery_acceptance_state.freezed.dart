// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_acceptance_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeliveryAcceptanceState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryAcceptanceState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeliveryAcceptanceState()';
}


}

/// @nodoc
class $DeliveryAcceptanceStateCopyWith<$Res>  {
$DeliveryAcceptanceStateCopyWith(DeliveryAcceptanceState _, $Res Function(DeliveryAcceptanceState) __);
}


/// Adds pattern-matching-related methods to [DeliveryAcceptanceState].
extension DeliveryAcceptanceStatePatterns on DeliveryAcceptanceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DeliveryAcceptanceInitial value)?  initial,TResult Function( DeliveryAcceptanceLoading value)?  loading,TResult Function( DeliveryAcceptanceLoaded value)?  loaded,TResult Function( DeliveryAcceptanceConfirmed value)?  confirmed,TResult Function( DeliveryAcceptanceReported value)?  reported,TResult Function( DeliveryAcceptanceFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DeliveryAcceptanceInitial() when initial != null:
return initial(_that);case DeliveryAcceptanceLoading() when loading != null:
return loading(_that);case DeliveryAcceptanceLoaded() when loaded != null:
return loaded(_that);case DeliveryAcceptanceConfirmed() when confirmed != null:
return confirmed(_that);case DeliveryAcceptanceReported() when reported != null:
return reported(_that);case DeliveryAcceptanceFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DeliveryAcceptanceInitial value)  initial,required TResult Function( DeliveryAcceptanceLoading value)  loading,required TResult Function( DeliveryAcceptanceLoaded value)  loaded,required TResult Function( DeliveryAcceptanceConfirmed value)  confirmed,required TResult Function( DeliveryAcceptanceReported value)  reported,required TResult Function( DeliveryAcceptanceFailure value)  failure,}){
final _that = this;
switch (_that) {
case DeliveryAcceptanceInitial():
return initial(_that);case DeliveryAcceptanceLoading():
return loading(_that);case DeliveryAcceptanceLoaded():
return loaded(_that);case DeliveryAcceptanceConfirmed():
return confirmed(_that);case DeliveryAcceptanceReported():
return reported(_that);case DeliveryAcceptanceFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DeliveryAcceptanceInitial value)?  initial,TResult? Function( DeliveryAcceptanceLoading value)?  loading,TResult? Function( DeliveryAcceptanceLoaded value)?  loaded,TResult? Function( DeliveryAcceptanceConfirmed value)?  confirmed,TResult? Function( DeliveryAcceptanceReported value)?  reported,TResult? Function( DeliveryAcceptanceFailure value)?  failure,}){
final _that = this;
switch (_that) {
case DeliveryAcceptanceInitial() when initial != null:
return initial(_that);case DeliveryAcceptanceLoading() when loading != null:
return loading(_that);case DeliveryAcceptanceLoaded() when loaded != null:
return loaded(_that);case DeliveryAcceptanceConfirmed() when confirmed != null:
return confirmed(_that);case DeliveryAcceptanceReported() when reported != null:
return reported(_that);case DeliveryAcceptanceFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( OrderEntity order,  bool isReportingIssue,  String reason,  String? reasonError,  bool isProcessing)?  loaded,TResult Function( OrderEntity order)?  confirmed,TResult Function( OrderEntity order)?  reported,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DeliveryAcceptanceInitial() when initial != null:
return initial();case DeliveryAcceptanceLoading() when loading != null:
return loading();case DeliveryAcceptanceLoaded() when loaded != null:
return loaded(_that.order,_that.isReportingIssue,_that.reason,_that.reasonError,_that.isProcessing);case DeliveryAcceptanceConfirmed() when confirmed != null:
return confirmed(_that.order);case DeliveryAcceptanceReported() when reported != null:
return reported(_that.order);case DeliveryAcceptanceFailure() when failure != null:
return failure(_that.exception);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( OrderEntity order,  bool isReportingIssue,  String reason,  String? reasonError,  bool isProcessing)  loaded,required TResult Function( OrderEntity order)  confirmed,required TResult Function( OrderEntity order)  reported,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case DeliveryAcceptanceInitial():
return initial();case DeliveryAcceptanceLoading():
return loading();case DeliveryAcceptanceLoaded():
return loaded(_that.order,_that.isReportingIssue,_that.reason,_that.reasonError,_that.isProcessing);case DeliveryAcceptanceConfirmed():
return confirmed(_that.order);case DeliveryAcceptanceReported():
return reported(_that.order);case DeliveryAcceptanceFailure():
return failure(_that.exception);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( OrderEntity order,  bool isReportingIssue,  String reason,  String? reasonError,  bool isProcessing)?  loaded,TResult? Function( OrderEntity order)?  confirmed,TResult? Function( OrderEntity order)?  reported,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case DeliveryAcceptanceInitial() when initial != null:
return initial();case DeliveryAcceptanceLoading() when loading != null:
return loading();case DeliveryAcceptanceLoaded() when loaded != null:
return loaded(_that.order,_that.isReportingIssue,_that.reason,_that.reasonError,_that.isProcessing);case DeliveryAcceptanceConfirmed() when confirmed != null:
return confirmed(_that.order);case DeliveryAcceptanceReported() when reported != null:
return reported(_that.order);case DeliveryAcceptanceFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class DeliveryAcceptanceInitial implements DeliveryAcceptanceState {
  const DeliveryAcceptanceInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryAcceptanceInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeliveryAcceptanceState.initial()';
}


}




/// @nodoc


class DeliveryAcceptanceLoading implements DeliveryAcceptanceState {
  const DeliveryAcceptanceLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryAcceptanceLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeliveryAcceptanceState.loading()';
}


}




/// @nodoc


class DeliveryAcceptanceLoaded implements DeliveryAcceptanceState {
  const DeliveryAcceptanceLoaded(this.order, {this.isReportingIssue = false, this.reason = '', this.reasonError, this.isProcessing = false});
  

 final  OrderEntity order;
@JsonKey() final  bool isReportingIssue;
@JsonKey() final  String reason;
 final  String? reasonError;
@JsonKey() final  bool isProcessing;

/// Create a copy of DeliveryAcceptanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryAcceptanceLoadedCopyWith<DeliveryAcceptanceLoaded> get copyWith => _$DeliveryAcceptanceLoadedCopyWithImpl<DeliveryAcceptanceLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryAcceptanceLoaded&&(identical(other.order, order) || other.order == order)&&(identical(other.isReportingIssue, isReportingIssue) || other.isReportingIssue == isReportingIssue)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.reasonError, reasonError) || other.reasonError == reasonError)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing));
}


@override
int get hashCode => Object.hash(runtimeType,order,isReportingIssue,reason,reasonError,isProcessing);

@override
String toString() {
  return 'DeliveryAcceptanceState.loaded(order: $order, isReportingIssue: $isReportingIssue, reason: $reason, reasonError: $reasonError, isProcessing: $isProcessing)';
}


}

/// @nodoc
abstract mixin class $DeliveryAcceptanceLoadedCopyWith<$Res> implements $DeliveryAcceptanceStateCopyWith<$Res> {
  factory $DeliveryAcceptanceLoadedCopyWith(DeliveryAcceptanceLoaded value, $Res Function(DeliveryAcceptanceLoaded) _then) = _$DeliveryAcceptanceLoadedCopyWithImpl;
@useResult
$Res call({
 OrderEntity order, bool isReportingIssue, String reason, String? reasonError, bool isProcessing
});




}
/// @nodoc
class _$DeliveryAcceptanceLoadedCopyWithImpl<$Res>
    implements $DeliveryAcceptanceLoadedCopyWith<$Res> {
  _$DeliveryAcceptanceLoadedCopyWithImpl(this._self, this._then);

  final DeliveryAcceptanceLoaded _self;
  final $Res Function(DeliveryAcceptanceLoaded) _then;

/// Create a copy of DeliveryAcceptanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,Object? isReportingIssue = null,Object? reason = null,Object? reasonError = freezed,Object? isProcessing = null,}) {
  return _then(DeliveryAcceptanceLoaded(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderEntity,isReportingIssue: null == isReportingIssue ? _self.isReportingIssue : isReportingIssue // ignore: cast_nullable_to_non_nullable
as bool,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,reasonError: freezed == reasonError ? _self.reasonError : reasonError // ignore: cast_nullable_to_non_nullable
as String?,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class DeliveryAcceptanceConfirmed implements DeliveryAcceptanceState {
  const DeliveryAcceptanceConfirmed(this.order);
  

 final  OrderEntity order;

/// Create a copy of DeliveryAcceptanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryAcceptanceConfirmedCopyWith<DeliveryAcceptanceConfirmed> get copyWith => _$DeliveryAcceptanceConfirmedCopyWithImpl<DeliveryAcceptanceConfirmed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryAcceptanceConfirmed&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'DeliveryAcceptanceState.confirmed(order: $order)';
}


}

/// @nodoc
abstract mixin class $DeliveryAcceptanceConfirmedCopyWith<$Res> implements $DeliveryAcceptanceStateCopyWith<$Res> {
  factory $DeliveryAcceptanceConfirmedCopyWith(DeliveryAcceptanceConfirmed value, $Res Function(DeliveryAcceptanceConfirmed) _then) = _$DeliveryAcceptanceConfirmedCopyWithImpl;
@useResult
$Res call({
 OrderEntity order
});




}
/// @nodoc
class _$DeliveryAcceptanceConfirmedCopyWithImpl<$Res>
    implements $DeliveryAcceptanceConfirmedCopyWith<$Res> {
  _$DeliveryAcceptanceConfirmedCopyWithImpl(this._self, this._then);

  final DeliveryAcceptanceConfirmed _self;
  final $Res Function(DeliveryAcceptanceConfirmed) _then;

/// Create a copy of DeliveryAcceptanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,}) {
  return _then(DeliveryAcceptanceConfirmed(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderEntity,
  ));
}


}

/// @nodoc


class DeliveryAcceptanceReported implements DeliveryAcceptanceState {
  const DeliveryAcceptanceReported(this.order);
  

 final  OrderEntity order;

/// Create a copy of DeliveryAcceptanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryAcceptanceReportedCopyWith<DeliveryAcceptanceReported> get copyWith => _$DeliveryAcceptanceReportedCopyWithImpl<DeliveryAcceptanceReported>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryAcceptanceReported&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'DeliveryAcceptanceState.reported(order: $order)';
}


}

/// @nodoc
abstract mixin class $DeliveryAcceptanceReportedCopyWith<$Res> implements $DeliveryAcceptanceStateCopyWith<$Res> {
  factory $DeliveryAcceptanceReportedCopyWith(DeliveryAcceptanceReported value, $Res Function(DeliveryAcceptanceReported) _then) = _$DeliveryAcceptanceReportedCopyWithImpl;
@useResult
$Res call({
 OrderEntity order
});




}
/// @nodoc
class _$DeliveryAcceptanceReportedCopyWithImpl<$Res>
    implements $DeliveryAcceptanceReportedCopyWith<$Res> {
  _$DeliveryAcceptanceReportedCopyWithImpl(this._self, this._then);

  final DeliveryAcceptanceReported _self;
  final $Res Function(DeliveryAcceptanceReported) _then;

/// Create a copy of DeliveryAcceptanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,}) {
  return _then(DeliveryAcceptanceReported(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderEntity,
  ));
}


}

/// @nodoc


class DeliveryAcceptanceFailure implements DeliveryAcceptanceState {
  const DeliveryAcceptanceFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of DeliveryAcceptanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryAcceptanceFailureCopyWith<DeliveryAcceptanceFailure> get copyWith => _$DeliveryAcceptanceFailureCopyWithImpl<DeliveryAcceptanceFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryAcceptanceFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'DeliveryAcceptanceState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $DeliveryAcceptanceFailureCopyWith<$Res> implements $DeliveryAcceptanceStateCopyWith<$Res> {
  factory $DeliveryAcceptanceFailureCopyWith(DeliveryAcceptanceFailure value, $Res Function(DeliveryAcceptanceFailure) _then) = _$DeliveryAcceptanceFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$DeliveryAcceptanceFailureCopyWithImpl<$Res>
    implements $DeliveryAcceptanceFailureCopyWith<$Res> {
  _$DeliveryAcceptanceFailureCopyWithImpl(this._self, this._then);

  final DeliveryAcceptanceFailure _self;
  final $Res Function(DeliveryAcceptanceFailure) _then;

/// Create a copy of DeliveryAcceptanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(DeliveryAcceptanceFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
