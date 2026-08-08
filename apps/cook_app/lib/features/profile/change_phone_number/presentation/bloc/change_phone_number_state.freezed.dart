// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_phone_number_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChangePhoneNumberState {
  String get phoneNumber => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)
        enteringPhone,
    required TResult Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)
        enteringOtp,
    required TResult Function(String phoneNumber) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)?
        enteringPhone,
    TResult? Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)?
        enteringOtp,
    TResult? Function(String phoneNumber)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)?
        enteringPhone,
    TResult Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)?
        enteringOtp,
    TResult Function(String phoneNumber)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangePhoneNumberEnteringPhone value)
        enteringPhone,
    required TResult Function(ChangePhoneNumberEnteringOtp value) enteringOtp,
    required TResult Function(ChangePhoneNumberSuccess value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangePhoneNumberEnteringPhone value)? enteringPhone,
    TResult? Function(ChangePhoneNumberEnteringOtp value)? enteringOtp,
    TResult? Function(ChangePhoneNumberSuccess value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangePhoneNumberEnteringPhone value)? enteringPhone,
    TResult Function(ChangePhoneNumberEnteringOtp value)? enteringOtp,
    TResult Function(ChangePhoneNumberSuccess value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ChangePhoneNumberState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangePhoneNumberStateCopyWith<ChangePhoneNumberState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePhoneNumberStateCopyWith<$Res> {
  factory $ChangePhoneNumberStateCopyWith(ChangePhoneNumberState value,
          $Res Function(ChangePhoneNumberState) then) =
      _$ChangePhoneNumberStateCopyWithImpl<$Res, ChangePhoneNumberState>;
  @useResult
  $Res call({String phoneNumber});
}

/// @nodoc
class _$ChangePhoneNumberStateCopyWithImpl<$Res,
        $Val extends ChangePhoneNumberState>
    implements $ChangePhoneNumberStateCopyWith<$Res> {
  _$ChangePhoneNumberStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangePhoneNumberState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
  }) {
    return _then(_value.copyWith(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangePhoneNumberEnteringPhoneImplCopyWith<$Res>
    implements $ChangePhoneNumberStateCopyWith<$Res> {
  factory _$$ChangePhoneNumberEnteringPhoneImplCopyWith(
          _$ChangePhoneNumberEnteringPhoneImpl value,
          $Res Function(_$ChangePhoneNumberEnteringPhoneImpl) then) =
      __$$ChangePhoneNumberEnteringPhoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phoneNumber, bool isSubmitting, String? errorMessage});
}

/// @nodoc
class __$$ChangePhoneNumberEnteringPhoneImplCopyWithImpl<$Res>
    extends _$ChangePhoneNumberStateCopyWithImpl<$Res,
        _$ChangePhoneNumberEnteringPhoneImpl>
    implements _$$ChangePhoneNumberEnteringPhoneImplCopyWith<$Res> {
  __$$ChangePhoneNumberEnteringPhoneImplCopyWithImpl(
      _$ChangePhoneNumberEnteringPhoneImpl _value,
      $Res Function(_$ChangePhoneNumberEnteringPhoneImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePhoneNumberState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? isSubmitting = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ChangePhoneNumberEnteringPhoneImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ChangePhoneNumberEnteringPhoneImpl
    implements ChangePhoneNumberEnteringPhone {
  const _$ChangePhoneNumberEnteringPhoneImpl(
      {this.phoneNumber = '', this.isSubmitting = false, this.errorMessage});

  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ChangePhoneNumberState.enteringPhone(phoneNumber: $phoneNumber, isSubmitting: $isSubmitting, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePhoneNumberEnteringPhoneImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phoneNumber, isSubmitting, errorMessage);

  /// Create a copy of ChangePhoneNumberState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePhoneNumberEnteringPhoneImplCopyWith<
          _$ChangePhoneNumberEnteringPhoneImpl>
      get copyWith => __$$ChangePhoneNumberEnteringPhoneImplCopyWithImpl<
          _$ChangePhoneNumberEnteringPhoneImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)
        enteringPhone,
    required TResult Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)
        enteringOtp,
    required TResult Function(String phoneNumber) success,
  }) {
    return enteringPhone(phoneNumber, isSubmitting, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)?
        enteringPhone,
    TResult? Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)?
        enteringOtp,
    TResult? Function(String phoneNumber)? success,
  }) {
    return enteringPhone?.call(phoneNumber, isSubmitting, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)?
        enteringPhone,
    TResult Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)?
        enteringOtp,
    TResult Function(String phoneNumber)? success,
    required TResult orElse(),
  }) {
    if (enteringPhone != null) {
      return enteringPhone(phoneNumber, isSubmitting, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangePhoneNumberEnteringPhone value)
        enteringPhone,
    required TResult Function(ChangePhoneNumberEnteringOtp value) enteringOtp,
    required TResult Function(ChangePhoneNumberSuccess value) success,
  }) {
    return enteringPhone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangePhoneNumberEnteringPhone value)? enteringPhone,
    TResult? Function(ChangePhoneNumberEnteringOtp value)? enteringOtp,
    TResult? Function(ChangePhoneNumberSuccess value)? success,
  }) {
    return enteringPhone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangePhoneNumberEnteringPhone value)? enteringPhone,
    TResult Function(ChangePhoneNumberEnteringOtp value)? enteringOtp,
    TResult Function(ChangePhoneNumberSuccess value)? success,
    required TResult orElse(),
  }) {
    if (enteringPhone != null) {
      return enteringPhone(this);
    }
    return orElse();
  }
}

abstract class ChangePhoneNumberEnteringPhone
    implements ChangePhoneNumberState {
  const factory ChangePhoneNumberEnteringPhone(
      {final String phoneNumber,
      final bool isSubmitting,
      final String? errorMessage}) = _$ChangePhoneNumberEnteringPhoneImpl;

  @override
  String get phoneNumber;
  bool get isSubmitting;
  String? get errorMessage;

  /// Create a copy of ChangePhoneNumberState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePhoneNumberEnteringPhoneImplCopyWith<
          _$ChangePhoneNumberEnteringPhoneImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangePhoneNumberEnteringOtpImplCopyWith<$Res>
    implements $ChangePhoneNumberStateCopyWith<$Res> {
  factory _$$ChangePhoneNumberEnteringOtpImplCopyWith(
          _$ChangePhoneNumberEnteringOtpImpl value,
          $Res Function(_$ChangePhoneNumberEnteringOtpImpl) then) =
      __$$ChangePhoneNumberEnteringOtpImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String phoneNumber,
      String otp,
      bool isVerifying,
      bool isResending,
      String? errorMessage});
}

/// @nodoc
class __$$ChangePhoneNumberEnteringOtpImplCopyWithImpl<$Res>
    extends _$ChangePhoneNumberStateCopyWithImpl<$Res,
        _$ChangePhoneNumberEnteringOtpImpl>
    implements _$$ChangePhoneNumberEnteringOtpImplCopyWith<$Res> {
  __$$ChangePhoneNumberEnteringOtpImplCopyWithImpl(
      _$ChangePhoneNumberEnteringOtpImpl _value,
      $Res Function(_$ChangePhoneNumberEnteringOtpImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePhoneNumberState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? otp = null,
    Object? isVerifying = null,
    Object? isResending = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ChangePhoneNumberEnteringOtpImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      isVerifying: null == isVerifying
          ? _value.isVerifying
          : isVerifying // ignore: cast_nullable_to_non_nullable
              as bool,
      isResending: null == isResending
          ? _value.isResending
          : isResending // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ChangePhoneNumberEnteringOtpImpl
    implements ChangePhoneNumberEnteringOtp {
  const _$ChangePhoneNumberEnteringOtpImpl(
      {required this.phoneNumber,
      this.otp = '',
      this.isVerifying = false,
      this.isResending = false,
      this.errorMessage});

  @override
  final String phoneNumber;
  @override
  @JsonKey()
  final String otp;
  @override
  @JsonKey()
  final bool isVerifying;
  @override
  @JsonKey()
  final bool isResending;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ChangePhoneNumberState.enteringOtp(phoneNumber: $phoneNumber, otp: $otp, isVerifying: $isVerifying, isResending: $isResending, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePhoneNumberEnteringOtpImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.isVerifying, isVerifying) ||
                other.isVerifying == isVerifying) &&
            (identical(other.isResending, isResending) ||
                other.isResending == isResending) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, phoneNumber, otp, isVerifying, isResending, errorMessage);

  /// Create a copy of ChangePhoneNumberState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePhoneNumberEnteringOtpImplCopyWith<
          _$ChangePhoneNumberEnteringOtpImpl>
      get copyWith => __$$ChangePhoneNumberEnteringOtpImplCopyWithImpl<
          _$ChangePhoneNumberEnteringOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)
        enteringPhone,
    required TResult Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)
        enteringOtp,
    required TResult Function(String phoneNumber) success,
  }) {
    return enteringOtp(
        phoneNumber, otp, isVerifying, isResending, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)?
        enteringPhone,
    TResult? Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)?
        enteringOtp,
    TResult? Function(String phoneNumber)? success,
  }) {
    return enteringOtp?.call(
        phoneNumber, otp, isVerifying, isResending, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)?
        enteringPhone,
    TResult Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)?
        enteringOtp,
    TResult Function(String phoneNumber)? success,
    required TResult orElse(),
  }) {
    if (enteringOtp != null) {
      return enteringOtp(
          phoneNumber, otp, isVerifying, isResending, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangePhoneNumberEnteringPhone value)
        enteringPhone,
    required TResult Function(ChangePhoneNumberEnteringOtp value) enteringOtp,
    required TResult Function(ChangePhoneNumberSuccess value) success,
  }) {
    return enteringOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangePhoneNumberEnteringPhone value)? enteringPhone,
    TResult? Function(ChangePhoneNumberEnteringOtp value)? enteringOtp,
    TResult? Function(ChangePhoneNumberSuccess value)? success,
  }) {
    return enteringOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangePhoneNumberEnteringPhone value)? enteringPhone,
    TResult Function(ChangePhoneNumberEnteringOtp value)? enteringOtp,
    TResult Function(ChangePhoneNumberSuccess value)? success,
    required TResult orElse(),
  }) {
    if (enteringOtp != null) {
      return enteringOtp(this);
    }
    return orElse();
  }
}

abstract class ChangePhoneNumberEnteringOtp implements ChangePhoneNumberState {
  const factory ChangePhoneNumberEnteringOtp(
      {required final String phoneNumber,
      final String otp,
      final bool isVerifying,
      final bool isResending,
      final String? errorMessage}) = _$ChangePhoneNumberEnteringOtpImpl;

  @override
  String get phoneNumber;
  String get otp;
  bool get isVerifying;
  bool get isResending;
  String? get errorMessage;

  /// Create a copy of ChangePhoneNumberState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePhoneNumberEnteringOtpImplCopyWith<
          _$ChangePhoneNumberEnteringOtpImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangePhoneNumberSuccessImplCopyWith<$Res>
    implements $ChangePhoneNumberStateCopyWith<$Res> {
  factory _$$ChangePhoneNumberSuccessImplCopyWith(
          _$ChangePhoneNumberSuccessImpl value,
          $Res Function(_$ChangePhoneNumberSuccessImpl) then) =
      __$$ChangePhoneNumberSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phoneNumber});
}

/// @nodoc
class __$$ChangePhoneNumberSuccessImplCopyWithImpl<$Res>
    extends _$ChangePhoneNumberStateCopyWithImpl<$Res,
        _$ChangePhoneNumberSuccessImpl>
    implements _$$ChangePhoneNumberSuccessImplCopyWith<$Res> {
  __$$ChangePhoneNumberSuccessImplCopyWithImpl(
      _$ChangePhoneNumberSuccessImpl _value,
      $Res Function(_$ChangePhoneNumberSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePhoneNumberState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
  }) {
    return _then(_$ChangePhoneNumberSuccessImpl(
      null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChangePhoneNumberSuccessImpl implements ChangePhoneNumberSuccess {
  const _$ChangePhoneNumberSuccessImpl(this.phoneNumber);

  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'ChangePhoneNumberState.success(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePhoneNumberSuccessImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);

  /// Create a copy of ChangePhoneNumberState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePhoneNumberSuccessImplCopyWith<_$ChangePhoneNumberSuccessImpl>
      get copyWith => __$$ChangePhoneNumberSuccessImplCopyWithImpl<
          _$ChangePhoneNumberSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)
        enteringPhone,
    required TResult Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)
        enteringOtp,
    required TResult Function(String phoneNumber) success,
  }) {
    return success(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)?
        enteringPhone,
    TResult? Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)?
        enteringOtp,
    TResult? Function(String phoneNumber)? success,
  }) {
    return success?.call(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String phoneNumber, bool isSubmitting, String? errorMessage)?
        enteringPhone,
    TResult Function(String phoneNumber, String otp, bool isVerifying,
            bool isResending, String? errorMessage)?
        enteringOtp,
    TResult Function(String phoneNumber)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangePhoneNumberEnteringPhone value)
        enteringPhone,
    required TResult Function(ChangePhoneNumberEnteringOtp value) enteringOtp,
    required TResult Function(ChangePhoneNumberSuccess value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangePhoneNumberEnteringPhone value)? enteringPhone,
    TResult? Function(ChangePhoneNumberEnteringOtp value)? enteringOtp,
    TResult? Function(ChangePhoneNumberSuccess value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangePhoneNumberEnteringPhone value)? enteringPhone,
    TResult Function(ChangePhoneNumberEnteringOtp value)? enteringOtp,
    TResult Function(ChangePhoneNumberSuccess value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ChangePhoneNumberSuccess implements ChangePhoneNumberState {
  const factory ChangePhoneNumberSuccess(final String phoneNumber) =
      _$ChangePhoneNumberSuccessImpl;

  @override
  String get phoneNumber;

  /// Create a copy of ChangePhoneNumberState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePhoneNumberSuccessImplCopyWith<_$ChangePhoneNumberSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}
