// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForgotPasswordState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState()';
}


}

/// @nodoc
class $ForgotPasswordStateCopyWith<$Res>  {
$ForgotPasswordStateCopyWith(ForgotPasswordState _, $Res Function(ForgotPasswordState) __);
}


/// Adds pattern-matching-related methods to [ForgotPasswordState].
extension ForgotPasswordStatePatterns on ForgotPasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ForgotPasswordInitial value)?  initial,TResult Function( ForgotPasswordSubmitting value)?  submitting,TResult Function( ForgotPasswordSent value)?  sent,TResult Function( ForgotPasswordFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ForgotPasswordInitial() when initial != null:
return initial(_that);case ForgotPasswordSubmitting() when submitting != null:
return submitting(_that);case ForgotPasswordSent() when sent != null:
return sent(_that);case ForgotPasswordFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ForgotPasswordInitial value)  initial,required TResult Function( ForgotPasswordSubmitting value)  submitting,required TResult Function( ForgotPasswordSent value)  sent,required TResult Function( ForgotPasswordFailure value)  failure,}){
final _that = this;
switch (_that) {
case ForgotPasswordInitial():
return initial(_that);case ForgotPasswordSubmitting():
return submitting(_that);case ForgotPasswordSent():
return sent(_that);case ForgotPasswordFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ForgotPasswordInitial value)?  initial,TResult? Function( ForgotPasswordSubmitting value)?  submitting,TResult? Function( ForgotPasswordSent value)?  sent,TResult? Function( ForgotPasswordFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ForgotPasswordInitial() when initial != null:
return initial(_that);case ForgotPasswordSubmitting() when submitting != null:
return submitting(_that);case ForgotPasswordSent() when sent != null:
return sent(_that);case ForgotPasswordFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  submitting,TResult Function( String phone)?  sent,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ForgotPasswordInitial() when initial != null:
return initial();case ForgotPasswordSubmitting() when submitting != null:
return submitting();case ForgotPasswordSent() when sent != null:
return sent(_that.phone);case ForgotPasswordFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  submitting,required TResult Function( String phone)  sent,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case ForgotPasswordInitial():
return initial();case ForgotPasswordSubmitting():
return submitting();case ForgotPasswordSent():
return sent(_that.phone);case ForgotPasswordFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  submitting,TResult? Function( String phone)?  sent,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case ForgotPasswordInitial() when initial != null:
return initial();case ForgotPasswordSubmitting() when submitting != null:
return submitting();case ForgotPasswordSent() when sent != null:
return sent(_that.phone);case ForgotPasswordFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class ForgotPasswordInitial implements ForgotPasswordState {
  const ForgotPasswordInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.initial()';
}


}




/// @nodoc


class ForgotPasswordSubmitting implements ForgotPasswordState {
  const ForgotPasswordSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.submitting()';
}


}




/// @nodoc


class ForgotPasswordSent implements ForgotPasswordState {
  const ForgotPasswordSent(this.phone);
  

 final  String phone;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordSentCopyWith<ForgotPasswordSent> get copyWith => _$ForgotPasswordSentCopyWithImpl<ForgotPasswordSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordSent&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'ForgotPasswordState.sent(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordSentCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $ForgotPasswordSentCopyWith(ForgotPasswordSent value, $Res Function(ForgotPasswordSent) _then) = _$ForgotPasswordSentCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$ForgotPasswordSentCopyWithImpl<$Res>
    implements $ForgotPasswordSentCopyWith<$Res> {
  _$ForgotPasswordSentCopyWithImpl(this._self, this._then);

  final ForgotPasswordSent _self;
  final $Res Function(ForgotPasswordSent) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(ForgotPasswordSent(
null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ForgotPasswordFailure implements ForgotPasswordState {
  const ForgotPasswordFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordFailureCopyWith<ForgotPasswordFailure> get copyWith => _$ForgotPasswordFailureCopyWithImpl<ForgotPasswordFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'ForgotPasswordState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordFailureCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $ForgotPasswordFailureCopyWith(ForgotPasswordFailure value, $Res Function(ForgotPasswordFailure) _then) = _$ForgotPasswordFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$ForgotPasswordFailureCopyWithImpl<$Res>
    implements $ForgotPasswordFailureCopyWith<$Res> {
  _$ForgotPasswordFailureCopyWithImpl(this._self, this._then);

  final ForgotPasswordFailure _self;
  final $Res Function(ForgotPasswordFailure) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(ForgotPasswordFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
