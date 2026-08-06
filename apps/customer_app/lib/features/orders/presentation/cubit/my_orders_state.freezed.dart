// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyOrdersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyOrdersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyOrdersState()';
}


}

/// @nodoc
class $MyOrdersStateCopyWith<$Res>  {
$MyOrdersStateCopyWith(MyOrdersState _, $Res Function(MyOrdersState) __);
}


/// Adds pattern-matching-related methods to [MyOrdersState].
extension MyOrdersStatePatterns on MyOrdersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MyOrdersInitial value)?  initial,TResult Function( MyOrdersLoading value)?  loading,TResult Function( MyOrdersLoaded value)?  loaded,TResult Function( MyOrdersFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MyOrdersInitial() when initial != null:
return initial(_that);case MyOrdersLoading() when loading != null:
return loading(_that);case MyOrdersLoaded() when loaded != null:
return loaded(_that);case MyOrdersFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MyOrdersInitial value)  initial,required TResult Function( MyOrdersLoading value)  loading,required TResult Function( MyOrdersLoaded value)  loaded,required TResult Function( MyOrdersFailure value)  failure,}){
final _that = this;
switch (_that) {
case MyOrdersInitial():
return initial(_that);case MyOrdersLoading():
return loading(_that);case MyOrdersLoaded():
return loaded(_that);case MyOrdersFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MyOrdersInitial value)?  initial,TResult? Function( MyOrdersLoading value)?  loading,TResult? Function( MyOrdersLoaded value)?  loaded,TResult? Function( MyOrdersFailure value)?  failure,}){
final _that = this;
switch (_that) {
case MyOrdersInitial() when initial != null:
return initial(_that);case MyOrdersLoading() when loading != null:
return loading(_that);case MyOrdersLoaded() when loaded != null:
return loaded(_that);case MyOrdersFailure() when failure != null:
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
case MyOrdersInitial() when initial != null:
return initial();case MyOrdersLoading() when loading != null:
return loading();case MyOrdersLoaded() when loaded != null:
return loaded(_that.orders);case MyOrdersFailure() when failure != null:
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
case MyOrdersInitial():
return initial();case MyOrdersLoading():
return loading();case MyOrdersLoaded():
return loaded(_that.orders);case MyOrdersFailure():
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
case MyOrdersInitial() when initial != null:
return initial();case MyOrdersLoading() when loading != null:
return loading();case MyOrdersLoaded() when loaded != null:
return loaded(_that.orders);case MyOrdersFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class MyOrdersInitial implements MyOrdersState {
  const MyOrdersInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyOrdersInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyOrdersState.initial()';
}


}




/// @nodoc


class MyOrdersLoading implements MyOrdersState {
  const MyOrdersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyOrdersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MyOrdersState.loading()';
}


}




/// @nodoc


class MyOrdersLoaded implements MyOrdersState {
  const MyOrdersLoaded(final  List<OrderEntity> orders): _orders = orders;
  

 final  List<OrderEntity> _orders;
 List<OrderEntity> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}


/// Create a copy of MyOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyOrdersLoadedCopyWith<MyOrdersLoaded> get copyWith => _$MyOrdersLoadedCopyWithImpl<MyOrdersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyOrdersLoaded&&const DeepCollectionEquality().equals(other._orders, _orders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders));

@override
String toString() {
  return 'MyOrdersState.loaded(orders: $orders)';
}


}

/// @nodoc
abstract mixin class $MyOrdersLoadedCopyWith<$Res> implements $MyOrdersStateCopyWith<$Res> {
  factory $MyOrdersLoadedCopyWith(MyOrdersLoaded value, $Res Function(MyOrdersLoaded) _then) = _$MyOrdersLoadedCopyWithImpl;
@useResult
$Res call({
 List<OrderEntity> orders
});




}
/// @nodoc
class _$MyOrdersLoadedCopyWithImpl<$Res>
    implements $MyOrdersLoadedCopyWith<$Res> {
  _$MyOrdersLoadedCopyWithImpl(this._self, this._then);

  final MyOrdersLoaded _self;
  final $Res Function(MyOrdersLoaded) _then;

/// Create a copy of MyOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,}) {
  return _then(MyOrdersLoaded(
null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderEntity>,
  ));
}


}

/// @nodoc


class MyOrdersFailure implements MyOrdersState {
  const MyOrdersFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of MyOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyOrdersFailureCopyWith<MyOrdersFailure> get copyWith => _$MyOrdersFailureCopyWithImpl<MyOrdersFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyOrdersFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'MyOrdersState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $MyOrdersFailureCopyWith<$Res> implements $MyOrdersStateCopyWith<$Res> {
  factory $MyOrdersFailureCopyWith(MyOrdersFailure value, $Res Function(MyOrdersFailure) _then) = _$MyOrdersFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$MyOrdersFailureCopyWithImpl<$Res>
    implements $MyOrdersFailureCopyWith<$Res> {
  _$MyOrdersFailureCopyWithImpl(this._self, this._then);

  final MyOrdersFailure _self;
  final $Res Function(MyOrdersFailure) _then;

/// Create a copy of MyOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(MyOrdersFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
