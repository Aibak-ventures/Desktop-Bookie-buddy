// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductModel {

 int get id; String get name; String? get description;@JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString) MainServiceType? get mainServiceType; String? get color; String? get model; String? get image;@JsonKey(name: 'thumbnail_image') String? get thumbnailImage; String? get category;@JsonKey(name: 'purchase_price') int? get purchaseAmount;@JsonKey(name: 'price') int? get price;@JsonKey(name: 'sale_price', fromJson: _salePriceFromJson) String? get salePrice;// Vehicle-specific fields (for direct API responses or request models)
@JsonKey(name: 'registration_number') String? get registrationNumber;@JsonKey(name: 'pollution_expiry') String? get pollutionExpiry;@JsonKey(name: 'insurance_expiry') String? get insuranceExpiry;@JsonKey(name: 'fitness_expiry') String? get fitnessExpiry;@JsonKey(name: 'barcode') String? get barcode;@JsonKey(name: 'general_service_name') String? get generalServiceName;// Attributes map for nested vehicle data from list API
 Map<String, dynamic> get attributes;@JsonKey(name: 'variants') List<ProductVariantModel> get variants;
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductModelCopyWith<ProductModel> get copyWith => _$ProductModelCopyWithImpl<ProductModel>(this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.mainServiceType, mainServiceType) || other.mainServiceType == mainServiceType)&&(identical(other.color, color) || other.color == color)&&(identical(other.model, model) || other.model == model)&&(identical(other.image, image) || other.image == image)&&(identical(other.thumbnailImage, thumbnailImage) || other.thumbnailImage == thumbnailImage)&&(identical(other.category, category) || other.category == category)&&(identical(other.purchaseAmount, purchaseAmount) || other.purchaseAmount == purchaseAmount)&&(identical(other.price, price) || other.price == price)&&(identical(other.salePrice, salePrice) || other.salePrice == salePrice)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.pollutionExpiry, pollutionExpiry) || other.pollutionExpiry == pollutionExpiry)&&(identical(other.insuranceExpiry, insuranceExpiry) || other.insuranceExpiry == insuranceExpiry)&&(identical(other.fitnessExpiry, fitnessExpiry) || other.fitnessExpiry == fitnessExpiry)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.generalServiceName, generalServiceName) || other.generalServiceName == generalServiceName)&&const DeepCollectionEquality().equals(other.attributes, attributes)&&const DeepCollectionEquality().equals(other.variants, variants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,mainServiceType,color,model,image,thumbnailImage,category,purchaseAmount,price,salePrice,registrationNumber,pollutionExpiry,insuranceExpiry,fitnessExpiry,barcode,generalServiceName,const DeepCollectionEquality().hash(attributes),const DeepCollectionEquality().hash(variants)]);

@override
String toString() {
  return 'ProductModel(id: $id, name: $name, description: $description, mainServiceType: $mainServiceType, color: $color, model: $model, image: $image, thumbnailImage: $thumbnailImage, category: $category, purchaseAmount: $purchaseAmount, price: $price, salePrice: $salePrice, registrationNumber: $registrationNumber, pollutionExpiry: $pollutionExpiry, insuranceExpiry: $insuranceExpiry, fitnessExpiry: $fitnessExpiry, barcode: $barcode, generalServiceName: $generalServiceName, attributes: $attributes, variants: $variants)';
}


}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res>  {
  factory $ProductModelCopyWith(ProductModel value, $Res Function(ProductModel) _then) = _$ProductModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description,@JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString) MainServiceType? mainServiceType, String? color, String? model, String? image,@JsonKey(name: 'thumbnail_image') String? thumbnailImage, String? category,@JsonKey(name: 'purchase_price') int? purchaseAmount,@JsonKey(name: 'price') int? price,@JsonKey(name: 'sale_price', fromJson: _salePriceFromJson) String? salePrice,@JsonKey(name: 'registration_number') String? registrationNumber,@JsonKey(name: 'pollution_expiry') String? pollutionExpiry,@JsonKey(name: 'insurance_expiry') String? insuranceExpiry,@JsonKey(name: 'fitness_expiry') String? fitnessExpiry,@JsonKey(name: 'barcode') String? barcode,@JsonKey(name: 'general_service_name') String? generalServiceName, Map<String, dynamic> attributes,@JsonKey(name: 'variants') List<ProductVariantModel> variants
});




}
/// @nodoc
class _$ProductModelCopyWithImpl<$Res>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? mainServiceType = freezed,Object? color = freezed,Object? model = freezed,Object? image = freezed,Object? thumbnailImage = freezed,Object? category = freezed,Object? purchaseAmount = freezed,Object? price = freezed,Object? salePrice = freezed,Object? registrationNumber = freezed,Object? pollutionExpiry = freezed,Object? insuranceExpiry = freezed,Object? fitnessExpiry = freezed,Object? barcode = freezed,Object? generalServiceName = freezed,Object? attributes = null,Object? variants = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mainServiceType: freezed == mainServiceType ? _self.mainServiceType : mainServiceType // ignore: cast_nullable_to_non_nullable
as MainServiceType?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,thumbnailImage: freezed == thumbnailImage ? _self.thumbnailImage : thumbnailImage // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,purchaseAmount: freezed == purchaseAmount ? _self.purchaseAmount : purchaseAmount // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,salePrice: freezed == salePrice ? _self.salePrice : salePrice // ignore: cast_nullable_to_non_nullable
as String?,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,pollutionExpiry: freezed == pollutionExpiry ? _self.pollutionExpiry : pollutionExpiry // ignore: cast_nullable_to_non_nullable
as String?,insuranceExpiry: freezed == insuranceExpiry ? _self.insuranceExpiry : insuranceExpiry // ignore: cast_nullable_to_non_nullable
as String?,fitnessExpiry: freezed == fitnessExpiry ? _self.fitnessExpiry : fitnessExpiry // ignore: cast_nullable_to_non_nullable
as String?,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,generalServiceName: freezed == generalServiceName ? _self.generalServiceName : generalServiceName // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,variants: null == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<ProductVariantModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductModel].
extension ProductModelPatterns on ProductModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description, @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)  MainServiceType? mainServiceType,  String? color,  String? model,  String? image, @JsonKey(name: 'thumbnail_image')  String? thumbnailImage,  String? category, @JsonKey(name: 'purchase_price')  int? purchaseAmount, @JsonKey(name: 'price')  int? price, @JsonKey(name: 'sale_price', fromJson: _salePriceFromJson)  String? salePrice, @JsonKey(name: 'registration_number')  String? registrationNumber, @JsonKey(name: 'pollution_expiry')  String? pollutionExpiry, @JsonKey(name: 'insurance_expiry')  String? insuranceExpiry, @JsonKey(name: 'fitness_expiry')  String? fitnessExpiry, @JsonKey(name: 'barcode')  String? barcode, @JsonKey(name: 'general_service_name')  String? generalServiceName,  Map<String, dynamic> attributes, @JsonKey(name: 'variants')  List<ProductVariantModel> variants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.mainServiceType,_that.color,_that.model,_that.image,_that.thumbnailImage,_that.category,_that.purchaseAmount,_that.price,_that.salePrice,_that.registrationNumber,_that.pollutionExpiry,_that.insuranceExpiry,_that.fitnessExpiry,_that.barcode,_that.generalServiceName,_that.attributes,_that.variants);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description, @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)  MainServiceType? mainServiceType,  String? color,  String? model,  String? image, @JsonKey(name: 'thumbnail_image')  String? thumbnailImage,  String? category, @JsonKey(name: 'purchase_price')  int? purchaseAmount, @JsonKey(name: 'price')  int? price, @JsonKey(name: 'sale_price', fromJson: _salePriceFromJson)  String? salePrice, @JsonKey(name: 'registration_number')  String? registrationNumber, @JsonKey(name: 'pollution_expiry')  String? pollutionExpiry, @JsonKey(name: 'insurance_expiry')  String? insuranceExpiry, @JsonKey(name: 'fitness_expiry')  String? fitnessExpiry, @JsonKey(name: 'barcode')  String? barcode, @JsonKey(name: 'general_service_name')  String? generalServiceName,  Map<String, dynamic> attributes, @JsonKey(name: 'variants')  List<ProductVariantModel> variants)  $default,) {final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that.id,_that.name,_that.description,_that.mainServiceType,_that.color,_that.model,_that.image,_that.thumbnailImage,_that.category,_that.purchaseAmount,_that.price,_that.salePrice,_that.registrationNumber,_that.pollutionExpiry,_that.insuranceExpiry,_that.fitnessExpiry,_that.barcode,_that.generalServiceName,_that.attributes,_that.variants);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description, @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString)  MainServiceType? mainServiceType,  String? color,  String? model,  String? image, @JsonKey(name: 'thumbnail_image')  String? thumbnailImage,  String? category, @JsonKey(name: 'purchase_price')  int? purchaseAmount, @JsonKey(name: 'price')  int? price, @JsonKey(name: 'sale_price', fromJson: _salePriceFromJson)  String? salePrice, @JsonKey(name: 'registration_number')  String? registrationNumber, @JsonKey(name: 'pollution_expiry')  String? pollutionExpiry, @JsonKey(name: 'insurance_expiry')  String? insuranceExpiry, @JsonKey(name: 'fitness_expiry')  String? fitnessExpiry, @JsonKey(name: 'barcode')  String? barcode, @JsonKey(name: 'general_service_name')  String? generalServiceName,  Map<String, dynamic> attributes, @JsonKey(name: 'variants')  List<ProductVariantModel> variants)?  $default,) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.mainServiceType,_that.color,_that.model,_that.image,_that.thumbnailImage,_that.category,_that.purchaseAmount,_that.price,_that.salePrice,_that.registrationNumber,_that.pollutionExpiry,_that.insuranceExpiry,_that.fitnessExpiry,_that.barcode,_that.generalServiceName,_that.attributes,_that.variants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductModel extends ProductModel {
  const _ProductModel({required this.id, required this.name, required this.description, @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString) this.mainServiceType, this.color, this.model, this.image, @JsonKey(name: 'thumbnail_image') this.thumbnailImage, this.category, @JsonKey(name: 'purchase_price') this.purchaseAmount, @JsonKey(name: 'price') this.price, @JsonKey(name: 'sale_price', fromJson: _salePriceFromJson) this.salePrice, @JsonKey(name: 'registration_number') this.registrationNumber, @JsonKey(name: 'pollution_expiry') this.pollutionExpiry, @JsonKey(name: 'insurance_expiry') this.insuranceExpiry, @JsonKey(name: 'fitness_expiry') this.fitnessExpiry, @JsonKey(name: 'barcode') this.barcode, @JsonKey(name: 'general_service_name') this.generalServiceName, final  Map<String, dynamic> attributes = const {}, @JsonKey(name: 'variants') required final  List<ProductVariantModel> variants}): _attributes = attributes,_variants = variants,super._();
  factory _ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override@JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString) final  MainServiceType? mainServiceType;
@override final  String? color;
@override final  String? model;
@override final  String? image;
@override@JsonKey(name: 'thumbnail_image') final  String? thumbnailImage;
@override final  String? category;
@override@JsonKey(name: 'purchase_price') final  int? purchaseAmount;
@override@JsonKey(name: 'price') final  int? price;
@override@JsonKey(name: 'sale_price', fromJson: _salePriceFromJson) final  String? salePrice;
// Vehicle-specific fields (for direct API responses or request models)
@override@JsonKey(name: 'registration_number') final  String? registrationNumber;
@override@JsonKey(name: 'pollution_expiry') final  String? pollutionExpiry;
@override@JsonKey(name: 'insurance_expiry') final  String? insuranceExpiry;
@override@JsonKey(name: 'fitness_expiry') final  String? fitnessExpiry;
@override@JsonKey(name: 'barcode') final  String? barcode;
@override@JsonKey(name: 'general_service_name') final  String? generalServiceName;
// Attributes map for nested vehicle data from list API
 final  Map<String, dynamic> _attributes;
// Attributes map for nested vehicle data from list API
@override@JsonKey() Map<String, dynamic> get attributes {
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attributes);
}

 final  List<ProductVariantModel> _variants;
@override@JsonKey(name: 'variants') List<ProductVariantModel> get variants {
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variants);
}


/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductModelCopyWith<_ProductModel> get copyWith => __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.mainServiceType, mainServiceType) || other.mainServiceType == mainServiceType)&&(identical(other.color, color) || other.color == color)&&(identical(other.model, model) || other.model == model)&&(identical(other.image, image) || other.image == image)&&(identical(other.thumbnailImage, thumbnailImage) || other.thumbnailImage == thumbnailImage)&&(identical(other.category, category) || other.category == category)&&(identical(other.purchaseAmount, purchaseAmount) || other.purchaseAmount == purchaseAmount)&&(identical(other.price, price) || other.price == price)&&(identical(other.salePrice, salePrice) || other.salePrice == salePrice)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.pollutionExpiry, pollutionExpiry) || other.pollutionExpiry == pollutionExpiry)&&(identical(other.insuranceExpiry, insuranceExpiry) || other.insuranceExpiry == insuranceExpiry)&&(identical(other.fitnessExpiry, fitnessExpiry) || other.fitnessExpiry == fitnessExpiry)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.generalServiceName, generalServiceName) || other.generalServiceName == generalServiceName)&&const DeepCollectionEquality().equals(other._attributes, _attributes)&&const DeepCollectionEquality().equals(other._variants, _variants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,mainServiceType,color,model,image,thumbnailImage,category,purchaseAmount,price,salePrice,registrationNumber,pollutionExpiry,insuranceExpiry,fitnessExpiry,barcode,generalServiceName,const DeepCollectionEquality().hash(_attributes),const DeepCollectionEquality().hash(_variants)]);

@override
String toString() {
  return 'ProductModel(id: $id, name: $name, description: $description, mainServiceType: $mainServiceType, color: $color, model: $model, image: $image, thumbnailImage: $thumbnailImage, category: $category, purchaseAmount: $purchaseAmount, price: $price, salePrice: $salePrice, registrationNumber: $registrationNumber, pollutionExpiry: $pollutionExpiry, insuranceExpiry: $insuranceExpiry, fitnessExpiry: $fitnessExpiry, barcode: $barcode, generalServiceName: $generalServiceName, attributes: $attributes, variants: $variants)';
}


}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res> implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(_ProductModel value, $Res Function(_ProductModel) _then) = __$ProductModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description,@JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString) MainServiceType? mainServiceType, String? color, String? model, String? image,@JsonKey(name: 'thumbnail_image') String? thumbnailImage, String? category,@JsonKey(name: 'purchase_price') int? purchaseAmount,@JsonKey(name: 'price') int? price,@JsonKey(name: 'sale_price', fromJson: _salePriceFromJson) String? salePrice,@JsonKey(name: 'registration_number') String? registrationNumber,@JsonKey(name: 'pollution_expiry') String? pollutionExpiry,@JsonKey(name: 'insurance_expiry') String? insuranceExpiry,@JsonKey(name: 'fitness_expiry') String? fitnessExpiry,@JsonKey(name: 'barcode') String? barcode,@JsonKey(name: 'general_service_name') String? generalServiceName, Map<String, dynamic> attributes,@JsonKey(name: 'variants') List<ProductVariantModel> variants
});




}
/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? mainServiceType = freezed,Object? color = freezed,Object? model = freezed,Object? image = freezed,Object? thumbnailImage = freezed,Object? category = freezed,Object? purchaseAmount = freezed,Object? price = freezed,Object? salePrice = freezed,Object? registrationNumber = freezed,Object? pollutionExpiry = freezed,Object? insuranceExpiry = freezed,Object? fitnessExpiry = freezed,Object? barcode = freezed,Object? generalServiceName = freezed,Object? attributes = null,Object? variants = null,}) {
  return _then(_ProductModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mainServiceType: freezed == mainServiceType ? _self.mainServiceType : mainServiceType // ignore: cast_nullable_to_non_nullable
as MainServiceType?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,thumbnailImage: freezed == thumbnailImage ? _self.thumbnailImage : thumbnailImage // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,purchaseAmount: freezed == purchaseAmount ? _self.purchaseAmount : purchaseAmount // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,salePrice: freezed == salePrice ? _self.salePrice : salePrice // ignore: cast_nullable_to_non_nullable
as String?,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,pollutionExpiry: freezed == pollutionExpiry ? _self.pollutionExpiry : pollutionExpiry // ignore: cast_nullable_to_non_nullable
as String?,insuranceExpiry: freezed == insuranceExpiry ? _self.insuranceExpiry : insuranceExpiry // ignore: cast_nullable_to_non_nullable
as String?,fitnessExpiry: freezed == fitnessExpiry ? _self.fitnessExpiry : fitnessExpiry // ignore: cast_nullable_to_non_nullable
as String?,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,generalServiceName: freezed == generalServiceName ? _self.generalServiceName : generalServiceName // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,variants: null == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<ProductVariantModel>,
  ));
}


}

// dart format on
