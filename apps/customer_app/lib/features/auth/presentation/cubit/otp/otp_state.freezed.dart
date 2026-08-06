// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtpState {

 String get code; bool get isVerifying; bool get isResending; bool get verified; String? get errorMessage;
/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpStateCopyWith<OtpState> get copyWith => _$OtpStateCopyWithImpl<OtpState>(this as OtpState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpState&&(identical(other.code, code) || other.code == code)&&(identical(other.isVerifying, isVerifying) || other.isVerifying == isVerifying)&&(identical(other.isResending, isResending) || other.isResending == isResending)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,code,isVerifying,isResending,verified,errorMessage);

@override
String toString() {
  return 'OtpState(code: $code, isVerifying: $isVerifying, isResending: $isResending, verified: $verified, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $OtpStateCopyWith<$Res>  {
  factory $OtpStateCopyWith(OtpState value, $Res Function(OtpState) _then) = _$OtpStateCopyWithImpl;
@useResult
$Res call({
 String code, bool isVerifying, bool isResending, bool verified, String? errorMessage
});




}
/// @nodoc
class _$OtpStateCopyWithImpl<$Res>
    implements $OtpStateCopyWith<$Res> {
  _$OtpStateCopyWithImpl(this._self, this._then);

  final OtpState _self;
  final $Res Function(OtpState) _then;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? isVerifying = null,Object? isResending = null,Object? verified = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,isVerifying: null == isVerifying ? _self.isVerifying : isVerifying // ignore: cast_nullable_to_non_nullable
as bool,isResending: null == isResending ? _self.isResending : isResending // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpState].
extension OtpStatePatterns on OtpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpState value)  $default,){
final _that = this;
switch (_that) {
case _OtpState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpState value)?  $default,){
final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  bool isVerifying,  bool isResending,  bool verified,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that.code,_that.isVerifying,_that.isResending,_that.verified,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  bool isVerifying,  bool isResending,  bool verified,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _OtpState():
return $default(_that.code,_that.isVerifying,_that.isResending,_that.verified,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  bool isVerifying,  bool isResending,  bool verified,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that.code,_that.isVerifying,_that.isResending,_that.verified,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _OtpState implements OtpState {
  const _OtpState({this.code = '', this.isVerifying = false, this.isResending = false, this.verified = false, this.errorMessage});
  

@override@JsonKey() final  String code;
@override@JsonKey() final  bool isVerifying;
@override@JsonKey() final  bool isResending;
@override@JsonKey() final  bool verified;
@override final  String? errorMessage;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpStateCopyWith<_OtpState> get copyWith => __$OtpStateCopyWithImpl<_OtpState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpState&&(identical(other.code, code) || other.code == code)&&(identical(other.isVerifying, isVerifying) || other.isVerifying == isVerifying)&&(identical(other.isResending, isResending) || other.isResending == isResending)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,code,isVerifying,isResending,verified,errorMessage);

@override
String toString() {
  return 'OtpState(code: $code, isVerifying: $isVerifying, isResending: $isResending, verified: $verified, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$OtpStateCopyWith<$Res> implements $OtpStateCopyWith<$Res> {
  factory _$OtpStateCopyWith(_OtpState value, $Res Function(_OtpState) _then) = __$OtpStateCopyWithImpl;
@override @useResult
$Res call({
 String code, bool isVerifying, bool isResending, bool verified, String? errorMessage
});




}
/// @nodoc
class __$OtpStateCopyWithImpl<$Res>
    implements _$OtpStateCopyWith<$Res> {
  __$OtpStateCopyWithImpl(this._self, this._then);

  final _OtpState _self;
  final $Res Function(_OtpState) _then;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? isVerifying = null,Object? isResending = null,Object? verified = null,Object? errorMessage = freezed,}) {
  return _then(_OtpState(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,isVerifying: null == isVerifying ? _self.isVerifying : isVerifying // ignore: cast_nullable_to_non_nullable
as bool,isResending: null == isResending ? _self.isResending : isResending // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
