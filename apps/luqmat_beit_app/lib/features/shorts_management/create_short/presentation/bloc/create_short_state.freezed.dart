// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_short_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateShortState {
  String? get videoPath => throw _privateConstructorUsedError;
  int? get videoSizeBytes => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  MealEntity? get selectedMeal => throw _privateConstructorUsedError;
  ShortSubmitStatus get submitStatus => throw _privateConstructorUsedError;

  /// Create a copy of CreateShortState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateShortStateCopyWith<CreateShortState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateShortStateCopyWith<$Res> {
  factory $CreateShortStateCopyWith(
          CreateShortState value, $Res Function(CreateShortState) then) =
      _$CreateShortStateCopyWithImpl<$Res, CreateShortState>;
  @useResult
  $Res call(
      {String? videoPath,
      int? videoSizeBytes,
      String description,
      MealEntity? selectedMeal,
      ShortSubmitStatus submitStatus});

  $ShortSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class _$CreateShortStateCopyWithImpl<$Res, $Val extends CreateShortState>
    implements $CreateShortStateCopyWith<$Res> {
  _$CreateShortStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateShortState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoPath = freezed,
    Object? videoSizeBytes = freezed,
    Object? description = null,
    Object? selectedMeal = freezed,
    Object? submitStatus = null,
  }) {
    return _then(_value.copyWith(
      videoPath: freezed == videoPath
          ? _value.videoPath
          : videoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      videoSizeBytes: freezed == videoSizeBytes
          ? _value.videoSizeBytes
          : videoSizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      selectedMeal: freezed == selectedMeal
          ? _value.selectedMeal
          : selectedMeal // ignore: cast_nullable_to_non_nullable
              as MealEntity?,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as ShortSubmitStatus,
    ) as $Val);
  }

  /// Create a copy of CreateShortState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShortSubmitStatusCopyWith<$Res> get submitStatus {
    return $ShortSubmitStatusCopyWith<$Res>(_value.submitStatus, (value) {
      return _then(_value.copyWith(submitStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateShortStateImplCopyWith<$Res>
    implements $CreateShortStateCopyWith<$Res> {
  factory _$$CreateShortStateImplCopyWith(_$CreateShortStateImpl value,
          $Res Function(_$CreateShortStateImpl) then) =
      __$$CreateShortStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? videoPath,
      int? videoSizeBytes,
      String description,
      MealEntity? selectedMeal,
      ShortSubmitStatus submitStatus});

  @override
  $ShortSubmitStatusCopyWith<$Res> get submitStatus;
}

/// @nodoc
class __$$CreateShortStateImplCopyWithImpl<$Res>
    extends _$CreateShortStateCopyWithImpl<$Res, _$CreateShortStateImpl>
    implements _$$CreateShortStateImplCopyWith<$Res> {
  __$$CreateShortStateImplCopyWithImpl(_$CreateShortStateImpl _value,
      $Res Function(_$CreateShortStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateShortState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoPath = freezed,
    Object? videoSizeBytes = freezed,
    Object? description = null,
    Object? selectedMeal = freezed,
    Object? submitStatus = null,
  }) {
    return _then(_$CreateShortStateImpl(
      videoPath: freezed == videoPath
          ? _value.videoPath
          : videoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      videoSizeBytes: freezed == videoSizeBytes
          ? _value.videoSizeBytes
          : videoSizeBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      selectedMeal: freezed == selectedMeal
          ? _value.selectedMeal
          : selectedMeal // ignore: cast_nullable_to_non_nullable
              as MealEntity?,
      submitStatus: null == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as ShortSubmitStatus,
    ));
  }
}

/// @nodoc

class _$CreateShortStateImpl implements _CreateShortState {
  const _$CreateShortStateImpl(
      {this.videoPath,
      this.videoSizeBytes,
      this.description = '',
      this.selectedMeal,
      this.submitStatus = const ShortSubmitStatus.idle()});

  @override
  final String? videoPath;
  @override
  final int? videoSizeBytes;
  @override
  @JsonKey()
  final String description;
  @override
  final MealEntity? selectedMeal;
  @override
  @JsonKey()
  final ShortSubmitStatus submitStatus;

  @override
  String toString() {
    return 'CreateShortState(videoPath: $videoPath, videoSizeBytes: $videoSizeBytes, description: $description, selectedMeal: $selectedMeal, submitStatus: $submitStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateShortStateImpl &&
            (identical(other.videoPath, videoPath) ||
                other.videoPath == videoPath) &&
            (identical(other.videoSizeBytes, videoSizeBytes) ||
                other.videoSizeBytes == videoSizeBytes) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.selectedMeal, selectedMeal) ||
                other.selectedMeal == selectedMeal) &&
            (identical(other.submitStatus, submitStatus) ||
                other.submitStatus == submitStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, videoPath, videoSizeBytes,
      description, selectedMeal, submitStatus);

  /// Create a copy of CreateShortState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateShortStateImplCopyWith<_$CreateShortStateImpl> get copyWith =>
      __$$CreateShortStateImplCopyWithImpl<_$CreateShortStateImpl>(
          this, _$identity);
}

abstract class _CreateShortState implements CreateShortState {
  const factory _CreateShortState(
      {final String? videoPath,
      final int? videoSizeBytes,
      final String description,
      final MealEntity? selectedMeal,
      final ShortSubmitStatus submitStatus}) = _$CreateShortStateImpl;

  @override
  String? get videoPath;
  @override
  int? get videoSizeBytes;
  @override
  String get description;
  @override
  MealEntity? get selectedMeal;
  @override
  ShortSubmitStatus get submitStatus;

  /// Create a copy of CreateShortState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateShortStateImplCopyWith<_$CreateShortStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
