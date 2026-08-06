// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderHistoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderHistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderHistoryState()';
}


}

/// @nodoc
class $OrderHistoryStateCopyWith<$Res>  {
$OrderHistoryStateCopyWith(OrderHistoryState _, $Res Function(OrderHistoryState) __);
}


/// Adds pattern-matching-related methods to [OrderHistoryState].
extension OrderHistoryStatePatterns on OrderHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrderHistoryInitial value)?  initial,TResult Function( OrderHistoryLoading value)?  loading,TResult Function( OrderHistoryLoaded value)?  loaded,TResult Function( OrderHistoryFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrderHistoryInitial() when initial != null:
return initial(_that);case OrderHistoryLoading() when loading != null:
return loading(_that);case OrderHistoryLoaded() when loaded != null:
return loaded(_that);case OrderHistoryFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrderHistoryInitial value)  initial,required TResult Function( OrderHistoryLoading value)  loading,required TResult Function( OrderHistoryLoaded value)  loaded,required TResult Function( OrderHistoryFailure value)  failure,}){
final _that = this;
switch (_that) {
case OrderHistoryInitial():
return initial(_that);case OrderHistoryLoading():
return loading(_that);case OrderHistoryLoaded():
return loaded(_that);case OrderHistoryFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrderHistoryInitial value)?  initial,TResult? Function( OrderHistoryLoading value)?  loading,TResult? Function( OrderHistoryLoaded value)?  loaded,TResult? Function( OrderHistoryFailure value)?  failure,}){
final _that = this;
switch (_that) {
case OrderHistoryInitial() when initial != null:
return initial(_that);case OrderHistoryLoading() when loading != null:
return loading(_that);case OrderHistoryLoaded() when loaded != null:
return loaded(_that);case OrderHistoryFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<OrderEntity> orders)?  loaded,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrderHistoryInitial() when initial != null:
return initial();case OrderHistoryLoading() when loading != null:
return loading();case OrderHistoryLoaded() when loaded != null:
return loaded(_that.orders);case OrderHistoryFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<OrderEntity> orders)  loaded,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case OrderHistoryInitial():
return initial();case OrderHistoryLoading():
return loading();case OrderHistoryLoaded():
return loaded(_that.orders);case OrderHistoryFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<OrderEntity> orders)?  loaded,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case OrderHistoryInitial() when initial != null:
return initial();case OrderHistoryLoading() when loading != null:
return loading();case OrderHistoryLoaded() when loaded != null:
return loaded(_that.orders);case OrderHistoryFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class OrderHistoryInitial implements OrderHistoryState {
  const OrderHistoryInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderHistoryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderHistoryState.initial()';
}


}




/// @nodoc


class OrderHistoryLoading implements OrderHistoryState {
  const OrderHistoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderHistoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderHistoryState.loading()';
}


}




/// @nodoc


class OrderHistoryLoaded implements OrderHistoryState {
  const OrderHistoryLoaded(final  List<OrderEntity> orders): _orders = orders;
  

 final  List<OrderEntity> _orders;
 List<OrderEntity> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}


/// Create a copy of OrderHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderHistoryLoadedCopyWith<OrderHistoryLoaded> get copyWith => _$OrderHistoryLoadedCopyWithImpl<OrderHistoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderHistoryLoaded&&const DeepCollectionEquality().equals(other._orders, _orders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders));

@override
String toString() {
  return 'OrderHistoryState.loaded(orders: $orders)';
}


}

/// @nodoc
abstract mixin class $OrderHistoryLoadedCopyWith<$Res> implements $OrderHistoryStateCopyWith<$Res> {
  factory $OrderHistoryLoadedCopyWith(OrderHistoryLoaded value, $Res Function(OrderHistoryLoaded) _then) = _$OrderHistoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<OrderEntity> orders
});




}
/// @nodoc
class _$OrderHistoryLoadedCopyWithImpl<$Res>
    implements $OrderHistoryLoadedCopyWith<$Res> {
  _$OrderHistoryLoadedCopyWithImpl(this._self, this._then);

  final OrderHistoryLoaded _self;
  final $Res Function(OrderHistoryLoaded) _then;

/// Create a copy of OrderHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,}) {
  return _then(OrderHistoryLoaded(
null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderEntity>,
  ));
}


}

/// @nodoc


class OrderHistoryFailure implements OrderHistoryState {
  const OrderHistoryFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of OrderHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderHistoryFailureCopyWith<OrderHistoryFailure> get copyWith => _$OrderHistoryFailureCopyWithImpl<OrderHistoryFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderHistoryFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'OrderHistoryState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $OrderHistoryFailureCopyWith<$Res> implements $OrderHistoryStateCopyWith<$Res> {
  factory $OrderHistoryFailureCopyWith(OrderHistoryFailure value, $Res Function(OrderHistoryFailure) _then) = _$OrderHistoryFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$OrderHistoryFailureCopyWithImpl<$Res>
    implements $OrderHistoryFailureCopyWith<$Res> {
  _$OrderHistoryFailureCopyWithImpl(this._self, this._then);

  final OrderHistoryFailure _self;
  final $Res Function(OrderHistoryFailure) _then;

/// Create a copy of OrderHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(OrderHistoryFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
