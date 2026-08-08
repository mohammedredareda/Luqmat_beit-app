// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_menu_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ViewMenuState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MealEntity> meals, bool isSellingPaused,
            bool hasMore, bool isLoadingMore)
        loaded,
    required TResult Function(AppException exception) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MealEntity> meals, bool isSellingPaused,
            bool hasMore, bool isLoadingMore)?
        loaded,
    TResult? Function(AppException exception)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MealEntity> meals, bool isSellingPaused, bool hasMore,
            bool isLoadingMore)?
        loaded,
    TResult Function(AppException exception)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ViewMenuInitial value) initial,
    required TResult Function(ViewMenuLoading value) loading,
    required TResult Function(ViewMenuLoaded value) loaded,
    required TResult Function(ViewMenuError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewMenuInitial value)? initial,
    TResult? Function(ViewMenuLoading value)? loading,
    TResult? Function(ViewMenuLoaded value)? loaded,
    TResult? Function(ViewMenuError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewMenuInitial value)? initial,
    TResult Function(ViewMenuLoading value)? loading,
    TResult Function(ViewMenuLoaded value)? loaded,
    TResult Function(ViewMenuError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewMenuStateCopyWith<$Res> {
  factory $ViewMenuStateCopyWith(
          ViewMenuState value, $Res Function(ViewMenuState) then) =
      _$ViewMenuStateCopyWithImpl<$Res, ViewMenuState>;
}

/// @nodoc
class _$ViewMenuStateCopyWithImpl<$Res, $Val extends ViewMenuState>
    implements $ViewMenuStateCopyWith<$Res> {
  _$ViewMenuStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ViewMenuState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ViewMenuInitialImplCopyWith<$Res> {
  factory _$$ViewMenuInitialImplCopyWith(_$ViewMenuInitialImpl value,
          $Res Function(_$ViewMenuInitialImpl) then) =
      __$$ViewMenuInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ViewMenuInitialImplCopyWithImpl<$Res>
    extends _$ViewMenuStateCopyWithImpl<$Res, _$ViewMenuInitialImpl>
    implements _$$ViewMenuInitialImplCopyWith<$Res> {
  __$$ViewMenuInitialImplCopyWithImpl(
      _$ViewMenuInitialImpl _value, $Res Function(_$ViewMenuInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewMenuState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ViewMenuInitialImpl implements ViewMenuInitial {
  const _$ViewMenuInitialImpl();

  @override
  String toString() {
    return 'ViewMenuState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ViewMenuInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MealEntity> meals, bool isSellingPaused,
            bool hasMore, bool isLoadingMore)
        loaded,
    required TResult Function(AppException exception) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MealEntity> meals, bool isSellingPaused,
            bool hasMore, bool isLoadingMore)?
        loaded,
    TResult? Function(AppException exception)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MealEntity> meals, bool isSellingPaused, bool hasMore,
            bool isLoadingMore)?
        loaded,
    TResult Function(AppException exception)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ViewMenuInitial value) initial,
    required TResult Function(ViewMenuLoading value) loading,
    required TResult Function(ViewMenuLoaded value) loaded,
    required TResult Function(ViewMenuError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewMenuInitial value)? initial,
    TResult? Function(ViewMenuLoading value)? loading,
    TResult? Function(ViewMenuLoaded value)? loaded,
    TResult? Function(ViewMenuError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewMenuInitial value)? initial,
    TResult Function(ViewMenuLoading value)? loading,
    TResult Function(ViewMenuLoaded value)? loaded,
    TResult Function(ViewMenuError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ViewMenuInitial implements ViewMenuState {
  const factory ViewMenuInitial() = _$ViewMenuInitialImpl;
}

/// @nodoc
abstract class _$$ViewMenuLoadingImplCopyWith<$Res> {
  factory _$$ViewMenuLoadingImplCopyWith(_$ViewMenuLoadingImpl value,
          $Res Function(_$ViewMenuLoadingImpl) then) =
      __$$ViewMenuLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ViewMenuLoadingImplCopyWithImpl<$Res>
    extends _$ViewMenuStateCopyWithImpl<$Res, _$ViewMenuLoadingImpl>
    implements _$$ViewMenuLoadingImplCopyWith<$Res> {
  __$$ViewMenuLoadingImplCopyWithImpl(
      _$ViewMenuLoadingImpl _value, $Res Function(_$ViewMenuLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewMenuState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ViewMenuLoadingImpl implements ViewMenuLoading {
  const _$ViewMenuLoadingImpl();

  @override
  String toString() {
    return 'ViewMenuState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ViewMenuLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MealEntity> meals, bool isSellingPaused,
            bool hasMore, bool isLoadingMore)
        loaded,
    required TResult Function(AppException exception) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MealEntity> meals, bool isSellingPaused,
            bool hasMore, bool isLoadingMore)?
        loaded,
    TResult? Function(AppException exception)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MealEntity> meals, bool isSellingPaused, bool hasMore,
            bool isLoadingMore)?
        loaded,
    TResult Function(AppException exception)? error,
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
    required TResult Function(ViewMenuInitial value) initial,
    required TResult Function(ViewMenuLoading value) loading,
    required TResult Function(ViewMenuLoaded value) loaded,
    required TResult Function(ViewMenuError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewMenuInitial value)? initial,
    TResult? Function(ViewMenuLoading value)? loading,
    TResult? Function(ViewMenuLoaded value)? loaded,
    TResult? Function(ViewMenuError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewMenuInitial value)? initial,
    TResult Function(ViewMenuLoading value)? loading,
    TResult Function(ViewMenuLoaded value)? loaded,
    TResult Function(ViewMenuError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ViewMenuLoading implements ViewMenuState {
  const factory ViewMenuLoading() = _$ViewMenuLoadingImpl;
}

/// @nodoc
abstract class _$$ViewMenuLoadedImplCopyWith<$Res> {
  factory _$$ViewMenuLoadedImplCopyWith(_$ViewMenuLoadedImpl value,
          $Res Function(_$ViewMenuLoadedImpl) then) =
      __$$ViewMenuLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<MealEntity> meals,
      bool isSellingPaused,
      bool hasMore,
      bool isLoadingMore});
}

/// @nodoc
class __$$ViewMenuLoadedImplCopyWithImpl<$Res>
    extends _$ViewMenuStateCopyWithImpl<$Res, _$ViewMenuLoadedImpl>
    implements _$$ViewMenuLoadedImplCopyWith<$Res> {
  __$$ViewMenuLoadedImplCopyWithImpl(
      _$ViewMenuLoadedImpl _value, $Res Function(_$ViewMenuLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewMenuState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meals = null,
    Object? isSellingPaused = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
  }) {
    return _then(_$ViewMenuLoadedImpl(
      meals: null == meals
          ? _value._meals
          : meals // ignore: cast_nullable_to_non_nullable
              as List<MealEntity>,
      isSellingPaused: null == isSellingPaused
          ? _value.isSellingPaused
          : isSellingPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ViewMenuLoadedImpl implements ViewMenuLoaded {
  const _$ViewMenuLoadedImpl(
      {required final List<MealEntity> meals,
      required this.isSellingPaused,
      required this.hasMore,
      required this.isLoadingMore})
      : _meals = meals;

  final List<MealEntity> _meals;
  @override
  List<MealEntity> get meals {
    if (_meals is EqualUnmodifiableListView) return _meals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meals);
  }

  @override
  final bool isSellingPaused;
  @override
  final bool hasMore;
  @override
  final bool isLoadingMore;

  @override
  String toString() {
    return 'ViewMenuState.loaded(meals: $meals, isSellingPaused: $isSellingPaused, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewMenuLoadedImpl &&
            const DeepCollectionEquality().equals(other._meals, _meals) &&
            (identical(other.isSellingPaused, isSellingPaused) ||
                other.isSellingPaused == isSellingPaused) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_meals),
      isSellingPaused,
      hasMore,
      isLoadingMore);

  /// Create a copy of ViewMenuState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewMenuLoadedImplCopyWith<_$ViewMenuLoadedImpl> get copyWith =>
      __$$ViewMenuLoadedImplCopyWithImpl<_$ViewMenuLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MealEntity> meals, bool isSellingPaused,
            bool hasMore, bool isLoadingMore)
        loaded,
    required TResult Function(AppException exception) error,
  }) {
    return loaded(meals, isSellingPaused, hasMore, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MealEntity> meals, bool isSellingPaused,
            bool hasMore, bool isLoadingMore)?
        loaded,
    TResult? Function(AppException exception)? error,
  }) {
    return loaded?.call(meals, isSellingPaused, hasMore, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MealEntity> meals, bool isSellingPaused, bool hasMore,
            bool isLoadingMore)?
        loaded,
    TResult Function(AppException exception)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(meals, isSellingPaused, hasMore, isLoadingMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ViewMenuInitial value) initial,
    required TResult Function(ViewMenuLoading value) loading,
    required TResult Function(ViewMenuLoaded value) loaded,
    required TResult Function(ViewMenuError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewMenuInitial value)? initial,
    TResult? Function(ViewMenuLoading value)? loading,
    TResult? Function(ViewMenuLoaded value)? loaded,
    TResult? Function(ViewMenuError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewMenuInitial value)? initial,
    TResult Function(ViewMenuLoading value)? loading,
    TResult Function(ViewMenuLoaded value)? loaded,
    TResult Function(ViewMenuError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ViewMenuLoaded implements ViewMenuState {
  const factory ViewMenuLoaded(
      {required final List<MealEntity> meals,
      required final bool isSellingPaused,
      required final bool hasMore,
      required final bool isLoadingMore}) = _$ViewMenuLoadedImpl;

  List<MealEntity> get meals;
  bool get isSellingPaused;
  bool get hasMore;
  bool get isLoadingMore;

  /// Create a copy of ViewMenuState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ViewMenuLoadedImplCopyWith<_$ViewMenuLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ViewMenuErrorImplCopyWith<$Res> {
  factory _$$ViewMenuErrorImplCopyWith(
          _$ViewMenuErrorImpl value, $Res Function(_$ViewMenuErrorImpl) then) =
      __$$ViewMenuErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$ViewMenuErrorImplCopyWithImpl<$Res>
    extends _$ViewMenuStateCopyWithImpl<$Res, _$ViewMenuErrorImpl>
    implements _$$ViewMenuErrorImplCopyWith<$Res> {
  __$$ViewMenuErrorImplCopyWithImpl(
      _$ViewMenuErrorImpl _value, $Res Function(_$ViewMenuErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewMenuState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$ViewMenuErrorImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$ViewMenuErrorImpl implements ViewMenuError {
  const _$ViewMenuErrorImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'ViewMenuState.error(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewMenuErrorImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of ViewMenuState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewMenuErrorImplCopyWith<_$ViewMenuErrorImpl> get copyWith =>
      __$$ViewMenuErrorImplCopyWithImpl<_$ViewMenuErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MealEntity> meals, bool isSellingPaused,
            bool hasMore, bool isLoadingMore)
        loaded,
    required TResult Function(AppException exception) error,
  }) {
    return error(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MealEntity> meals, bool isSellingPaused,
            bool hasMore, bool isLoadingMore)?
        loaded,
    TResult? Function(AppException exception)? error,
  }) {
    return error?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MealEntity> meals, bool isSellingPaused, bool hasMore,
            bool isLoadingMore)?
        loaded,
    TResult Function(AppException exception)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ViewMenuInitial value) initial,
    required TResult Function(ViewMenuLoading value) loading,
    required TResult Function(ViewMenuLoaded value) loaded,
    required TResult Function(ViewMenuError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewMenuInitial value)? initial,
    TResult? Function(ViewMenuLoading value)? loading,
    TResult? Function(ViewMenuLoaded value)? loaded,
    TResult? Function(ViewMenuError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewMenuInitial value)? initial,
    TResult Function(ViewMenuLoading value)? loading,
    TResult Function(ViewMenuLoaded value)? loaded,
    TResult Function(ViewMenuError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ViewMenuError implements ViewMenuState {
  const factory ViewMenuError(final AppException exception) =
      _$ViewMenuErrorImpl;

  AppException get exception;

  /// Create a copy of ViewMenuState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ViewMenuErrorImplCopyWith<_$ViewMenuErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
