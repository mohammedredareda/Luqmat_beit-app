// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeInitial value)?  initial,TResult Function( HomeLoading value)?  loading,TResult Function( HomeLoaded value)?  loaded,TResult Function( HomeFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeInitial() when initial != null:
return initial(_that);case HomeLoading() when loading != null:
return loading(_that);case HomeLoaded() when loaded != null:
return loaded(_that);case HomeFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeInitial value)  initial,required TResult Function( HomeLoading value)  loading,required TResult Function( HomeLoaded value)  loaded,required TResult Function( HomeFailure value)  failure,}){
final _that = this;
switch (_that) {
case HomeInitial():
return initial(_that);case HomeLoading():
return loading(_that);case HomeLoaded():
return loaded(_that);case HomeFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeInitial value)?  initial,TResult? Function( HomeLoading value)?  loading,TResult? Function( HomeLoaded value)?  loaded,TResult? Function( HomeFailure value)?  failure,}){
final _that = this;
switch (_that) {
case HomeInitial() when initial != null:
return initial(_that);case HomeLoading() when loading != null:
return loading(_that);case HomeLoaded() when loaded != null:
return loaded(_that);case HomeFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( HomeFeedEntity feed,  String? selectedCategoryId)?  loaded,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeInitial() when initial != null:
return initial();case HomeLoading() when loading != null:
return loading();case HomeLoaded() when loaded != null:
return loaded(_that.feed,_that.selectedCategoryId);case HomeFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( HomeFeedEntity feed,  String? selectedCategoryId)  loaded,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case HomeInitial():
return initial();case HomeLoading():
return loading();case HomeLoaded():
return loaded(_that.feed,_that.selectedCategoryId);case HomeFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( HomeFeedEntity feed,  String? selectedCategoryId)?  loaded,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case HomeInitial() when initial != null:
return initial();case HomeLoading() when loading != null:
return loading();case HomeLoaded() when loaded != null:
return loaded(_that.feed,_that.selectedCategoryId);case HomeFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class HomeInitial implements HomeState {
  const HomeInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.initial()';
}


}




/// @nodoc


class HomeLoading implements HomeState {
  const HomeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.loading()';
}


}




/// @nodoc


class HomeLoaded implements HomeState {
  const HomeLoaded(this.feed, {this.selectedCategoryId});
  

 final  HomeFeedEntity feed;
 final  String? selectedCategoryId;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeLoadedCopyWith<HomeLoaded> get copyWith => _$HomeLoadedCopyWithImpl<HomeLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLoaded&&(identical(other.feed, feed) || other.feed == feed)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId));
}


@override
int get hashCode => Object.hash(runtimeType,feed,selectedCategoryId);

@override
String toString() {
  return 'HomeState.loaded(feed: $feed, selectedCategoryId: $selectedCategoryId)';
}


}

/// @nodoc
abstract mixin class $HomeLoadedCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeLoadedCopyWith(HomeLoaded value, $Res Function(HomeLoaded) _then) = _$HomeLoadedCopyWithImpl;
@useResult
$Res call({
 HomeFeedEntity feed, String? selectedCategoryId
});




}
/// @nodoc
class _$HomeLoadedCopyWithImpl<$Res>
    implements $HomeLoadedCopyWith<$Res> {
  _$HomeLoadedCopyWithImpl(this._self, this._then);

  final HomeLoaded _self;
  final $Res Function(HomeLoaded) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? feed = null,Object? selectedCategoryId = freezed,}) {
  return _then(HomeLoaded(
null == feed ? _self.feed : feed // ignore: cast_nullable_to_non_nullable
as HomeFeedEntity,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class HomeFailure implements HomeState {
  const HomeFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeFailureCopyWith<HomeFailure> get copyWith => _$HomeFailureCopyWithImpl<HomeFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'HomeState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $HomeFailureCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeFailureCopyWith(HomeFailure value, $Res Function(HomeFailure) _then) = _$HomeFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$HomeFailureCopyWithImpl<$Res>
    implements $HomeFailureCopyWith<$Res> {
  _$HomeFailureCopyWithImpl(this._self, this._then);

  final HomeFailure _self;
  final $Res Function(HomeFailure) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(HomeFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
