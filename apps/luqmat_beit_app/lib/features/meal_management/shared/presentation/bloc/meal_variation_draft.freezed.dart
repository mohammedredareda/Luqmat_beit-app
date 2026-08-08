// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_variation_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MealVariationDraft {
  String get localId => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get priceInput => throw _privateConstructorUsedError;

  /// Create a copy of MealVariationDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealVariationDraftCopyWith<MealVariationDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealVariationDraftCopyWith<$Res> {
  factory $MealVariationDraftCopyWith(
          MealVariationDraft value, $Res Function(MealVariationDraft) then) =
      _$MealVariationDraftCopyWithImpl<$Res, MealVariationDraft>;
  @useResult
  $Res call({String localId, String label, String priceInput});
}

/// @nodoc
class _$MealVariationDraftCopyWithImpl<$Res, $Val extends MealVariationDraft>
    implements $MealVariationDraftCopyWith<$Res> {
  _$MealVariationDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealVariationDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? label = null,
    Object? priceInput = null,
  }) {
    return _then(_value.copyWith(
      localId: null == localId
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      priceInput: null == priceInput
          ? _value.priceInput
          : priceInput // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealVariationDraftImplCopyWith<$Res>
    implements $MealVariationDraftCopyWith<$Res> {
  factory _$$MealVariationDraftImplCopyWith(_$MealVariationDraftImpl value,
          $Res Function(_$MealVariationDraftImpl) then) =
      __$$MealVariationDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String localId, String label, String priceInput});
}

/// @nodoc
class __$$MealVariationDraftImplCopyWithImpl<$Res>
    extends _$MealVariationDraftCopyWithImpl<$Res, _$MealVariationDraftImpl>
    implements _$$MealVariationDraftImplCopyWith<$Res> {
  __$$MealVariationDraftImplCopyWithImpl(_$MealVariationDraftImpl _value,
      $Res Function(_$MealVariationDraftImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealVariationDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? label = null,
    Object? priceInput = null,
  }) {
    return _then(_$MealVariationDraftImpl(
      localId: null == localId
          ? _value.localId
          : localId // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      priceInput: null == priceInput
          ? _value.priceInput
          : priceInput // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MealVariationDraftImpl implements _MealVariationDraft {
  const _$MealVariationDraftImpl(
      {required this.localId, this.label = '', this.priceInput = ''});

  @override
  final String localId;
  @override
  @JsonKey()
  final String label;
  @override
  @JsonKey()
  final String priceInput;

  @override
  String toString() {
    return 'MealVariationDraft(localId: $localId, label: $label, priceInput: $priceInput)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealVariationDraftImpl &&
            (identical(other.localId, localId) || other.localId == localId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.priceInput, priceInput) ||
                other.priceInput == priceInput));
  }

  @override
  int get hashCode => Object.hash(runtimeType, localId, label, priceInput);

  /// Create a copy of MealVariationDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealVariationDraftImplCopyWith<_$MealVariationDraftImpl> get copyWith =>
      __$$MealVariationDraftImplCopyWithImpl<_$MealVariationDraftImpl>(
          this, _$identity);
}

abstract class _MealVariationDraft implements MealVariationDraft {
  const factory _MealVariationDraft(
      {required final String localId,
      final String label,
      final String priceInput}) = _$MealVariationDraftImpl;

  @override
  String get localId;
  @override
  String get label;
  @override
  String get priceInput;

  /// Create a copy of MealVariationDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealVariationDraftImplCopyWith<_$MealVariationDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
