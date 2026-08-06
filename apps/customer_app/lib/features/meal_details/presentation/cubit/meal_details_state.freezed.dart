// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MealDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MealDetailsState()';
}


}

/// @nodoc
class $MealDetailsStateCopyWith<$Res>  {
$MealDetailsStateCopyWith(MealDetailsState _, $Res Function(MealDetailsState) __);
}


/// Adds pattern-matching-related methods to [MealDetailsState].
extension MealDetailsStatePatterns on MealDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MealDetailsInitial value)?  initial,TResult Function( MealDetailsLoading value)?  loading,TResult Function( MealDetailsLoaded value)?  loaded,TResult Function( MealDetailsAddedToCart value)?  addedToCart,TResult Function( MealDetailsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MealDetailsInitial() when initial != null:
return initial(_that);case MealDetailsLoading() when loading != null:
return loading(_that);case MealDetailsLoaded() when loaded != null:
return loaded(_that);case MealDetailsAddedToCart() when addedToCart != null:
return addedToCart(_that);case MealDetailsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MealDetailsInitial value)  initial,required TResult Function( MealDetailsLoading value)  loading,required TResult Function( MealDetailsLoaded value)  loaded,required TResult Function( MealDetailsAddedToCart value)  addedToCart,required TResult Function( MealDetailsFailure value)  failure,}){
final _that = this;
switch (_that) {
case MealDetailsInitial():
return initial(_that);case MealDetailsLoading():
return loading(_that);case MealDetailsLoaded():
return loaded(_that);case MealDetailsAddedToCart():
return addedToCart(_that);case MealDetailsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MealDetailsInitial value)?  initial,TResult? Function( MealDetailsLoading value)?  loading,TResult? Function( MealDetailsLoaded value)?  loaded,TResult? Function( MealDetailsAddedToCart value)?  addedToCart,TResult? Function( MealDetailsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case MealDetailsInitial() when initial != null:
return initial(_that);case MealDetailsLoading() when loading != null:
return loading(_that);case MealDetailsLoaded() when loaded != null:
return loaded(_that);case MealDetailsAddedToCart() when addedToCart != null:
return addedToCart(_that);case MealDetailsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( MealEntity meal,  String selectedSellingOptionId,  int quantity,  String note,  bool isFavorite)?  loaded,TResult Function( MealEntity meal,  String selectedSellingOptionId,  int quantity,  String note,  bool isFavorite)?  addedToCart,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MealDetailsInitial() when initial != null:
return initial();case MealDetailsLoading() when loading != null:
return loading();case MealDetailsLoaded() when loaded != null:
return loaded(_that.meal,_that.selectedSellingOptionId,_that.quantity,_that.note,_that.isFavorite);case MealDetailsAddedToCart() when addedToCart != null:
return addedToCart(_that.meal,_that.selectedSellingOptionId,_that.quantity,_that.note,_that.isFavorite);case MealDetailsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( MealEntity meal,  String selectedSellingOptionId,  int quantity,  String note,  bool isFavorite)  loaded,required TResult Function( MealEntity meal,  String selectedSellingOptionId,  int quantity,  String note,  bool isFavorite)  addedToCart,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case MealDetailsInitial():
return initial();case MealDetailsLoading():
return loading();case MealDetailsLoaded():
return loaded(_that.meal,_that.selectedSellingOptionId,_that.quantity,_that.note,_that.isFavorite);case MealDetailsAddedToCart():
return addedToCart(_that.meal,_that.selectedSellingOptionId,_that.quantity,_that.note,_that.isFavorite);case MealDetailsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( MealEntity meal,  String selectedSellingOptionId,  int quantity,  String note,  bool isFavorite)?  loaded,TResult? Function( MealEntity meal,  String selectedSellingOptionId,  int quantity,  String note,  bool isFavorite)?  addedToCart,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case MealDetailsInitial() when initial != null:
return initial();case MealDetailsLoading() when loading != null:
return loading();case MealDetailsLoaded() when loaded != null:
return loaded(_that.meal,_that.selectedSellingOptionId,_that.quantity,_that.note,_that.isFavorite);case MealDetailsAddedToCart() when addedToCart != null:
return addedToCart(_that.meal,_that.selectedSellingOptionId,_that.quantity,_that.note,_that.isFavorite);case MealDetailsFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class MealDetailsInitial implements MealDetailsState {
  const MealDetailsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealDetailsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MealDetailsState.initial()';
}


}




/// @nodoc


class MealDetailsLoading implements MealDetailsState {
  const MealDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MealDetailsState.loading()';
}


}




/// @nodoc


class MealDetailsLoaded implements MealDetailsState {
  const MealDetailsLoaded({required this.meal, required this.selectedSellingOptionId, this.quantity = 1, this.note = '', this.isFavorite = false});
  

 final  MealEntity meal;
 final  String selectedSellingOptionId;
@JsonKey() final  int quantity;
@JsonKey() final  String note;
@JsonKey() final  bool isFavorite;

/// Create a copy of MealDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealDetailsLoadedCopyWith<MealDetailsLoaded> get copyWith => _$MealDetailsLoadedCopyWithImpl<MealDetailsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealDetailsLoaded&&(identical(other.meal, meal) || other.meal == meal)&&(identical(other.selectedSellingOptionId, selectedSellingOptionId) || other.selectedSellingOptionId == selectedSellingOptionId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.note, note) || other.note == note)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}


@override
int get hashCode => Object.hash(runtimeType,meal,selectedSellingOptionId,quantity,note,isFavorite);

@override
String toString() {
  return 'MealDetailsState.loaded(meal: $meal, selectedSellingOptionId: $selectedSellingOptionId, quantity: $quantity, note: $note, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $MealDetailsLoadedCopyWith<$Res> implements $MealDetailsStateCopyWith<$Res> {
  factory $MealDetailsLoadedCopyWith(MealDetailsLoaded value, $Res Function(MealDetailsLoaded) _then) = _$MealDetailsLoadedCopyWithImpl;
@useResult
$Res call({
 MealEntity meal, String selectedSellingOptionId, int quantity, String note, bool isFavorite
});




}
/// @nodoc
class _$MealDetailsLoadedCopyWithImpl<$Res>
    implements $MealDetailsLoadedCopyWith<$Res> {
  _$MealDetailsLoadedCopyWithImpl(this._self, this._then);

  final MealDetailsLoaded _self;
  final $Res Function(MealDetailsLoaded) _then;

/// Create a copy of MealDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? meal = null,Object? selectedSellingOptionId = null,Object? quantity = null,Object? note = null,Object? isFavorite = null,}) {
  return _then(MealDetailsLoaded(
meal: null == meal ? _self.meal : meal // ignore: cast_nullable_to_non_nullable
as MealEntity,selectedSellingOptionId: null == selectedSellingOptionId ? _self.selectedSellingOptionId : selectedSellingOptionId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class MealDetailsAddedToCart implements MealDetailsState {
  const MealDetailsAddedToCart({required this.meal, required this.selectedSellingOptionId, this.quantity = 1, this.note = '', this.isFavorite = false});
  

 final  MealEntity meal;
 final  String selectedSellingOptionId;
@JsonKey() final  int quantity;
@JsonKey() final  String note;
@JsonKey() final  bool isFavorite;

/// Create a copy of MealDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealDetailsAddedToCartCopyWith<MealDetailsAddedToCart> get copyWith => _$MealDetailsAddedToCartCopyWithImpl<MealDetailsAddedToCart>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealDetailsAddedToCart&&(identical(other.meal, meal) || other.meal == meal)&&(identical(other.selectedSellingOptionId, selectedSellingOptionId) || other.selectedSellingOptionId == selectedSellingOptionId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.note, note) || other.note == note)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}


@override
int get hashCode => Object.hash(runtimeType,meal,selectedSellingOptionId,quantity,note,isFavorite);

@override
String toString() {
  return 'MealDetailsState.addedToCart(meal: $meal, selectedSellingOptionId: $selectedSellingOptionId, quantity: $quantity, note: $note, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $MealDetailsAddedToCartCopyWith<$Res> implements $MealDetailsStateCopyWith<$Res> {
  factory $MealDetailsAddedToCartCopyWith(MealDetailsAddedToCart value, $Res Function(MealDetailsAddedToCart) _then) = _$MealDetailsAddedToCartCopyWithImpl;
@useResult
$Res call({
 MealEntity meal, String selectedSellingOptionId, int quantity, String note, bool isFavorite
});




}
/// @nodoc
class _$MealDetailsAddedToCartCopyWithImpl<$Res>
    implements $MealDetailsAddedToCartCopyWith<$Res> {
  _$MealDetailsAddedToCartCopyWithImpl(this._self, this._then);

  final MealDetailsAddedToCart _self;
  final $Res Function(MealDetailsAddedToCart) _then;

/// Create a copy of MealDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? meal = null,Object? selectedSellingOptionId = null,Object? quantity = null,Object? note = null,Object? isFavorite = null,}) {
  return _then(MealDetailsAddedToCart(
meal: null == meal ? _self.meal : meal // ignore: cast_nullable_to_non_nullable
as MealEntity,selectedSellingOptionId: null == selectedSellingOptionId ? _self.selectedSellingOptionId : selectedSellingOptionId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class MealDetailsFailure implements MealDetailsState {
  const MealDetailsFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of MealDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealDetailsFailureCopyWith<MealDetailsFailure> get copyWith => _$MealDetailsFailureCopyWithImpl<MealDetailsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealDetailsFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'MealDetailsState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $MealDetailsFailureCopyWith<$Res> implements $MealDetailsStateCopyWith<$Res> {
  factory $MealDetailsFailureCopyWith(MealDetailsFailure value, $Res Function(MealDetailsFailure) _then) = _$MealDetailsFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$MealDetailsFailureCopyWithImpl<$Res>
    implements $MealDetailsFailureCopyWith<$Res> {
  _$MealDetailsFailureCopyWithImpl(this._self, this._then);

  final MealDetailsFailure _self;
  final $Res Function(MealDetailsFailure) _then;

/// Create a copy of MealDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(MealDetailsFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
