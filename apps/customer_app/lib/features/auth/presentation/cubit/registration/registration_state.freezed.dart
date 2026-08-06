// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegistrationState {

 String get fullName; String get phone; String get password; String get address; DetectedLocationEntity? get detectedLocation; bool get isDetectingLocation; bool get isSubmitting; String? get locationError; String? get submitError; bool get success;
/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationStateCopyWith<RegistrationState> get copyWith => _$RegistrationStateCopyWithImpl<RegistrationState>(this as RegistrationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.password, password) || other.password == password)&&(identical(other.address, address) || other.address == address)&&(identical(other.detectedLocation, detectedLocation) || other.detectedLocation == detectedLocation)&&(identical(other.isDetectingLocation, isDetectingLocation) || other.isDetectingLocation == isDetectingLocation)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.locationError, locationError) || other.locationError == locationError)&&(identical(other.submitError, submitError) || other.submitError == submitError)&&(identical(other.success, success) || other.success == success));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,phone,password,address,detectedLocation,isDetectingLocation,isSubmitting,locationError,submitError,success);

@override
String toString() {
  return 'RegistrationState(fullName: $fullName, phone: $phone, password: $password, address: $address, detectedLocation: $detectedLocation, isDetectingLocation: $isDetectingLocation, isSubmitting: $isSubmitting, locationError: $locationError, submitError: $submitError, success: $success)';
}


}

/// @nodoc
abstract mixin class $RegistrationStateCopyWith<$Res>  {
  factory $RegistrationStateCopyWith(RegistrationState value, $Res Function(RegistrationState) _then) = _$RegistrationStateCopyWithImpl;
@useResult
$Res call({
 String fullName, String phone, String password, String address, DetectedLocationEntity? detectedLocation, bool isDetectingLocation, bool isSubmitting, String? locationError, String? submitError, bool success
});




}
/// @nodoc
class _$RegistrationStateCopyWithImpl<$Res>
    implements $RegistrationStateCopyWith<$Res> {
  _$RegistrationStateCopyWithImpl(this._self, this._then);

  final RegistrationState _self;
  final $Res Function(RegistrationState) _then;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? phone = null,Object? password = null,Object? address = null,Object? detectedLocation = freezed,Object? isDetectingLocation = null,Object? isSubmitting = null,Object? locationError = freezed,Object? submitError = freezed,Object? success = null,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,detectedLocation: freezed == detectedLocation ? _self.detectedLocation : detectedLocation // ignore: cast_nullable_to_non_nullable
as DetectedLocationEntity?,isDetectingLocation: null == isDetectingLocation ? _self.isDetectingLocation : isDetectingLocation // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,locationError: freezed == locationError ? _self.locationError : locationError // ignore: cast_nullable_to_non_nullable
as String?,submitError: freezed == submitError ? _self.submitError : submitError // ignore: cast_nullable_to_non_nullable
as String?,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RegistrationState].
extension RegistrationStatePatterns on RegistrationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegistrationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegistrationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegistrationState value)  $default,){
final _that = this;
switch (_that) {
case _RegistrationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegistrationState value)?  $default,){
final _that = this;
switch (_that) {
case _RegistrationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String phone,  String password,  String address,  DetectedLocationEntity? detectedLocation,  bool isDetectingLocation,  bool isSubmitting,  String? locationError,  String? submitError,  bool success)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegistrationState() when $default != null:
return $default(_that.fullName,_that.phone,_that.password,_that.address,_that.detectedLocation,_that.isDetectingLocation,_that.isSubmitting,_that.locationError,_that.submitError,_that.success);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String phone,  String password,  String address,  DetectedLocationEntity? detectedLocation,  bool isDetectingLocation,  bool isSubmitting,  String? locationError,  String? submitError,  bool success)  $default,) {final _that = this;
switch (_that) {
case _RegistrationState():
return $default(_that.fullName,_that.phone,_that.password,_that.address,_that.detectedLocation,_that.isDetectingLocation,_that.isSubmitting,_that.locationError,_that.submitError,_that.success);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String phone,  String password,  String address,  DetectedLocationEntity? detectedLocation,  bool isDetectingLocation,  bool isSubmitting,  String? locationError,  String? submitError,  bool success)?  $default,) {final _that = this;
switch (_that) {
case _RegistrationState() when $default != null:
return $default(_that.fullName,_that.phone,_that.password,_that.address,_that.detectedLocation,_that.isDetectingLocation,_that.isSubmitting,_that.locationError,_that.submitError,_that.success);case _:
  return null;

}
}

}

/// @nodoc


class _RegistrationState implements RegistrationState {
  const _RegistrationState({this.fullName = '', this.phone = '', this.password = '', this.address = '', this.detectedLocation, this.isDetectingLocation = false, this.isSubmitting = false, this.locationError, this.submitError, this.success = false});
  

@override@JsonKey() final  String fullName;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String password;
@override@JsonKey() final  String address;
@override final  DetectedLocationEntity? detectedLocation;
@override@JsonKey() final  bool isDetectingLocation;
@override@JsonKey() final  bool isSubmitting;
@override final  String? locationError;
@override final  String? submitError;
@override@JsonKey() final  bool success;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationStateCopyWith<_RegistrationState> get copyWith => __$RegistrationStateCopyWithImpl<_RegistrationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.password, password) || other.password == password)&&(identical(other.address, address) || other.address == address)&&(identical(other.detectedLocation, detectedLocation) || other.detectedLocation == detectedLocation)&&(identical(other.isDetectingLocation, isDetectingLocation) || other.isDetectingLocation == isDetectingLocation)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.locationError, locationError) || other.locationError == locationError)&&(identical(other.submitError, submitError) || other.submitError == submitError)&&(identical(other.success, success) || other.success == success));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,phone,password,address,detectedLocation,isDetectingLocation,isSubmitting,locationError,submitError,success);

@override
String toString() {
  return 'RegistrationState(fullName: $fullName, phone: $phone, password: $password, address: $address, detectedLocation: $detectedLocation, isDetectingLocation: $isDetectingLocation, isSubmitting: $isSubmitting, locationError: $locationError, submitError: $submitError, success: $success)';
}


}

/// @nodoc
abstract mixin class _$RegistrationStateCopyWith<$Res> implements $RegistrationStateCopyWith<$Res> {
  factory _$RegistrationStateCopyWith(_RegistrationState value, $Res Function(_RegistrationState) _then) = __$RegistrationStateCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String phone, String password, String address, DetectedLocationEntity? detectedLocation, bool isDetectingLocation, bool isSubmitting, String? locationError, String? submitError, bool success
});




}
/// @nodoc
class __$RegistrationStateCopyWithImpl<$Res>
    implements _$RegistrationStateCopyWith<$Res> {
  __$RegistrationStateCopyWithImpl(this._self, this._then);

  final _RegistrationState _self;
  final $Res Function(_RegistrationState) _then;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? phone = null,Object? password = null,Object? address = null,Object? detectedLocation = freezed,Object? isDetectingLocation = null,Object? isSubmitting = null,Object? locationError = freezed,Object? submitError = freezed,Object? success = null,}) {
  return _then(_RegistrationState(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,detectedLocation: freezed == detectedLocation ? _self.detectedLocation : detectedLocation // ignore: cast_nullable_to_non_nullable
as DetectedLocationEntity?,isDetectingLocation: null == isDetectingLocation ? _self.isDetectingLocation : isDetectingLocation // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,locationError: freezed == locationError ? _self.locationError : locationError // ignore: cast_nullable_to_non_nullable
as String?,submitError: freezed == submitError ? _self.submitError : submitError // ignore: cast_nullable_to_non_nullable
as String?,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
