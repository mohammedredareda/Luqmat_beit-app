// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_discount_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateDiscountState {
  MealEntity? get selectedMeal => throw _privateConstructorUsedError;
  String get percentageInput => throw _privateConstructorUsedError;
  DiscountRestrictionType get restrictionType =>
      throw _privateConstructorUsedError;
  String get durationDaysInput => throw _privateConstructorUsedError;
  String get usageLimitInput => throw _privateConstructorUsedError;
  DiscountSubmitStatus get submitStatus => throw _privateConstructorUsedError;

  /// Create a copy of CreateDiscountState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateDiscountStateCopyWith<CreateDiscountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDiscountStateCopyWith<$Res> {
  factory $CreateDiscountStateCopyWith(
          CreateDiscountState value, $Res Function(CreateDiscountState) then) =
      _$CreateDiscountStateCopyWithImpl<$Res, CreateDiscountState>;
  @useResult
  $Res call(
      {MealEntity? selectedMeal,
      String percentageInput,
      DiscountRestrictionType restrictionType,
      String durationDaysInput,
      String usageLimitInput,
      DiscountSubmitStatus submitStatus});

  $DiscountSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class _$CreateDiscountStateCopyWithImpl<$Res, $Val extends CreateDiscountState>
    implements $CreateDiscountStateCopyWith<$Res> {
  _$CreateDiscountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateDiscountState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedMeal = freezed,
    Object? percentageInput = null,
    Object? restrictionType = null,
    Object? durationDaysInput = null,
    Object? usageLimitInput = null,
    Object? submitStatus = null,
  }) {
    return _then(_value.copyWith(
      selectedMeal: freezed == selectedMeal
          ? _value.selectedMeal
          : selectedMeal // ignore: cast_nullable_to_non_nullable
              as MealEntity?,
      percentageInput: null == percentageInput
          ? _value.percentageInput
          : percentageInput // ignore: cast_nullable_to_non_nullable
              as String,
      restrictionType: null == restrictionType
          ? _value.restrictionType
          : restrictionType // ignore: cast_nullable_to_non_nullable
              as DiscountRestrictionType,
      durationDaysInput: null == durationDaysInput
          ? _value.durationDaysInput
          : durationDaysInput // ignore: cast_nullable_to_non_nullable
              as String,
      usageLimitInput: null == usageLimitInput
          ? _value.usageLimitInput
          : usageLimitInput // ignore: cast_nullable_to_non_nullable
              as String,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as DiscountSubmitStatus,
    ) as $Val);
  }

  /// Create a copy of CreateDiscountState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscountSubmitStatusCopyWith<$Res> get submitStatus {
    return $DiscountSubmitStatusCopyWith<$Res>(_value.submitStatus, (value) {
      return _then(_value.copyWith(submitStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateDiscountStateImplCopyWith<$Res>
    implements $CreateDiscountStateCopyWith<$Res> {
  factory _$$CreateDiscountStateImplCopyWith(_$CreateDiscountStateImpl value,
          $Res Function(_$CreateDiscountStateImpl) then) =
      __$$CreateDiscountStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MealEntity? selectedMeal,
      String percentageInput,
      DiscountRestrictionType restrictionType,
      String durationDaysInput,
      String usageLimitInput,
      DiscountSubmitStatus submitStatus});

  @override
  $DiscountSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class __$$CreateDiscountStateImplCopyWithImpl<$Res>
    extends _$CreateDiscountStateCopyWithImpl<$Res, _$CreateDiscountStateImpl>
    implements _$$CreateDiscountStateImplCopyWith<$Res> {
  __$$CreateDiscountStateImplCopyWithImpl(_$CreateDiscountStateImpl _value,
      $Res Function(_$CreateDiscountStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateDiscountState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedMeal = freezed,
    Object? percentageInput = null,
    Object? restrictionType = null,
    Object? durationDaysInput = null,
    Object? usageLimitInput = null,
    Object? submitStatus = null,
  }) {
    return _then(_$CreateDiscountStateImpl(
      selectedMeal: freezed == selectedMeal
          ? _value.selectedMeal
          : selectedMeal // ignore: cast_nullable_to_non_nullable
              as MealEntity?,
      percentageInput: null == percentageInput
          ? _value.percentageInput
          : percentageInput // ignore: cast_nullable_to_non_nullable
              as String,
      restrictionType: null == restrictionType
          ? _value.restrictionType
          : restrictionType // ignore: cast_nullable_to_non_nullable
              as DiscountRestrictionType,
      durationDaysInput: null == durationDaysInput
          ? _value.durationDaysInput
          : durationDaysInput // ignore: cast_nullable_to_non_nullable
              as String,
      usageLimitInput: null == usageLimitInput
          ? _value.usageLimitInput
          : usageLimitInput // ignore: cast_nullable_to_non_nullable
              as String,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as DiscountSubmitStatus,
    ));
  }
}

/// @nodoc

class _$CreateDiscountStateImpl implements _CreateDiscountState {
  const _$CreateDiscountStateImpl(
      {this.selectedMeal,
      this.percentageInput = '',
      this.restrictionType = DiscountRestrictionType.duration,
      this.durationDaysInput = '',
      this.usageLimitInput = '',
      this.submitStatus = const DiscountSubmitStatus.idle()});

  @override
  final MealEntity? selectedMeal;
  @override
  @JsonKey()
  final String percentageInput;
  @override
  @JsonKey()
  final DiscountRestrictionType restrictionType;
  @override
  @JsonKey()
  final String durationDaysInput;
  @override
  @JsonKey()
  final String usageLimitInput;
  @override
  @JsonKey()
  final DiscountSubmitStatus submitStatus;

  @override
  String toString() {
    return 'CreateDiscountState(selectedMeal: $selectedMeal, percentageInput: $percentageInput, restrictionType: $restrictionType, durationDaysInput: $durationDaysInput, usageLimitInput: $usageLimitInput, submitStatus: $submitStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateDiscountStateImpl &&
            (identical(other.selectedMeal, selectedMeal) ||
                other.selectedMeal == selectedMeal) &&
            (identical(other.percentageInput, percentageInput) ||
                other.percentageInput == percentageInput) &&
            (identical(other.restrictionType, restrictionType) ||
                other.restrictionType == restrictionType) &&
            (identical(other.durationDaysInput, durationDaysInput) ||
                other.durationDaysInput == durationDaysInput) &&
            (identical(other.usageLimitInput, usageLimitInput) ||
                other.usageLimitInput == usageLimitInput) &&
            (identical(other.submitStatus, submitStatus) ||
                other.submitStatus == submitStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedMeal, percentageInput,
      restrictionType, durationDaysInput, usageLimitInput, submitStatus);

  /// Create a copy of CreateDiscountState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateDiscountStateImplCopyWith<_$CreateDiscountStateImpl> get copyWith =>
      __$$CreateDiscountStateImplCopyWithImpl<_$CreateDiscountStateImpl>(
          this, _$identity);
}

abstract class _CreateDiscountState implements CreateDiscountState {
  const factory _CreateDiscountState(
      {final MealEntity? selectedMeal,
      final String percentageInput,
      final DiscountRestrictionType restrictionType,
      final String durationDaysInput,
      final String usageLimitInput,
      final DiscountSubmitStatus submitStatus}) = _$CreateDiscountStateImpl;

  @override
  MealEntity? get selectedMeal;
  @override
  String get percentageInput;
  @override
  DiscountRestrictionType get restrictionType;
  @override
  String get durationDaysInput;
  @override
  String get usageLimitInput;
  @override
  DiscountSubmitStatus get submitStatus;

  /// Create a copy of CreateDiscountState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateDiscountStateImplCopyWith<_$CreateDiscountStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
