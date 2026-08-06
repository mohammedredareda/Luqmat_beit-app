// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState()';
}


}

/// @nodoc
class $SearchStateCopyWith<$Res>  {
$SearchStateCopyWith(SearchState _, $Res Function(SearchState) __);
}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchInitial value)?  initial,TResult Function( SearchLoading value)?  loading,TResult Function( SearchLoaded value)?  loaded,TResult Function( SearchFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial(_that);case SearchLoading() when loading != null:
return loading(_that);case SearchLoaded() when loaded != null:
return loaded(_that);case SearchFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchInitial value)  initial,required TResult Function( SearchLoading value)  loading,required TResult Function( SearchLoaded value)  loaded,required TResult Function( SearchFailure value)  failure,}){
final _that = this;
switch (_that) {
case SearchInitial():
return initial(_that);case SearchLoading():
return loading(_that);case SearchLoaded():
return loaded(_that);case SearchFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchInitial value)?  initial,TResult? Function( SearchLoading value)?  loading,TResult? Function( SearchLoaded value)?  loaded,TResult? Function( SearchFailure value)?  failure,}){
final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial(_that);case SearchLoading() when loading != null:
return loading(_that);case SearchLoaded() when loaded != null:
return loaded(_that);case SearchFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String query,  SearchSortOption sortOption,  String? categoryId,  int revision)?  loaded,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial();case SearchLoading() when loading != null:
return loading();case SearchLoaded() when loaded != null:
return loaded(_that.query,_that.sortOption,_that.categoryId,_that.revision);case SearchFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String query,  SearchSortOption sortOption,  String? categoryId,  int revision)  loaded,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case SearchInitial():
return initial();case SearchLoading():
return loading();case SearchLoaded():
return loaded(_that.query,_that.sortOption,_that.categoryId,_that.revision);case SearchFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String query,  SearchSortOption sortOption,  String? categoryId,  int revision)?  loaded,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case SearchInitial() when initial != null:
return initial();case SearchLoading() when loading != null:
return loading();case SearchLoaded() when loaded != null:
return loaded(_that.query,_that.sortOption,_that.categoryId,_that.revision);case SearchFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class SearchInitial implements SearchState {
  const SearchInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState.initial()';
}


}




/// @nodoc


class SearchLoading implements SearchState {
  const SearchLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState.loading()';
}


}




/// @nodoc


class SearchLoaded implements SearchState {
  const SearchLoaded({required this.query, required this.sortOption, this.categoryId, required this.revision});
  

 final  String query;
 final  SearchSortOption sortOption;
 final  String? categoryId;
 final  int revision;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchLoadedCopyWith<SearchLoaded> get copyWith => _$SearchLoadedCopyWithImpl<SearchLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchLoaded&&(identical(other.query, query) || other.query == query)&&(identical(other.sortOption, sortOption) || other.sortOption == sortOption)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode => Object.hash(runtimeType,query,sortOption,categoryId,revision);

@override
String toString() {
  return 'SearchState.loaded(query: $query, sortOption: $sortOption, categoryId: $categoryId, revision: $revision)';
}


}

/// @nodoc
abstract mixin class $SearchLoadedCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory $SearchLoadedCopyWith(SearchLoaded value, $Res Function(SearchLoaded) _then) = _$SearchLoadedCopyWithImpl;
@useResult
$Res call({
 String query, SearchSortOption sortOption, String? categoryId, int revision
});




}
/// @nodoc
class _$SearchLoadedCopyWithImpl<$Res>
    implements $SearchLoadedCopyWith<$Res> {
  _$SearchLoadedCopyWithImpl(this._self, this._then);

  final SearchLoaded _self;
  final $Res Function(SearchLoaded) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,Object? sortOption = null,Object? categoryId = freezed,Object? revision = null,}) {
  return _then(SearchLoaded(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,sortOption: null == sortOption ? _self.sortOption : sortOption // ignore: cast_nullable_to_non_nullable
as SearchSortOption,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SearchFailure implements SearchState {
  const SearchFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFailureCopyWith<SearchFailure> get copyWith => _$SearchFailureCopyWithImpl<SearchFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'SearchState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $SearchFailureCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory $SearchFailureCopyWith(SearchFailure value, $Res Function(SearchFailure) _then) = _$SearchFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$SearchFailureCopyWithImpl<$Res>
    implements $SearchFailureCopyWith<$Res> {
  _$SearchFailureCopyWithImpl(this._self, this._then);

  final SearchFailure _self;
  final $Res Function(SearchFailure) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(SearchFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
