// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_confirmation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderConfirmationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderConfirmationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderConfirmationState()';
}


}

/// @nodoc
class $OrderConfirmationStateCopyWith<$Res>  {
$OrderConfirmationStateCopyWith(OrderConfirmationState _, $Res Function(OrderConfirmationState) __);
}


/// Adds pattern-matching-related methods to [OrderConfirmationState].
extension OrderConfirmationStatePatterns on OrderConfirmationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrderConfirmationInitial value)?  initial,TResult Function( OrderConfirmationLoading value)?  loading,TResult Function( OrderConfirmationLoaded value)?  loaded,TResult Function( OrderConfirmationFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrderConfirmationInitial() when initial != null:
return initial(_that);case OrderConfirmationLoading() when loading != null:
return loading(_that);case OrderConfirmationLoaded() when loaded != null:
return loaded(_that);case OrderConfirmationFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrderConfirmationInitial value)  initial,required TResult Function( OrderConfirmationLoading value)  loading,required TResult Function( OrderConfirmationLoaded value)  loaded,required TResult Function( OrderConfirmationFailure value)  failure,}){
final _that = this;
switch (_that) {
case OrderConfirmationInitial():
return initial(_that);case OrderConfirmationLoading():
return loading(_that);case OrderConfirmationLoaded():
return loaded(_that);case OrderConfirmationFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrderConfirmationInitial value)?  initial,TResult? Function( OrderConfirmationLoading value)?  loading,TResult? Function( OrderConfirmationLoaded value)?  loaded,TResult? Function( OrderConfirmationFailure value)?  failure,}){
final _that = this;
switch (_that) {
case OrderConfirmationInitial() when initial != null:
return initial(_that);case OrderConfirmationLoading() when loading != null:
return loading(_that);case OrderConfirmationLoaded() when loaded != null:
return loaded(_that);case OrderConfirmationFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( OrderEntity order)?  loaded,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrderConfirmationInitial() when initial != null:
return initial();case OrderConfirmationLoading() when loading != null:
return loading();case OrderConfirmationLoaded() when loaded != null:
return loaded(_that.order);case OrderConfirmationFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( OrderEntity order)  loaded,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case OrderConfirmationInitial():
return initial();case OrderConfirmationLoading():
return loading();case OrderConfirmationLoaded():
return loaded(_that.order);case OrderConfirmationFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( OrderEntity order)?  loaded,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case OrderConfirmationInitial() when initial != null:
return initial();case OrderConfirmationLoading() when loading != null:
return loading();case OrderConfirmationLoaded() when loaded != null:
return loaded(_that.order);case OrderConfirmationFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class OrderConfirmationInitial implements OrderConfirmationState {
  const OrderConfirmationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderConfirmationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderConfirmationState.initial()';
}


}




/// @nodoc


class OrderConfirmationLoading implements OrderConfirmationState {
  const OrderConfirmationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderConfirmationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderConfirmationState.loading()';
}


}




/// @nodoc


class OrderConfirmationLoaded implements OrderConfirmationState {
  const OrderConfirmationLoaded(this.order);
  

 final  OrderEntity order;

/// Create a copy of OrderConfirmationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderConfirmationLoadedCopyWith<OrderConfirmationLoaded> get copyWith => _$OrderConfirmationLoadedCopyWithImpl<OrderConfirmationLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderConfirmationLoaded&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'OrderConfirmationState.loaded(order: $order)';
}


}

/// @nodoc
abstract mixin class $OrderConfirmationLoadedCopyWith<$Res> implements $OrderConfirmationStateCopyWith<$Res> {
  factory $OrderConfirmationLoadedCopyWith(OrderConfirmationLoaded value, $Res Function(OrderConfirmationLoaded) _then) = _$OrderConfirmationLoadedCopyWithImpl;
@useResult
$Res call({
 OrderEntity order
});




}
/// @nodoc
class _$OrderConfirmationLoadedCopyWithImpl<$Res>
    implements $OrderConfirmationLoadedCopyWith<$Res> {
  _$OrderConfirmationLoadedCopyWithImpl(this._self, this._then);

  final OrderConfirmationLoaded _self;
  final $Res Function(OrderConfirmationLoaded) _then;

/// Create a copy of OrderConfirmationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,}) {
  return _then(OrderConfirmationLoaded(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderEntity,
  ));
}


}

/// @nodoc


class OrderConfirmationFailure implements OrderConfirmationState {
  const OrderConfirmationFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of OrderConfirmationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderConfirmationFailureCopyWith<OrderConfirmationFailure> get copyWith => _$OrderConfirmationFailureCopyWithImpl<OrderConfirmationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderConfirmationFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'OrderConfirmationState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $OrderConfirmationFailureCopyWith<$Res> implements $OrderConfirmationStateCopyWith<$Res> {
  factory $OrderConfirmationFailureCopyWith(OrderConfirmationFailure value, $Res Function(OrderConfirmationFailure) _then) = _$OrderConfirmationFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$OrderConfirmationFailureCopyWithImpl<$Res>
    implements $OrderConfirmationFailureCopyWith<$Res> {
  _$OrderConfirmationFailureCopyWithImpl(this._self, this._then);

  final OrderConfirmationFailure _self;
  final $Res Function(OrderConfirmationFailure) _then;

/// Create a copy of OrderConfirmationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(OrderConfirmationFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
