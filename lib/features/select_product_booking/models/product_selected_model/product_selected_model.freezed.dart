// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_selected_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductSelectedModel _$ProductSelectedModelFromJson(Map<String, dynamic> json) {
  return _ProductSelectedModel.fromJson(json);
}

/// @nodoc
mixin _$ProductSelectedModel {
  ProductInfoModel get variant => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  List<MeasurementValueModel> get measurements =>
      throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  /// Serializes this ProductSelectedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductSelectedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductSelectedModelCopyWith<ProductSelectedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductSelectedModelCopyWith<$Res> {
  factory $ProductSelectedModelCopyWith(ProductSelectedModel value,
          $Res Function(ProductSelectedModel) then) =
      _$ProductSelectedModelCopyWithImpl<$Res, ProductSelectedModel>;
  @useResult
  $Res call(
      {ProductInfoModel variant,
      int amount,
      List<MeasurementValueModel> measurements,
      int quantity});

  $ProductInfoModelCopyWith<$Res> get variant;
}

/// @nodoc
class _$ProductSelectedModelCopyWithImpl<$Res,
        $Val extends ProductSelectedModel>
    implements $ProductSelectedModelCopyWith<$Res> {
  _$ProductSelectedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductSelectedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? variant = null,
    Object? amount = null,
    Object? measurements = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      variant: null == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as ProductInfoModel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      measurements: null == measurements
          ? _value.measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as List<MeasurementValueModel>,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of ProductSelectedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductInfoModelCopyWith<$Res> get variant {
    return $ProductInfoModelCopyWith<$Res>(_value.variant, (value) {
      return _then(_value.copyWith(variant: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductSelectedModelImplCopyWith<$Res>
    implements $ProductSelectedModelCopyWith<$Res> {
  factory _$$ProductSelectedModelImplCopyWith(_$ProductSelectedModelImpl value,
          $Res Function(_$ProductSelectedModelImpl) then) =
      __$$ProductSelectedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProductInfoModel variant,
      int amount,
      List<MeasurementValueModel> measurements,
      int quantity});

  @override
  $ProductInfoModelCopyWith<$Res> get variant;
}

/// @nodoc
class __$$ProductSelectedModelImplCopyWithImpl<$Res>
    extends _$ProductSelectedModelCopyWithImpl<$Res, _$ProductSelectedModelImpl>
    implements _$$ProductSelectedModelImplCopyWith<$Res> {
  __$$ProductSelectedModelImplCopyWithImpl(_$ProductSelectedModelImpl _value,
      $Res Function(_$ProductSelectedModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductSelectedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? variant = null,
    Object? amount = null,
    Object? measurements = null,
    Object? quantity = null,
  }) {
    return _then(_$ProductSelectedModelImpl(
      variant: null == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as ProductInfoModel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      measurements: null == measurements
          ? _value._measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as List<MeasurementValueModel>,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductSelectedModelImpl implements _ProductSelectedModel {
  const _$ProductSelectedModelImpl(
      {required this.variant,
      required this.amount,
      final List<MeasurementValueModel> measurements = const [],
      required this.quantity})
      : _measurements = measurements;

  factory _$ProductSelectedModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductSelectedModelImplFromJson(json);

  @override
  final ProductInfoModel variant;
  @override
  final int amount;
  final List<MeasurementValueModel> _measurements;
  @override
  @JsonKey()
  List<MeasurementValueModel> get measurements {
    if (_measurements is EqualUnmodifiableListView) return _measurements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_measurements);
  }

  @override
  final int quantity;

  @override
  String toString() {
    return 'ProductSelectedModel(variant: $variant, amount: $amount, measurements: $measurements, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductSelectedModelImpl &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            const DeepCollectionEquality()
                .equals(other._measurements, _measurements) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, variant, amount,
      const DeepCollectionEquality().hash(_measurements), quantity);

  /// Create a copy of ProductSelectedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductSelectedModelImplCopyWith<_$ProductSelectedModelImpl>
      get copyWith =>
          __$$ProductSelectedModelImplCopyWithImpl<_$ProductSelectedModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductSelectedModelImplToJson(
      this,
    );
  }
}

abstract class _ProductSelectedModel implements ProductSelectedModel {
  const factory _ProductSelectedModel(
      {required final ProductInfoModel variant,
      required final int amount,
      final List<MeasurementValueModel> measurements,
      required final int quantity}) = _$ProductSelectedModelImpl;

  factory _ProductSelectedModel.fromJson(Map<String, dynamic> json) =
      _$ProductSelectedModelImpl.fromJson;

  @override
  ProductInfoModel get variant;
  @override
  int get amount;
  @override
  List<MeasurementValueModel> get measurements;
  @override
  int get quantity;

  /// Create a copy of ProductSelectedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductSelectedModelImplCopyWith<_$ProductSelectedModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
