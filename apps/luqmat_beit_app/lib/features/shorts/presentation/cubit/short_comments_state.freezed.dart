// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'short_comments_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShortCommentsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShortCommentEntity> comments, bool isPosting)
        loaded,
    required TResult Function(AppException exception) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShortCommentEntity> comments, bool isPosting)?
        loaded,
    TResult? Function(AppException exception)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShortCommentEntity> comments, bool isPosting)? loaded,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShortCommentsInitial value) initial,
    required TResult Function(ShortCommentsLoading value) loading,
    required TResult Function(ShortCommentsLoaded value) loaded,
    required TResult Function(ShortCommentsFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShortCommentsInitial value)? initial,
    TResult? Function(ShortCommentsLoading value)? loading,
    TResult? Function(ShortCommentsLoaded value)? loaded,
    TResult? Function(ShortCommentsFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShortCommentsInitial value)? initial,
    TResult Function(ShortCommentsLoading value)? loading,
    TResult Function(ShortCommentsLoaded value)? loaded,
    TResult Function(ShortCommentsFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShortCommentsStateCopyWith<$Res> {
  factory $ShortCommentsStateCopyWith(
          ShortCommentsState value, $Res Function(ShortCommentsState) then) =
      _$ShortCommentsStateCopyWithImpl<$Res, ShortCommentsState>;
}

/// @nodoc
class _$ShortCommentsStateCopyWithImpl<$Res, $Val extends ShortCommentsState>
    implements $ShortCommentsStateCopyWith<$Res> {
  _$ShortCommentsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShortCommentsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ShortCommentsInitialImplCopyWith<$Res> {
  factory _$$ShortCommentsInitialImplCopyWith(_$ShortCommentsInitialImpl value,
          $Res Function(_$ShortCommentsInitialImpl) then) =
      __$$ShortCommentsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShortCommentsInitialImplCopyWithImpl<$Res>
    extends _$ShortCommentsStateCopyWithImpl<$Res, _$ShortCommentsInitialImpl>
    implements _$$ShortCommentsInitialImplCopyWith<$Res> {
  __$$ShortCommentsInitialImplCopyWithImpl(_$ShortCommentsInitialImpl _value,
      $Res Function(_$ShortCommentsInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShortCommentsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShortCommentsInitialImpl implements ShortCommentsInitial {
  const _$ShortCommentsInitialImpl();

  @override
  String toString() {
    return 'ShortCommentsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShortCommentsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShortCommentEntity> comments, bool isPosting)
        loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShortCommentEntity> comments, bool isPosting)?
        loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShortCommentEntity> comments, bool isPosting)? loaded,
    TResult Function(AppException exception)? failure,
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
    required TResult Function(ShortCommentsInitial value) initial,
    required TResult Function(ShortCommentsLoading value) loading,
    required TResult Function(ShortCommentsLoaded value) loaded,
    required TResult Function(ShortCommentsFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShortCommentsInitial value)? initial,
    TResult? Function(ShortCommentsLoading value)? loading,
    TResult? Function(ShortCommentsLoaded value)? loaded,
    TResult? Function(ShortCommentsFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShortCommentsInitial value)? initial,
    TResult Function(ShortCommentsLoading value)? loading,
    TResult Function(ShortCommentsLoaded value)? loaded,
    TResult Function(ShortCommentsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ShortCommentsInitial implements ShortCommentsState {
  const factory ShortCommentsInitial() = _$ShortCommentsInitialImpl;
}

/// @nodoc
abstract class _$$ShortCommentsLoadingImplCopyWith<$Res> {
  factory _$$ShortCommentsLoadingImplCopyWith(_$ShortCommentsLoadingImpl value,
          $Res Function(_$ShortCommentsLoadingImpl) then) =
      __$$ShortCommentsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShortCommentsLoadingImplCopyWithImpl<$Res>
    extends _$ShortCommentsStateCopyWithImpl<$Res, _$ShortCommentsLoadingImpl>
    implements _$$ShortCommentsLoadingImplCopyWith<$Res> {
  __$$ShortCommentsLoadingImplCopyWithImpl(_$ShortCommentsLoadingImpl _value,
      $Res Function(_$ShortCommentsLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShortCommentsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShortCommentsLoadingImpl implements ShortCommentsLoading {
  const _$ShortCommentsLoadingImpl();

  @override
  String toString() {
    return 'ShortCommentsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShortCommentsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShortCommentEntity> comments, bool isPosting)
        loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShortCommentEntity> comments, bool isPosting)?
        loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShortCommentEntity> comments, bool isPosting)? loaded,
    TResult Function(AppException exception)? failure,
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
    required TResult Function(ShortCommentsInitial value) initial,
    required TResult Function(ShortCommentsLoading value) loading,
    required TResult Function(ShortCommentsLoaded value) loaded,
    required TResult Function(ShortCommentsFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShortCommentsInitial value)? initial,
    TResult? Function(ShortCommentsLoading value)? loading,
    TResult? Function(ShortCommentsLoaded value)? loaded,
    TResult? Function(ShortCommentsFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShortCommentsInitial value)? initial,
    TResult Function(ShortCommentsLoading value)? loading,
    TResult Function(ShortCommentsLoaded value)? loaded,
    TResult Function(ShortCommentsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ShortCommentsLoading implements ShortCommentsState {
  const factory ShortCommentsLoading() = _$ShortCommentsLoadingImpl;
}

/// @nodoc
abstract class _$$ShortCommentsLoadedImplCopyWith<$Res> {
  factory _$$ShortCommentsLoadedImplCopyWith(_$ShortCommentsLoadedImpl value,
          $Res Function(_$ShortCommentsLoadedImpl) then) =
      __$$ShortCommentsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ShortCommentEntity> comments, bool isPosting});
}

/// @nodoc
class __$$ShortCommentsLoadedImplCopyWithImpl<$Res>
    extends _$ShortCommentsStateCopyWithImpl<$Res, _$ShortCommentsLoadedImpl>
    implements _$$ShortCommentsLoadedImplCopyWith<$Res> {
  __$$ShortCommentsLoadedImplCopyWithImpl(_$ShortCommentsLoadedImpl _value,
      $Res Function(_$ShortCommentsLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShortCommentsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
    Object? isPosting = null,
  }) {
    return _then(_$ShortCommentsLoadedImpl(
      null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<ShortCommentEntity>,
      isPosting: null == isPosting
          ? _value.isPosting
          : isPosting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ShortCommentsLoadedImpl implements ShortCommentsLoaded {
  const _$ShortCommentsLoadedImpl(final List<ShortCommentEntity> comments,
      {this.isPosting = false})
      : _comments = comments;

  final List<ShortCommentEntity> _comments;
  @override
  List<ShortCommentEntity> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  @JsonKey()
  final bool isPosting;

  @override
  String toString() {
    return 'ShortCommentsState.loaded(comments: $comments, isPosting: $isPosting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShortCommentsLoadedImpl &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.isPosting, isPosting) ||
                other.isPosting == isPosting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_comments), isPosting);

  /// Create a copy of ShortCommentsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShortCommentsLoadedImplCopyWith<_$ShortCommentsLoadedImpl> get copyWith =>
      __$$ShortCommentsLoadedImplCopyWithImpl<_$ShortCommentsLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShortCommentEntity> comments, bool isPosting)
        loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return loaded(comments, isPosting);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShortCommentEntity> comments, bool isPosting)?
        loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return loaded?.call(comments, isPosting);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShortCommentEntity> comments, bool isPosting)? loaded,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(comments, isPosting);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShortCommentsInitial value) initial,
    required TResult Function(ShortCommentsLoading value) loading,
    required TResult Function(ShortCommentsLoaded value) loaded,
    required TResult Function(ShortCommentsFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShortCommentsInitial value)? initial,
    TResult? Function(ShortCommentsLoading value)? loading,
    TResult? Function(ShortCommentsLoaded value)? loaded,
    TResult? Function(ShortCommentsFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShortCommentsInitial value)? initial,
    TResult Function(ShortCommentsLoading value)? loading,
    TResult Function(ShortCommentsLoaded value)? loaded,
    TResult Function(ShortCommentsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ShortCommentsLoaded implements ShortCommentsState {
  const factory ShortCommentsLoaded(final List<ShortCommentEntity> comments,
      {final bool isPosting}) = _$ShortCommentsLoadedImpl;

  List<ShortCommentEntity> get comments;
  bool get isPosting;

  /// Create a copy of ShortCommentsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShortCommentsLoadedImplCopyWith<_$ShortCommentsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShortCommentsFailureImplCopyWith<$Res> {
  factory _$$ShortCommentsFailureImplCopyWith(_$ShortCommentsFailureImpl value,
          $Res Function(_$ShortCommentsFailureImpl) then) =
      __$$ShortCommentsFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$ShortCommentsFailureImplCopyWithImpl<$Res>
    extends _$ShortCommentsStateCopyWithImpl<$Res, _$ShortCommentsFailureImpl>
    implements _$$ShortCommentsFailureImplCopyWith<$Res> {
  __$$ShortCommentsFailureImplCopyWithImpl(_$ShortCommentsFailureImpl _value,
      $Res Function(_$ShortCommentsFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShortCommentsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$ShortCommentsFailureImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$ShortCommentsFailureImpl implements ShortCommentsFailure {
  const _$ShortCommentsFailureImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'ShortCommentsState.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShortCommentsFailureImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of ShortCommentsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShortCommentsFailureImplCopyWith<_$ShortCommentsFailureImpl>
      get copyWith =>
          __$$ShortCommentsFailureImplCopyWithImpl<_$ShortCommentsFailureImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ShortCommentEntity> comments, bool isPosting)
        loaded,
    required TResult Function(AppException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ShortCommentEntity> comments, bool isPosting)?
        loaded,
    TResult? Function(AppException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ShortCommentEntity> comments, bool isPosting)? loaded,
    TResult Function(AppException exception)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShortCommentsInitial value) initial,
    required TResult Function(ShortCommentsLoading value) loading,
    required TResult Function(ShortCommentsLoaded value) loaded,
    required TResult Function(ShortCommentsFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShortCommentsInitial value)? initial,
    TResult? Function(ShortCommentsLoading value)? loading,
    TResult? Function(ShortCommentsLoaded value)? loaded,
    TResult? Function(ShortCommentsFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShortCommentsInitial value)? initial,
    TResult Function(ShortCommentsLoading value)? loading,
    TResult Function(ShortCommentsLoaded value)? loaded,
    TResult Function(ShortCommentsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ShortCommentsFailure implements ShortCommentsState {
  const factory ShortCommentsFailure(final AppException exception) =
      _$ShortCommentsFailureImpl;

  AppException get exception;

  /// Create a copy of ShortCommentsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShortCommentsFailureImplCopyWith<_$ShortCommentsFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
