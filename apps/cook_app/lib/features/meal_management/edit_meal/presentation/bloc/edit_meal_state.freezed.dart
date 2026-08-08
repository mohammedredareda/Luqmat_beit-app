// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_meal_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditMealState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditMealFormData data) form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditMealFormData data)? form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditMealFormData data)? form,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditMealLoading value) loading,
    required TResult Function(EditMealLoadError value) loadError,
    required TResult Function(EditMealForm value) form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditMealLoading value)? loading,
    TResult? Function(EditMealLoadError value)? loadError,
    TResult? Function(EditMealForm value)? form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditMealLoading value)? loading,
    TResult Function(EditMealLoadError value)? loadError,
    TResult Function(EditMealForm value)? form,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditMealStateCopyWith<$Res> {
  factory $EditMealStateCopyWith(
          EditMealState value, $Res Function(EditMealState) then) =
      _$EditMealStateCopyWithImpl<$Res, EditMealState>;
}

/// @nodoc
class _$EditMealStateCopyWithImpl<$Res, $Val extends EditMealState>
    implements $EditMealStateCopyWith<$Res> {
  _$EditMealStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditMealState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EditMealLoadingImplCopyWith<$Res> {
  factory _$$EditMealLoadingImplCopyWith(_$EditMealLoadingImpl value,
          $Res Function(_$EditMealLoadingImpl) then) =
      __$$EditMealLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EditMealLoadingImplCopyWithImpl<$Res>
    extends _$EditMealStateCopyWithImpl<$Res, _$EditMealLoadingImpl>
    implements _$$EditMealLoadingImplCopyWith<$Res> {
  __$$EditMealLoadingImplCopyWithImpl(
      _$EditMealLoadingImpl _value, $Res Function(_$EditMealLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditMealState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EditMealLoadingImpl implements EditMealLoading {
  const _$EditMealLoadingImpl();

  @override
  String toString() {
    return 'EditMealState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EditMealLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditMealFormData data) form,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditMealFormData data)? form,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditMealFormData data)? form,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditMealLoading value) loading,
    required TResult Function(EditMealLoadError value) loadError,
    required TResult Function(EditMealForm value) form,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditMealLoading value)? loading,
    TResult? Function(EditMealLoadError value)? loadError,
    TResult? Function(EditMealForm value)? form,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditMealLoading value)? loading,
    TResult Function(EditMealLoadError value)? loadError,
    TResult Function(EditMealForm value)? form,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EditMealLoading implements EditMealState {
  const factory EditMealLoading() = _$EditMealLoadingImpl;
}

/// @nodoc
abstract class _$$EditMealLoadErrorImplCopyWith<$Res> {
  factory _$$EditMealLoadErrorImplCopyWith(_$EditMealLoadErrorImpl value,
          $Res Function(_$EditMealLoadErrorImpl) then) =
      __$$EditMealLoadErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$EditMealLoadErrorImplCopyWithImpl<$Res>
    extends _$EditMealStateCopyWithImpl<$Res, _$EditMealLoadErrorImpl>
    implements _$$EditMealLoadErrorImplCopyWith<$Res> {
  __$$EditMealLoadErrorImplCopyWithImpl(_$EditMealLoadErrorImpl _value,
      $Res Function(_$EditMealLoadErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditMealState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$EditMealLoadErrorImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$EditMealLoadErrorImpl implements EditMealLoadError {
  const _$EditMealLoadErrorImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'EditMealState.loadError(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditMealLoadErrorImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of EditMealState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditMealLoadErrorImplCopyWith<_$EditMealLoadErrorImpl> get copyWith =>
      __$$EditMealLoadErrorImplCopyWithImpl<_$EditMealLoadErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditMealFormData data) form,
  }) {
    return loadError(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditMealFormData data)? form,
  }) {
    return loadError?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditMealFormData data)? form,
    required TResult orElse(),
  }) {
    if (loadError != null) {
      return loadError(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditMealLoading value) loading,
    required TResult Function(EditMealLoadError value) loadError,
    required TResult Function(EditMealForm value) form,
  }) {
    return loadError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditMealLoading value)? loading,
    TResult? Function(EditMealLoadError value)? loadError,
    TResult? Function(EditMealForm value)? form,
  }) {
    return loadError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditMealLoading value)? loading,
    TResult Function(EditMealLoadError value)? loadError,
    TResult Function(EditMealForm value)? form,
    required TResult orElse(),
  }) {
    if (loadError != null) {
      return loadError(this);
    }
    return orElse();
  }
}

abstract class EditMealLoadError implements EditMealState {
  const factory EditMealLoadError(final AppException exception) =
      _$EditMealLoadErrorImpl;

  AppException get exception;

  /// Create a copy of EditMealState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditMealLoadErrorImplCopyWith<_$EditMealLoadErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditMealFormImplCopyWith<$Res> {
  factory _$$EditMealFormImplCopyWith(
          _$EditMealFormImpl value, $Res Function(_$EditMealFormImpl) then) =
      __$$EditMealFormImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EditMealFormData data});

  $EditMealFormDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$EditMealFormImplCopyWithImpl<$Res>
    extends _$EditMealStateCopyWithImpl<$Res, _$EditMealFormImpl>
    implements _$$EditMealFormImplCopyWith<$Res> {
  __$$EditMealFormImplCopyWithImpl(
      _$EditMealFormImpl _value, $Res Function(_$EditMealFormImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditMealState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$EditMealFormImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as EditMealFormData,
    ));
  }

  /// Create a copy of EditMealState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EditMealFormDataCopyWith<$Res> get data {
    return $EditMealFormDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc

class _$EditMealFormImpl implements EditMealForm {
  const _$EditMealFormImpl(this.data);

  @override
  final EditMealFormData data;

  @override
  String toString() {
    return 'EditMealState.form(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditMealFormImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of EditMealState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditMealFormImplCopyWith<_$EditMealFormImpl> get copyWith =>
      __$$EditMealFormImplCopyWithImpl<_$EditMealFormImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditMealFormData data) form,
  }) {
    return form(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditMealFormData data)? form,
  }) {
    return form?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditMealFormData data)? form,
    required TResult orElse(),
  }) {
    if (form != null) {
      return form(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditMealLoading value) loading,
    required TResult Function(EditMealLoadError value) loadError,
    required TResult Function(EditMealForm value) form,
  }) {
    return form(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditMealLoading value)? loading,
    TResult? Function(EditMealLoadError value)? loadError,
    TResult? Function(EditMealForm value)? form,
  }) {
    return form?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditMealLoading value)? loading,
    TResult Function(EditMealLoadError value)? loadError,
    TResult Function(EditMealForm value)? form,
    required TResult orElse(),
  }) {
    if (form != null) {
      return form(this);
    }
    return orElse();
  }
}

abstract class EditMealForm implements EditMealState {
  const factory EditMealForm(final EditMealFormData data) = _$EditMealFormImpl;

  EditMealFormData get data;

  /// Create a copy of EditMealState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditMealFormImplCopyWith<_$EditMealFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EditMealFormData {
  String get mealId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Set<String> get categoryIds => throw _privateConstructorUsedError;
  String get preorderHoursInput => throw _privateConstructorUsedError;
  bool get sellWithVariations => throw _privateConstructorUsedError;
  String get priceInput => throw _privateConstructorUsedError;
  List<MealVariationDraft> get variations => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  int? get imageSizeBytes => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  MealSubmitStatus get submitStatus => throw _privateConstructorUsedError;

  /// Create a copy of EditMealFormData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditMealFormDataCopyWith<EditMealFormData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditMealFormDataCopyWith<$Res> {
  factory $EditMealFormDataCopyWith(
          EditMealFormData value, $Res Function(EditMealFormData) then) =
      _$EditMealFormDataCopyWithImpl<$Res, EditMealFormData>;
  @useResult
  $Res call(
      {String mealId,
      String name,
      String description,
      Set<String> categoryIds,
      String preorderHoursInput,
      bool sellWithVariations,
      String priceInput,
      List<MealVariationDraft> variations,
      String? imagePath,
      int? imageSizeBytes,
      bool isAvailable,
      MealSubmitStatus submitStatus});

  $MealSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class _$EditMealFormDataCopyWithImpl<$Res, $Val extends EditMealFormData>
    implements $EditMealFormDataCopyWith<$Res> {
  _$EditMealFormDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditMealFormData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealId = null,
    Object? name = null,
    Object? description = null,
    Object? categoryIds = null,
    Object? preorderHoursInput = null,
    Object? sellWithVariations = null,
    Object? priceInput = null,
    Object? variations = null,
    Object? imagePath = freezed,
    Object? imageSizeBytes = freezed,
    Object? isAvailable = null,
    Object? submitStatus = null,
  }) {
    return _then(_value.copyWith(
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
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
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as MealSubmitStatus,
    ) as $Val);
  }

  /// Create a copy of EditMealFormData
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
abstract class _$$EditMealFormDataImplCopyWith<$Res>
    implements $EditMealFormDataCopyWith<$Res> {
  factory _$$EditMealFormDataImplCopyWith(_$EditMealFormDataImpl value,
          $Res Function(_$EditMealFormDataImpl) then) =
      __$$EditMealFormDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String mealId,
      String name,
      String description,
      Set<String> categoryIds,
      String preorderHoursInput,
      bool sellWithVariations,
      String priceInput,
      List<MealVariationDraft> variations,
      String? imagePath,
      int? imageSizeBytes,
      bool isAvailable,
      MealSubmitStatus submitStatus});

  @override
  $MealSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class __$$EditMealFormDataImplCopyWithImpl<$Res>
    extends _$EditMealFormDataCopyWithImpl<$Res, _$EditMealFormDataImpl>
    implements _$$EditMealFormDataImplCopyWith<$Res> {
  __$$EditMealFormDataImplCopyWithImpl(_$EditMealFormDataImpl _value,
      $Res Function(_$EditMealFormDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditMealFormData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealId = null,
    Object? name = null,
    Object? description = null,
    Object? categoryIds = null,
    Object? preorderHoursInput = null,
    Object? sellWithVariations = null,
    Object? priceInput = null,
    Object? variations = null,
    Object? imagePath = freezed,
    Object? imageSizeBytes = freezed,
    Object? isAvailable = null,
    Object? submitStatus = null,
  }) {
    return _then(_$EditMealFormDataImpl(
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
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
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as MealSubmitStatus,
    ));
  }
}

/// @nodoc

class _$EditMealFormDataImpl implements _EditMealFormData {
  const _$EditMealFormDataImpl(
      {required this.mealId,
      this.name = '',
      this.description = '',
      final Set<String> categoryIds = const <String>{},
      this.preorderHoursInput = '',
      this.sellWithVariations = false,
      this.priceInput = '',
      final List<MealVariationDraft> variations = const <MealVariationDraft>[],
      this.imagePath,
      this.imageSizeBytes,
      this.isAvailable = true,
      this.submitStatus = const MealSubmitStatus.idle()})
      : _categoryIds = categoryIds,
        _variations = variations;

  @override
  final String mealId;
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
  final bool isAvailable;
  @override
  @JsonKey()
  final MealSubmitStatus submitStatus;

  @override
  String toString() {
    return 'EditMealFormData(mealId: $mealId, name: $name, description: $description, categoryIds: $categoryIds, preorderHoursInput: $preorderHoursInput, sellWithVariations: $sellWithVariations, priceInput: $priceInput, variations: $variations, imagePath: $imagePath, imageSizeBytes: $imageSizeBytes, isAvailable: $isAvailable, submitStatus: $submitStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditMealFormDataImpl &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
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
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.submitStatus, submitStatus) ||
                other.submitStatus == submitStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      mealId,
      name,
      description,
      const DeepCollectionEquality().hash(_categoryIds),
      preorderHoursInput,
      sellWithVariations,
      priceInput,
      const DeepCollectionEquality().hash(_variations),
      imagePath,
      imageSizeBytes,
      isAvailable,
      submitStatus);

  /// Create a copy of EditMealFormData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditMealFormDataImplCopyWith<_$EditMealFormDataImpl> get copyWith =>
      __$$EditMealFormDataImplCopyWithImpl<_$EditMealFormDataImpl>(
          this, _$identity);
}

abstract class _EditMealFormData implements EditMealFormData {
  const factory _EditMealFormData(
      {required final String mealId,
      final String name,
      final String description,
      final Set<String> categoryIds,
      final String preorderHoursInput,
      final bool sellWithVariations,
      final String priceInput,
      final List<MealVariationDraft> variations,
      final String? imagePath,
      final int? imageSizeBytes,
      final bool isAvailable,
      final MealSubmitStatus submitStatus}) = _$EditMealFormDataImpl;

  @override
  String get mealId;
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
  bool get isAvailable;
  @override
  MealSubmitStatus get submitStatus;

  /// Create a copy of EditMealFormData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditMealFormDataImplCopyWith<_$EditMealFormDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
