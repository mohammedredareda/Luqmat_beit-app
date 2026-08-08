// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_phone_number_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChangePhoneNumberEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) phoneNumberChanged,
    required TResult Function() sendCodeSubmitted,
    required TResult Function(String value) otpChanged,
    required TResult Function() resendPressed,
    required TResult Function() verifySubmitted,
    required TResult Function() backToPhoneInputPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? phoneNumberChanged,
    TResult? Function()? sendCodeSubmitted,
    TResult? Function(String value)? otpChanged,
    TResult? Function()? resendPressed,
    TResult? Function()? verifySubmitted,
    TResult? Function()? backToPhoneInputPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? phoneNumberChanged,
    TResult Function()? sendCodeSubmitted,
    TResult Function(String value)? otpChanged,
    TResult Function()? resendPressed,
    TResult Function()? verifySubmitted,
    TResult Function()? backToPhoneInputPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(_SendCodeSubmitted value) sendCodeSubmitted,
    required TResult Function(_OtpChanged value) otpChanged,
    required TResult Function(_ResendPressed value) resendPressed,
    required TResult Function(_VerifySubmitted value) verifySubmitted,
    required TResult Function(_BackToPhoneInputPressed value)
        backToPhoneInputPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult? Function(_OtpChanged value)? otpChanged,
    TResult? Function(_ResendPressed value)? resendPressed,
    TResult? Function(_VerifySubmitted value)? verifySubmitted,
    TResult? Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult Function(_OtpChanged value)? otpChanged,
    TResult Function(_ResendPressed value)? resendPressed,
    TResult Function(_VerifySubmitted value)? verifySubmitted,
    TResult Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePhoneNumberEventCopyWith<$Res> {
  factory $ChangePhoneNumberEventCopyWith(ChangePhoneNumberEvent value,
          $Res Function(ChangePhoneNumberEvent) then) =
      _$ChangePhoneNumberEventCopyWithImpl<$Res, ChangePhoneNumberEvent>;
}

/// @nodoc
class _$ChangePhoneNumberEventCopyWithImpl<$Res,
        $Val extends ChangePhoneNumberEvent>
    implements $ChangePhoneNumberEventCopyWith<$Res> {
  _$ChangePhoneNumberEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangePhoneNumberEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PhoneNumberChangedImplCopyWith<$Res> {
  factory _$$PhoneNumberChangedImplCopyWith(_$PhoneNumberChangedImpl value,
          $Res Function(_$PhoneNumberChangedImpl) then) =
      __$$PhoneNumberChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$PhoneNumberChangedImplCopyWithImpl<$Res>
    extends _$ChangePhoneNumberEventCopyWithImpl<$Res, _$PhoneNumberChangedImpl>
    implements _$$PhoneNumberChangedImplCopyWith<$Res> {
  __$$PhoneNumberChangedImplCopyWithImpl(_$PhoneNumberChangedImpl _value,
      $Res Function(_$PhoneNumberChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePhoneNumberEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$PhoneNumberChangedImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PhoneNumberChangedImpl implements _PhoneNumberChanged {
  const _$PhoneNumberChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'ChangePhoneNumberEvent.phoneNumberChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of ChangePhoneNumberEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberChangedImplCopyWith<_$PhoneNumberChangedImpl> get copyWith =>
      __$$PhoneNumberChangedImplCopyWithImpl<_$PhoneNumberChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) phoneNumberChanged,
    required TResult Function() sendCodeSubmitted,
    required TResult Function(String value) otpChanged,
    required TResult Function() resendPressed,
    required TResult Function() verifySubmitted,
    required TResult Function() backToPhoneInputPressed,
  }) {
    return phoneNumberChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? phoneNumberChanged,
    TResult? Function()? sendCodeSubmitted,
    TResult? Function(String value)? otpChanged,
    TResult? Function()? resendPressed,
    TResult? Function()? verifySubmitted,
    TResult? Function()? backToPhoneInputPressed,
  }) {
    return phoneNumberChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? phoneNumberChanged,
    TResult Function()? sendCodeSubmitted,
    TResult Function(String value)? otpChanged,
    TResult Function()? resendPressed,
    TResult Function()? verifySubmitted,
    TResult Function()? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (phoneNumberChanged != null) {
      return phoneNumberChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(_SendCodeSubmitted value) sendCodeSubmitted,
    required TResult Function(_OtpChanged value) otpChanged,
    required TResult Function(_ResendPressed value) resendPressed,
    required TResult Function(_VerifySubmitted value) verifySubmitted,
    required TResult Function(_BackToPhoneInputPressed value)
        backToPhoneInputPressed,
  }) {
    return phoneNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult? Function(_OtpChanged value)? otpChanged,
    TResult? Function(_ResendPressed value)? resendPressed,
    TResult? Function(_VerifySubmitted value)? verifySubmitted,
    TResult? Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
  }) {
    return phoneNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult Function(_OtpChanged value)? otpChanged,
    TResult Function(_ResendPressed value)? resendPressed,
    TResult Function(_VerifySubmitted value)? verifySubmitted,
    TResult Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (phoneNumberChanged != null) {
      return phoneNumberChanged(this);
    }
    return orElse();
  }
}

abstract class _PhoneNumberChanged implements ChangePhoneNumberEvent {
  const factory _PhoneNumberChanged(final String value) =
      _$PhoneNumberChangedImpl;

  String get value;

  /// Create a copy of ChangePhoneNumberEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneNumberChangedImplCopyWith<_$PhoneNumberChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendCodeSubmittedImplCopyWith<$Res> {
  factory _$$SendCodeSubmittedImplCopyWith(_$SendCodeSubmittedImpl value,
          $Res Function(_$SendCodeSubmittedImpl) then) =
      __$$SendCodeSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SendCodeSubmittedImplCopyWithImpl<$Res>
    extends _$ChangePhoneNumberEventCopyWithImpl<$Res, _$SendCodeSubmittedImpl>
    implements _$$SendCodeSubmittedImplCopyWith<$Res> {
  __$$SendCodeSubmittedImplCopyWithImpl(_$SendCodeSubmittedImpl _value,
      $Res Function(_$SendCodeSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePhoneNumberEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SendCodeSubmittedImpl implements _SendCodeSubmitted {
  const _$SendCodeSubmittedImpl();

  @override
  String toString() {
    return 'ChangePhoneNumberEvent.sendCodeSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SendCodeSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) phoneNumberChanged,
    required TResult Function() sendCodeSubmitted,
    required TResult Function(String value) otpChanged,
    required TResult Function() resendPressed,
    required TResult Function() verifySubmitted,
    required TResult Function() backToPhoneInputPressed,
  }) {
    return sendCodeSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? phoneNumberChanged,
    TResult? Function()? sendCodeSubmitted,
    TResult? Function(String value)? otpChanged,
    TResult? Function()? resendPressed,
    TResult? Function()? verifySubmitted,
    TResult? Function()? backToPhoneInputPressed,
  }) {
    return sendCodeSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? phoneNumberChanged,
    TResult Function()? sendCodeSubmitted,
    TResult Function(String value)? otpChanged,
    TResult Function()? resendPressed,
    TResult Function()? verifySubmitted,
    TResult Function()? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (sendCodeSubmitted != null) {
      return sendCodeSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(_SendCodeSubmitted value) sendCodeSubmitted,
    required TResult Function(_OtpChanged value) otpChanged,
    required TResult Function(_ResendPressed value) resendPressed,
    required TResult Function(_VerifySubmitted value) verifySubmitted,
    required TResult Function(_BackToPhoneInputPressed value)
        backToPhoneInputPressed,
  }) {
    return sendCodeSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult? Function(_OtpChanged value)? otpChanged,
    TResult? Function(_ResendPressed value)? resendPressed,
    TResult? Function(_VerifySubmitted value)? verifySubmitted,
    TResult? Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
  }) {
    return sendCodeSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult Function(_OtpChanged value)? otpChanged,
    TResult Function(_ResendPressed value)? resendPressed,
    TResult Function(_VerifySubmitted value)? verifySubmitted,
    TResult Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (sendCodeSubmitted != null) {
      return sendCodeSubmitted(this);
    }
    return orElse();
  }
}

abstract class _SendCodeSubmitted implements ChangePhoneNumberEvent {
  const factory _SendCodeSubmitted() = _$SendCodeSubmittedImpl;
}

/// @nodoc
abstract class _$$OtpChangedImplCopyWith<$Res> {
  factory _$$OtpChangedImplCopyWith(
          _$OtpChangedImpl value, $Res Function(_$OtpChangedImpl) then) =
      __$$OtpChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$OtpChangedImplCopyWithImpl<$Res>
    extends _$ChangePhoneNumberEventCopyWithImpl<$Res, _$OtpChangedImpl>
    implements _$$OtpChangedImplCopyWith<$Res> {
  __$$OtpChangedImplCopyWithImpl(
      _$OtpChangedImpl _value, $Res Function(_$OtpChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePhoneNumberEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$OtpChangedImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OtpChangedImpl implements _OtpChanged {
  const _$OtpChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'ChangePhoneNumberEvent.otpChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of ChangePhoneNumberEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpChangedImplCopyWith<_$OtpChangedImpl> get copyWith =>
      __$$OtpChangedImplCopyWithImpl<_$OtpChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) phoneNumberChanged,
    required TResult Function() sendCodeSubmitted,
    required TResult Function(String value) otpChanged,
    required TResult Function() resendPressed,
    required TResult Function() verifySubmitted,
    required TResult Function() backToPhoneInputPressed,
  }) {
    return otpChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? phoneNumberChanged,
    TResult? Function()? sendCodeSubmitted,
    TResult? Function(String value)? otpChanged,
    TResult? Function()? resendPressed,
    TResult? Function()? verifySubmitted,
    TResult? Function()? backToPhoneInputPressed,
  }) {
    return otpChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? phoneNumberChanged,
    TResult Function()? sendCodeSubmitted,
    TResult Function(String value)? otpChanged,
    TResult Function()? resendPressed,
    TResult Function()? verifySubmitted,
    TResult Function()? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (otpChanged != null) {
      return otpChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(_SendCodeSubmitted value) sendCodeSubmitted,
    required TResult Function(_OtpChanged value) otpChanged,
    required TResult Function(_ResendPressed value) resendPressed,
    required TResult Function(_VerifySubmitted value) verifySubmitted,
    required TResult Function(_BackToPhoneInputPressed value)
        backToPhoneInputPressed,
  }) {
    return otpChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult? Function(_OtpChanged value)? otpChanged,
    TResult? Function(_ResendPressed value)? resendPressed,
    TResult? Function(_VerifySubmitted value)? verifySubmitted,
    TResult? Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
  }) {
    return otpChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult Function(_OtpChanged value)? otpChanged,
    TResult Function(_ResendPressed value)? resendPressed,
    TResult Function(_VerifySubmitted value)? verifySubmitted,
    TResult Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (otpChanged != null) {
      return otpChanged(this);
    }
    return orElse();
  }
}

abstract class _OtpChanged implements ChangePhoneNumberEvent {
  const factory _OtpChanged(final String value) = _$OtpChangedImpl;

  String get value;

  /// Create a copy of ChangePhoneNumberEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpChangedImplCopyWith<_$OtpChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResendPressedImplCopyWith<$Res> {
  factory _$$ResendPressedImplCopyWith(
          _$ResendPressedImpl value, $Res Function(_$ResendPressedImpl) then) =
      __$$ResendPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResendPressedImplCopyWithImpl<$Res>
    extends _$ChangePhoneNumberEventCopyWithImpl<$Res, _$ResendPressedImpl>
    implements _$$ResendPressedImplCopyWith<$Res> {
  __$$ResendPressedImplCopyWithImpl(
      _$ResendPressedImpl _value, $Res Function(_$ResendPressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePhoneNumberEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResendPressedImpl implements _ResendPressed {
  const _$ResendPressedImpl();

  @override
  String toString() {
    return 'ChangePhoneNumberEvent.resendPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResendPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) phoneNumberChanged,
    required TResult Function() sendCodeSubmitted,
    required TResult Function(String value) otpChanged,
    required TResult Function() resendPressed,
    required TResult Function() verifySubmitted,
    required TResult Function() backToPhoneInputPressed,
  }) {
    return resendPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? phoneNumberChanged,
    TResult? Function()? sendCodeSubmitted,
    TResult? Function(String value)? otpChanged,
    TResult? Function()? resendPressed,
    TResult? Function()? verifySubmitted,
    TResult? Function()? backToPhoneInputPressed,
  }) {
    return resendPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? phoneNumberChanged,
    TResult Function()? sendCodeSubmitted,
    TResult Function(String value)? otpChanged,
    TResult Function()? resendPressed,
    TResult Function()? verifySubmitted,
    TResult Function()? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (resendPressed != null) {
      return resendPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(_SendCodeSubmitted value) sendCodeSubmitted,
    required TResult Function(_OtpChanged value) otpChanged,
    required TResult Function(_ResendPressed value) resendPressed,
    required TResult Function(_VerifySubmitted value) verifySubmitted,
    required TResult Function(_BackToPhoneInputPressed value)
        backToPhoneInputPressed,
  }) {
    return resendPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult? Function(_OtpChanged value)? otpChanged,
    TResult? Function(_ResendPressed value)? resendPressed,
    TResult? Function(_VerifySubmitted value)? verifySubmitted,
    TResult? Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
  }) {
    return resendPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult Function(_OtpChanged value)? otpChanged,
    TResult Function(_ResendPressed value)? resendPressed,
    TResult Function(_VerifySubmitted value)? verifySubmitted,
    TResult Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (resendPressed != null) {
      return resendPressed(this);
    }
    return orElse();
  }
}

abstract class _ResendPressed implements ChangePhoneNumberEvent {
  const factory _ResendPressed() = _$ResendPressedImpl;
}

/// @nodoc
abstract class _$$VerifySubmittedImplCopyWith<$Res> {
  factory _$$VerifySubmittedImplCopyWith(_$VerifySubmittedImpl value,
          $Res Function(_$VerifySubmittedImpl) then) =
      __$$VerifySubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VerifySubmittedImplCopyWithImpl<$Res>
    extends _$ChangePhoneNumberEventCopyWithImpl<$Res, _$VerifySubmittedImpl>
    implements _$$VerifySubmittedImplCopyWith<$Res> {
  __$$VerifySubmittedImplCopyWithImpl(
      _$VerifySubmittedImpl _value, $Res Function(_$VerifySubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePhoneNumberEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$VerifySubmittedImpl implements _VerifySubmitted {
  const _$VerifySubmittedImpl();

  @override
  String toString() {
    return 'ChangePhoneNumberEvent.verifySubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VerifySubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) phoneNumberChanged,
    required TResult Function() sendCodeSubmitted,
    required TResult Function(String value) otpChanged,
    required TResult Function() resendPressed,
    required TResult Function() verifySubmitted,
    required TResult Function() backToPhoneInputPressed,
  }) {
    return verifySubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? phoneNumberChanged,
    TResult? Function()? sendCodeSubmitted,
    TResult? Function(String value)? otpChanged,
    TResult? Function()? resendPressed,
    TResult? Function()? verifySubmitted,
    TResult? Function()? backToPhoneInputPressed,
  }) {
    return verifySubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? phoneNumberChanged,
    TResult Function()? sendCodeSubmitted,
    TResult Function(String value)? otpChanged,
    TResult Function()? resendPressed,
    TResult Function()? verifySubmitted,
    TResult Function()? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (verifySubmitted != null) {
      return verifySubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(_SendCodeSubmitted value) sendCodeSubmitted,
    required TResult Function(_OtpChanged value) otpChanged,
    required TResult Function(_ResendPressed value) resendPressed,
    required TResult Function(_VerifySubmitted value) verifySubmitted,
    required TResult Function(_BackToPhoneInputPressed value)
        backToPhoneInputPressed,
  }) {
    return verifySubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult? Function(_OtpChanged value)? otpChanged,
    TResult? Function(_ResendPressed value)? resendPressed,
    TResult? Function(_VerifySubmitted value)? verifySubmitted,
    TResult? Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
  }) {
    return verifySubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult Function(_OtpChanged value)? otpChanged,
    TResult Function(_ResendPressed value)? resendPressed,
    TResult Function(_VerifySubmitted value)? verifySubmitted,
    TResult Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (verifySubmitted != null) {
      return verifySubmitted(this);
    }
    return orElse();
  }
}

abstract class _VerifySubmitted implements ChangePhoneNumberEvent {
  const factory _VerifySubmitted() = _$VerifySubmittedImpl;
}

/// @nodoc
abstract class _$$BackToPhoneInputPressedImplCopyWith<$Res> {
  factory _$$BackToPhoneInputPressedImplCopyWith(
          _$BackToPhoneInputPressedImpl value,
          $Res Function(_$BackToPhoneInputPressedImpl) then) =
      __$$BackToPhoneInputPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BackToPhoneInputPressedImplCopyWithImpl<$Res>
    extends _$ChangePhoneNumberEventCopyWithImpl<$Res,
        _$BackToPhoneInputPressedImpl>
    implements _$$BackToPhoneInputPressedImplCopyWith<$Res> {
  __$$BackToPhoneInputPressedImplCopyWithImpl(
      _$BackToPhoneInputPressedImpl _value,
      $Res Function(_$BackToPhoneInputPressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePhoneNumberEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BackToPhoneInputPressedImpl implements _BackToPhoneInputPressed {
  const _$BackToPhoneInputPressedImpl();

  @override
  String toString() {
    return 'ChangePhoneNumberEvent.backToPhoneInputPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackToPhoneInputPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) phoneNumberChanged,
    required TResult Function() sendCodeSubmitted,
    required TResult Function(String value) otpChanged,
    required TResult Function() resendPressed,
    required TResult Function() verifySubmitted,
    required TResult Function() backToPhoneInputPressed,
  }) {
    return backToPhoneInputPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String value)? phoneNumberChanged,
    TResult? Function()? sendCodeSubmitted,
    TResult? Function(String value)? otpChanged,
    TResult? Function()? resendPressed,
    TResult? Function()? verifySubmitted,
    TResult? Function()? backToPhoneInputPressed,
  }) {
    return backToPhoneInputPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? phoneNumberChanged,
    TResult Function()? sendCodeSubmitted,
    TResult Function(String value)? otpChanged,
    TResult Function()? resendPressed,
    TResult Function()? verifySubmitted,
    TResult Function()? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (backToPhoneInputPressed != null) {
      return backToPhoneInputPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(_SendCodeSubmitted value) sendCodeSubmitted,
    required TResult Function(_OtpChanged value) otpChanged,
    required TResult Function(_ResendPressed value) resendPressed,
    required TResult Function(_VerifySubmitted value) verifySubmitted,
    required TResult Function(_BackToPhoneInputPressed value)
        backToPhoneInputPressed,
  }) {
    return backToPhoneInputPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult? Function(_OtpChanged value)? otpChanged,
    TResult? Function(_ResendPressed value)? resendPressed,
    TResult? Function(_VerifySubmitted value)? verifySubmitted,
    TResult? Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
  }) {
    return backToPhoneInputPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(_SendCodeSubmitted value)? sendCodeSubmitted,
    TResult Function(_OtpChanged value)? otpChanged,
    TResult Function(_ResendPressed value)? resendPressed,
    TResult Function(_VerifySubmitted value)? verifySubmitted,
    TResult Function(_BackToPhoneInputPressed value)? backToPhoneInputPressed,
    required TResult orElse(),
  }) {
    if (backToPhoneInputPressed != null) {
      return backToPhoneInputPressed(this);
    }
    return orElse();
  }
}

abstract class _BackToPhoneInputPressed implements ChangePhoneNumberEvent {
  const factory _BackToPhoneInputPressed() = _$BackToPhoneInputPressedImpl;
}
