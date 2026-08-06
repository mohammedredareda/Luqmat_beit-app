// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_follows_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoritesFollowsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesFollowsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesFollowsState()';
}


}

/// @nodoc
class $FavoritesFollowsStateCopyWith<$Res>  {
$FavoritesFollowsStateCopyWith(FavoritesFollowsState _, $Res Function(FavoritesFollowsState) __);
}


/// Adds pattern-matching-related methods to [FavoritesFollowsState].
extension FavoritesFollowsStatePatterns on FavoritesFollowsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FavoritesFollowsInitial value)?  initial,TResult Function( FavoritesFollowsLoading value)?  loading,TResult Function( FavoritesFollowsLoaded value)?  loaded,TResult Function( FavoritesFollowsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FavoritesFollowsInitial() when initial != null:
return initial(_that);case FavoritesFollowsLoading() when loading != null:
return loading(_that);case FavoritesFollowsLoaded() when loaded != null:
return loaded(_that);case FavoritesFollowsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FavoritesFollowsInitial value)  initial,required TResult Function( FavoritesFollowsLoading value)  loading,required TResult Function( FavoritesFollowsLoaded value)  loaded,required TResult Function( FavoritesFollowsFailure value)  failure,}){
final _that = this;
switch (_that) {
case FavoritesFollowsInitial():
return initial(_that);case FavoritesFollowsLoading():
return loading(_that);case FavoritesFollowsLoaded():
return loaded(_that);case FavoritesFollowsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FavoritesFollowsInitial value)?  initial,TResult? Function( FavoritesFollowsLoading value)?  loading,TResult? Function( FavoritesFollowsLoaded value)?  loaded,TResult? Function( FavoritesFollowsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case FavoritesFollowsInitial() when initial != null:
return initial(_that);case FavoritesFollowsLoading() when loading != null:
return loading(_that);case FavoritesFollowsLoaded() when loaded != null:
return loaded(_that);case FavoritesFollowsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<MealEntity> meals,  List<ChefSummaryEntity> chefs,  FavoritesTab activeTab)?  loaded,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FavoritesFollowsInitial() when initial != null:
return initial();case FavoritesFollowsLoading() when loading != null:
return loading();case FavoritesFollowsLoaded() when loaded != null:
return loaded(_that.meals,_that.chefs,_that.activeTab);case FavoritesFollowsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<MealEntity> meals,  List<ChefSummaryEntity> chefs,  FavoritesTab activeTab)  loaded,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case FavoritesFollowsInitial():
return initial();case FavoritesFollowsLoading():
return loading();case FavoritesFollowsLoaded():
return loaded(_that.meals,_that.chefs,_that.activeTab);case FavoritesFollowsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<MealEntity> meals,  List<ChefSummaryEntity> chefs,  FavoritesTab activeTab)?  loaded,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case FavoritesFollowsInitial() when initial != null:
return initial();case FavoritesFollowsLoading() when loading != null:
return loading();case FavoritesFollowsLoaded() when loaded != null:
return loaded(_that.meals,_that.chefs,_that.activeTab);case FavoritesFollowsFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class FavoritesFollowsInitial implements FavoritesFollowsState {
  const FavoritesFollowsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesFollowsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesFollowsState.initial()';
}


}




/// @nodoc


class FavoritesFollowsLoading implements FavoritesFollowsState {
  const FavoritesFollowsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesFollowsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesFollowsState.loading()';
}


}




/// @nodoc


class FavoritesFollowsLoaded implements FavoritesFollowsState {
  const FavoritesFollowsLoaded(final  List<MealEntity> meals, final  List<ChefSummaryEntity> chefs, this.activeTab): _meals = meals,_chefs = chefs;
  

 final  List<MealEntity> _meals;
 List<MealEntity> get meals {
  if (_meals is EqualUnmodifiableListView) return _meals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meals);
}

 final  List<ChefSummaryEntity> _chefs;
 List<ChefSummaryEntity> get chefs {
  if (_chefs is EqualUnmodifiableListView) return _chefs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chefs);
}

 final  FavoritesTab activeTab;

/// Create a copy of FavoritesFollowsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesFollowsLoadedCopyWith<FavoritesFollowsLoaded> get copyWith => _$FavoritesFollowsLoadedCopyWithImpl<FavoritesFollowsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesFollowsLoaded&&const DeepCollectionEquality().equals(other._meals, _meals)&&const DeepCollectionEquality().equals(other._chefs, _chefs)&&(identical(other.activeTab, activeTab) || other.activeTab == activeTab));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_meals),const DeepCollectionEquality().hash(_chefs),activeTab);

@override
String toString() {
  return 'FavoritesFollowsState.loaded(meals: $meals, chefs: $chefs, activeTab: $activeTab)';
}


}

/// @nodoc
abstract mixin class $FavoritesFollowsLoadedCopyWith<$Res> implements $FavoritesFollowsStateCopyWith<$Res> {
  factory $FavoritesFollowsLoadedCopyWith(FavoritesFollowsLoaded value, $Res Function(FavoritesFollowsLoaded) _then) = _$FavoritesFollowsLoadedCopyWithImpl;
@useResult
$Res call({
 List<MealEntity> meals, List<ChefSummaryEntity> chefs, FavoritesTab activeTab
});




}
/// @nodoc
class _$FavoritesFollowsLoadedCopyWithImpl<$Res>
    implements $FavoritesFollowsLoadedCopyWith<$Res> {
  _$FavoritesFollowsLoadedCopyWithImpl(this._self, this._then);

  final FavoritesFollowsLoaded _self;
  final $Res Function(FavoritesFollowsLoaded) _then;

/// Create a copy of FavoritesFollowsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? meals = null,Object? chefs = null,Object? activeTab = null,}) {
  return _then(FavoritesFollowsLoaded(
null == meals ? _self._meals : meals // ignore: cast_nullable_to_non_nullable
as List<MealEntity>,null == chefs ? _self._chefs : chefs // ignore: cast_nullable_to_non_nullable
as List<ChefSummaryEntity>,null == activeTab ? _self.activeTab : activeTab // ignore: cast_nullable_to_non_nullable
as FavoritesTab,
  ));
}


}

/// @nodoc


class FavoritesFollowsFailure implements FavoritesFollowsState {
  const FavoritesFollowsFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of FavoritesFollowsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesFollowsFailureCopyWith<FavoritesFollowsFailure> get copyWith => _$FavoritesFollowsFailureCopyWithImpl<FavoritesFollowsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesFollowsFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'FavoritesFollowsState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $FavoritesFollowsFailureCopyWith<$Res> implements $FavoritesFollowsStateCopyWith<$Res> {
  factory $FavoritesFollowsFailureCopyWith(FavoritesFollowsFailure value, $Res Function(FavoritesFollowsFailure) _then) = _$FavoritesFollowsFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$FavoritesFollowsFailureCopyWithImpl<$Res>
    implements $FavoritesFollowsFailureCopyWith<$Res> {
  _$FavoritesFollowsFailureCopyWithImpl(this._self, this._then);

  final FavoritesFollowsFailure _self;
  final $Res Function(FavoritesFollowsFailure) _then;

/// Create a copy of FavoritesFollowsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(FavoritesFollowsFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
