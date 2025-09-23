// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductRequestModel _$ProductRequestModelFromJson(Map<String, dynamic> json) {
  return _ProductRequestModel.fromJson(json);
}

/// @nodoc
mixin _$ProductRequestModel {
  @JsonKey(includeIfNull: false)
  int? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_service_id', includeIfNull: false)
  int? get serviceId => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_price', includeIfNull: false)
  int? get purchasePrice => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  int? get price => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get model => throw _privateConstructorUsedError;
  @JsonKey(toJson: _variantsToJson, includeIfNull: false)
  List<ProductVariantModel>? get variants =>
      throw _privateConstructorUsedError; // Don't include this in auto-generated JSON
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get image => throw _privateConstructorUsedError;

  /// Serializes this ProductRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductRequestModelCopyWith<ProductRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductRequestModelCopyWith<$Res> {
  factory $ProductRequestModelCopyWith(
          ProductRequestModel value, $Res Function(ProductRequestModel) then) =
      _$ProductRequestModelCopyWithImpl<$Res, ProductRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) int? productId,
      @JsonKey(name: 'shop_service_id', includeIfNull: false) int? serviceId,
      @JsonKey(includeIfNull: false) String? name,
      @JsonKey(includeIfNull: false) String? description,
      @JsonKey(includeIfNull: false) String? color,
      @JsonKey(name: 'purchase_price', includeIfNull: false) int? purchasePrice,
      @JsonKey(includeIfNull: false) int? price,
      @JsonKey(includeIfNull: false) String? category,
      @JsonKey(includeIfNull: false) String? model,
      @JsonKey(toJson: _variantsToJson, includeIfNull: false)
      List<ProductVariantModel>? variants,
      @JsonKey(includeFromJson: false, includeToJson: false) File? image});
}

/// @nodoc
class _$ProductRequestModelCopyWithImpl<$Res, $Val extends ProductRequestModel>
    implements $ProductRequestModelCopyWith<$Res> {
  _$ProductRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? serviceId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? color = freezed,
    Object? purchasePrice = freezed,
    Object? price = freezed,
    Object? category = freezed,
    Object? model = freezed,
    Object? variants = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      purchasePrice: freezed == purchasePrice
          ? _value.purchasePrice
          : purchasePrice // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      variants: freezed == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<ProductVariantModel>?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductRequestModelImplCopyWith<$Res>
    implements $ProductRequestModelCopyWith<$Res> {
  factory _$$ProductRequestModelImplCopyWith(_$ProductRequestModelImpl value,
          $Res Function(_$ProductRequestModelImpl) then) =
      __$$ProductRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) int? productId,
      @JsonKey(name: 'shop_service_id', includeIfNull: false) int? serviceId,
      @JsonKey(includeIfNull: false) String? name,
      @JsonKey(includeIfNull: false) String? description,
      @JsonKey(includeIfNull: false) String? color,
      @JsonKey(name: 'purchase_price', includeIfNull: false) int? purchasePrice,
      @JsonKey(includeIfNull: false) int? price,
      @JsonKey(includeIfNull: false) String? category,
      @JsonKey(includeIfNull: false) String? model,
      @JsonKey(toJson: _variantsToJson, includeIfNull: false)
      List<ProductVariantModel>? variants,
      @JsonKey(includeFromJson: false, includeToJson: false) File? image});
}

/// @nodoc
class __$$ProductRequestModelImplCopyWithImpl<$Res>
    extends _$ProductRequestModelCopyWithImpl<$Res, _$ProductRequestModelImpl>
    implements _$$ProductRequestModelImplCopyWith<$Res> {
  __$$ProductRequestModelImplCopyWithImpl(_$ProductRequestModelImpl _value,
      $Res Function(_$ProductRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? serviceId = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? color = freezed,
    Object? purchasePrice = freezed,
    Object? price = freezed,
    Object? category = freezed,
    Object? model = freezed,
    Object? variants = freezed,
    Object? image = freezed,
  }) {
    return _then(_$ProductRequestModelImpl(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      purchasePrice: freezed == purchasePrice
          ? _value.purchasePrice
          : purchasePrice // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      variants: freezed == variants
          ? _value._variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<ProductVariantModel>?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductRequestModelImpl implements _ProductRequestModel {
  const _$ProductRequestModelImpl(
      {@JsonKey(includeIfNull: false) this.productId,
      @JsonKey(name: 'shop_service_id', includeIfNull: false) this.serviceId,
      @JsonKey(includeIfNull: false) this.name,
      @JsonKey(includeIfNull: false) this.description,
      @JsonKey(includeIfNull: false) this.color,
      @JsonKey(name: 'purchase_price', includeIfNull: false) this.purchasePrice,
      @JsonKey(includeIfNull: false) this.price,
      @JsonKey(includeIfNull: false) this.category,
      @JsonKey(includeIfNull: false) this.model,
      @JsonKey(toJson: _variantsToJson, includeIfNull: false)
      final List<ProductVariantModel>? variants,
      @JsonKey(includeFromJson: false, includeToJson: false) this.image})
      : _variants = variants;

  factory _$ProductRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductRequestModelImplFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final int? productId;
  @override
  @JsonKey(name: 'shop_service_id', includeIfNull: false)
  final int? serviceId;
  @override
  @JsonKey(includeIfNull: false)
  final String? name;
  @override
  @JsonKey(includeIfNull: false)
  final String? description;
  @override
  @JsonKey(includeIfNull: false)
  final String? color;
  @override
  @JsonKey(name: 'purchase_price', includeIfNull: false)
  final int? purchasePrice;
  @override
  @JsonKey(includeIfNull: false)
  final int? price;
  @override
  @JsonKey(includeIfNull: false)
  final String? category;
  @override
  @JsonKey(includeIfNull: false)
  final String? model;
  final List<ProductVariantModel>? _variants;
  @override
  @JsonKey(toJson: _variantsToJson, includeIfNull: false)
  List<ProductVariantModel>? get variants {
    final value = _variants;
    if (value == null) return null;
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Don't include this in auto-generated JSON
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? image;

  @override
  String toString() {
    return 'ProductRequestModel(productId: $productId, serviceId: $serviceId, name: $name, description: $description, color: $color, purchasePrice: $purchasePrice, price: $price, category: $category, model: $model, variants: $variants, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductRequestModelImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.purchasePrice, purchasePrice) ||
                other.purchasePrice == purchasePrice) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.model, model) || other.model == model) &&
            const DeepCollectionEquality().equals(other._variants, _variants) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      serviceId,
      name,
      description,
      color,
      purchasePrice,
      price,
      category,
      model,
      const DeepCollectionEquality().hash(_variants),
      image);

  /// Create a copy of ProductRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductRequestModelImplCopyWith<_$ProductRequestModelImpl> get copyWith =>
      __$$ProductRequestModelImplCopyWithImpl<_$ProductRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductRequestModelImplToJson(
      this,
    );
  }
}

abstract class _ProductRequestModel implements ProductRequestModel {
  const factory _ProductRequestModel(
      {@JsonKey(includeIfNull: false) final int? productId,
      @JsonKey(name: 'shop_service_id', includeIfNull: false)
      final int? serviceId,
      @JsonKey(includeIfNull: false) final String? name,
      @JsonKey(includeIfNull: false) final String? description,
      @JsonKey(includeIfNull: false) final String? color,
      @JsonKey(name: 'purchase_price', includeIfNull: false)
      final int? purchasePrice,
      @JsonKey(includeIfNull: false) final int? price,
      @JsonKey(includeIfNull: false) final String? category,
      @JsonKey(includeIfNull: false) final String? model,
      @JsonKey(toJson: _variantsToJson, includeIfNull: false)
      final List<ProductVariantModel>? variants,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final File? image}) = _$ProductRequestModelImpl;

  factory _ProductRequestModel.fromJson(Map<String, dynamic> json) =
      _$ProductRequestModelImpl.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  int? get productId;
  @override
  @JsonKey(name: 'shop_service_id', includeIfNull: false)
  int? get serviceId;
  @override
  @JsonKey(includeIfNull: false)
  String? get name;
  @override
  @JsonKey(includeIfNull: false)
  String? get description;
  @override
  @JsonKey(includeIfNull: false)
  String? get color;
  @override
  @JsonKey(name: 'purchase_price', includeIfNull: false)
  int? get purchasePrice;
  @override
  @JsonKey(includeIfNull: false)
  int? get price;
  @override
  @JsonKey(includeIfNull: false)
  String? get category;
  @override
  @JsonKey(includeIfNull: false)
  String? get model;
  @override
  @JsonKey(toJson: _variantsToJson, includeIfNull: false)
  List<ProductVariantModel>?
      get variants; // Don't include this in auto-generated JSON
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get image;

  /// Create a copy of ProductRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductRequestModelImplCopyWith<_$ProductRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
