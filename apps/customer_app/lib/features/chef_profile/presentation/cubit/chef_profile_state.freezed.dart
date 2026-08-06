// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chef_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChefProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChefProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChefProfileState()';
}


}

/// @nodoc
class $ChefProfileStateCopyWith<$Res>  {
$ChefProfileStateCopyWith(ChefProfileState _, $Res Function(ChefProfileState) __);
}


/// Adds pattern-matching-related methods to [ChefProfileState].
extension ChefProfileStatePatterns on ChefProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChefProfileInitial value)?  initial,TResult Function( ChefProfileLoading value)?  loading,TResult Function( ChefProfileLoaded value)?  loaded,TResult Function( ChefProfileFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChefProfileInitial() when initial != null:
return initial(_that);case ChefProfileLoading() when loading != null:
return loading(_that);case ChefProfileLoaded() when loaded != null:
return loaded(_that);case ChefProfileFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChefProfileInitial value)  initial,required TResult Function( ChefProfileLoading value)  loading,required TResult Function( ChefProfileLoaded value)  loaded,required TResult Function( ChefProfileFailure value)  failure,}){
final _that = this;
switch (_that) {
case ChefProfileInitial():
return initial(_that);case ChefProfileLoading():
return loading(_that);case ChefProfileLoaded():
return loaded(_that);case ChefProfileFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChefProfileInitial value)?  initial,TResult? Function( ChefProfileLoading value)?  loading,TResult? Function( ChefProfileLoaded value)?  loaded,TResult? Function( ChefProfileFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ChefProfileInitial() when initial != null:
return initial(_that);case ChefProfileLoading() when loading != null:
return loading(_that);case ChefProfileLoaded() when loaded != null:
return loaded(_that);case ChefProfileFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ChefProfileEntity profile,  String searchQuery,  String? selectedTag)?  loaded,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChefProfileInitial() when initial != null:
return initial();case ChefProfileLoading() when loading != null:
return loading();case ChefProfileLoaded() when loaded != null:
return loaded(_that.profile,_that.searchQuery,_that.selectedTag);case ChefProfileFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ChefProfileEntity profile,  String searchQuery,  String? selectedTag)  loaded,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case ChefProfileInitial():
return initial();case ChefProfileLoading():
return loading();case ChefProfileLoaded():
return loaded(_that.profile,_that.searchQuery,_that.selectedTag);case ChefProfileFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ChefProfileEntity profile,  String searchQuery,  String? selectedTag)?  loaded,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case ChefProfileInitial() when initial != null:
return initial();case ChefProfileLoading() when loading != null:
return loading();case ChefProfileLoaded() when loaded != null:
return loaded(_that.profile,_that.searchQuery,_that.selectedTag);case ChefProfileFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class ChefProfileInitial implements ChefProfileState {
  const ChefProfileInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChefProfileInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChefProfileState.initial()';
}


}




/// @nodoc


class ChefProfileLoading implements ChefProfileState {
  const ChefProfileLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChefProfileLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChefProfileState.loading()';
}


}




/// @nodoc


class ChefProfileLoaded implements ChefProfileState {
  const ChefProfileLoaded(this.profile, {this.searchQuery = '', this.selectedTag});
  

 final  ChefProfileEntity profile;
@JsonKey() final  String searchQuery;
 final  String? selectedTag;

/// Create a copy of ChefProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChefProfileLoadedCopyWith<ChefProfileLoaded> get copyWith => _$ChefProfileLoadedCopyWithImpl<ChefProfileLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChefProfileLoaded&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedTag, selectedTag) || other.selectedTag == selectedTag));
}


@override
int get hashCode => Object.hash(runtimeType,profile,searchQuery,selectedTag);

@override
String toString() {
  return 'ChefProfileState.loaded(profile: $profile, searchQuery: $searchQuery, selectedTag: $selectedTag)';
}


}

/// @nodoc
abstract mixin class $ChefProfileLoadedCopyWith<$Res> implements $ChefProfileStateCopyWith<$Res> {
  factory $ChefProfileLoadedCopyWith(ChefProfileLoaded value, $Res Function(ChefProfileLoaded) _then) = _$ChefProfileLoadedCopyWithImpl;
@useResult
$Res call({
 ChefProfileEntity profile, String searchQuery, String? selectedTag
});




}
/// @nodoc
class _$ChefProfileLoadedCopyWithImpl<$Res>
    implements $ChefProfileLoadedCopyWith<$Res> {
  _$ChefProfileLoadedCopyWithImpl(this._self, this._then);

  final ChefProfileLoaded _self;
  final $Res Function(ChefProfileLoaded) _then;

/// Create a copy of ChefProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? searchQuery = null,Object? selectedTag = freezed,}) {
  return _then(ChefProfileLoaded(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ChefProfileEntity,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedTag: freezed == selectedTag ? _self.selectedTag : selectedTag // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ChefProfileFailure implements ChefProfileState {
  const ChefProfileFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of ChefProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChefProfileFailureCopyWith<ChefProfileFailure> get copyWith => _$ChefProfileFailureCopyWithImpl<ChefProfileFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChefProfileFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'ChefProfileState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $ChefProfileFailureCopyWith<$Res> implements $ChefProfileStateCopyWith<$Res> {
  factory $ChefProfileFailureCopyWith(ChefProfileFailure value, $Res Function(ChefProfileFailure) _then) = _$ChefProfileFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$ChefProfileFailureCopyWithImpl<$Res>
    implements $ChefProfileFailureCopyWith<$Res> {
  _$ChefProfileFailureCopyWithImpl(this._self, this._then);

  final ChefProfileFailure _self;
  final $Res Function(ChefProfileFailure) _then;

/// Create a copy of ChefProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(ChefProfileFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
