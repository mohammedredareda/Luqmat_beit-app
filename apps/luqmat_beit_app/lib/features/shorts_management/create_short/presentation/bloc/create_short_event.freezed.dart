// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_short_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateShortEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, int sizeBytes) videoPicked,
    required TResult Function(String value) descriptionChanged,
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function() mealRemoved,
    required TResult Function() submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, int sizeBytes)? videoPicked,
    TResult? Function(String value)? descriptionChanged,
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function()? mealRemoved,
    TResult? Function()? submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, int sizeBytes)? videoPicked,
    TResult Function(String value)? descriptionChanged,
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function()? mealRemoved,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_VideoPicked value) videoPicked,
    required TResult Function(_DescriptionChanged value) descriptionChanged,
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_MealRemoved value) mealRemoved,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_VideoPicked value)? videoPicked,
    TResult? Function(_DescriptionChanged value)? descriptionChanged,
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_MealRemoved value)? mealRemoved,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_VideoPicked value)? videoPicked,
    TResult Function(_DescriptionChanged value)? descriptionChanged,
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_MealRemoved value)? mealRemoved,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateShortEventCopyWith<$Res> {
  factory $CreateShortEventCopyWith(
          CreateShortEvent value, $Res Function(CreateShortEvent) then) =
      _$CreateShortEventCopyWithImpl<$Res, CreateShortEvent>;
}

/// @nodoc
class _$CreateShortEventCopyWithImpl<$Res, $Val extends CreateShortEvent>
    implements $CreateShortEventCopyWith<$Res> {
  _$CreateShortEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateShortEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$VideoPickedImplCopyWith<$Res> {
  factory _$$VideoPickedImplCopyWith(
          _$VideoPickedImpl value, $Res Function(_$VideoPickedImpl) then) =
      __$$VideoPickedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String path, int sizeBytes});
}

/// @nodoc
class __$$VideoPickedImplCopyWithImpl<$Res>
    extends _$CreateShortEventCopyWithImpl<$Res, _$VideoPickedImpl>
    implements _$$VideoPickedImplCopyWith<$Res> {
  __$$VideoPickedImplCopyWithImpl(
      _$VideoPickedImpl _value, $Res Function(_$VideoPickedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateShortEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? sizeBytes = null,
  }) {
    return _then(_$VideoPickedImpl(
      null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      null == sizeBytes
          ? _value.sizeBytes
          : sizeBytes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$VideoPickedImpl implements _VideoPicked {
  const _$VideoPickedImpl(this.path, this.sizeBytes);

  @override
  final String path;
  @override
  final int sizeBytes;

  @override
  String toString() {
    return 'CreateShortEvent.videoPicked(path: $path, sizeBytes: $sizeBytes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoPickedImpl &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, sizeBytes);

  /// Create a copy of CreateShortEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoPickedImplCopyWith<_$VideoPickedImpl> get copyWith =>
      __$$VideoPickedImplCopyWithImpl<_$VideoPickedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, int sizeBytes) videoPicked,
    required TResult Function(String value) descriptionChanged,
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function() mealRemoved,
    required TResult Function() submitPressed,
  }) {
    return videoPicked(path, sizeBytes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, int sizeBytes)? videoPicked,
    TResult? Function(String value)? descriptionChanged,
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function()? mealRemoved,
    TResult? Function()? submitPressed,
  }) {
    return videoPicked?.call(path, sizeBytes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, int sizeBytes)? videoPicked,
    TResult Function(String value)? descriptionChanged,
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function()? mealRemoved,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) {
    if (videoPicked != null) {
      return videoPicked(path, sizeBytes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_VideoPicked value) videoPicked,
    required TResult Function(_DescriptionChanged value) descriptionChanged,
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_MealRemoved value) mealRemoved,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return videoPicked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_VideoPicked value)? videoPicked,
    TResult? Function(_DescriptionChanged value)? descriptionChanged,
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_MealRemoved value)? mealRemoved,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return videoPicked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_VideoPicked value)? videoPicked,
    TResult Function(_DescriptionChanged value)? descriptionChanged,
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_MealRemoved value)? mealRemoved,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (videoPicked != null) {
      return videoPicked(this);
    }
    return orElse();
  }
}

abstract class _VideoPicked implements CreateShortEvent {
  const factory _VideoPicked(final String path, final int sizeBytes) =
      _$VideoPickedImpl;

  String get path;
  int get sizeBytes;

  /// Create a copy of CreateShortEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoPickedImplCopyWith<_$VideoPickedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DescriptionChangedImplCopyWith<$Res> {
  factory _$$DescriptionChangedImplCopyWith(_$DescriptionChangedImpl value,
          $Res Function(_$DescriptionChangedImpl) then) =
      __$$DescriptionChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$DescriptionChangedImplCopyWithImpl<$Res>
    extends _$CreateShortEventCopyWithImpl<$Res, _$DescriptionChangedImpl>
    implements _$$DescriptionChangedImplCopyWith<$Res> {
  __$$DescriptionChangedImplCopyWithImpl(_$DescriptionChangedImpl _value,
      $Res Function(_$DescriptionChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateShortEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$DescriptionChangedImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DescriptionChangedImpl implements _DescriptionChanged {
  const _$DescriptionChangedImpl(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'CreateShortEvent.descriptionChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DescriptionChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of CreateShortEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DescriptionChangedImplCopyWith<_$DescriptionChangedImpl> get copyWith =>
      __$$DescriptionChangedImplCopyWithImpl<_$DescriptionChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, int sizeBytes) videoPicked,
    required TResult Function(String value) descriptionChanged,
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function() mealRemoved,
    required TResult Function() submitPressed,
  }) {
    return descriptionChanged(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, int sizeBytes)? videoPicked,
    TResult? Function(String value)? descriptionChanged,
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function()? mealRemoved,
    TResult? Function()? submitPressed,
  }) {
    return descriptionChanged?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, int sizeBytes)? videoPicked,
    TResult Function(String value)? descriptionChanged,
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function()? mealRemoved,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) {
    if (descriptionChanged != null) {
      return descriptionChanged(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_VideoPicked value) videoPicked,
    required TResult Function(_DescriptionChanged value) descriptionChanged,
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_MealRemoved value) mealRemoved,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return descriptionChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_VideoPicked value)? videoPicked,
    TResult? Function(_DescriptionChanged value)? descriptionChanged,
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_MealRemoved value)? mealRemoved,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return descriptionChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_VideoPicked value)? videoPicked,
    TResult Function(_DescriptionChanged value)? descriptionChanged,
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_MealRemoved value)? mealRemoved,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (descriptionChanged != null) {
      return descriptionChanged(this);
    }
    return orElse();
  }
}

abstract class _DescriptionChanged implements CreateShortEvent {
  const factory _DescriptionChanged(final String value) =
      _$DescriptionChangedImpl;

  String get value;

  /// Create a copy of CreateShortEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DescriptionChangedImplCopyWith<_$DescriptionChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$CreateShortEventCopyWithImpl<$Res, _$MealSelectedImpl>
    implements _$$MealSelectedImplCopyWith<$Res> {
  __$$MealSelectedImplCopyWithImpl(
      _$MealSelectedImpl _value, $Res Function(_$MealSelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateShortEvent
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
    return 'CreateShortEvent.mealSelected(meal: $meal)';
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

  /// Create a copy of CreateShortEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealSelectedImplCopyWith<_$MealSelectedImpl> get copyWith =>
      __$$MealSelectedImplCopyWithImpl<_$MealSelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, int sizeBytes) videoPicked,
    required TResult Function(String value) descriptionChanged,
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function() mealRemoved,
    required TResult Function() submitPressed,
  }) {
    return mealSelected(meal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, int sizeBytes)? videoPicked,
    TResult? Function(String value)? descriptionChanged,
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function()? mealRemoved,
    TResult? Function()? submitPressed,
  }) {
    return mealSelected?.call(meal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, int sizeBytes)? videoPicked,
    TResult Function(String value)? descriptionChanged,
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function()? mealRemoved,
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
    required TResult Function(_VideoPicked value) videoPicked,
    required TResult Function(_DescriptionChanged value) descriptionChanged,
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_MealRemoved value) mealRemoved,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return mealSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_VideoPicked value)? videoPicked,
    TResult? Function(_DescriptionChanged value)? descriptionChanged,
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_MealRemoved value)? mealRemoved,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return mealSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_VideoPicked value)? videoPicked,
    TResult Function(_DescriptionChanged value)? descriptionChanged,
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_MealRemoved value)? mealRemoved,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (mealSelected != null) {
      return mealSelected(this);
    }
    return orElse();
  }
}

abstract class _MealSelected implements CreateShortEvent {
  const factory _MealSelected(final MealEntity meal) = _$MealSelectedImpl;

  MealEntity get meal;

  /// Create a copy of CreateShortEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealSelectedImplCopyWith<_$MealSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MealRemovedImplCopyWith<$Res> {
  factory _$$MealRemovedImplCopyWith(
          _$MealRemovedImpl value, $Res Function(_$MealRemovedImpl) then) =
      __$$MealRemovedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MealRemovedImplCopyWithImpl<$Res>
    extends _$CreateShortEventCopyWithImpl<$Res, _$MealRemovedImpl>
    implements _$$MealRemovedImplCopyWith<$Res> {
  __$$MealRemovedImplCopyWithImpl(
      _$MealRemovedImpl _value, $Res Function(_$MealRemovedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateShortEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MealRemovedImpl implements _MealRemoved {
  const _$MealRemovedImpl();

  @override
  String toString() {
    return 'CreateShortEvent.mealRemoved()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MealRemovedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, int sizeBytes) videoPicked,
    required TResult Function(String value) descriptionChanged,
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function() mealRemoved,
    required TResult Function() submitPressed,
  }) {
    return mealRemoved();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, int sizeBytes)? videoPicked,
    TResult? Function(String value)? descriptionChanged,
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function()? mealRemoved,
    TResult? Function()? submitPressed,
  }) {
    return mealRemoved?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, int sizeBytes)? videoPicked,
    TResult Function(String value)? descriptionChanged,
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function()? mealRemoved,
    TResult Function()? submitPressed,
    required TResult orElse(),
  }) {
    if (mealRemoved != null) {
      return mealRemoved();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_VideoPicked value) videoPicked,
    required TResult Function(_DescriptionChanged value) descriptionChanged,
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_MealRemoved value) mealRemoved,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return mealRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_VideoPicked value)? videoPicked,
    TResult? Function(_DescriptionChanged value)? descriptionChanged,
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_MealRemoved value)? mealRemoved,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return mealRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_VideoPicked value)? videoPicked,
    TResult Function(_DescriptionChanged value)? descriptionChanged,
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_MealRemoved value)? mealRemoved,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (mealRemoved != null) {
      return mealRemoved(this);
    }
    return orElse();
  }
}

abstract class _MealRemoved implements CreateShortEvent {
  const factory _MealRemoved() = _$MealRemovedImpl;
}

/// @nodoc
abstract class _$$SubmitPressedImplCopyWith<$Res> {
  factory _$$SubmitPressedImplCopyWith(
          _$SubmitPressedImpl value, $Res Function(_$SubmitPressedImpl) then) =
      __$$SubmitPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitPressedImplCopyWithImpl<$Res>
    extends _$CreateShortEventCopyWithImpl<$Res, _$SubmitPressedImpl>
    implements _$$SubmitPressedImplCopyWith<$Res> {
  __$$SubmitPressedImplCopyWithImpl(
      _$SubmitPressedImpl _value, $Res Function(_$SubmitPressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateShortEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmitPressedImpl implements _SubmitPressed {
  const _$SubmitPressedImpl();

  @override
  String toString() {
    return 'CreateShortEvent.submitPressed()';
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
    required TResult Function(String path, int sizeBytes) videoPicked,
    required TResult Function(String value) descriptionChanged,
    required TResult Function(MealEntity meal) mealSelected,
    required TResult Function() mealRemoved,
    required TResult Function() submitPressed,
  }) {
    return submitPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, int sizeBytes)? videoPicked,
    TResult? Function(String value)? descriptionChanged,
    TResult? Function(MealEntity meal)? mealSelected,
    TResult? Function()? mealRemoved,
    TResult? Function()? submitPressed,
  }) {
    return submitPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, int sizeBytes)? videoPicked,
    TResult Function(String value)? descriptionChanged,
    TResult Function(MealEntity meal)? mealSelected,
    TResult Function()? mealRemoved,
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
    required TResult Function(_VideoPicked value) videoPicked,
    required TResult Function(_DescriptionChanged value) descriptionChanged,
    required TResult Function(_MealSelected value) mealSelected,
    required TResult Function(_MealRemoved value) mealRemoved,
    required TResult Function(_SubmitPressed value) submitPressed,
  }) {
    return submitPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_VideoPicked value)? videoPicked,
    TResult? Function(_DescriptionChanged value)? descriptionChanged,
    TResult? Function(_MealSelected value)? mealSelected,
    TResult? Function(_MealRemoved value)? mealRemoved,
    TResult? Function(_SubmitPressed value)? submitPressed,
  }) {
    return submitPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_VideoPicked value)? videoPicked,
    TResult Function(_DescriptionChanged value)? descriptionChanged,
    TResult Function(_MealSelected value)? mealSelected,
    TResult Function(_MealRemoved value)? mealRemoved,
    TResult Function(_SubmitPressed value)? submitPressed,
    required TResult orElse(),
  }) {
    if (submitPressed != null) {
      return submitPressed(this);
    }
    return orElse();
  }
}

abstract class _SubmitPressed implements CreateShortEvent {
  const factory _SubmitPressed() = _$SubmitPressedImpl;
}
