// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_discount_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditDiscountEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String discountId) started,
    required TResult Function() retryLoadPressed,
    required TResult Function(String value) percentageChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String discountId)? started,
    TResult? Function()? retryLoadPressed,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String discountId)? started,
    TResult Function()? retryLoadPressed,
    TResult Function(String value)? percentageChanged,
    TResult Function(String value)? durationDaysChanged,
    TResult Function(String value)? usageLimitChanged,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RetryLoadPressed value) retryLoadPressed,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditDiscountEventCopyWith<$Res> {
  factory $EditDiscountEventCopyWith(
          EditDiscountEvent value, $Res Function(EditDiscountEvent) then) =
      _$EditDiscountEventCopyWithImpl<$Res, EditDiscountEvent>;
}

/// @nodoc
class _$EditDiscountEventCopyWithImpl<$Res, $Val extends EditDiscountEvent>
    implements $EditDiscountEventCopyWith<$Res> {
  _$EditDiscountEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String discountId});
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$EditDiscountEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discountId = null,
  }) {
    return _then(_$StartedImpl(
      null == discountId
          ? _value.discountId
          : discountId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl(this.discountId);

  @override
  final String discountId;

  @override
  String toString() {
    return 'EditDiscountEvent.started(discountId: $discountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartedImpl &&
            (identical(other.discountId, discountId) ||
                other.discountId == discountId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, discountId);

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith =>
      __$$StartedImplCopyWithImpl<_$StartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String discountId) started,
    required TResult Function() retryLoadPressed,
    required TResult Function(String value) percentageChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return started(discountId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String discountId)? started,
    TResult? Function()? retryLoadPressed,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return started?.call(discountId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String discountId)? started,
    TResult Function()? retryLoadPressed,
    TResult Function(String value)? percentageChanged,
    TResult Function(String value)? durationDaysChanged,
    TResult Function(String value)? usageLimitChanged,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(discountId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RetryLoadPressed value) retryLoadPressed,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements EditDiscountEvent {
  const factory _Started(final String discountId) = _$StartedImpl;

  String get discountId;

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RetryLoadPressedImplCopyWith<$Res> {
  factory _$$RetryLoadPressedImplCopyWith(_$RetryLoadPressedImpl value,
          $Res Function(_$RetryLoadPressedImpl) then) =
      __$$RetryLoadPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RetryLoadPressedImplCopyWithImpl<$Res>
    extends _$EditDiscountEventCopyWithImpl<$Res, _$RetryLoadPressedImpl>
    implements _$$RetryLoadPressedImplCopyWith<$Res> {
  __$$RetryLoadPressedImplCopyWithImpl(_$RetryLoadPressedImpl _value,
      $Res Function(_$RetryLoadPressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RetryLoadPressedImpl implements _RetryLoadPressed {
  const _$RetryLoadPressedImpl();

  @override
  String toString() {
    return 'EditDiscountEvent.retryLoadPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RetryLoadPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String discountId) started,
    required TResult Function() retryLoadPressed,
    required TResult Function(String value) percentageChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return retryLoadPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String discountId)? started,
    TResult? Function()? retryLoadPressed,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return retryLoadPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String discountId)? started,
    TResult Function()? retryLoadPressed,
    TResult Function(String value)? percentageChanged,
    TResult Function(String value)? durationDaysChanged,
    TResult Function(String value)? usageLimitChanged,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) {
    if (retryLoadPressed != null) {
      return retryLoadPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RetryLoadPressed value) retryLoadPressed,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return retryLoadPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return retryLoadPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (retryLoadPressed != null) {
      return retryLoadPressed(this);
    }
    return orElse();
  }
}

abstract class _RetryLoadPressed implements EditDiscountEvent {
  const factory _RetryLoadPressed() = _$RetryLoadPressedImpl;
}

/// @nodoc
abstract class _$$PercentageChangedImplCopyWith<$Res> {
  factory _$$PercentageChangedImplCopyWith(_$PercentageChangedImpl value,
          $Res Function(_$PercentageChangedImpl) then) =
      __$$PercentageChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$PercentageChangedImplCopyWithImpl<$Res>
    extends _$EditDiscountEventCopyWithImpl<$Res, _$PercentageChangedImpl>
    implements _$$PercentageChangedImplCopyWith<$Res> {
  __$$PercentageChangedImplCopyWithImpl(_$PercentageChangedImpl _value,
      $Res Function(_$PercentageChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$PercentageChangedImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PercentageChangedImpl implements _PercentageChanged {
  const _$PercentageChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'EditDiscountEvent.percentageChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PercentageChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PercentageChangedImplCopyWith<_$PercentageChangedImpl> get copyWith =>
      __$$PercentageChangedImplCopyWithImpl<_$PercentageChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String discountId) started,
    required TResult Function() retryLoadPressed,
    required TResult Function(String value) percentageChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return percentageChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String discountId)? started,
    TResult? Function()? retryLoadPressed,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return percentageChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String discountId)? started,
    TResult Function()? retryLoadPressed,
    TResult Function(String value)? percentageChanged,
    TResult Function(String value)? durationDaysChanged,
    TResult Function(String value)? usageLimitChanged,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) {
    if (percentageChanged != null) {
      return percentageChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RetryLoadPressed value) retryLoadPressed,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return percentageChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return percentageChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (percentageChanged != null) {
      return percentageChanged(this);
    }
    return orElse();
  }
}

abstract class _PercentageChanged implements EditDiscountEvent {
  const factory _PercentageChanged(final String value) =
      _$PercentageChangedImpl;

  String get value;

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PercentageChangedImplCopyWith<_$PercentageChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DurationDaysChangedImplCopyWith<$Res> {
  factory _$$DurationDaysChangedImplCopyWith(_$DurationDaysChangedImpl value,
          $Res Function(_$DurationDaysChangedImpl) then) =
      __$$DurationDaysChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$DurationDaysChangedImplCopyWithImpl<$Res>
    extends _$EditDiscountEventCopyWithImpl<$Res, _$DurationDaysChangedImpl>
    implements _$$DurationDaysChangedImplCopyWith<$Res> {
  __$$DurationDaysChangedImplCopyWithImpl(_$DurationDaysChangedImpl _value,
      $Res Function(_$DurationDaysChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$DurationDaysChangedImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DurationDaysChangedImpl implements _DurationDaysChanged {
  const _$DurationDaysChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'EditDiscountEvent.durationDaysChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DurationDaysChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DurationDaysChangedImplCopyWith<_$DurationDaysChangedImpl> get copyWith =>
      __$$DurationDaysChangedImplCopyWithImpl<_$DurationDaysChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String discountId) started,
    required TResult Function() retryLoadPressed,
    required TResult Function(String value) percentageChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return durationDaysChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String discountId)? started,
    TResult? Function()? retryLoadPressed,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return durationDaysChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String discountId)? started,
    TResult Function()? retryLoadPressed,
    TResult Function(String value)? percentageChanged,
    TResult Function(String value)? durationDaysChanged,
    TResult Function(String value)? usageLimitChanged,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) {
    if (durationDaysChanged != null) {
      return durationDaysChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RetryLoadPressed value) retryLoadPressed,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return durationDaysChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return durationDaysChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (durationDaysChanged != null) {
      return durationDaysChanged(this);
    }
    return orElse();
  }
}

abstract class _DurationDaysChanged implements EditDiscountEvent {
  const factory _DurationDaysChanged(final String value) =
      _$DurationDaysChangedImpl;

  String get value;

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DurationDaysChangedImplCopyWith<_$DurationDaysChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UsageLimitChangedImplCopyWith<$Res> {
  factory _$$UsageLimitChangedImplCopyWith(_$UsageLimitChangedImpl value,
          $Res Function(_$UsageLimitChangedImpl) then) =
      __$$UsageLimitChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$UsageLimitChangedImplCopyWithImpl<$Res>
    extends _$EditDiscountEventCopyWithImpl<$Res, _$UsageLimitChangedImpl>
    implements _$$UsageLimitChangedImplCopyWith<$Res> {
  __$$UsageLimitChangedImplCopyWithImpl(_$UsageLimitChangedImpl _value,
      $Res Function(_$UsageLimitChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$UsageLimitChangedImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UsageLimitChangedImpl implements _UsageLimitChanged {
  const _$UsageLimitChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'EditDiscountEvent.usageLimitChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageLimitChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageLimitChangedImplCopyWith<_$UsageLimitChangedImpl> get copyWith =>
      __$$UsageLimitChangedImplCopyWithImpl<_$UsageLimitChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String discountId) started,
    required TResult Function() retryLoadPressed,
    required TResult Function(String value) percentageChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return usageLimitChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String discountId)? started,
    TResult? Function()? retryLoadPressed,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return usageLimitChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String discountId)? started,
    TResult Function()? retryLoadPressed,
    TResult Function(String value)? percentageChanged,
    TResult Function(String value)? durationDaysChanged,
    TResult Function(String value)? usageLimitChanged,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) {
    if (usageLimitChanged != null) {
      return usageLimitChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RetryLoadPressed value) retryLoadPressed,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return usageLimitChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return usageLimitChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (usageLimitChanged != null) {
      return usageLimitChanged(this);
    }
    return orElse();
  }
}

abstract class _UsageLimitChanged implements EditDiscountEvent {
  const factory _UsageLimitChanged(final String value) =
      _$UsageLimitChangedImpl;

  String get value;

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageLimitChangedImplCopyWith<_$UsageLimitChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitPressedImplCopyWith<$Res> {
  factory _$$SubmitPressedImplCopyWith(
          _$SubmitPressedImpl value, $Res Function(_$SubmitPressedImpl) then) =
      __$$SubmitPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitPressedImplCopyWithImpl<$Res>
    extends _$EditDiscountEventCopyWithImpl<$Res, _$SubmitPressedImpl>
    implements _$$SubmitPressedImplCopyWith<$Res> {
  __$$SubmitPressedImplCopyWithImpl(
      _$SubmitPressedImpl _value, $Res Function(_$SubmitPressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmitPressedImpl implements _SubmitPressed {
  const _$SubmitPressedImpl();

  @override
  String toString() {
    return 'EditDiscountEvent.submitPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmitPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String discountId) started,
    required TResult Function() retryLoadPressed,
    required TResult Function(String value) percentageChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return submitPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String discountId)? started,
    TResult? Function()? retryLoadPressed,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return submitPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String discountId)? started,
    TResult Function()? retryLoadPressed,
    TResult Function(String value)? percentageChanged,
    TResult Function(String value)? durationDaysChanged,
    TResult Function(String value)? usageLimitChanged,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) {
    if (submitPressed != null) {
      return submitPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RetryLoadPressed value) retryLoadPressed,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return submitPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return submitPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RetryLoadPressed value)? retryLoadPressed,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (submitPressed != null) {
      return submitPressed(this);
    }
    return orElse();
  }
}

abstract class _SubmitPressed implements EditDiscountEvent {
  const factory _SubmitPressed() = _$SubmitPressedImpl;
}
