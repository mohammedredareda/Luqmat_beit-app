// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_discount_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateDiscountEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function(String value) percentageChanged,
    required TResult Function(DiscountRestrictionType type)
        restrictionTypeChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(DiscountRestrictionType type)? restrictionTypeChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function(String value)? percentageChanged,
    TResult Function(DiscountRestrictionType type)? restrictionTypeChanged,
    TResult Function(String value)? durationDaysChanged,
    TResult Function(String value)? usageLimitChanged,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_RestrictionTypeChanged value)
        restrictionTypeChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
    TResult Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDiscountEventCopyWith<$Res> {
  factory $CreateDiscountEventCopyWith(
          CreateDiscountEvent value, $Res Function(CreateDiscountEvent) then) =
      _$CreateDiscountEventCopyWithImpl<$Res, CreateDiscountEvent>;
}

/// @nodoc
class _$CreateDiscountEventCopyWithImpl<$Res, $Val extends CreateDiscountEvent>
    implements $CreateDiscountEventCopyWith<$Res> {
  _$CreateDiscountEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$MealSelectedImplCopyWith<$Res> {
  factory _$$MealSelectedImplCopyWith(
          _$MealSelectedImpl value, $Res Function(_$MealSelectedImpl) then) =
      __$$MealSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MealEntity meal});
}

/// @nodoc
class __$$MealSelectedImplCopyWithImpl<$Res>
    extends _$CreateDiscountEventCopyWithImpl<$Res, _$MealSelectedImpl>
    implements _$$MealSelectedImplCopyWith<$Res> {
  __$$MealSelectedImplCopyWithImpl(
      _$MealSelectedImpl _value, $Res Function(_$MealSelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meal = null,
  }) {
    return _then(_$MealSelectedImpl(
      null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as MealEntity,
    ));
  }
}

/// @nodoc

class _$MealSelectedImpl implements _MealSelected {
  const _$MealSelectedImpl(this.meal);

  @override
  final MealEntity meal;

  @override
  String toString() {
    return 'CreateDiscountEvent.mealSelected(meal: $meal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealSelectedImpl &&
            (identical(other.meal, meal) || other.meal == meal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, meal);

  /// Create a copy of CreateDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealSelectedImplCopyWith<_$MealSelectedImpl> get copyWith =>
      __$$MealSelectedImplCopyWithImpl<_$MealSelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function(String value) percentageChanged,
    required TResult Function(DiscountRestrictionType type)
        restrictionTypeChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return mealSelected(meal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(DiscountRestrictionType type)? restrictionTypeChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return mealSelected?.call(meal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function(String value)? percentageChanged,
    TResult Function(DiscountRestrictionType type)? restrictionTypeChanged,
    TResult Function(String value)? durationDaysChanged,
    TResult Function(String value)? usageLimitChanged,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) {
    if (mealSelected != null) {
      return mealSelected(meal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_RestrictionTypeChanged value)
        restrictionTypeChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return mealSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return mealSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
    TResult Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (mealSelected != null) {
      return mealSelected(this);
    }
    return orElse();
  }
}

abstract class _MealSelected implements CreateDiscountEvent {
  const factory _MealSelected(final MealEntity meal) = _$MealSelectedImpl;

  MealEntity get meal;

  /// Create a copy of CreateDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealSelectedImplCopyWith<_$MealSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$CreateDiscountEventCopyWithImpl<$Res, _$PercentageChangedImpl>
    implements _$$PercentageChangedImplCopyWith<$Res> {
  __$$PercentageChangedImplCopyWithImpl(_$PercentageChangedImpl _value,
      $Res Function(_$PercentageChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateDiscountEvent
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
    return 'CreateDiscountEvent.percentageChanged(value: $value)';
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

  /// Create a copy of CreateDiscountEvent
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
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function(String value) percentageChanged,
    required TResult Function(DiscountRestrictionType type)
        restrictionTypeChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return percentageChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(DiscountRestrictionType type)? restrictionTypeChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return percentageChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function(String value)? percentageChanged,
    TResult Function(DiscountRestrictionType type)? restrictionTypeChanged,
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
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_RestrictionTypeChanged value)
        restrictionTypeChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return percentageChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return percentageChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
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

abstract class _PercentageChanged implements CreateDiscountEvent {
  const factory _PercentageChanged(final String value) =
      _$PercentageChangedImpl;

  String get value;

  /// Create a copy of CreateDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PercentageChangedImplCopyWith<_$PercentageChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RestrictionTypeChangedImplCopyWith<$Res> {
  factory _$$RestrictionTypeChangedImplCopyWith(
          _$RestrictionTypeChangedImpl value,
          $Res Function(_$RestrictionTypeChangedImpl) then) =
      __$$RestrictionTypeChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DiscountRestrictionType type});
}

/// @nodoc
class __$$RestrictionTypeChangedImplCopyWithImpl<$Res>
    extends _$CreateDiscountEventCopyWithImpl<$Res,
        _$RestrictionTypeChangedImpl>
    implements _$$RestrictionTypeChangedImplCopyWith<$Res> {
  __$$RestrictionTypeChangedImplCopyWithImpl(
      _$RestrictionTypeChangedImpl _value,
      $Res Function(_$RestrictionTypeChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$RestrictionTypeChangedImpl(
      null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DiscountRestrictionType,
    ));
  }
}

/// @nodoc

class _$RestrictionTypeChangedImpl implements _RestrictionTypeChanged {
  const _$RestrictionTypeChangedImpl(this.type);

  @override
  final DiscountRestrictionType type;

  @override
  String toString() {
    return 'CreateDiscountEvent.restrictionTypeChanged(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestrictionTypeChangedImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  /// Create a copy of CreateDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestrictionTypeChangedImplCopyWith<_$RestrictionTypeChangedImpl>
      get copyWith => __$$RestrictionTypeChangedImplCopyWithImpl<
          _$RestrictionTypeChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function(String value) percentageChanged,
    required TResult Function(DiscountRestrictionType type)
        restrictionTypeChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return restrictionTypeChanged(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(DiscountRestrictionType type)? restrictionTypeChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return restrictionTypeChanged?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function(String value)? percentageChanged,
    TResult Function(DiscountRestrictionType type)? restrictionTypeChanged,
    TResult Function(String value)? durationDaysChanged,
    TResult Function(String value)? usageLimitChanged,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) {
    if (restrictionTypeChanged != null) {
      return restrictionTypeChanged(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_RestrictionTypeChanged value)
        restrictionTypeChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return restrictionTypeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return restrictionTypeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
    TResult Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (restrictionTypeChanged != null) {
      return restrictionTypeChanged(this);
    }
    return orElse();
  }
}

abstract class _RestrictionTypeChanged implements CreateDiscountEvent {
  const factory _RestrictionTypeChanged(final DiscountRestrictionType type) =
      _$RestrictionTypeChangedImpl;

  DiscountRestrictionType get type;

  /// Create a copy of CreateDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestrictionTypeChangedImplCopyWith<_$RestrictionTypeChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
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
    extends _$CreateDiscountEventCopyWithImpl<$Res, _$DurationDaysChangedImpl>
    implements _$$DurationDaysChangedImplCopyWith<$Res> {
  __$$DurationDaysChangedImplCopyWithImpl(_$DurationDaysChangedImpl _value,
      $Res Function(_$DurationDaysChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateDiscountEvent
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
    return 'CreateDiscountEvent.durationDaysChanged(value: $value)';
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

  /// Create a copy of CreateDiscountEvent
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
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function(String value) percentageChanged,
    required TResult Function(DiscountRestrictionType type)
        restrictionTypeChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return durationDaysChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(DiscountRestrictionType type)? restrictionTypeChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return durationDaysChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function(String value)? percentageChanged,
    TResult Function(DiscountRestrictionType type)? restrictionTypeChanged,
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
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_RestrictionTypeChanged value)
        restrictionTypeChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return durationDaysChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return durationDaysChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
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

abstract class _DurationDaysChanged implements CreateDiscountEvent {
  const factory _DurationDaysChanged(final String value) =
      _$DurationDaysChangedImpl;

  String get value;

  /// Create a copy of CreateDiscountEvent
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
    extends _$CreateDiscountEventCopyWithImpl<$Res, _$UsageLimitChangedImpl>
    implements _$$UsageLimitChangedImplCopyWith<$Res> {
  __$$UsageLimitChangedImplCopyWithImpl(_$UsageLimitChangedImpl _value,
      $Res Function(_$UsageLimitChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateDiscountEvent
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
    return 'CreateDiscountEvent.usageLimitChanged(value: $value)';
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

  /// Create a copy of CreateDiscountEvent
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
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function(String value) percentageChanged,
    required TResult Function(DiscountRestrictionType type)
        restrictionTypeChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return usageLimitChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(DiscountRestrictionType type)? restrictionTypeChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return usageLimitChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function(String value)? percentageChanged,
    TResult Function(DiscountRestrictionType type)? restrictionTypeChanged,
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
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_RestrictionTypeChanged value)
        restrictionTypeChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return usageLimitChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return usageLimitChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
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

abstract class _UsageLimitChanged implements CreateDiscountEvent {
  const factory _UsageLimitChanged(final String value) =
      _$UsageLimitChangedImpl;

  String get value;

  /// Create a copy of CreateDiscountEvent
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
    extends _$CreateDiscountEventCopyWithImpl<$Res, _$SubmitPressedImpl>
    implements _$$SubmitPressedImplCopyWith<$Res> {
  __$$SubmitPressedImplCopyWithImpl(
      _$SubmitPressedImpl _value, $Res Function(_$SubmitPressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateDiscountEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmitPressedImpl implements _SubmitPressed {
  const _$SubmitPressedImpl();

  @override
  String toString() {
    return 'CreateDiscountEvent.submitPressed()';
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
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function(String value) percentageChanged,
    required TResult Function(DiscountRestrictionType type)
        restrictionTypeChanged,
    required TResult Function(String value) durationDaysChanged,
    required TResult Function(String value) usageLimitChanged,
    required TResult Function() submitPressed,
  }) {
    return submitPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function(String value)? percentageChanged,
    TResult? Function(DiscountRestrictionType type)? restrictionTypeChanged,
    TResult? Function(String value)? durationDaysChanged,
    TResult? Function(String value)? usageLimitChanged,
    TResult? Function()? submitPressed,
  }) {
    return submitPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function(String value)? percentageChanged,
    TResult Function(DiscountRestrictionType type)? restrictionTypeChanged,
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
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_PercentageChanged value) percentageChanged,
    required TResult Function(_RestrictionTypeChanged value)
        restrictionTypeChanged,
    required TResult Function(_DurationDaysChanged value) durationDaysChanged,
    required TResult Function(_UsageLimitChanged value) usageLimitChanged,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return submitPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_PercentageChanged value)? percentageChanged,
    TResult? Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
    TResult? Function(_DurationDaysChanged value)? durationDaysChanged,
    TResult? Function(_UsageLimitChanged value)? usageLimitChanged,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return submitPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_PercentageChanged value)? percentageChanged,
    TResult Function(_RestrictionTypeChanged value)? restrictionTypeChanged,
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

abstract class _SubmitPressed implements CreateDiscountEvent {
  const factory _SubmitPressed() = _$SubmitPressedImpl;
}
