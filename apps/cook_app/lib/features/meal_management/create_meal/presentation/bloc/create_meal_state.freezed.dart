// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_meal_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateMealState {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Set<String> get categoryIds => throw _privateConstructorUsedError;
  String get preorderHoursInput => throw _privateConstructorUsedError;
  bool get sellWithVariations => throw _privateConstructorUsedError;
  String get priceInput => throw _privateConstructorUsedError;
  List<MealVariationDraft> get variations => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  int? get imageSizeBytes => throw _privateConstructorUsedError;
  MealSubmitStatus get submitStatus => throw _privateConstructorUsedError;

  /// Create a copy of CreateMealState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateMealStateCopyWith<CreateMealState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateMealStateCopyWith<$Res> {
  factory $CreateMealStateCopyWith(
          CreateMealState value, $Res Function(CreateMealState) then) =
      _$CreateMealStateCopyWithImpl<$Res, CreateMealState>;
  @useResult
  $Res call(
      {String name,
      String description,
      Set<String> categoryIds,
      String preorderHoursInput,
      bool sellWithVariations,
      String priceInput,
      List<MealVariationDraft> variations,
      String? imagePath,
      int? imageSizeBytes,
      MealSubmitStatus submitStatus});

  $MealSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class _$CreateMealStateCopyWithImpl<$Res, $Val extends CreateMealState>
    implements $CreateMealStateCopyWith<$Res> {
  _$CreateMealStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateMealState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? categoryIds = null,
    Object? preorderHoursInput = null,
    Object? sellWithVariations = null,
    Object? priceInput = null,
    Object? variations = null,
    Object? imagePath = freezed,
    Object? imageSizeBytes = freezed,
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
      categoryIds: null == categoryIds
          ? _value.categoryIds
          : categoryIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      preorderHoursInput: null == preorderHoursInput
          ? _value.preorderHoursInput
          : preorderHoursInput // ignore: cast_nullable_to_non_nullable
              as String,
      sellWithVariations: null == sellWithVariations
          ? _value.sellWithVariations
          : sellWithVariations // ignore: cast_nullable_to_non_nullable
              as bool,
      priceInput: null == priceInput
          ? _value.priceInput
          : priceInput // ignore: cast_nullable_to_non_nullable
              as String,
      variations: null == variations
          ? _value.variations
          : variations // ignore: cast_nullable_to_non_nullable
              as List<MealVariationDraft>,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      imageSizeBytes: freezed == imageSizeBytes
          ? _value.imageSizeBytes
          : imageSizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as MealSubmitStatus,
    ) as $Val);
  }

  /// Create a copy of CreateMealState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealSubmitStatusCopyWith<$Res> get submitStatus {
    return $MealSubmitStatusCopyWith<$Res>(_value.submitStatus, (value) {
      return _then(_value.copyWith(submitStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateMealStateImplCopyWith<$Res>
    implements $CreateMealStateCopyWith<$Res> {
  factory _$$CreateMealStateImplCopyWith(_$CreateMealStateImpl value,
          $Res Function(_$CreateMealStateImpl) then) =
      __$$CreateMealStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      Set<String> categoryIds,
      String preorderHoursInput,
      bool sellWithVariations,
      String priceInput,
      List<MealVariationDraft> variations,
      String? imagePath,
      int? imageSizeBytes,
      MealSubmitStatus submitStatus});

  @override
  $MealSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class __$$CreateMealStateImplCopyWithImpl<$Res>
    extends _$CreateMealStateCopyWithImpl<$Res, _$CreateMealStateImpl>
    implements _$$CreateMealStateImplCopyWith<$Res> {
  __$$CreateMealStateImplCopyWithImpl(
      _$CreateMealStateImpl _value, $Res Function(_$CreateMealStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateMealState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? categoryIds = null,
    Object? preorderHoursInput = null,
    Object? sellWithVariations = null,
    Object? priceInput = null,
    Object? variations = null,
    Object? imagePath = freezed,
    Object? imageSizeBytes = freezed,
    Object? submitStatus = null,
  }) {
    return _then(_$CreateMealStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      categoryIds: null == categoryIds
          ? _value._categoryIds
          : categoryIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      preorderHoursInput: null == preorderHoursInput
          ? _value.preorderHoursInput
          : preorderHoursInput // ignore: cast_nullable_to_non_nullable
              as String,
      sellWithVariations: null == sellWithVariations
          ? _value.sellWithVariations
          : sellWithVariations // ignore: cast_nullable_to_non_nullable
              as bool,
      priceInput: null == priceInput
          ? _value.priceInput
          : priceInput // ignore: cast_nullable_to_non_nullable
              as String,
      variations: null == variations
          ? _value._variations
          : variations // ignore: cast_nullable_to_non_nullable
              as List<MealVariationDraft>,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      imageSizeBytes: freezed == imageSizeBytes
          ? _value.imageSizeBytes
          : imageSizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as MealSubmitStatus,
    ));
  }
}

/// @nodoc

class _$CreateMealStateImpl implements _CreateMealState {
  const _$CreateMealStateImpl(
      {this.name = '',
      this.description = '',
      final Set<String> categoryIds = const <String>{},
      this.preorderHoursInput = '',
      this.sellWithVariations = false,
      this.priceInput = '',
      final List<MealVariationDraft> variations = const <MealVariationDraft>[],
      this.imagePath,
      this.imageSizeBytes,
      this.submitStatus = const MealSubmitStatus.idle()})
      : _categoryIds = categoryIds,
        _variations = variations;

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  final Set<String> _categoryIds;
  @override
  @JsonKey()
  Set<String> get categoryIds {
    if (_categoryIds is EqualUnmodifiableSetView) return _categoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_categoryIds);
  }

  @override
  @JsonKey()
  final String preorderHoursInput;
  @override
  @JsonKey()
  final bool sellWithVariations;
  @override
  @JsonKey()
  final String priceInput;
  final List<MealVariationDraft> _variations;
  @override
  @JsonKey()
  List<MealVariationDraft> get variations {
    if (_variations is EqualUnmodifiableListView) return _variations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variations);
  }

  @override
  final String? imagePath;
  @override
  final int? imageSizeBytes;
  @override
  @JsonKey()
  final MealSubmitStatus submitStatus;

  @override
  String toString() {
    return 'CreateMealState(name: $name, description: $description, categoryIds: $categoryIds, preorderHoursInput: $preorderHoursInput, sellWithVariations: $sellWithVariations, priceInput: $priceInput, variations: $variations, imagePath: $imagePath, imageSizeBytes: $imageSizeBytes, submitStatus: $submitStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateMealStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._categoryIds, _categoryIds) &&
            (identical(other.preorderHoursInput, preorderHoursInput) ||
                other.preorderHoursInput == preorderHoursInput) &&
            (identical(other.sellWithVariations, sellWithVariations) ||
                other.sellWithVariations == sellWithVariations) &&
            (identical(other.priceInput, priceInput) ||
                other.priceInput == priceInput) &&
            const DeepCollectionEquality()
                .equals(other._variations, _variations) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.imageSizeBytes, imageSizeBytes) ||
                other.imageSizeBytes == imageSizeBytes) &&
            (identical(other.submitStatus, submitStatus) ||
                other.submitStatus == submitStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(_categoryIds),
      preorderHoursInput,
      sellWithVariations,
      priceInput,
      const DeepCollectionEquality().hash(_variations),
      imagePath,
      imageSizeBytes,
      submitStatus);

  /// Create a copy of CreateMealState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateMealStateImplCopyWith<_$CreateMealStateImpl> get copyWith =>
      __$$CreateMealStateImplCopyWithImpl<_$CreateMealStateImpl>(
          this, _$identity);
}

abstract class _CreateMealState implements CreateMealState {
  const factory _CreateMealState(
      {final String name,
      final String description,
      final Set<String> categoryIds,
      final String preorderHoursInput,
      final bool sellWithVariations,
      final String priceInput,
      final List<MealVariationDraft> variations,
      final String? imagePath,
      final int? imageSizeBytes,
      final MealSubmitStatus submitStatus}) = _$CreateMealStateImpl;

  @override
  String get name;
  @override
  String get description;
  @override
  Set<String> get categoryIds;
  @override
  String get preorderHoursInput;
  @override
  bool get sellWithVariations;
  @override
  String get priceInput;
  @override
  List<MealVariationDraft> get variations;
  @override
  String? get imagePath;
  @override
  int? get imageSizeBytes;
  @override
  MealSubmitStatus get submitStatus;

  /// Create a copy of CreateMealState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateMealStateImplCopyWith<_$CreateMealStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
