// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catering_review_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CateringReviewState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CateringReviewState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CateringReviewState()';
}


}

/// @nodoc
class $CateringReviewStateCopyWith<$Res>  {
$CateringReviewStateCopyWith(CateringReviewState _, $Res Function(CateringReviewState) __);
}


/// Adds pattern-matching-related methods to [CateringReviewState].
extension CateringReviewStatePatterns on CateringReviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CateringReviewInitial value)?  initial,TResult Function( CateringReviewLoading value)?  loading,TResult Function( CateringReviewLoaded value)?  loaded,TResult Function( CateringReviewSubmitting value)?  submitting,TResult Function( CateringReviewSubmitted value)?  submitted,TResult Function( CateringReviewFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CateringReviewInitial() when initial != null:
return initial(_that);case CateringReviewLoading() when loading != null:
return loading(_that);case CateringReviewLoaded() when loaded != null:
return loaded(_that);case CateringReviewSubmitting() when submitting != null:
return submitting(_that);case CateringReviewSubmitted() when submitted != null:
return submitted(_that);case CateringReviewFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CateringReviewInitial value)  initial,required TResult Function( CateringReviewLoading value)  loading,required TResult Function( CateringReviewLoaded value)  loaded,required TResult Function( CateringReviewSubmitting value)  submitting,required TResult Function( CateringReviewSubmitted value)  submitted,required TResult Function( CateringReviewFailure value)  failure,}){
final _that = this;
switch (_that) {
case CateringReviewInitial():
return initial(_that);case CateringReviewLoading():
return loading(_that);case CateringReviewLoaded():
return loaded(_that);case CateringReviewSubmitting():
return submitting(_that);case CateringReviewSubmitted():
return submitted(_that);case CateringReviewFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CateringReviewInitial value)?  initial,TResult? Function( CateringReviewLoading value)?  loading,TResult? Function( CateringReviewLoaded value)?  loaded,TResult? Function( CateringReviewSubmitting value)?  submitting,TResult? Function( CateringReviewSubmitted value)?  submitted,TResult? Function( CateringReviewFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CateringReviewInitial() when initial != null:
return initial(_that);case CateringReviewLoading() when loading != null:
return loading(_that);case CateringReviewLoaded() when loaded != null:
return loaded(_that);case CateringReviewSubmitting() when submitting != null:
return submitting(_that);case CateringReviewSubmitted() when submitted != null:
return submitted(_that);case CateringReviewFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( CateringRequestEntity request)?  loaded,TResult Function( CateringRequestEntity request)?  submitting,TResult Function( CateringRequestEntity request)?  submitted,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CateringReviewInitial() when initial != null:
return initial();case CateringReviewLoading() when loading != null:
return loading();case CateringReviewLoaded() when loaded != null:
return loaded(_that.request);case CateringReviewSubmitting() when submitting != null:
return submitting(_that.request);case CateringReviewSubmitted() when submitted != null:
return submitted(_that.request);case CateringReviewFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( CateringRequestEntity request)  loaded,required TResult Function( CateringRequestEntity request)  submitting,required TResult Function( CateringRequestEntity request)  submitted,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case CateringReviewInitial():
return initial();case CateringReviewLoading():
return loading();case CateringReviewLoaded():
return loaded(_that.request);case CateringReviewSubmitting():
return submitting(_that.request);case CateringReviewSubmitted():
return submitted(_that.request);case CateringReviewFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( CateringRequestEntity request)?  loaded,TResult? Function( CateringRequestEntity request)?  submitting,TResult? Function( CateringRequestEntity request)?  submitted,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case CateringReviewInitial() when initial != null:
return initial();case CateringReviewLoading() when loading != null:
return loading();case CateringReviewLoaded() when loaded != null:
return loaded(_that.request);case CateringReviewSubmitting() when submitting != null:
return submitting(_that.request);case CateringReviewSubmitted() when submitted != null:
return submitted(_that.request);case CateringReviewFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class CateringReviewInitial implements CateringReviewState {
  const CateringReviewInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CateringReviewInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CateringReviewState.initial()';
}


}




/// @nodoc


class CateringReviewLoading implements CateringReviewState {
  const CateringReviewLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CateringReviewLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CateringReviewState.loading()';
}


}




/// @nodoc


class CateringReviewLoaded implements CateringReviewState {
  const CateringReviewLoaded(this.request);
  

 final  CateringRequestEntity request;

/// Create a copy of CateringReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CateringReviewLoadedCopyWith<CateringReviewLoaded> get copyWith => _$CateringReviewLoadedCopyWithImpl<CateringReviewLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CateringReviewLoaded&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'CateringReviewState.loaded(request: $request)';
}


}

/// @nodoc
abstract mixin class $CateringReviewLoadedCopyWith<$Res> implements $CateringReviewStateCopyWith<$Res> {
  factory $CateringReviewLoadedCopyWith(CateringReviewLoaded value, $Res Function(CateringReviewLoaded) _then) = _$CateringReviewLoadedCopyWithImpl;
@useResult
$Res call({
 CateringRequestEntity request
});




}
/// @nodoc
class _$CateringReviewLoadedCopyWithImpl<$Res>
    implements $CateringReviewLoadedCopyWith<$Res> {
  _$CateringReviewLoadedCopyWithImpl(this._self, this._then);

  final CateringReviewLoaded _self;
  final $Res Function(CateringReviewLoaded) _then;

/// Create a copy of CateringReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(CateringReviewLoaded(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as CateringRequestEntity,
  ));
}


}

/// @nodoc


class CateringReviewSubmitting implements CateringReviewState {
  const CateringReviewSubmitting(this.request);
  

 final  CateringRequestEntity request;

/// Create a copy of CateringReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CateringReviewSubmittingCopyWith<CateringReviewSubmitting> get copyWith => _$CateringReviewSubmittingCopyWithImpl<CateringReviewSubmitting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CateringReviewSubmitting&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'CateringReviewState.submitting(request: $request)';
}


}

/// @nodoc
abstract mixin class $CateringReviewSubmittingCopyWith<$Res> implements $CateringReviewStateCopyWith<$Res> {
  factory $CateringReviewSubmittingCopyWith(CateringReviewSubmitting value, $Res Function(CateringReviewSubmitting) _then) = _$CateringReviewSubmittingCopyWithImpl;
@useResult
$Res call({
 CateringRequestEntity request
});




}
/// @nodoc
class _$CateringReviewSubmittingCopyWithImpl<$Res>
    implements $CateringReviewSubmittingCopyWith<$Res> {
  _$CateringReviewSubmittingCopyWithImpl(this._self, this._then);

  final CateringReviewSubmitting _self;
  final $Res Function(CateringReviewSubmitting) _then;

/// Create a copy of CateringReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(CateringReviewSubmitting(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as CateringRequestEntity,
  ));
}


}

/// @nodoc


class CateringReviewSubmitted implements CateringReviewState {
  const CateringReviewSubmitted(this.request);
  

 final  CateringRequestEntity request;

/// Create a copy of CateringReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CateringReviewSubmittedCopyWith<CateringReviewSubmitted> get copyWith => _$CateringReviewSubmittedCopyWithImpl<CateringReviewSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CateringReviewSubmitted&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'CateringReviewState.submitted(request: $request)';
}


}

/// @nodoc
abstract mixin class $CateringReviewSubmittedCopyWith<$Res> implements $CateringReviewStateCopyWith<$Res> {
  factory $CateringReviewSubmittedCopyWith(CateringReviewSubmitted value, $Res Function(CateringReviewSubmitted) _then) = _$CateringReviewSubmittedCopyWithImpl;
@useResult
$Res call({
 CateringRequestEntity request
});




}
/// @nodoc
class _$CateringReviewSubmittedCopyWithImpl<$Res>
    implements $CateringReviewSubmittedCopyWith<$Res> {
  _$CateringReviewSubmittedCopyWithImpl(this._self, this._then);

  final CateringReviewSubmitted _self;
  final $Res Function(CateringReviewSubmitted) _then;

/// Create a copy of CateringReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(CateringReviewSubmitted(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as CateringRequestEntity,
  ));
}


}

/// @nodoc


class CateringReviewFailure implements CateringReviewState {
  const CateringReviewFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of CateringReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CateringReviewFailureCopyWith<CateringReviewFailure> get copyWith => _$CateringReviewFailureCopyWithImpl<CateringReviewFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CateringReviewFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'CateringReviewState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $CateringReviewFailureCopyWith<$Res> implements $CateringReviewStateCopyWith<$Res> {
  factory $CateringReviewFailureCopyWith(CateringReviewFailure value, $Res Function(CateringReviewFailure) _then) = _$CateringReviewFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$CateringReviewFailureCopyWithImpl<$Res>
    implements $CateringReviewFailureCopyWith<$Res> {
  _$CateringReviewFailureCopyWithImpl(this._self, this._then);

  final CateringReviewFailure _self;
  final $Res Function(CateringReviewFailure) _then;

/// Create a copy of CateringReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(CateringReviewFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
