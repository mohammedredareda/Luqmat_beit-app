// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_offer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateOfferState {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get totalPriceInput => throw _privateConstructorUsedError;
  String get durationDaysInput => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  int? get imageSizeBytes => throw _privateConstructorUsedError;
  List<OfferMealDraft> get includedMeals => throw _privateConstructorUsedError;
  OfferSubmitStatus get submitStatus => throw _privateConstructorUsedError;

  /// Create a copy of CreateOfferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateOfferStateCopyWith<CreateOfferState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateOfferStateCopyWith<$Res> {
  factory $CreateOfferStateCopyWith(
          CreateOfferState value, $Res Function(CreateOfferState) then) =
      _$CreateOfferStateCopyWithImpl<$Res, CreateOfferState>;
  @useResult
  $Res call(
      {String name,
      String description,
      String totalPriceInput,
      String durationDaysInput,
      bool isActive,
      String? imagePath,
      int? imageSizeBytes,
      List<OfferMealDraft> includedMeals,
      OfferSubmitStatus submitStatus});

  $OfferSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class _$CreateOfferStateCopyWithImpl<$Res, $Val extends CreateOfferState>
    implements $CreateOfferStateCopyWith<$Res> {
  _$CreateOfferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateOfferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? totalPriceInput = null,
    Object? durationDaysInput = null,
    Object? isActive = null,
    Object? imagePath = freezed,
    Object? imageSizeBytes = freezed,
    Object? includedMeals = null,
    Object? submitStatus = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      totalPriceInput: null == totalPriceInput
          ? _value.totalPriceInput
          : totalPriceInput // ignore: cast_nullable_to_non_nullable
              as String,
      durationDaysInput: null == durationDaysInput
          ? _value.durationDaysInput
          : durationDaysInput // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      imageSizeBytes: freezed == imageSizeBytes
          ? _value.imageSizeBytes
          : imageSizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      includedMeals: null == includedMeals
          ? _value.includedMeals
          : includedMeals // ignore: cast_nullable_to_non_nullable
              as List<OfferMealDraft>,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as OfferSubmitStatus,
    ) as $Val);
  }

  /// Create a copy of CreateOfferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OfferSubmitStatusCopyWith<$Res> get submitStatus {
    return $OfferSubmitStatusCopyWith<$Res>(_value.submitStatus, (value) {
      return _then(_value.copyWith(submitStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateOfferStateImplCopyWith<$Res>
    implements $CreateOfferStateCopyWith<$Res> {
  factory _$$CreateOfferStateImplCopyWith(_$CreateOfferStateImpl value,
          $Res Function(_$CreateOfferStateImpl) then) =
      __$$CreateOfferStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      String totalPriceInput,
      String durationDaysInput,
      bool isActive,
      String? imagePath,
      int? imageSizeBytes,
      List<OfferMealDraft> includedMeals,
      OfferSubmitStatus submitStatus});

  @override
  $OfferSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class __$$CreateOfferStateImplCopyWithImpl<$Res>
    extends _$CreateOfferStateCopyWithImpl<$Res, _$CreateOfferStateImpl>
    implements _$$CreateOfferStateImplCopyWith<$Res> {
  __$$CreateOfferStateImplCopyWithImpl(_$CreateOfferStateImpl _value,
      $Res Function(_$CreateOfferStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateOfferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? totalPriceInput = null,
    Object? durationDaysInput = null,
    Object? isActive = null,
    Object? imagePath = freezed,
    Object? imageSizeBytes = freezed,
    Object? includedMeals = null,
    Object? submitStatus = null,
  }) {
    return _then(_$CreateOfferStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      totalPriceInput: null == totalPriceInput
          ? _value.totalPriceInput
          : totalPriceInput // ignore: cast_nullable_to_non_nullable
              as String,
      durationDaysInput: null == durationDaysInput
          ? _value.durationDaysInput
          : durationDaysInput // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      imageSizeBytes: freezed == imageSizeBytes
          ? _value.imageSizeBytes
          : imageSizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      includedMeals: null == includedMeals
          ? _value._includedMeals
          : includedMeals // ignore: cast_nullable_to_non_nullable
              as List<OfferMealDraft>,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as OfferSubmitStatus,
    ));
  }
}

/// @nodoc

class _$CreateOfferStateImpl implements _CreateOfferState {
  const _$CreateOfferStateImpl(
      {this.name = '',
      this.description = '',
      this.totalPriceInput = '',
      this.durationDaysInput = '',
      this.isActive = true,
      this.imagePath,
      this.imageSizeBytes,
      final List<OfferMealDraft> includedMeals = const <OfferMealDraft>[],
      this.submitStatus = const OfferSubmitStatus.idle()})
      : _includedMeals = includedMeals;

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String totalPriceInput;
  @override
  @JsonKey()
  final String durationDaysInput;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? imagePath;
  @override
  final int? imageSizeBytes;
  final List<OfferMealDraft> _includedMeals;
  @override
  @JsonKey()
  List<OfferMealDraft> get includedMeals {
    if (_includedMeals is EqualUnmodifiableListView) return _includedMeals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_includedMeals);
  }

  @override
  @JsonKey()
  final OfferSubmitStatus submitStatus;

  @override
  String toString() {
    return 'CreateOfferState(name: $name, description: $description, totalPriceInput: $totalPriceInput, durationDaysInput: $durationDaysInput, isActive: $isActive, imagePath: $imagePath, imageSizeBytes: $imageSizeBytes, includedMeals: $includedMeals, submitStatus: $submitStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateOfferStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.totalPriceInput, totalPriceInput) ||
                other.totalPriceInput == totalPriceInput) &&
            (identical(other.durationDaysInput, durationDaysInput) ||
                other.durationDaysInput == durationDaysInput) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.imageSizeBytes, imageSizeBytes) ||
                other.imageSizeBytes == imageSizeBytes) &&
            const DeepCollectionEquality()
                .equals(other._includedMeals, _includedMeals) &&
            (identical(other.submitStatus, submitStatus) ||
                other.submitStatus == submitStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      totalPriceInput,
      durationDaysInput,
      isActive,
      imagePath,
      imageSizeBytes,
      const DeepCollectionEquality().hash(_includedMeals),
      submitStatus);

  /// Create a copy of CreateOfferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateOfferStateImplCopyWith<_$CreateOfferStateImpl> get copyWith =>
      __$$CreateOfferStateImplCopyWithImpl<_$CreateOfferStateImpl>(
          this, _$identity);
}

abstract class _CreateOfferState implements CreateOfferState {
  const factory _CreateOfferState(
      {final String name,
      final String description,
      final String totalPriceInput,
      final String durationDaysInput,
      final bool isActive,
      final String? imagePath,
      final int? imageSizeBytes,
      final List<OfferMealDraft> includedMeals,
      final OfferSubmitStatus submitStatus}) = _$CreateOfferStateImpl;

  @override
  String get name;
  @override
  String get description;
  @override
  String get totalPriceInput;
  @override
  String get durationDaysInput;
  @override
  bool get isActive;
  @override
  String? get imagePath;
  @override
  int? get imageSizeBytes;
  @override
  List<OfferMealDraft> get includedMeals;
  @override
  OfferSubmitStatus get submitStatus;

  /// Create a copy of CreateOfferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateOfferStateImplCopyWith<_$CreateOfferStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
