// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_offer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditOfferState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditOfferFormData data) form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditOfferFormData data)? form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditOfferFormData data)? form,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditOfferLoading value) loading,
    required TResult Function(EditOfferLoadError value) loadError,
    required TResult Function(EditOfferForm value) form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditOfferLoading value)? loading,
    TResult? Function(EditOfferLoadError value)? loadError,
    TResult? Function(EditOfferForm value)? form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditOfferLoading value)? loading,
    TResult Function(EditOfferLoadError value)? loadError,
    TResult Function(EditOfferForm value)? form,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditOfferStateCopyWith<$Res> {
  factory $EditOfferStateCopyWith(
          EditOfferState value, $Res Function(EditOfferState) then) =
      _$EditOfferStateCopyWithImpl<$Res, EditOfferState>;
}

/// @nodoc
class _$EditOfferStateCopyWithImpl<$Res, $Val extends EditOfferState>
    implements $EditOfferStateCopyWith<$Res> {
  _$EditOfferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditOfferState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EditOfferLoadingImplCopyWith<$Res> {
  factory _$$EditOfferLoadingImplCopyWith(_$EditOfferLoadingImpl value,
          $Res Function(_$EditOfferLoadingImpl) then) =
      __$$EditOfferLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EditOfferLoadingImplCopyWithImpl<$Res>
    extends _$EditOfferStateCopyWithImpl<$Res, _$EditOfferLoadingImpl>
    implements _$$EditOfferLoadingImplCopyWith<$Res> {
  __$$EditOfferLoadingImplCopyWithImpl(_$EditOfferLoadingImpl _value,
      $Res Function(_$EditOfferLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditOfferState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EditOfferLoadingImpl implements EditOfferLoading {
  const _$EditOfferLoadingImpl();

  @override
  String toString() {
    return 'EditOfferState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EditOfferLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditOfferFormData data) form,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditOfferFormData data)? form,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditOfferFormData data)? form,
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
    required TResult Function(EditOfferLoading value) loading,
    required TResult Function(EditOfferLoadError value) loadError,
    required TResult Function(EditOfferForm value) form,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditOfferLoading value)? loading,
    TResult? Function(EditOfferLoadError value)? loadError,
    TResult? Function(EditOfferForm value)? form,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditOfferLoading value)? loading,
    TResult Function(EditOfferLoadError value)? loadError,
    TResult Function(EditOfferForm value)? form,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EditOfferLoading implements EditOfferState {
  const factory EditOfferLoading() = _$EditOfferLoadingImpl;
}

/// @nodoc
abstract class _$$EditOfferLoadErrorImplCopyWith<$Res> {
  factory _$$EditOfferLoadErrorImplCopyWith(_$EditOfferLoadErrorImpl value,
          $Res Function(_$EditOfferLoadErrorImpl) then) =
      __$$EditOfferLoadErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$EditOfferLoadErrorImplCopyWithImpl<$Res>
    extends _$EditOfferStateCopyWithImpl<$Res, _$EditOfferLoadErrorImpl>
    implements _$$EditOfferLoadErrorImplCopyWith<$Res> {
  __$$EditOfferLoadErrorImplCopyWithImpl(_$EditOfferLoadErrorImpl _value,
      $Res Function(_$EditOfferLoadErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditOfferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$EditOfferLoadErrorImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$EditOfferLoadErrorImpl implements EditOfferLoadError {
  const _$EditOfferLoadErrorImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'EditOfferState.loadError(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditOfferLoadErrorImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of EditOfferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditOfferLoadErrorImplCopyWith<_$EditOfferLoadErrorImpl> get copyWith =>
      __$$EditOfferLoadErrorImplCopyWithImpl<_$EditOfferLoadErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditOfferFormData data) form,
  }) {
    return loadError(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditOfferFormData data)? form,
  }) {
    return loadError?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditOfferFormData data)? form,
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
    required TResult Function(EditOfferLoading value) loading,
    required TResult Function(EditOfferLoadError value) loadError,
    required TResult Function(EditOfferForm value) form,
  }) {
    return loadError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditOfferLoading value)? loading,
    TResult? Function(EditOfferLoadError value)? loadError,
    TResult? Function(EditOfferForm value)? form,
  }) {
    return loadError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditOfferLoading value)? loading,
    TResult Function(EditOfferLoadError value)? loadError,
    TResult Function(EditOfferForm value)? form,
    required TResult orElse(),
  }) {
    if (loadError != null) {
      return loadError(this);
    }
    return orElse();
  }
}

abstract class EditOfferLoadError implements EditOfferState {
  const factory EditOfferLoadError(final AppException exception) =
      _$EditOfferLoadErrorImpl;

  AppException get exception;

  /// Create a copy of EditOfferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditOfferLoadErrorImplCopyWith<_$EditOfferLoadErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditOfferFormImplCopyWith<$Res> {
  factory _$$EditOfferFormImplCopyWith(
          _$EditOfferFormImpl value, $Res Function(_$EditOfferFormImpl) then) =
      __$$EditOfferFormImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EditOfferFormData data});

  $EditOfferFormDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$EditOfferFormImplCopyWithImpl<$Res>
    extends _$EditOfferStateCopyWithImpl<$Res, _$EditOfferFormImpl>
    implements _$$EditOfferFormImplCopyWith<$Res> {
  __$$EditOfferFormImplCopyWithImpl(
      _$EditOfferFormImpl _value, $Res Function(_$EditOfferFormImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditOfferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$EditOfferFormImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as EditOfferFormData,
    ));
  }

  /// Create a copy of EditOfferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EditOfferFormDataCopyWith<$Res> get data {
    return $EditOfferFormDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc

class _$EditOfferFormImpl implements EditOfferForm {
  const _$EditOfferFormImpl(this.data);

  @override
  final EditOfferFormData data;

  @override
  String toString() {
    return 'EditOfferState.form(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditOfferFormImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of EditOfferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditOfferFormImplCopyWith<_$EditOfferFormImpl> get copyWith =>
      __$$EditOfferFormImplCopyWithImpl<_$EditOfferFormImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditOfferFormData data) form,
  }) {
    return form(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditOfferFormData data)? form,
  }) {
    return form?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditOfferFormData data)? form,
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
    required TResult Function(EditOfferLoading value) loading,
    required TResult Function(EditOfferLoadError value) loadError,
    required TResult Function(EditOfferForm value) form,
  }) {
    return form(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditOfferLoading value)? loading,
    TResult? Function(EditOfferLoadError value)? loadError,
    TResult? Function(EditOfferForm value)? form,
  }) {
    return form?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditOfferLoading value)? loading,
    TResult Function(EditOfferLoadError value)? loadError,
    TResult Function(EditOfferForm value)? form,
    required TResult orElse(),
  }) {
    if (form != null) {
      return form(this);
    }
    return orElse();
  }
}

abstract class EditOfferForm implements EditOfferState {
  const factory EditOfferForm(final EditOfferFormData data) =
      _$EditOfferFormImpl;

  EditOfferFormData get data;

  /// Create a copy of EditOfferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditOfferFormImplCopyWith<_$EditOfferFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EditOfferFormData {
  String get offerId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get totalPriceInput => throw _privateConstructorUsedError;
  String get durationDaysInput => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  int? get imageSizeBytes => throw _privateConstructorUsedError;
  List<OfferMealDraft> get includedMeals => throw _privateConstructorUsedError;
  OfferSubmitStatus get submitStatus => throw _privateConstructorUsedError;

  /// Create a copy of EditOfferFormData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditOfferFormDataCopyWith<EditOfferFormData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditOfferFormDataCopyWith<$Res> {
  factory $EditOfferFormDataCopyWith(
          EditOfferFormData value, $Res Function(EditOfferFormData) then) =
      _$EditOfferFormDataCopyWithImpl<$Res, EditOfferFormData>;
  @useResult
  $Res call(
      {String offerId,
      String name,
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
class _$EditOfferFormDataCopyWithImpl<$Res, $Val extends EditOfferFormData>
    implements $EditOfferFormDataCopyWith<$Res> {
  _$EditOfferFormDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditOfferFormData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerId = null,
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
      offerId: null == offerId
          ? _value.offerId
          : offerId // ignore: cast_nullable_to_non_nullable
              as String,
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

  /// Create a copy of EditOfferFormData
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
abstract class _$$EditOfferFormDataImplCopyWith<$Res>
    implements $EditOfferFormDataCopyWith<$Res> {
  factory _$$EditOfferFormDataImplCopyWith(_$EditOfferFormDataImpl value,
          $Res Function(_$EditOfferFormDataImpl) then) =
      __$$EditOfferFormDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String offerId,
      String name,
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
class __$$EditOfferFormDataImplCopyWithImpl<$Res>
    extends _$EditOfferFormDataCopyWithImpl<$Res, _$EditOfferFormDataImpl>
    implements _$$EditOfferFormDataImplCopyWith<$Res> {
  __$$EditOfferFormDataImplCopyWithImpl(_$EditOfferFormDataImpl _value,
      $Res Function(_$EditOfferFormDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditOfferFormData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerId = null,
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
    return _then(_$EditOfferFormDataImpl(
      offerId: null == offerId
          ? _value.offerId
          : offerId // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$EditOfferFormDataImpl implements _EditOfferFormData {
  const _$EditOfferFormDataImpl(
      {required this.offerId,
      this.name = '',
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
  final String offerId;
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
    return 'EditOfferFormData(offerId: $offerId, name: $name, description: $description, totalPriceInput: $totalPriceInput, durationDaysInput: $durationDaysInput, isActive: $isActive, imagePath: $imagePath, imageSizeBytes: $imageSizeBytes, includedMeals: $includedMeals, submitStatus: $submitStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditOfferFormDataImpl &&
            (identical(other.offerId, offerId) || other.offerId == offerId) &&
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
      offerId,
      name,
      description,
      totalPriceInput,
      durationDaysInput,
      isActive,
      imagePath,
      imageSizeBytes,
      const DeepCollectionEquality().hash(_includedMeals),
      submitStatus);

  /// Create a copy of EditOfferFormData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditOfferFormDataImplCopyWith<_$EditOfferFormDataImpl> get copyWith =>
      __$$EditOfferFormDataImplCopyWithImpl<_$EditOfferFormDataImpl>(
          this, _$identity);
}

abstract class _EditOfferFormData implements EditOfferFormData {
  const factory _EditOfferFormData(
      {required final String offerId,
      final String name,
      final String description,
      final String totalPriceInput,
      final String durationDaysInput,
      final bool isActive,
      final String? imagePath,
      final int? imageSizeBytes,
      final List<OfferMealDraft> includedMeals,
      final OfferSubmitStatus submitStatus}) = _$EditOfferFormDataImpl;

  @override
  String get offerId;
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

  /// Create a copy of EditOfferFormData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditOfferFormDataImplCopyWith<_$EditOfferFormDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
