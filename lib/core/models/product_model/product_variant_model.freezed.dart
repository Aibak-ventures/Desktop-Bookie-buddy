// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_variant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductVariantModel _$ProductVariantModelFromJson(Map<String, dynamic> json) {
  return _ProductVariantModel.fromJson(json);
}

/// @nodoc
mixin _$ProductVariantModel {
  int get id => throw _privateConstructorUsedError;

  /// E.g. "S, L, XL, XXL"
  String get attribute => throw _privateConstructorUsedError;
  int get stock => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_stock')
  int? get remainingStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'price')
  int? get price => throw _privateConstructorUsedError;

  /// Serializes this ProductVariantModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductVariantModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductVariantModelCopyWith<ProductVariantModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductVariantModelCopyWith<$Res> {
  factory $ProductVariantModelCopyWith(
    ProductVariantModel value,
    $Res Function(ProductVariantModel) then,
  ) = _$ProductVariantModelCopyWithImpl<$Res, ProductVariantModel>;
  @useResult
  $Res call({
    int id,
    String attribute,
    int stock,
    @JsonKey(name: 'remaining_stock') int? remainingStock,
    @JsonKey(name: 'price') int? price,
  });
}

/// @nodoc
class _$ProductVariantModelCopyWithImpl<$Res, $Val extends ProductVariantModel>
    implements $ProductVariantModelCopyWith<$Res> {
  _$ProductVariantModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductVariantModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attribute = null,
    Object? stock = null,
    Object? remainingStock = freezed,
    Object? price = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            attribute: null == attribute
                ? _value.attribute
                : attribute // ignore: cast_nullable_to_non_nullable
                      as String,
            stock: null == stock
                ? _value.stock
                : stock // ignore: cast_nullable_to_non_nullable
                      as int,
            remainingStock: freezed == remainingStock
                ? _value.remainingStock
                : remainingStock // ignore: cast_nullable_to_non_nullable
                      as int?,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductVariantModelImplCopyWith<$Res>
    implements $ProductVariantModelCopyWith<$Res> {
  factory _$$ProductVariantModelImplCopyWith(
    _$ProductVariantModelImpl value,
    $Res Function(_$ProductVariantModelImpl) then,
  ) = __$$ProductVariantModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String attribute,
    int stock,
    @JsonKey(name: 'remaining_stock') int? remainingStock,
    @JsonKey(name: 'price') int? price,
  });
}

/// @nodoc
class __$$ProductVariantModelImplCopyWithImpl<$Res>
    extends _$ProductVariantModelCopyWithImpl<$Res, _$ProductVariantModelImpl>
    implements _$$ProductVariantModelImplCopyWith<$Res> {
  __$$ProductVariantModelImplCopyWithImpl(
    _$ProductVariantModelImpl _value,
    $Res Function(_$ProductVariantModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductVariantModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attribute = null,
    Object? stock = null,
    Object? remainingStock = freezed,
    Object? price = freezed,
  }) {
    return _then(
      _$ProductVariantModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        attribute: null == attribute
            ? _value.attribute
            : attribute // ignore: cast_nullable_to_non_nullable
                  as String,
        stock: null == stock
            ? _value.stock
            : stock // ignore: cast_nullable_to_non_nullable
                  as int,
        remainingStock: freezed == remainingStock
            ? _value.remainingStock
            : remainingStock // ignore: cast_nullable_to_non_nullable
                  as int?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductVariantModelImpl implements _ProductVariantModel {
  const _$ProductVariantModelImpl({
    required this.id,
    required this.attribute,
    required this.stock,
    @JsonKey(name: 'remaining_stock') this.remainingStock,
    @JsonKey(name: 'price') this.price,
  });

  factory _$ProductVariantModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductVariantModelImplFromJson(json);

  @override
  final int id;

  /// E.g. "S, L, XL, XXL"
  @override
  final String attribute;
  @override
  final int stock;
  @override
  @JsonKey(name: 'remaining_stock')
  final int? remainingStock;
  @override
  @JsonKey(name: 'price')
  final int? price;

  @override
  String toString() {
    return 'ProductVariantModel(id: $id, attribute: $attribute, stock: $stock, remainingStock: $remainingStock, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductVariantModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.remainingStock, remainingStock) ||
                other.remainingStock == remainingStock) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, attribute, stock, remainingStock, price);

  /// Create a copy of ProductVariantModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductVariantModelImplCopyWith<_$ProductVariantModelImpl> get copyWith =>
      __$$ProductVariantModelImplCopyWithImpl<_$ProductVariantModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductVariantModelImplToJson(this);
  }
}

abstract class _ProductVariantModel implements ProductVariantModel {
  const factory _ProductVariantModel({
    required final int id,
    required final String attribute,
    required final int stock,
    @JsonKey(name: 'remaining_stock') final int? remainingStock,
    @JsonKey(name: 'price') final int? price,
  }) = _$ProductVariantModelImpl;

  factory _ProductVariantModel.fromJson(Map<String, dynamic> json) =
      _$ProductVariantModelImpl.fromJson;

  @override
  int get id;

  /// E.g. "S, L, XL, XXL"
  @override
  String get attribute;
  @override
  int get stock;
  @override
  @JsonKey(name: 'remaining_stock')
  int? get remainingStock;
  @override
  @JsonKey(name: 'price')
  int? get price;

  /// Create a copy of ProductVariantModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductVariantModelImplCopyWith<_$ProductVariantModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
