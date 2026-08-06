// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shorts_feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShortsFeedState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShortsFeedState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShortsFeedState()';
}


}

/// @nodoc
class $ShortsFeedStateCopyWith<$Res>  {
$ShortsFeedStateCopyWith(ShortsFeedState _, $Res Function(ShortsFeedState) __);
}


/// Adds pattern-matching-related methods to [ShortsFeedState].
extension ShortsFeedStatePatterns on ShortsFeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ShortsFeedInitial value)?  initial,TResult Function( ShortsFeedLoading value)?  loading,TResult Function( ShortsFeedLoaded value)?  loaded,TResult Function( ShortsFeedFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ShortsFeedInitial() when initial != null:
return initial(_that);case ShortsFeedLoading() when loading != null:
return loading(_that);case ShortsFeedLoaded() when loaded != null:
return loaded(_that);case ShortsFeedFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ShortsFeedInitial value)  initial,required TResult Function( ShortsFeedLoading value)  loading,required TResult Function( ShortsFeedLoaded value)  loaded,required TResult Function( ShortsFeedFailure value)  failure,}){
final _that = this;
switch (_that) {
case ShortsFeedInitial():
return initial(_that);case ShortsFeedLoading():
return loading(_that);case ShortsFeedLoaded():
return loaded(_that);case ShortsFeedFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ShortsFeedInitial value)?  initial,TResult? Function( ShortsFeedLoading value)?  loading,TResult? Function( ShortsFeedLoaded value)?  loaded,TResult? Function( ShortsFeedFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ShortsFeedInitial() when initial != null:
return initial(_that);case ShortsFeedLoading() when loading != null:
return loading(_that);case ShortsFeedLoaded() when loaded != null:
return loaded(_that);case ShortsFeedFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ShortEntity> shorts)?  loaded,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ShortsFeedInitial() when initial != null:
return initial();case ShortsFeedLoading() when loading != null:
return loading();case ShortsFeedLoaded() when loaded != null:
return loaded(_that.shorts);case ShortsFeedFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ShortEntity> shorts)  loaded,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case ShortsFeedInitial():
return initial();case ShortsFeedLoading():
return loading();case ShortsFeedLoaded():
return loaded(_that.shorts);case ShortsFeedFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ShortEntity> shorts)?  loaded,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case ShortsFeedInitial() when initial != null:
return initial();case ShortsFeedLoading() when loading != null:
return loading();case ShortsFeedLoaded() when loaded != null:
return loaded(_that.shorts);case ShortsFeedFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class ShortsFeedInitial implements ShortsFeedState {
  const ShortsFeedInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShortsFeedInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShortsFeedState.initial()';
}


}




/// @nodoc


class ShortsFeedLoading implements ShortsFeedState {
  const ShortsFeedLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShortsFeedLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShortsFeedState.loading()';
}


}




/// @nodoc


class ShortsFeedLoaded implements ShortsFeedState {
  const ShortsFeedLoaded(final  List<ShortEntity> shorts): _shorts = shorts;
  

 final  List<ShortEntity> _shorts;
 List<ShortEntity> get shorts {
  if (_shorts is EqualUnmodifiableListView) return _shorts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shorts);
}


/// Create a copy of ShortsFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShortsFeedLoadedCopyWith<ShortsFeedLoaded> get copyWith => _$ShortsFeedLoadedCopyWithImpl<ShortsFeedLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShortsFeedLoaded&&const DeepCollectionEquality().equals(other._shorts, _shorts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_shorts));

@override
String toString() {
  return 'ShortsFeedState.loaded(shorts: $shorts)';
}


}

/// @nodoc
abstract mixin class $ShortsFeedLoadedCopyWith<$Res> implements $ShortsFeedStateCopyWith<$Res> {
  factory $ShortsFeedLoadedCopyWith(ShortsFeedLoaded value, $Res Function(ShortsFeedLoaded) _then) = _$ShortsFeedLoadedCopyWithImpl;
@useResult
$Res call({
 List<ShortEntity> shorts
});




}
/// @nodoc
class _$ShortsFeedLoadedCopyWithImpl<$Res>
    implements $ShortsFeedLoadedCopyWith<$Res> {
  _$ShortsFeedLoadedCopyWithImpl(this._self, this._then);

  final ShortsFeedLoaded _self;
  final $Res Function(ShortsFeedLoaded) _then;

/// Create a copy of ShortsFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shorts = null,}) {
  return _then(ShortsFeedLoaded(
null == shorts ? _self._shorts : shorts // ignore: cast_nullable_to_non_nullable
as List<ShortEntity>,
  ));
}


}

/// @nodoc


class ShortsFeedFailure implements ShortsFeedState {
  const ShortsFeedFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of ShortsFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShortsFeedFailureCopyWith<ShortsFeedFailure> get copyWith => _$ShortsFeedFailureCopyWithImpl<ShortsFeedFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShortsFeedFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'ShortsFeedState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $ShortsFeedFailureCopyWith<$Res> implements $ShortsFeedStateCopyWith<$Res> {
  factory $ShortsFeedFailureCopyWith(ShortsFeedFailure value, $Res Function(ShortsFeedFailure) _then) = _$ShortsFeedFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$ShortsFeedFailureCopyWithImpl<$Res>
    implements $ShortsFeedFailureCopyWith<$Res> {
  _$ShortsFeedFailureCopyWithImpl(this._self, this._then);

  final ShortsFeedFailure _self;
  final $Res Function(ShortsFeedFailure) _then;

/// Create a copy of ShortsFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(ShortsFeedFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
