// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
  MainServiceType? get mainServiceType => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnail_image')
  String? get thumbnailImage => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_price')
  int? get purchaseAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'price')
  int? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_price', fromJson: _salePriceFromJson)
  String? get salePrice =>
      throw _privateConstructorUsedError; // Vehicle-specific fields (for direct API responses or request models)
  @JsonKey(name: 'registration_number')
  String? get registrationNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'pollution_expiry')
  String? get pollutionExpiry => throw _privateConstructorUsedError;
  @JsonKey(name: 'insurance_expiry')
  String? get insuranceExpiry => throw _privateConstructorUsedError;
  @JsonKey(name: 'fitness_expiry')
  String? get fitnessExpiry => throw _privateConstructorUsedError;
  @JsonKey(name: 'barcode')
  String? get barcode => throw _privateConstructorUsedError;
  @JsonKey(name: 'general_service_name')
  String? get generalServiceName =>
      throw _privateConstructorUsedError; // Attributes map for nested vehicle data from list API
  Map<String, dynamic> get attributes => throw _privateConstructorUsedError;
  @JsonKey(name: 'variants')
  List<ProductVariantModel> get variants => throw _privateConstructorUsedError;

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) then) =
      _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
      MainServiceType? mainServiceType,
      String? color,
      String? model,
      String? image,
      @JsonKey(name: 'thumbnail_image') String? thumbnailImage,
      String? category,
      @JsonKey(name: 'purchase_price') int? purchaseAmount,
      @JsonKey(name: 'price') int? price,
      @JsonKey(name: 'sale_price', fromJson: _salePriceFromJson)
      String? salePrice,
      @JsonKey(name: 'registration_number') String? registrationNumber,
      @JsonKey(name: 'pollution_expiry') String? pollutionExpiry,
      @JsonKey(name: 'insurance_expiry') String? insuranceExpiry,
      @JsonKey(name: 'fitness_expiry') String? fitnessExpiry,
      @JsonKey(name: 'barcode') String? barcode,
      @JsonKey(name: 'general_service_name') String? generalServiceName,
      Map<String, dynamic> attributes,
      @JsonKey(name: 'variants') List<ProductVariantModel> variants});
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? mainServiceType = freezed,
    Object? color = freezed,
    Object? model = freezed,
    Object? image = freezed,
    Object? thumbnailImage = freezed,
    Object? category = freezed,
    Object? purchaseAmount = freezed,
    Object? price = freezed,
    Object? salePrice = freezed,
    Object? registrationNumber = freezed,
    Object? pollutionExpiry = freezed,
    Object? insuranceExpiry = freezed,
    Object? fitnessExpiry = freezed,
    Object? barcode = freezed,
    Object? generalServiceName = freezed,
    Object? attributes = null,
    Object? variants = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      mainServiceType: freezed == mainServiceType
          ? _value.mainServiceType
          : mainServiceType // ignore: cast_nullable_to_non_nullable
              as MainServiceType?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailImage: freezed == thumbnailImage
          ? _value.thumbnailImage
          : thumbnailImage // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseAmount: freezed == purchaseAmount
          ? _value.purchaseAmount
          : purchaseAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      salePrice: freezed == salePrice
          ? _value.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      pollutionExpiry: freezed == pollutionExpiry
          ? _value.pollutionExpiry
          : pollutionExpiry // ignore: cast_nullable_to_non_nullable
              as String?,
      insuranceExpiry: freezed == insuranceExpiry
          ? _value.insuranceExpiry
          : insuranceExpiry // ignore: cast_nullable_to_non_nullable
              as String?,
      fitnessExpiry: freezed == fitnessExpiry
          ? _value.fitnessExpiry
          : fitnessExpiry // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      generalServiceName: freezed == generalServiceName
          ? _value.generalServiceName
          : generalServiceName // ignore: cast_nullable_to_non_nullable
              as String?,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      variants: null == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<ProductVariantModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
          _$ProductModelImpl value, $Res Function(_$ProductModelImpl) then) =
      __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
      MainServiceType? mainServiceType,
      String? color,
      String? model,
      String? image,
      @JsonKey(name: 'thumbnail_image') String? thumbnailImage,
      String? category,
      @JsonKey(name: 'purchase_price') int? purchaseAmount,
      @JsonKey(name: 'price') int? price,
      @JsonKey(name: 'sale_price', fromJson: _salePriceFromJson)
      String? salePrice,
      @JsonKey(name: 'registration_number') String? registrationNumber,
      @JsonKey(name: 'pollution_expiry') String? pollutionExpiry,
      @JsonKey(name: 'insurance_expiry') String? insuranceExpiry,
      @JsonKey(name: 'fitness_expiry') String? fitnessExpiry,
      @JsonKey(name: 'barcode') String? barcode,
      @JsonKey(name: 'general_service_name') String? generalServiceName,
      Map<String, dynamic> attributes,
      @JsonKey(name: 'variants') List<ProductVariantModel> variants});
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
      _$ProductModelImpl _value, $Res Function(_$ProductModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? mainServiceType = freezed,
    Object? color = freezed,
    Object? model = freezed,
    Object? image = freezed,
    Object? thumbnailImage = freezed,
    Object? category = freezed,
    Object? purchaseAmount = freezed,
    Object? price = freezed,
    Object? salePrice = freezed,
    Object? registrationNumber = freezed,
    Object? pollutionExpiry = freezed,
    Object? insuranceExpiry = freezed,
    Object? fitnessExpiry = freezed,
    Object? barcode = freezed,
    Object? generalServiceName = freezed,
    Object? attributes = null,
    Object? variants = null,
  }) {
    return _then(_$ProductModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      mainServiceType: freezed == mainServiceType
          ? _value.mainServiceType
          : mainServiceType // ignore: cast_nullable_to_non_nullable
              as MainServiceType?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailImage: freezed == thumbnailImage
          ? _value.thumbnailImage
          : thumbnailImage // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseAmount: freezed == purchaseAmount
          ? _value.purchaseAmount
          : purchaseAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      salePrice: freezed == salePrice
          ? _value.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      pollutionExpiry: freezed == pollutionExpiry
          ? _value.pollutionExpiry
          : pollutionExpiry // ignore: cast_nullable_to_non_nullable
              as String?,
      insuranceExpiry: freezed == insuranceExpiry
          ? _value.insuranceExpiry
          : insuranceExpiry // ignore: cast_nullable_to_non_nullable
              as String?,
      fitnessExpiry: freezed == fitnessExpiry
          ? _value.fitnessExpiry
          : fitnessExpiry // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      generalServiceName: freezed == generalServiceName
          ? _value.generalServiceName
          : generalServiceName // ignore: cast_nullable_to_non_nullable
              as String?,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      variants: null == variants
          ? _value._variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<ProductVariantModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductModelImpl extends _ProductModel {
  const _$ProductModelImpl(
      {required this.id,
      required this.name,
      required this.description,
      @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
      this.mainServiceType,
      this.color,
      this.model,
      this.image,
      @JsonKey(name: 'thumbnail_image') this.thumbnailImage,
      this.category,
      @JsonKey(name: 'purchase_price') this.purchaseAmount,
      @JsonKey(name: 'price') this.price,
      @JsonKey(name: 'sale_price', fromJson: _salePriceFromJson) this.salePrice,
      @JsonKey(name: 'registration_number') this.registrationNumber,
      @JsonKey(name: 'pollution_expiry') this.pollutionExpiry,
      @JsonKey(name: 'insurance_expiry') this.insuranceExpiry,
      @JsonKey(name: 'fitness_expiry') this.fitnessExpiry,
      @JsonKey(name: 'barcode') this.barcode,
      @JsonKey(name: 'general_service_name') this.generalServiceName,
      final Map<String, dynamic> attributes = const {},
      @JsonKey(name: 'variants')
      required final List<ProductVariantModel> variants})
      : _attributes = attributes,
        _variants = variants,
        super._();

  factory _$ProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
  final MainServiceType? mainServiceType;
  @override
  final String? color;
  @override
  final String? model;
  @override
  final String? image;
  @override
  @JsonKey(name: 'thumbnail_image')
  final String? thumbnailImage;
  @override
  final String? category;
  @override
  @JsonKey(name: 'purchase_price')
  final int? purchaseAmount;
  @override
  @JsonKey(name: 'price')
  final int? price;
  @override
  @JsonKey(name: 'sale_price', fromJson: _salePriceFromJson)
  final String? salePrice;
// Vehicle-specific fields (for direct API responses or request models)
  @override
  @JsonKey(name: 'registration_number')
  final String? registrationNumber;
  @override
  @JsonKey(name: 'pollution_expiry')
  final String? pollutionExpiry;
  @override
  @JsonKey(name: 'insurance_expiry')
  final String? insuranceExpiry;
  @override
  @JsonKey(name: 'fitness_expiry')
  final String? fitnessExpiry;
  @override
  @JsonKey(name: 'barcode')
  final String? barcode;
  @override
  @JsonKey(name: 'general_service_name')
  final String? generalServiceName;
// Attributes map for nested vehicle data from list API
  final Map<String, dynamic> _attributes;
// Attributes map for nested vehicle data from list API
  @override
  @JsonKey()
  Map<String, dynamic> get attributes {
    if (_attributes is EqualUnmodifiableMapView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attributes);
  }

  final List<ProductVariantModel> _variants;
  @override
  @JsonKey(name: 'variants')
  List<ProductVariantModel> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, mainServiceType: $mainServiceType, color: $color, model: $model, image: $image, thumbnailImage: $thumbnailImage, category: $category, purchaseAmount: $purchaseAmount, price: $price, salePrice: $salePrice, registrationNumber: $registrationNumber, pollutionExpiry: $pollutionExpiry, insuranceExpiry: $insuranceExpiry, fitnessExpiry: $fitnessExpiry, barcode: $barcode, generalServiceName: $generalServiceName, attributes: $attributes, variants: $variants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.mainServiceType, mainServiceType) ||
                other.mainServiceType == mainServiceType) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.thumbnailImage, thumbnailImage) ||
                other.thumbnailImage == thumbnailImage) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.purchaseAmount, purchaseAmount) ||
                other.purchaseAmount == purchaseAmount) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.pollutionExpiry, pollutionExpiry) ||
                other.pollutionExpiry == pollutionExpiry) &&
            (identical(other.insuranceExpiry, insuranceExpiry) ||
                other.insuranceExpiry == insuranceExpiry) &&
            (identical(other.fitnessExpiry, fitnessExpiry) ||
                other.fitnessExpiry == fitnessExpiry) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.generalServiceName, generalServiceName) ||
                other.generalServiceName == generalServiceName) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes) &&
            const DeepCollectionEquality().equals(other._variants, _variants));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        description,
        mainServiceType,
        color,
        model,
        image,
        thumbnailImage,
        category,
        purchaseAmount,
        price,
        salePrice,
        registrationNumber,
        pollutionExpiry,
        insuranceExpiry,
        fitnessExpiry,
        barcode,
        generalServiceName,
        const DeepCollectionEquality().hash(_attributes),
        const DeepCollectionEquality().hash(_variants)
      ]);

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductModelImplToJson(
      this,
    );
  }
}

abstract class _ProductModel extends ProductModel {
  const factory _ProductModel(
      {required final int id,
      required final String name,
      required final String? description,
      @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
      final MainServiceType? mainServiceType,
      final String? color,
      final String? model,
      final String? image,
      @JsonKey(name: 'thumbnail_image') final String? thumbnailImage,
      final String? category,
      @JsonKey(name: 'purchase_price') final int? purchaseAmount,
      @JsonKey(name: 'price') final int? price,
      @JsonKey(name: 'sale_price', fromJson: _salePriceFromJson)
      final String? salePrice,
      @JsonKey(name: 'registration_number') final String? registrationNumber,
      @JsonKey(name: 'pollution_expiry') final String? pollutionExpiry,
      @JsonKey(name: 'insurance_expiry') final String? insuranceExpiry,
      @JsonKey(name: 'fitness_expiry') final String? fitnessExpiry,
      @JsonKey(name: 'barcode') final String? barcode,
      @JsonKey(name: 'general_service_name') final String? generalServiceName,
      final Map<String, dynamic> attributes,
      @JsonKey(name: 'variants')
      required final List<ProductVariantModel> variants}) = _$ProductModelImpl;
  const _ProductModel._() : super._();

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$ProductModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)
  MainServiceType? get mainServiceType;
  @override
  String? get color;
  @override
  String? get model;
  @override
  String? get image;
  @override
  @JsonKey(name: 'thumbnail_image')
  String? get thumbnailImage;
  @override
  String? get category;
  @override
  @JsonKey(name: 'purchase_price')
  int? get purchaseAmount;
  @override
  @JsonKey(name: 'price')
  int? get price;
  @override
  @JsonKey(name: 'sale_price', fromJson: _salePriceFromJson)
  String?
      get salePrice; // Vehicle-specific fields (for direct API responses or request models)
  @override
  @JsonKey(name: 'registration_number')
  String? get registrationNumber;
  @override
  @JsonKey(name: 'pollution_expiry')
  String? get pollutionExpiry;
  @override
  @JsonKey(name: 'insurance_expiry')
  String? get insuranceExpiry;
  @override
  @JsonKey(name: 'fitness_expiry')
  String? get fitnessExpiry;
  @override
  @JsonKey(name: 'barcode')
  String? get barcode;
  @override
  @JsonKey(name: 'general_service_name')
  String?
      get generalServiceName; // Attributes map for nested vehicle data from list API
  @override
  Map<String, dynamic> get attributes;
  @override
  @JsonKey(name: 'variants')
  List<ProductVariantModel> get variants;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
