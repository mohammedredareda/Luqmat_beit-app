// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shopping_cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShoppingCartState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingCartState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShoppingCartState()';
}


}

/// @nodoc
class $ShoppingCartStateCopyWith<$Res>  {
$ShoppingCartStateCopyWith(ShoppingCartState _, $Res Function(ShoppingCartState) __);
}


/// Adds pattern-matching-related methods to [ShoppingCartState].
extension ShoppingCartStatePatterns on ShoppingCartState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ShoppingCartInitial value)?  initial,TResult Function( ShoppingCartLoading value)?  loading,TResult Function( ShoppingCartLoaded value)?  loaded,TResult Function( ShoppingCartEmpty value)?  empty,TResult Function( ShoppingCartFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ShoppingCartInitial() when initial != null:
return initial(_that);case ShoppingCartLoading() when loading != null:
return loading(_that);case ShoppingCartLoaded() when loaded != null:
return loaded(_that);case ShoppingCartEmpty() when empty != null:
return empty(_that);case ShoppingCartFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ShoppingCartInitial value)  initial,required TResult Function( ShoppingCartLoading value)  loading,required TResult Function( ShoppingCartLoaded value)  loaded,required TResult Function( ShoppingCartEmpty value)  empty,required TResult Function( ShoppingCartFailure value)  failure,}){
final _that = this;
switch (_that) {
case ShoppingCartInitial():
return initial(_that);case ShoppingCartLoading():
return loading(_that);case ShoppingCartLoaded():
return loaded(_that);case ShoppingCartEmpty():
return empty(_that);case ShoppingCartFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ShoppingCartInitial value)?  initial,TResult? Function( ShoppingCartLoading value)?  loading,TResult? Function( ShoppingCartLoaded value)?  loaded,TResult? Function( ShoppingCartEmpty value)?  empty,TResult? Function( ShoppingCartFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ShoppingCartInitial() when initial != null:
return initial(_that);case ShoppingCartLoading() when loading != null:
return loading(_that);case ShoppingCartLoaded() when loaded != null:
return loaded(_that);case ShoppingCartEmpty() when empty != null:
return empty(_that);case ShoppingCartFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CartItemEntity> items,  double subtotal,  double deliveryFee)?  loaded,TResult Function()?  empty,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ShoppingCartInitial() when initial != null:
return initial();case ShoppingCartLoading() when loading != null:
return loading();case ShoppingCartLoaded() when loaded != null:
return loaded(_that.items,_that.subtotal,_that.deliveryFee);case ShoppingCartEmpty() when empty != null:
return empty();case ShoppingCartFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CartItemEntity> items,  double subtotal,  double deliveryFee)  loaded,required TResult Function()  empty,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case ShoppingCartInitial():
return initial();case ShoppingCartLoading():
return loading();case ShoppingCartLoaded():
return loaded(_that.items,_that.subtotal,_that.deliveryFee);case ShoppingCartEmpty():
return empty();case ShoppingCartFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CartItemEntity> items,  double subtotal,  double deliveryFee)?  loaded,TResult? Function()?  empty,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case ShoppingCartInitial() when initial != null:
return initial();case ShoppingCartLoading() when loading != null:
return loading();case ShoppingCartLoaded() when loaded != null:
return loaded(_that.items,_that.subtotal,_that.deliveryFee);case ShoppingCartEmpty() when empty != null:
return empty();case ShoppingCartFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class ShoppingCartInitial implements ShoppingCartState {
  const ShoppingCartInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingCartInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShoppingCartState.initial()';
}


}




/// @nodoc


class ShoppingCartLoading implements ShoppingCartState {
  const ShoppingCartLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingCartLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShoppingCartState.loading()';
}


}




/// @nodoc


class ShoppingCartLoaded implements ShoppingCartState {
  const ShoppingCartLoaded(final  List<CartItemEntity> items, {required this.subtotal, required this.deliveryFee}): _items = items;
  

 final  List<CartItemEntity> _items;
 List<CartItemEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  double subtotal;
 final  double deliveryFee;

/// Create a copy of ShoppingCartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShoppingCartLoadedCopyWith<ShoppingCartLoaded> get copyWith => _$ShoppingCartLoadedCopyWithImpl<ShoppingCartLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingCartLoaded&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),subtotal,deliveryFee);

@override
String toString() {
  return 'ShoppingCartState.loaded(items: $items, subtotal: $subtotal, deliveryFee: $deliveryFee)';
}


}

/// @nodoc
abstract mixin class $ShoppingCartLoadedCopyWith<$Res> implements $ShoppingCartStateCopyWith<$Res> {
  factory $ShoppingCartLoadedCopyWith(ShoppingCartLoaded value, $Res Function(ShoppingCartLoaded) _then) = _$ShoppingCartLoadedCopyWithImpl;
@useResult
$Res call({
 List<CartItemEntity> items, double subtotal, double deliveryFee
});




}
/// @nodoc
class _$ShoppingCartLoadedCopyWithImpl<$Res>
    implements $ShoppingCartLoadedCopyWith<$Res> {
  _$ShoppingCartLoadedCopyWithImpl(this._self, this._then);

  final ShoppingCartLoaded _self;
  final $Res Function(ShoppingCartLoaded) _then;

/// Create a copy of ShoppingCartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? subtotal = null,Object? deliveryFee = null,}) {
  return _then(ShoppingCartLoaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemEntity>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class ShoppingCartEmpty implements ShoppingCartState {
  const ShoppingCartEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingCartEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShoppingCartState.empty()';
}


}




/// @nodoc


class ShoppingCartFailure implements ShoppingCartState {
  const ShoppingCartFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of ShoppingCartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShoppingCartFailureCopyWith<ShoppingCartFailure> get copyWith => _$ShoppingCartFailureCopyWithImpl<ShoppingCartFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingCartFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'ShoppingCartState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $ShoppingCartFailureCopyWith<$Res> implements $ShoppingCartStateCopyWith<$Res> {
  factory $ShoppingCartFailureCopyWith(ShoppingCartFailure value, $Res Function(ShoppingCartFailure) _then) = _$ShoppingCartFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$ShoppingCartFailureCopyWithImpl<$Res>
    implements $ShoppingCartFailureCopyWith<$Res> {
  _$ShoppingCartFailureCopyWithImpl(this._self, this._then);

  final ShoppingCartFailure _self;
  final $Res Function(ShoppingCartFailure) _then;

/// Create a copy of ShoppingCartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(ShoppingCartFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
