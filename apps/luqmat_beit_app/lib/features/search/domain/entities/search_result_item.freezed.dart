// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchResultItem {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MealEntity meal) meal,
    required TResult Function(OfferBundleEntity offer) offer,
    required TResult Function(ChefSummaryEntity cook) cook,
    required TResult Function(ReturnedMealEntity returnedMeal) returnedMeal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? meal,
    TResult? Function(OfferBundleEntity offer)? offer,
    TResult? Function(ChefSummaryEntity cook)? cook,
    TResult? Function(ReturnedMealEntity returnedMeal)? returnedMeal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? meal,
    TResult Function(OfferBundleEntity offer)? offer,
    TResult Function(ChefSummaryEntity cook)? cook,
    TResult Function(ReturnedMealEntity returnedMeal)? returnedMeal,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchResultMeal value) meal,
    required TResult Function(SearchResultOffer value) offer,
    required TResult Function(SearchResultCook value) cook,
    required TResult Function(SearchResultReturnedMeal value) returnedMeal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchResultMeal value)? meal,
    TResult? Function(SearchResultOffer value)? offer,
    TResult? Function(SearchResultCook value)? cook,
    TResult? Function(SearchResultReturnedMeal value)? returnedMeal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchResultMeal value)? meal,
    TResult Function(SearchResultOffer value)? offer,
    TResult Function(SearchResultCook value)? cook,
    TResult Function(SearchResultReturnedMeal value)? returnedMeal,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultItemCopyWith<$Res> {
  factory $SearchResultItemCopyWith(
          SearchResultItem value, $Res Function(SearchResultItem) then) =
      _$SearchResultItemCopyWithImpl<$Res, SearchResultItem>;
}

/// @nodoc
class _$SearchResultItemCopyWithImpl<$Res, $Val extends SearchResultItem>
    implements $SearchResultItemCopyWith<$Res> {
  _$SearchResultItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SearchResultMealImplCopyWith<$Res> {
  factory _$$SearchResultMealImplCopyWith(_$SearchResultMealImpl value,
          $Res Function(_$SearchResultMealImpl) then) =
      __$$SearchResultMealImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MealEntity meal});
}

/// @nodoc
class __$$SearchResultMealImplCopyWithImpl<$Res>
    extends _$SearchResultItemCopyWithImpl<$Res, _$SearchResultMealImpl>
    implements _$$SearchResultMealImplCopyWith<$Res> {
  __$$SearchResultMealImplCopyWithImpl(_$SearchResultMealImpl _value,
      $Res Function(_$SearchResultMealImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meal = null,
  }) {
    return _then(_$SearchResultMealImpl(
      null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as MealEntity,
    ));
  }
}

/// @nodoc

class _$SearchResultMealImpl implements SearchResultMeal {
  const _$SearchResultMealImpl(this.meal);

  @override
  final MealEntity meal;

  @override
  String toString() {
    return 'SearchResultItem.meal(meal: $meal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultMealImpl &&
            (identical(other.meal, meal) || other.meal == meal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, meal);

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultMealImplCopyWith<_$SearchResultMealImpl> get copyWith =>
      __$$SearchResultMealImplCopyWithImpl<_$SearchResultMealImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MealEntity meal) meal,
    required TResult Function(OfferBundleEntity offer) offer,
    required TResult Function(ChefSummaryEntity cook) cook,
    required TResult Function(ReturnedMealEntity returnedMeal) returnedMeal,
  }) {
    return meal(this.meal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? meal,
    TResult? Function(OfferBundleEntity offer)? offer,
    TResult? Function(ChefSummaryEntity cook)? cook,
    TResult? Function(ReturnedMealEntity returnedMeal)? returnedMeal,
  }) {
    return meal?.call(this.meal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? meal,
    TResult Function(OfferBundleEntity offer)? offer,
    TResult Function(ChefSummaryEntity cook)? cook,
    TResult Function(ReturnedMealEntity returnedMeal)? returnedMeal,
    required TResult orElse(),
  }) {
    if (meal != null) {
      return meal(this.meal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchResultMeal value) meal,
    required TResult Function(SearchResultOffer value) offer,
    required TResult Function(SearchResultCook value) cook,
    required TResult Function(SearchResultReturnedMeal value) returnedMeal,
  }) {
    return meal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchResultMeal value)? meal,
    TResult? Function(SearchResultOffer value)? offer,
    TResult? Function(SearchResultCook value)? cook,
    TResult? Function(SearchResultReturnedMeal value)? returnedMeal,
  }) {
    return meal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchResultMeal value)? meal,
    TResult Function(SearchResultOffer value)? offer,
    TResult Function(SearchResultCook value)? cook,
    TResult Function(SearchResultReturnedMeal value)? returnedMeal,
    required TResult orElse(),
  }) {
    if (meal != null) {
      return meal(this);
    }
    return orElse();
  }
}

abstract class SearchResultMeal implements SearchResultItem {
  const factory SearchResultMeal(final MealEntity meal) =
      _$SearchResultMealImpl;

  MealEntity get meal;

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchResultMealImplCopyWith<_$SearchResultMealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchResultOfferImplCopyWith<$Res> {
  factory _$$SearchResultOfferImplCopyWith(_$SearchResultOfferImpl value,
          $Res Function(_$SearchResultOfferImpl) then) =
      __$$SearchResultOfferImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OfferBundleEntity offer});
}

/// @nodoc
class __$$SearchResultOfferImplCopyWithImpl<$Res>
    extends _$SearchResultItemCopyWithImpl<$Res, _$SearchResultOfferImpl>
    implements _$$SearchResultOfferImplCopyWith<$Res> {
  __$$SearchResultOfferImplCopyWithImpl(_$SearchResultOfferImpl _value,
      $Res Function(_$SearchResultOfferImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offer = null,
  }) {
    return _then(_$SearchResultOfferImpl(
      null == offer
          ? _value.offer
          : offer // ignore: cast_nullable_to_non_nullable
              as OfferBundleEntity,
    ));
  }
}

/// @nodoc

class _$SearchResultOfferImpl implements SearchResultOffer {
  const _$SearchResultOfferImpl(this.offer);

  @override
  final OfferBundleEntity offer;

  @override
  String toString() {
    return 'SearchResultItem.offer(offer: $offer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultOfferImpl &&
            (identical(other.offer, offer) || other.offer == offer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, offer);

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultOfferImplCopyWith<_$SearchResultOfferImpl> get copyWith =>
      __$$SearchResultOfferImplCopyWithImpl<_$SearchResultOfferImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MealEntity meal) meal,
    required TResult Function(OfferBundleEntity offer) offer,
    required TResult Function(ChefSummaryEntity cook) cook,
    required TResult Function(ReturnedMealEntity returnedMeal) returnedMeal,
  }) {
    return offer(this.offer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? meal,
    TResult? Function(OfferBundleEntity offer)? offer,
    TResult? Function(ChefSummaryEntity cook)? cook,
    TResult? Function(ReturnedMealEntity returnedMeal)? returnedMeal,
  }) {
    return offer?.call(this.offer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? meal,
    TResult Function(OfferBundleEntity offer)? offer,
    TResult Function(ChefSummaryEntity cook)? cook,
    TResult Function(ReturnedMealEntity returnedMeal)? returnedMeal,
    required TResult orElse(),
  }) {
    if (offer != null) {
      return offer(this.offer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchResultMeal value) meal,
    required TResult Function(SearchResultOffer value) offer,
    required TResult Function(SearchResultCook value) cook,
    required TResult Function(SearchResultReturnedMeal value) returnedMeal,
  }) {
    return offer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchResultMeal value)? meal,
    TResult? Function(SearchResultOffer value)? offer,
    TResult? Function(SearchResultCook value)? cook,
    TResult? Function(SearchResultReturnedMeal value)? returnedMeal,
  }) {
    return offer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchResultMeal value)? meal,
    TResult Function(SearchResultOffer value)? offer,
    TResult Function(SearchResultCook value)? cook,
    TResult Function(SearchResultReturnedMeal value)? returnedMeal,
    required TResult orElse(),
  }) {
    if (offer != null) {
      return offer(this);
    }
    return orElse();
  }
}

abstract class SearchResultOffer implements SearchResultItem {
  const factory SearchResultOffer(final OfferBundleEntity offer) =
      _$SearchResultOfferImpl;

  OfferBundleEntity get offer;

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchResultOfferImplCopyWith<_$SearchResultOfferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchResultCookImplCopyWith<$Res> {
  factory _$$SearchResultCookImplCopyWith(_$SearchResultCookImpl value,
          $Res Function(_$SearchResultCookImpl) then) =
      __$$SearchResultCookImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ChefSummaryEntity cook});
}

/// @nodoc
class __$$SearchResultCookImplCopyWithImpl<$Res>
    extends _$SearchResultItemCopyWithImpl<$Res, _$SearchResultCookImpl>
    implements _$$SearchResultCookImplCopyWith<$Res> {
  __$$SearchResultCookImplCopyWithImpl(_$SearchResultCookImpl _value,
      $Res Function(_$SearchResultCookImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cook = null,
  }) {
    return _then(_$SearchResultCookImpl(
      null == cook
          ? _value.cook
          : cook // ignore: cast_nullable_to_non_nullable
              as ChefSummaryEntity,
    ));
  }
}

/// @nodoc

class _$SearchResultCookImpl implements SearchResultCook {
  const _$SearchResultCookImpl(this.cook);

  @override
  final ChefSummaryEntity cook;

  @override
  String toString() {
    return 'SearchResultItem.cook(cook: $cook)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultCookImpl &&
            (identical(other.cook, cook) || other.cook == cook));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cook);

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultCookImplCopyWith<_$SearchResultCookImpl> get copyWith =>
      __$$SearchResultCookImplCopyWithImpl<_$SearchResultCookImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MealEntity meal) meal,
    required TResult Function(OfferBundleEntity offer) offer,
    required TResult Function(ChefSummaryEntity cook) cook,
    required TResult Function(ReturnedMealEntity returnedMeal) returnedMeal,
  }) {
    return cook(this.cook);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? meal,
    TResult? Function(OfferBundleEntity offer)? offer,
    TResult? Function(ChefSummaryEntity cook)? cook,
    TResult? Function(ReturnedMealEntity returnedMeal)? returnedMeal,
  }) {
    return cook?.call(this.cook);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? meal,
    TResult Function(OfferBundleEntity offer)? offer,
    TResult Function(ChefSummaryEntity cook)? cook,
    TResult Function(ReturnedMealEntity returnedMeal)? returnedMeal,
    required TResult orElse(),
  }) {
    if (cook != null) {
      return cook(this.cook);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchResultMeal value) meal,
    required TResult Function(SearchResultOffer value) offer,
    required TResult Function(SearchResultCook value) cook,
    required TResult Function(SearchResultReturnedMeal value) returnedMeal,
  }) {
    return cook(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchResultMeal value)? meal,
    TResult? Function(SearchResultOffer value)? offer,
    TResult? Function(SearchResultCook value)? cook,
    TResult? Function(SearchResultReturnedMeal value)? returnedMeal,
  }) {
    return cook?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchResultMeal value)? meal,
    TResult Function(SearchResultOffer value)? offer,
    TResult Function(SearchResultCook value)? cook,
    TResult Function(SearchResultReturnedMeal value)? returnedMeal,
    required TResult orElse(),
  }) {
    if (cook != null) {
      return cook(this);
    }
    return orElse();
  }
}

abstract class SearchResultCook implements SearchResultItem {
  const factory SearchResultCook(final ChefSummaryEntity cook) =
      _$SearchResultCookImpl;

  ChefSummaryEntity get cook;

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchResultCookImplCopyWith<_$SearchResultCookImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchResultReturnedMealImplCopyWith<$Res> {
  factory _$$SearchResultReturnedMealImplCopyWith(
          _$SearchResultReturnedMealImpl value,
          $Res Function(_$SearchResultReturnedMealImpl) then) =
      __$$SearchResultReturnedMealImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ReturnedMealEntity returnedMeal});
}

/// @nodoc
class __$$SearchResultReturnedMealImplCopyWithImpl<$Res>
    extends _$SearchResultItemCopyWithImpl<$Res, _$SearchResultReturnedMealImpl>
    implements _$$SearchResultReturnedMealImplCopyWith<$Res> {
  __$$SearchResultReturnedMealImplCopyWithImpl(
      _$SearchResultReturnedMealImpl _value,
      $Res Function(_$SearchResultReturnedMealImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? returnedMeal = null,
  }) {
    return _then(_$SearchResultReturnedMealImpl(
      null == returnedMeal
          ? _value.returnedMeal
          : returnedMeal // ignore: cast_nullable_to_non_nullable
              as ReturnedMealEntity,
    ));
  }
}

/// @nodoc

class _$SearchResultReturnedMealImpl implements SearchResultReturnedMeal {
  const _$SearchResultReturnedMealImpl(this.returnedMeal);

  @override
  final ReturnedMealEntity returnedMeal;

  @override
  String toString() {
    return 'SearchResultItem.returnedMeal(returnedMeal: $returnedMeal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultReturnedMealImpl &&
            (identical(other.returnedMeal, returnedMeal) ||
                other.returnedMeal == returnedMeal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, returnedMeal);

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultReturnedMealImplCopyWith<_$SearchResultReturnedMealImpl>
      get copyWith => __$$SearchResultReturnedMealImplCopyWithImpl<
          _$SearchResultReturnedMealImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MealEntity meal) meal,
    required TResult Function(OfferBundleEntity offer) offer,
    required TResult Function(ChefSummaryEntity cook) cook,
    required TResult Function(ReturnedMealEntity returnedMeal) returnedMeal,
  }) {
    return returnedMeal(this.returnedMeal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MealEntity meal)? meal,
    TResult? Function(OfferBundleEntity offer)? offer,
    TResult? Function(ChefSummaryEntity cook)? cook,
    TResult? Function(ReturnedMealEntity returnedMeal)? returnedMeal,
  }) {
    return returnedMeal?.call(this.returnedMeal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MealEntity meal)? meal,
    TResult Function(OfferBundleEntity offer)? offer,
    TResult Function(ChefSummaryEntity cook)? cook,
    TResult Function(ReturnedMealEntity returnedMeal)? returnedMeal,
    required TResult orElse(),
  }) {
    if (returnedMeal != null) {
      return returnedMeal(this.returnedMeal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchResultMeal value) meal,
    required TResult Function(SearchResultOffer value) offer,
    required TResult Function(SearchResultCook value) cook,
    required TResult Function(SearchResultReturnedMeal value) returnedMeal,
  }) {
    return returnedMeal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchResultMeal value)? meal,
    TResult? Function(SearchResultOffer value)? offer,
    TResult? Function(SearchResultCook value)? cook,
    TResult? Function(SearchResultReturnedMeal value)? returnedMeal,
  }) {
    return returnedMeal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchResultMeal value)? meal,
    TResult Function(SearchResultOffer value)? offer,
    TResult Function(SearchResultCook value)? cook,
    TResult Function(SearchResultReturnedMeal value)? returnedMeal,
    required TResult orElse(),
  }) {
    if (returnedMeal != null) {
      return returnedMeal(this);
    }
    return orElse();
  }
}

abstract class SearchResultReturnedMeal implements SearchResultItem {
  const factory SearchResultReturnedMeal(
      final ReturnedMealEntity returnedMeal) = _$SearchResultReturnedMealImpl;

  ReturnedMealEntity get returnedMeal;

  /// Create a copy of SearchResultItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchResultReturnedMealImplCopyWith<_$SearchResultReturnedMealImpl>
      get copyWith => throw _privateConstructorUsedError;
}
