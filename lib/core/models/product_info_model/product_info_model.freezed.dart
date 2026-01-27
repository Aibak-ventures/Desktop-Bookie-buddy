// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductInfoModel _$ProductInfoModelFromJson(Map<String, dynamic> json) {
  return _ProductInfoModel.fromJson(json);
}

/// @nodoc
mixin _$ProductInfoModel {
  @JsonKey(name: 'id', readValue: _idCustomRead)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'variant_id')
  int? get variantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_thumbnail', defaultValue: '')
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
  MainServiceType? get mainServiceType => throw _privateConstructorUsedError;
  @JsonKey(name: 'variant_attribute')
  String? get variantAttribute => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 0)
  int get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'measurements', fromJson: _parseMeasurements)
  List<MeasurementValueModel> get measurements =>
      throw _privateConstructorUsedError; // Available stock from the variant
  int? get stock => throw _privateConstructorUsedError;

  /// Serializes this ProductInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductInfoModelCopyWith<ProductInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductInfoModelCopyWith<$Res> {
  factory $ProductInfoModelCopyWith(
          ProductInfoModel value, $Res Function(ProductInfoModel) then) =
      _$ProductInfoModelCopyWithImpl<$Res, ProductInfoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id', readValue: _idCustomRead) int id,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'variant_id') int? variantId,
      @JsonKey(name: 'product_name') String name,
      @JsonKey(name: 'product_thumbnail', defaultValue: '') String? image,
      @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
      MainServiceType? mainServiceType,
      @JsonKey(name: 'variant_attribute') String? variantAttribute,
      String? color,
      String? category,
      String? model,
      int quantity,
      @JsonKey(defaultValue: 0) int amount,
      @JsonKey(name: 'measurements', fromJson: _parseMeasurements)
      List<MeasurementValueModel> measurements,
      int? stock});
}

/// @nodoc
class _$ProductInfoModelCopyWithImpl<$Res, $Val extends ProductInfoModel>
    implements $ProductInfoModelCopyWith<$Res> {
  _$ProductInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = freezed,
    Object? variantId = freezed,
    Object? name = null,
    Object? image = freezed,
    Object? mainServiceType = freezed,
    Object? variantAttribute = freezed,
    Object? color = freezed,
    Object? category = freezed,
    Object? model = freezed,
    Object? quantity = null,
    Object? amount = null,
    Object? measurements = null,
    Object? stock = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      mainServiceType: freezed == mainServiceType
          ? _value.mainServiceType
          : mainServiceType // ignore: cast_nullable_to_non_nullable
              as MainServiceType?,
      variantAttribute: freezed == variantAttribute
          ? _value.variantAttribute
          : variantAttribute // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      measurements: null == measurements
          ? _value.measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as List<MeasurementValueModel>,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductInfoModelImplCopyWith<$Res>
    implements $ProductInfoModelCopyWith<$Res> {
  factory _$$ProductInfoModelImplCopyWith(_$ProductInfoModelImpl value,
          $Res Function(_$ProductInfoModelImpl) then) =
      __$$ProductInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id', readValue: _idCustomRead) int id,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'variant_id') int? variantId,
      @JsonKey(name: 'product_name') String name,
      @JsonKey(name: 'product_thumbnail', defaultValue: '') String? image,
      @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
      MainServiceType? mainServiceType,
      @JsonKey(name: 'variant_attribute') String? variantAttribute,
      String? color,
      String? category,
      String? model,
      int quantity,
      @JsonKey(defaultValue: 0) int amount,
      @JsonKey(name: 'measurements', fromJson: _parseMeasurements)
      List<MeasurementValueModel> measurements,
      int? stock});
}

/// @nodoc
class __$$ProductInfoModelImplCopyWithImpl<$Res>
    extends _$ProductInfoModelCopyWithImpl<$Res, _$ProductInfoModelImpl>
    implements _$$ProductInfoModelImplCopyWith<$Res> {
  __$$ProductInfoModelImplCopyWithImpl(_$ProductInfoModelImpl _value,
      $Res Function(_$ProductInfoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = freezed,
    Object? variantId = freezed,
    Object? name = null,
    Object? image = freezed,
    Object? mainServiceType = freezed,
    Object? variantAttribute = freezed,
    Object? color = freezed,
    Object? category = freezed,
    Object? model = freezed,
    Object? quantity = null,
    Object? amount = null,
    Object? measurements = null,
    Object? stock = freezed,
  }) {
    return _then(_$ProductInfoModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      mainServiceType: freezed == mainServiceType
          ? _value.mainServiceType
          : mainServiceType // ignore: cast_nullable_to_non_nullable
              as MainServiceType?,
      variantAttribute: freezed == variantAttribute
          ? _value.variantAttribute
          : variantAttribute // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      measurements: null == measurements
          ? _value._measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as List<MeasurementValueModel>,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductInfoModelImpl implements _ProductInfoModel {
  const _$ProductInfoModelImpl(
      {@JsonKey(name: 'id', readValue: _idCustomRead) required this.id,
      @JsonKey(name: 'product_id') required this.productId,
      @JsonKey(name: 'variant_id') required this.variantId,
      @JsonKey(name: 'product_name') required this.name,
      @JsonKey(name: 'product_thumbnail', defaultValue: '') required this.image,
      @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
      this.mainServiceType,
      @JsonKey(name: 'variant_attribute') this.variantAttribute,
      this.color,
      this.category,
      this.model,
      required this.quantity,
      @JsonKey(defaultValue: 0) required this.amount,
      @JsonKey(name: 'measurements', fromJson: _parseMeasurements)
      final List<MeasurementValueModel> measurements = const [],
      this.stock})
      : _measurements = measurements;

  factory _$ProductInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductInfoModelImplFromJson(json);

  @override
  @JsonKey(name: 'id', readValue: _idCustomRead)
  final int id;
  @override
  @JsonKey(name: 'product_id')
  final int? productId;
  @override
  @JsonKey(name: 'variant_id')
  final int? variantId;
  @override
  @JsonKey(name: 'product_name')
  final String name;
  @override
  @JsonKey(name: 'product_thumbnail', defaultValue: '')
  final String? image;
  @override
  @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
  final MainServiceType? mainServiceType;
  @override
  @JsonKey(name: 'variant_attribute')
  final String? variantAttribute;
  @override
  final String? color;
  @override
  final String? category;
  @override
  final String? model;
  @override
  final int quantity;
  @override
  @JsonKey(defaultValue: 0)
  final int amount;
  final List<MeasurementValueModel> _measurements;
  @override
  @JsonKey(name: 'measurements', fromJson: _parseMeasurements)
  List<MeasurementValueModel> get measurements {
    if (_measurements is EqualUnmodifiableListView) return _measurements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_measurements);
  }

// Available stock from the variant
  @override
  final int? stock;

  @override
  String toString() {
    return 'ProductInfoModel(id: $id, productId: $productId, variantId: $variantId, name: $name, image: $image, mainServiceType: $mainServiceType, variantAttribute: $variantAttribute, color: $color, category: $category, model: $model, quantity: $quantity, amount: $amount, measurements: $measurements, stock: $stock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductInfoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.mainServiceType, mainServiceType) ||
                other.mainServiceType == mainServiceType) &&
            (identical(other.variantAttribute, variantAttribute) ||
                other.variantAttribute == variantAttribute) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            const DeepCollectionEquality()
                .equals(other._measurements, _measurements) &&
            (identical(other.stock, stock) || other.stock == stock));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      productId,
      variantId,
      name,
      image,
      mainServiceType,
      variantAttribute,
      color,
      category,
      model,
      quantity,
      amount,
      const DeepCollectionEquality().hash(_measurements),
      stock);

  /// Create a copy of ProductInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductInfoModelImplCopyWith<_$ProductInfoModelImpl> get copyWith =>
      __$$ProductInfoModelImplCopyWithImpl<_$ProductInfoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductInfoModelImplToJson(
      this,
    );
  }
}

abstract class _ProductInfoModel implements ProductInfoModel {
  const factory _ProductInfoModel(
      {@JsonKey(name: 'id', readValue: _idCustomRead) required final int id,
      @JsonKey(name: 'product_id') required final int? productId,
      @JsonKey(name: 'variant_id') required final int? variantId,
      @JsonKey(name: 'product_name') required final String name,
      @JsonKey(name: 'product_thumbnail', defaultValue: '')
      required final String? image,
      @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
      final MainServiceType? mainServiceType,
      @JsonKey(name: 'variant_attribute') final String? variantAttribute,
      final String? color,
      final String? category,
      final String? model,
      required final int quantity,
      @JsonKey(defaultValue: 0) required final int amount,
      @JsonKey(name: 'measurements', fromJson: _parseMeasurements)
      final List<MeasurementValueModel> measurements,
      final int? stock}) = _$ProductInfoModelImpl;

  factory _ProductInfoModel.fromJson(Map<String, dynamic> json) =
      _$ProductInfoModelImpl.fromJson;

  @override
  @JsonKey(name: 'id', readValue: _idCustomRead)
  int get id;
  @override
  @JsonKey(name: 'product_id')
  int? get productId;
  @override
  @JsonKey(name: 'variant_id')
  int? get variantId;
  @override
  @JsonKey(name: 'product_name')
  String get name;
  @override
  @JsonKey(name: 'product_thumbnail', defaultValue: '')
  String? get image;
  @override
  @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
  MainServiceType? get mainServiceType;
  @override
  @JsonKey(name: 'variant_attribute')
  String? get variantAttribute;
  @override
  String? get color;
  @override
  String? get category;
  @override
  String? get model;
  @override
  int get quantity;
  @override
  @JsonKey(defaultValue: 0)
  int get amount;
  @override
  @JsonKey(name: 'measurements', fromJson: _parseMeasurements)
  List<MeasurementValueModel>
      get measurements; // Available stock from the variant
  @override
  int? get stock;

  /// Create a copy of ProductInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductInfoModelImplCopyWith<_$ProductInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
