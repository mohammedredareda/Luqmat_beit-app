// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_rating_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MealRatingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealRatingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MealRatingState()';
}


}

/// @nodoc
class $MealRatingStateCopyWith<$Res>  {
$MealRatingStateCopyWith(MealRatingState _, $Res Function(MealRatingState) __);
}


/// Adds pattern-matching-related methods to [MealRatingState].
extension MealRatingStatePatterns on MealRatingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MealRatingInitial value)?  initial,TResult Function( MealRatingLoading value)?  loading,TResult Function( MealRatingLoaded value)?  loaded,TResult Function( MealRatingSubmitted value)?  submitted,TResult Function( MealRatingFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MealRatingInitial() when initial != null:
return initial(_that);case MealRatingLoading() when loading != null:
return loading(_that);case MealRatingLoaded() when loaded != null:
return loaded(_that);case MealRatingSubmitted() when submitted != null:
return submitted(_that);case MealRatingFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MealRatingInitial value)  initial,required TResult Function( MealRatingLoading value)  loading,required TResult Function( MealRatingLoaded value)  loaded,required TResult Function( MealRatingSubmitted value)  submitted,required TResult Function( MealRatingFailure value)  failure,}){
final _that = this;
switch (_that) {
case MealRatingInitial():
return initial(_that);case MealRatingLoading():
return loading(_that);case MealRatingLoaded():
return loaded(_that);case MealRatingSubmitted():
return submitted(_that);case MealRatingFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MealRatingInitial value)?  initial,TResult? Function( MealRatingLoading value)?  loading,TResult? Function( MealRatingLoaded value)?  loaded,TResult? Function( MealRatingSubmitted value)?  submitted,TResult? Function( MealRatingFailure value)?  failure,}){
final _that = this;
switch (_that) {
case MealRatingInitial() when initial != null:
return initial(_that);case MealRatingLoading() when loading != null:
return loading(_that);case MealRatingLoaded() when loaded != null:
return loaded(_that);case MealRatingSubmitted() when submitted != null:
return submitted(_that);case MealRatingFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( OrderEntity order,  int stars,  String review,  bool isSubmitting,  AppException? submitError)?  loaded,TResult Function()?  submitted,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MealRatingInitial() when initial != null:
return initial();case MealRatingLoading() when loading != null:
return loading();case MealRatingLoaded() when loaded != null:
return loaded(_that.order,_that.stars,_that.review,_that.isSubmitting,_that.submitError);case MealRatingSubmitted() when submitted != null:
return submitted();case MealRatingFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( OrderEntity order,  int stars,  String review,  bool isSubmitting,  AppException? submitError)  loaded,required TResult Function()  submitted,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case MealRatingInitial():
return initial();case MealRatingLoading():
return loading();case MealRatingLoaded():
return loaded(_that.order,_that.stars,_that.review,_that.isSubmitting,_that.submitError);case MealRatingSubmitted():
return submitted();case MealRatingFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( OrderEntity order,  int stars,  String review,  bool isSubmitting,  AppException? submitError)?  loaded,TResult? Function()?  submitted,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case MealRatingInitial() when initial != null:
return initial();case MealRatingLoading() when loading != null:
return loading();case MealRatingLoaded() when loaded != null:
return loaded(_that.order,_that.stars,_that.review,_that.isSubmitting,_that.submitError);case MealRatingSubmitted() when submitted != null:
return submitted();case MealRatingFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class MealRatingInitial implements MealRatingState {
  const MealRatingInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealRatingInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MealRatingState.initial()';
}


}




/// @nodoc


class MealRatingLoading implements MealRatingState {
  const MealRatingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealRatingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MealRatingState.loading()';
}


}




/// @nodoc


class MealRatingLoaded implements MealRatingState {
  const MealRatingLoaded({required this.order, this.stars = 0, this.review = '', this.isSubmitting = false, this.submitError});
  

 final  OrderEntity order;
@JsonKey() final  int stars;
@JsonKey() final  String review;
@JsonKey() final  bool isSubmitting;
 final  AppException? submitError;

/// Create a copy of MealRatingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealRatingLoadedCopyWith<MealRatingLoaded> get copyWith => _$MealRatingLoadedCopyWithImpl<MealRatingLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealRatingLoaded&&(identical(other.order, order) || other.order == order)&&(identical(other.stars, stars) || other.stars == stars)&&(identical(other.review, review) || other.review == review)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.submitError, submitError) || other.submitError == submitError));
}


@override
int get hashCode => Object.hash(runtimeType,order,stars,review,isSubmitting,submitError);

@override
String toString() {
  return 'MealRatingState.loaded(order: $order, stars: $stars, review: $review, isSubmitting: $isSubmitting, submitError: $submitError)';
}


}

/// @nodoc
abstract mixin class $MealRatingLoadedCopyWith<$Res> implements $MealRatingStateCopyWith<$Res> {
  factory $MealRatingLoadedCopyWith(MealRatingLoaded value, $Res Function(MealRatingLoaded) _then) = _$MealRatingLoadedCopyWithImpl;
@useResult
$Res call({
 OrderEntity order, int stars, String review, bool isSubmitting, AppException? submitError
});




}
/// @nodoc
class _$MealRatingLoadedCopyWithImpl<$Res>
    implements $MealRatingLoadedCopyWith<$Res> {
  _$MealRatingLoadedCopyWithImpl(this._self, this._then);

  final MealRatingLoaded _self;
  final $Res Function(MealRatingLoaded) _then;

/// Create a copy of MealRatingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,Object? stars = null,Object? review = null,Object? isSubmitting = null,Object? submitError = freezed,}) {
  return _then(MealRatingLoaded(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderEntity,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,submitError: freezed == submitError ? _self.submitError : submitError // ignore: cast_nullable_to_non_nullable
as AppException?,
  ));
}


}

/// @nodoc


class MealRatingSubmitted implements MealRatingState {
  const MealRatingSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealRatingSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MealRatingState.submitted()';
}


}




/// @nodoc


class MealRatingFailure implements MealRatingState {
  const MealRatingFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of MealRatingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealRatingFailureCopyWith<MealRatingFailure> get copyWith => _$MealRatingFailureCopyWithImpl<MealRatingFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MealRatingFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'MealRatingState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $MealRatingFailureCopyWith<$Res> implements $MealRatingStateCopyWith<$Res> {
  factory $MealRatingFailureCopyWith(MealRatingFailure value, $Res Function(MealRatingFailure) _then) = _$MealRatingFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$MealRatingFailureCopyWithImpl<$Res>
    implements $MealRatingFailureCopyWith<$Res> {
  _$MealRatingFailureCopyWithImpl(this._self, this._then);

  final MealRatingFailure _self;
  final $Res Function(MealRatingFailure) _then;

/// Create a copy of MealRatingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(MealRatingFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
