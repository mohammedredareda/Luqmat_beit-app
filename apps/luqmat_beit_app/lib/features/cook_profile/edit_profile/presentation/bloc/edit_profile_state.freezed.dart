// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditProfileFormData data) form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditProfileFormData data)? form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditProfileFormData data)? form,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditProfileLoading value) loading,
    required TResult Function(EditProfileLoadError value) loadError,
    required TResult Function(EditProfileForm value) form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditProfileLoading value)? loading,
    TResult? Function(EditProfileLoadError value)? loadError,
    TResult? Function(EditProfileForm value)? form,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditProfileLoading value)? loading,
    TResult Function(EditProfileLoadError value)? loadError,
    TResult Function(EditProfileForm value)? form,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditProfileStateCopyWith<$Res> {
  factory $EditProfileStateCopyWith(
          EditProfileState value, $Res Function(EditProfileState) then) =
      _$EditProfileStateCopyWithImpl<$Res, EditProfileState>;
}

/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res, $Val extends EditProfileState>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EditProfileLoadingImplCopyWith<$Res> {
  factory _$$EditProfileLoadingImplCopyWith(_$EditProfileLoadingImpl value,
          $Res Function(_$EditProfileLoadingImpl) then) =
      __$$EditProfileLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EditProfileLoadingImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$EditProfileLoadingImpl>
    implements _$$EditProfileLoadingImplCopyWith<$Res> {
  __$$EditProfileLoadingImplCopyWithImpl(_$EditProfileLoadingImpl _value,
      $Res Function(_$EditProfileLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EditProfileLoadingImpl implements EditProfileLoading {
  const _$EditProfileLoadingImpl();

  @override
  String toString() {
    return 'EditProfileState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EditProfileLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditProfileFormData data) form,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditProfileFormData data)? form,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditProfileFormData data)? form,
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
    required TResult Function(EditProfileLoading value) loading,
    required TResult Function(EditProfileLoadError value) loadError,
    required TResult Function(EditProfileForm value) form,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditProfileLoading value)? loading,
    TResult? Function(EditProfileLoadError value)? loadError,
    TResult? Function(EditProfileForm value)? form,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditProfileLoading value)? loading,
    TResult Function(EditProfileLoadError value)? loadError,
    TResult Function(EditProfileForm value)? form,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EditProfileLoading implements EditProfileState {
  const factory EditProfileLoading() = _$EditProfileLoadingImpl;
}

/// @nodoc
abstract class _$$EditProfileLoadErrorImplCopyWith<$Res> {
  factory _$$EditProfileLoadErrorImplCopyWith(_$EditProfileLoadErrorImpl value,
          $Res Function(_$EditProfileLoadErrorImpl) then) =
      __$$EditProfileLoadErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$EditProfileLoadErrorImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$EditProfileLoadErrorImpl>
    implements _$$EditProfileLoadErrorImplCopyWith<$Res> {
  __$$EditProfileLoadErrorImplCopyWithImpl(_$EditProfileLoadErrorImpl _value,
      $Res Function(_$EditProfileLoadErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$EditProfileLoadErrorImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$EditProfileLoadErrorImpl implements EditProfileLoadError {
  const _$EditProfileLoadErrorImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'EditProfileState.loadError(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProfileLoadErrorImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProfileLoadErrorImplCopyWith<_$EditProfileLoadErrorImpl>
      get copyWith =>
          __$$EditProfileLoadErrorImplCopyWithImpl<_$EditProfileLoadErrorImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditProfileFormData data) form,
  }) {
    return loadError(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditProfileFormData data)? form,
  }) {
    return loadError?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditProfileFormData data)? form,
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
    required TResult Function(EditProfileLoading value) loading,
    required TResult Function(EditProfileLoadError value) loadError,
    required TResult Function(EditProfileForm value) form,
  }) {
    return loadError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditProfileLoading value)? loading,
    TResult? Function(EditProfileLoadError value)? loadError,
    TResult? Function(EditProfileForm value)? form,
  }) {
    return loadError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditProfileLoading value)? loading,
    TResult Function(EditProfileLoadError value)? loadError,
    TResult Function(EditProfileForm value)? form,
    required TResult orElse(),
  }) {
    if (loadError != null) {
      return loadError(this);
    }
    return orElse();
  }
}

abstract class EditProfileLoadError implements EditProfileState {
  const factory EditProfileLoadError(final AppException exception) =
      _$EditProfileLoadErrorImpl;

  AppException get exception;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditProfileLoadErrorImplCopyWith<_$EditProfileLoadErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditProfileFormImplCopyWith<$Res> {
  factory _$$EditProfileFormImplCopyWith(_$EditProfileFormImpl value,
          $Res Function(_$EditProfileFormImpl) then) =
      __$$EditProfileFormImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EditProfileFormData data});

  $EditProfileFormDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$EditProfileFormImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$EditProfileFormImpl>
    implements _$$EditProfileFormImplCopyWith<$Res> {
  __$$EditProfileFormImplCopyWithImpl(
      _$EditProfileFormImpl _value, $Res Function(_$EditProfileFormImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$EditProfileFormImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as EditProfileFormData,
    ));
  }

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EditProfileFormDataCopyWith<$Res> get data {
    return $EditProfileFormDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc

class _$EditProfileFormImpl implements EditProfileForm {
  const _$EditProfileFormImpl(this.data);

  @override
  final EditProfileFormData data;

  @override
  String toString() {
    return 'EditProfileState.form(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProfileFormImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProfileFormImplCopyWith<_$EditProfileFormImpl> get copyWith =>
      __$$EditProfileFormImplCopyWithImpl<_$EditProfileFormImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(AppException exception) loadError,
    required TResult Function(EditProfileFormData data) form,
  }) {
    return form(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(AppException exception)? loadError,
    TResult? Function(EditProfileFormData data)? form,
  }) {
    return form?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(AppException exception)? loadError,
    TResult Function(EditProfileFormData data)? form,
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
    required TResult Function(EditProfileLoading value) loading,
    required TResult Function(EditProfileLoadError value) loadError,
    required TResult Function(EditProfileForm value) form,
  }) {
    return form(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditProfileLoading value)? loading,
    TResult? Function(EditProfileLoadError value)? loadError,
    TResult? Function(EditProfileForm value)? form,
  }) {
    return form?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditProfileLoading value)? loading,
    TResult Function(EditProfileLoadError value)? loadError,
    TResult Function(EditProfileForm value)? form,
    required TResult orElse(),
  }) {
    if (form != null) {
      return form(this);
    }
    return orElse();
  }
}

abstract class EditProfileForm implements EditProfileState {
  const factory EditProfileForm(final EditProfileFormData data) =
      _$EditProfileFormImpl;

  EditProfileFormData get data;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditProfileFormImplCopyWith<_$EditProfileFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EditProfileFormData {
  String get fullName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get availabilityStartTime => throw _privateConstructorUsedError;
  String get availabilityEndTime => throw _privateConstructorUsedError;
  Set<Weekday> get selectedDays => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  bool get isDetectingLocation => throw _privateConstructorUsedError;
  String? get locationError => throw _privateConstructorUsedError;
  String? get avatarPath => throw _privateConstructorUsedError;
  int? get avatarSizeBytes => throw _privateConstructorUsedError;
  ProfileSubmitStatus get submitStatus => throw _privateConstructorUsedError;

  /// Create a copy of EditProfileFormData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditProfileFormDataCopyWith<EditProfileFormData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditProfileFormDataCopyWith<$Res> {
  factory $EditProfileFormDataCopyWith(
          EditProfileFormData value, $Res Function(EditProfileFormData) then) =
      _$EditProfileFormDataCopyWithImpl<$Res, EditProfileFormData>;
  @useResult
  $Res call(
      {String fullName,
      String phoneNumber,
      String bio,
      String address,
      String availabilityStartTime,
      String availabilityEndTime,
      Set<Weekday> selectedDays,
      double? latitude,
      double? longitude,
      bool isDetectingLocation,
      String? locationError,
      String? avatarPath,
      int? avatarSizeBytes,
      ProfileSubmitStatus submitStatus});

  $ProfileSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class _$EditProfileFormDataCopyWithImpl<$Res, $Val extends EditProfileFormData>
    implements $EditProfileFormDataCopyWith<$Res> {
  _$EditProfileFormDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditProfileFormData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? bio = null,
    Object? address = null,
    Object? availabilityStartTime = null,
    Object? availabilityEndTime = null,
    Object? selectedDays = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isDetectingLocation = null,
    Object? locationError = freezed,
    Object? avatarPath = freezed,
    Object? avatarSizeBytes = freezed,
    Object? submitStatus = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      availabilityStartTime: null == availabilityStartTime
          ? _value.availabilityStartTime
          : availabilityStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      availabilityEndTime: null == availabilityEndTime
          ? _value.availabilityEndTime
          : availabilityEndTime // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDays: null == selectedDays
          ? _value.selectedDays
          : selectedDays // ignore: cast_nullable_to_non_nullable
              as Set<Weekday>,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      isDetectingLocation: null == isDetectingLocation
          ? _value.isDetectingLocation
          : isDetectingLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      locationError: freezed == locationError
          ? _value.locationError
          : locationError // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarPath: freezed == avatarPath
          ? _value.avatarPath
          : avatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarSizeBytes: freezed == avatarSizeBytes
          ? _value.avatarSizeBytes
          : avatarSizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as ProfileSubmitStatus,
    ) as $Val);
  }

  /// Create a copy of EditProfileFormData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileSubmitStatusCopyWith<$Res> get submitStatus {
    return $ProfileSubmitStatusCopyWith<$Res>(_value.submitStatus, (value) {
      return _then(_value.copyWith(submitStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EditProfileFormDataImplCopyWith<$Res>
    implements $EditProfileFormDataCopyWith<$Res> {
  factory _$$EditProfileFormDataImplCopyWith(_$EditProfileFormDataImpl value,
          $Res Function(_$EditProfileFormDataImpl) then) =
      __$$EditProfileFormDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fullName,
      String phoneNumber,
      String bio,
      String address,
      String availabilityStartTime,
      String availabilityEndTime,
      Set<Weekday> selectedDays,
      double? latitude,
      double? longitude,
      bool isDetectingLocation,
      String? locationError,
      String? avatarPath,
      int? avatarSizeBytes,
      ProfileSubmitStatus submitStatus});

  @override
  $ProfileSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class __$$EditProfileFormDataImplCopyWithImpl<$Res>
    extends _$EditProfileFormDataCopyWithImpl<$Res, _$EditProfileFormDataImpl>
    implements _$$EditProfileFormDataImplCopyWith<$Res> {
  __$$EditProfileFormDataImplCopyWithImpl(_$EditProfileFormDataImpl _value,
      $Res Function(_$EditProfileFormDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProfileFormData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? bio = null,
    Object? address = null,
    Object? availabilityStartTime = null,
    Object? availabilityEndTime = null,
    Object? selectedDays = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isDetectingLocation = null,
    Object? locationError = freezed,
    Object? avatarPath = freezed,
    Object? avatarSizeBytes = freezed,
    Object? submitStatus = null,
  }) {
    return _then(_$EditProfileFormDataImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      availabilityStartTime: null == availabilityStartTime
          ? _value.availabilityStartTime
          : availabilityStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      availabilityEndTime: null == availabilityEndTime
          ? _value.availabilityEndTime
          : availabilityEndTime // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDays: null == selectedDays
          ? _value._selectedDays
          : selectedDays // ignore: cast_nullable_to_non_nullable
              as Set<Weekday>,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      isDetectingLocation: null == isDetectingLocation
          ? _value.isDetectingLocation
          : isDetectingLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      locationError: freezed == locationError
          ? _value.locationError
          : locationError // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarPath: freezed == avatarPath
          ? _value.avatarPath
          : avatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarSizeBytes: freezed == avatarSizeBytes
          ? _value.avatarSizeBytes
          : avatarSizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as ProfileSubmitStatus,
    ));
  }
}

/// @nodoc

class _$EditProfileFormDataImpl implements _EditProfileFormData {
  const _$EditProfileFormDataImpl(
      {this.fullName = '',
      this.phoneNumber = '',
      this.bio = '',
      this.address = '',
      this.availabilityStartTime = '09:00',
      this.availabilityEndTime = '17:00',
      final Set<Weekday> selectedDays = const <Weekday>{},
      this.latitude,
      this.longitude,
      this.isDetectingLocation = false,
      this.locationError,
      this.avatarPath,
      this.avatarSizeBytes,
      this.submitStatus = const ProfileSubmitStatus.idle()})
      : _selectedDays = selectedDays;

  @override
  @JsonKey()
  final String fullName;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final String bio;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String availabilityStartTime;
  @override
  @JsonKey()
  final String availabilityEndTime;
  final Set<Weekday> _selectedDays;
  @override
  @JsonKey()
  Set<Weekday> get selectedDays {
    if (_selectedDays is EqualUnmodifiableSetView) return _selectedDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedDays);
  }

  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey()
  final bool isDetectingLocation;
  @override
  final String? locationError;
  @override
  final String? avatarPath;
  @override
  final int? avatarSizeBytes;
  @override
  @JsonKey()
  final ProfileSubmitStatus submitStatus;

  @override
  String toString() {
    return 'EditProfileFormData(fullName: $fullName, phoneNumber: $phoneNumber, bio: $bio, address: $address, availabilityStartTime: $availabilityStartTime, availabilityEndTime: $availabilityEndTime, selectedDays: $selectedDays, latitude: $latitude, longitude: $longitude, isDetectingLocation: $isDetectingLocation, locationError: $locationError, avatarPath: $avatarPath, avatarSizeBytes: $avatarSizeBytes, submitStatus: $submitStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProfileFormDataImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.availabilityStartTime, availabilityStartTime) ||
                other.availabilityStartTime == availabilityStartTime) &&
            (identical(other.availabilityEndTime, availabilityEndTime) ||
                other.availabilityEndTime == availabilityEndTime) &&
            const DeepCollectionEquality()
                .equals(other._selectedDays, _selectedDays) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isDetectingLocation, isDetectingLocation) ||
                other.isDetectingLocation == isDetectingLocation) &&
            (identical(other.locationError, locationError) ||
                other.locationError == locationError) &&
            (identical(other.avatarPath, avatarPath) ||
                other.avatarPath == avatarPath) &&
            (identical(other.avatarSizeBytes, avatarSizeBytes) ||
                other.avatarSizeBytes == avatarSizeBytes) &&
            (identical(other.submitStatus, submitStatus) ||
                other.submitStatus == submitStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fullName,
      phoneNumber,
      bio,
      address,
      availabilityStartTime,
      availabilityEndTime,
      const DeepCollectionEquality().hash(_selectedDays),
      latitude,
      longitude,
      isDetectingLocation,
      locationError,
      avatarPath,
      avatarSizeBytes,
      submitStatus);

  /// Create a copy of EditProfileFormData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProfileFormDataImplCopyWith<_$EditProfileFormDataImpl> get copyWith =>
      __$$EditProfileFormDataImplCopyWithImpl<_$EditProfileFormDataImpl>(
          this, _$identity);
}

abstract class _EditProfileFormData implements EditProfileFormData {
  const factory _EditProfileFormData(
      {final String fullName,
      final String phoneNumber,
      final String bio,
      final String address,
      final String availabilityStartTime,
      final String availabilityEndTime,
      final Set<Weekday> selectedDays,
      final double? latitude,
      final double? longitude,
      final bool isDetectingLocation,
      final String? locationError,
      final String? avatarPath,
      final int? avatarSizeBytes,
      final ProfileSubmitStatus submitStatus}) = _$EditProfileFormDataImpl;

  @override
  String get fullName;
  @override
  String get phoneNumber;
  @override
  String get bio;
  @override
  String get address;
  @override
  String get availabilityStartTime;
  @override
  String get availabilityEndTime;
  @override
  Set<Weekday> get selectedDays;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  bool get isDetectingLocation;
  @override
  String? get locationError;
  @override
  String? get avatarPath;
  @override
  int? get avatarSizeBytes;
  @override
  ProfileSubmitStatus get submitStatus;

  /// Create a copy of EditProfileFormData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditProfileFormDataImplCopyWith<_$EditProfileFormDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
