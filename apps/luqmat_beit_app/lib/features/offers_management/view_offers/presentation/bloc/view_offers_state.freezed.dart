// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_offers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ViewOffersState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)
        loaded,
    required TResult Function(AppException exception) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)?
        loaded,
    TResult? Function(AppException exception)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)?
        loaded,
    TResult Function(AppException exception)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ViewOffersInitial value) initial,
    required TResult Function(ViewOffersLoading value) loading,
    required TResult Function(ViewOffersLoaded value) loaded,
    required TResult Function(ViewOffersError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewOffersInitial value)? initial,
    TResult? Function(ViewOffersLoading value)? loading,
    TResult? Function(ViewOffersLoaded value)? loaded,
    TResult? Function(ViewOffersError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewOffersInitial value)? initial,
    TResult Function(ViewOffersLoading value)? loading,
    TResult Function(ViewOffersLoaded value)? loaded,
    TResult Function(ViewOffersError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewOffersStateCopyWith<$Res> {
  factory $ViewOffersStateCopyWith(
          ViewOffersState value, $Res Function(ViewOffersState) then) =
      _$ViewOffersStateCopyWithImpl<$Res, ViewOffersState>;
}

/// @nodoc
class _$ViewOffersStateCopyWithImpl<$Res, $Val extends ViewOffersState>
    implements $ViewOffersStateCopyWith<$Res> {
  _$ViewOffersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ViewOffersState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ViewOffersInitialImplCopyWith<$Res> {
  factory _$$ViewOffersInitialImplCopyWith(_$ViewOffersInitialImpl value,
          $Res Function(_$ViewOffersInitialImpl) then) =
      __$$ViewOffersInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ViewOffersInitialImplCopyWithImpl<$Res>
    extends _$ViewOffersStateCopyWithImpl<$Res, _$ViewOffersInitialImpl>
    implements _$$ViewOffersInitialImplCopyWith<$Res> {
  __$$ViewOffersInitialImplCopyWithImpl(_$ViewOffersInitialImpl _value,
      $Res Function(_$ViewOffersInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewOffersState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ViewOffersInitialImpl implements ViewOffersInitial {
  const _$ViewOffersInitialImpl();

  @override
  String toString() {
    return 'ViewOffersState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ViewOffersInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)
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
    TResult? Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)?
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
    TResult Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)?
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
    required TResult Function(ViewOffersInitial value) initial,
    required TResult Function(ViewOffersLoading value) loading,
    required TResult Function(ViewOffersLoaded value) loaded,
    required TResult Function(ViewOffersError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewOffersInitial value)? initial,
    TResult? Function(ViewOffersLoading value)? loading,
    TResult? Function(ViewOffersLoaded value)? loaded,
    TResult? Function(ViewOffersError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewOffersInitial value)? initial,
    TResult Function(ViewOffersLoading value)? loading,
    TResult Function(ViewOffersLoaded value)? loaded,
    TResult Function(ViewOffersError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ViewOffersInitial implements ViewOffersState {
  const factory ViewOffersInitial() = _$ViewOffersInitialImpl;
}

/// @nodoc
abstract class _$$ViewOffersLoadingImplCopyWith<$Res> {
  factory _$$ViewOffersLoadingImplCopyWith(_$ViewOffersLoadingImpl value,
          $Res Function(_$ViewOffersLoadingImpl) then) =
      __$$ViewOffersLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ViewOffersLoadingImplCopyWithImpl<$Res>
    extends _$ViewOffersStateCopyWithImpl<$Res, _$ViewOffersLoadingImpl>
    implements _$$ViewOffersLoadingImplCopyWith<$Res> {
  __$$ViewOffersLoadingImplCopyWithImpl(_$ViewOffersLoadingImpl _value,
      $Res Function(_$ViewOffersLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewOffersState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ViewOffersLoadingImpl implements ViewOffersLoading {
  const _$ViewOffersLoadingImpl();

  @override
  String toString() {
    return 'ViewOffersState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ViewOffersLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)
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
    TResult? Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)?
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
    TResult Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)?
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
    required TResult Function(ViewOffersInitial value) initial,
    required TResult Function(ViewOffersLoading value) loading,
    required TResult Function(ViewOffersLoaded value) loaded,
    required TResult Function(ViewOffersError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewOffersInitial value)? initial,
    TResult? Function(ViewOffersLoading value)? loading,
    TResult? Function(ViewOffersLoaded value)? loaded,
    TResult? Function(ViewOffersError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewOffersInitial value)? initial,
    TResult Function(ViewOffersLoading value)? loading,
    TResult Function(ViewOffersLoaded value)? loaded,
    TResult Function(ViewOffersError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ViewOffersLoading implements ViewOffersState {
  const factory ViewOffersLoading() = _$ViewOffersLoadingImpl;
}

/// @nodoc
abstract class _$$ViewOffersLoadedImplCopyWith<$Res> {
  factory _$$ViewOffersLoadedImplCopyWith(_$ViewOffersLoadedImpl value,
          $Res Function(_$ViewOffersLoadedImpl) then) =
      __$$ViewOffersLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore});
}

/// @nodoc
class __$$ViewOffersLoadedImplCopyWithImpl<$Res>
    extends _$ViewOffersStateCopyWithImpl<$Res, _$ViewOffersLoadedImpl>
    implements _$$ViewOffersLoadedImplCopyWith<$Res> {
  __$$ViewOffersLoadedImplCopyWithImpl(_$ViewOffersLoadedImpl _value,
      $Res Function(_$ViewOffersLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewOffersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
  }) {
    return _then(_$ViewOffersLoadedImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OfferFeedItemEntity>,
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

class _$ViewOffersLoadedImpl implements ViewOffersLoaded {
  const _$ViewOffersLoadedImpl(
      {required final List<OfferFeedItemEntity> items,
      required this.hasMore,
      required this.isLoadingMore})
      : _items = items;

  final List<OfferFeedItemEntity> _items;
  @override
  List<OfferFeedItemEntity> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool hasMore;
  @override
  final bool isLoadingMore;

  @override
  String toString() {
    return 'ViewOffersState.loaded(items: $items, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewOffersLoadedImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), hasMore, isLoadingMore);

  /// Create a copy of ViewOffersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewOffersLoadedImplCopyWith<_$ViewOffersLoadedImpl> get copyWith =>
      __$$ViewOffersLoadedImplCopyWithImpl<_$ViewOffersLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)
        loaded,
    required TResult Function(AppException exception) error,
  }) {
    return loaded(items, hasMore, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)?
        loaded,
    TResult? Function(AppException exception)? error,
  }) {
    return loaded?.call(items, hasMore, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)?
        loaded,
    TResult Function(AppException exception)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(items, hasMore, isLoadingMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ViewOffersInitial value) initial,
    required TResult Function(ViewOffersLoading value) loading,
    required TResult Function(ViewOffersLoaded value) loaded,
    required TResult Function(ViewOffersError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewOffersInitial value)? initial,
    TResult? Function(ViewOffersLoading value)? loading,
    TResult? Function(ViewOffersLoaded value)? loaded,
    TResult? Function(ViewOffersError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewOffersInitial value)? initial,
    TResult Function(ViewOffersLoading value)? loading,
    TResult Function(ViewOffersLoaded value)? loaded,
    TResult Function(ViewOffersError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ViewOffersLoaded implements ViewOffersState {
  const factory ViewOffersLoaded(
      {required final List<OfferFeedItemEntity> items,
      required final bool hasMore,
      required final bool isLoadingMore}) = _$ViewOffersLoadedImpl;

  List<OfferFeedItemEntity> get items;
  bool get hasMore;
  bool get isLoadingMore;

  /// Create a copy of ViewOffersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ViewOffersLoadedImplCopyWith<_$ViewOffersLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ViewOffersErrorImplCopyWith<$Res> {
  factory _$$ViewOffersErrorImplCopyWith(_$ViewOffersErrorImpl value,
          $Res Function(_$ViewOffersErrorImpl) then) =
      __$$ViewOffersErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException exception});
}

/// @nodoc
class __$$ViewOffersErrorImplCopyWithImpl<$Res>
    extends _$ViewOffersStateCopyWithImpl<$Res, _$ViewOffersErrorImpl>
    implements _$$ViewOffersErrorImplCopyWith<$Res> {
  __$$ViewOffersErrorImplCopyWithImpl(
      _$ViewOffersErrorImpl _value, $Res Function(_$ViewOffersErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewOffersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
  }) {
    return _then(_$ViewOffersErrorImpl(
      null == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$ViewOffersErrorImpl implements ViewOffersError {
  const _$ViewOffersErrorImpl(this.exception);

  @override
  final AppException exception;

  @override
  String toString() {
    return 'ViewOffersState.error(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewOffersErrorImpl &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of ViewOffersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewOffersErrorImplCopyWith<_$ViewOffersErrorImpl> get copyWith =>
      __$$ViewOffersErrorImplCopyWithImpl<_$ViewOffersErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)
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
    TResult? Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)?
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
    TResult Function(
            List<OfferFeedItemEntity> items, bool hasMore, bool isLoadingMore)?
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
    required TResult Function(ViewOffersInitial value) initial,
    required TResult Function(ViewOffersLoading value) loading,
    required TResult Function(ViewOffersLoaded value) loaded,
    required TResult Function(ViewOffersError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ViewOffersInitial value)? initial,
    TResult? Function(ViewOffersLoading value)? loading,
    TResult? Function(ViewOffersLoaded value)? loaded,
    TResult? Function(ViewOffersError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ViewOffersInitial value)? initial,
    TResult Function(ViewOffersLoading value)? loading,
    TResult Function(ViewOffersLoaded value)? loaded,
    TResult Function(ViewOffersError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ViewOffersError implements ViewOffersState {
  const factory ViewOffersError(final AppException exception) =
      _$ViewOffersErrorImpl;

  AppException get exception;

  /// Create a copy of ViewOffersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ViewOffersErrorImplCopyWith<_$ViewOffersErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
