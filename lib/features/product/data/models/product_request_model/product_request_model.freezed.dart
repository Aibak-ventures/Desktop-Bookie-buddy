// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductRequestModel {

@JsonKey(includeIfNull: false) int? get productId;@JsonKey(name: 'shop_service_id', includeIfNull: false) int? get serviceId;@JsonKey(includeIfNull: false) String? get name;@JsonKey(includeIfNull: false) String? get description;@JsonKey(includeIfNull: false) String? get color;@JsonKey(name: 'purchase_price', includeIfNull: false) int? get purchasePrice;@JsonKey(includeIfNull: false) int? get price;@JsonKey(name: 'sale_price', includeIfNull: false) int? get salePrice;@JsonKey(includeIfNull: false) String? get category;@JsonKey(includeIfNull: false) String? get model;@JsonKey(includeFromJson: false, includeToJson: false) String? get registrationNumber;@JsonKey(includeFromJson: false, includeToJson: false) String? get pollutionExpiry;@JsonKey(includeFromJson: false, includeToJson: false) String? get insuranceExpiry;@JsonKey(includeFromJson: false, includeToJson: false) String? get fitnessExpiry;@JsonKey(includeFromJson: false, includeToJson: false) String? get barcode;@JsonKey(toJson: _variantsToJson, includeIfNull: false) List<ProductVariantModel>? get variants;@JsonKey(includeFromJson: false, includeToJson: false) XFile? get image;
/// Create a copy of ProductRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductRequestModelCopyWith<ProductRequestModel> get copyWith => _$ProductRequestModelCopyWithImpl<ProductRequestModel>(this as ProductRequestModel, _$identity);

  /// Serializes this ProductRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProductRequestModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductRequestModel&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.serviceId, _this.serviceId) || other.serviceId == _this.serviceId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.purchasePrice, _this.purchasePrice) || other.purchasePrice == _this.purchasePrice)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.salePrice, _this.salePrice) || other.salePrice == _this.salePrice)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.model, _this.model) || other.model == _this.model)&&(identical(other.registrationNumber, _this.registrationNumber) || other.registrationNumber == _this.registrationNumber)&&(identical(other.pollutionExpiry, _this.pollutionExpiry) || other.pollutionExpiry == _this.pollutionExpiry)&&(identical(other.insuranceExpiry, _this.insuranceExpiry) || other.insuranceExpiry == _this.insuranceExpiry)&&(identical(other.fitnessExpiry, _this.fitnessExpiry) || other.fitnessExpiry == _this.fitnessExpiry)&&(identical(other.barcode, _this.barcode) || other.barcode == _this.barcode)&&const DeepCollectionEquality().equals(other.variants, _this.variants)&&(identical(other.image, _this.image) || other.image == _this.image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProductRequestModel;
  return Object.hash(runtimeType,_this.productId,_this.serviceId,_this.name,_this.description,_this.color,_this.purchasePrice,_this.price,_this.salePrice,_this.category,_this.model,_this.registrationNumber,_this.pollutionExpiry,_this.insuranceExpiry,_this.fitnessExpiry,_this.barcode,const DeepCollectionEquality().hash(_this.variants),_this.image);
}

@override
String toString() {
  final _this = this as ProductRequestModel;
  return 'ProductRequestModel(productId: ${_this.productId}, serviceId: ${_this.serviceId}, name: ${_this.name}, description: ${_this.description}, color: ${_this.color}, purchasePrice: ${_this.purchasePrice}, price: ${_this.price}, salePrice: ${_this.salePrice}, category: ${_this.category}, model: ${_this.model}, registrationNumber: ${_this.registrationNumber}, pollutionExpiry: ${_this.pollutionExpiry}, insuranceExpiry: ${_this.insuranceExpiry}, fitnessExpiry: ${_this.fitnessExpiry}, barcode: ${_this.barcode}, variants: ${_this.variants}, image: ${_this.image})';
}


}

/// @nodoc
abstract mixin class $ProductRequestModelCopyWith<$Res>  {
  factory $ProductRequestModelCopyWith(ProductRequestModel value, $Res Function(ProductRequestModel) _then) = _$ProductRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) int? productId,@JsonKey(name: 'shop_service_id', includeIfNull: false) int? serviceId,@JsonKey(includeIfNull: false) String? name,@JsonKey(includeIfNull: false) String? description,@JsonKey(includeIfNull: false) String? color,@JsonKey(name: 'purchase_price', includeIfNull: false) int? purchasePrice,@JsonKey(includeIfNull: false) int? price,@JsonKey(name: 'sale_price', includeIfNull: false) int? salePrice,@JsonKey(includeIfNull: false) String? category,@JsonKey(includeIfNull: false) String? model,@JsonKey(includeFromJson: false, includeToJson: false) String? registrationNumber,@JsonKey(includeFromJson: false, includeToJson: false) String? pollutionExpiry,@JsonKey(includeFromJson: false, includeToJson: false) String? insuranceExpiry,@JsonKey(includeFromJson: false, includeToJson: false) String? fitnessExpiry,@JsonKey(includeFromJson: false, includeToJson: false) String? barcode,@JsonKey(toJson: _variantsToJson, includeIfNull: false) List<ProductVariantModel>? variants,@JsonKey(includeFromJson: false, includeToJson: false) XFile? image
});




}
/// @nodoc
class _$ProductRequestModelCopyWithImpl<$Res>
    implements $ProductRequestModelCopyWith<$Res> {
  _$ProductRequestModelCopyWithImpl(this._self, this._then);

  final ProductRequestModel _self;
  final $Res Function(ProductRequestModel) _then;

/// Create a copy of ProductRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = freezed,Object? serviceId = freezed,Object? name = freezed,Object? description = freezed,Object? color = freezed,Object? purchasePrice = freezed,Object? price = freezed,Object? salePrice = freezed,Object? category = freezed,Object? model = freezed,Object? registrationNumber = freezed,Object? pollutionExpiry = freezed,Object? insuranceExpiry = freezed,Object? fitnessExpiry = freezed,Object? barcode = freezed,Object? variants = freezed,Object? image = freezed,}) {
  return _then(ProductRequestModel(
productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,salePrice: freezed == salePrice ? _self.salePrice : salePrice // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,pollutionExpiry: freezed == pollutionExpiry ? _self.pollutionExpiry : pollutionExpiry // ignore: cast_nullable_to_non_nullable
as String?,insuranceExpiry: freezed == insuranceExpiry ? _self.insuranceExpiry : insuranceExpiry // ignore: cast_nullable_to_non_nullable
as String?,fitnessExpiry: freezed == fitnessExpiry ? _self.fitnessExpiry : fitnessExpiry // ignore: cast_nullable_to_non_nullable
as String?,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,variants: freezed == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<ProductVariantModel>?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as XFile?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductRequestModel].
extension ProductRequestModelPatterns on ProductRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? productId, @JsonKey(name: 'shop_service_id', includeIfNull: false)  int? serviceId, @JsonKey(includeIfNull: false)  String? name, @JsonKey(includeIfNull: false)  String? description, @JsonKey(includeIfNull: false)  String? color, @JsonKey(name: 'purchase_price', includeIfNull: false)  int? purchasePrice, @JsonKey(includeIfNull: false)  int? price, @JsonKey(name: 'sale_price', includeIfNull: false)  int? salePrice, @JsonKey(includeIfNull: false)  String? category, @JsonKey(includeIfNull: false)  String? model, @JsonKey(includeFromJson: false, includeToJson: false)  String? registrationNumber, @JsonKey(includeFromJson: false, includeToJson: false)  String? pollutionExpiry, @JsonKey(includeFromJson: false, includeToJson: false)  String? insuranceExpiry, @JsonKey(includeFromJson: false, includeToJson: false)  String? fitnessExpiry, @JsonKey(includeFromJson: false, includeToJson: false)  String? barcode, @JsonKey(toJson: _variantsToJson, includeIfNull: false)  List<ProductVariantModel>? variants, @JsonKey(includeFromJson: false, includeToJson: false)  XFile? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductRequestModel() when $default != null:
return $default(_that.productId,_that.serviceId,_that.name,_that.description,_that.color,_that.purchasePrice,_that.price,_that.salePrice,_that.category,_that.model,_that.registrationNumber,_that.pollutionExpiry,_that.insuranceExpiry,_that.fitnessExpiry,_that.barcode,_that.variants,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? productId, @JsonKey(name: 'shop_service_id', includeIfNull: false)  int? serviceId, @JsonKey(includeIfNull: false)  String? name, @JsonKey(includeIfNull: false)  String? description, @JsonKey(includeIfNull: false)  String? color, @JsonKey(name: 'purchase_price', includeIfNull: false)  int? purchasePrice, @JsonKey(includeIfNull: false)  int? price, @JsonKey(name: 'sale_price', includeIfNull: false)  int? salePrice, @JsonKey(includeIfNull: false)  String? category, @JsonKey(includeIfNull: false)  String? model, @JsonKey(includeFromJson: false, includeToJson: false)  String? registrationNumber, @JsonKey(includeFromJson: false, includeToJson: false)  String? pollutionExpiry, @JsonKey(includeFromJson: false, includeToJson: false)  String? insuranceExpiry, @JsonKey(includeFromJson: false, includeToJson: false)  String? fitnessExpiry, @JsonKey(includeFromJson: false, includeToJson: false)  String? barcode, @JsonKey(toJson: _variantsToJson, includeIfNull: false)  List<ProductVariantModel>? variants, @JsonKey(includeFromJson: false, includeToJson: false)  XFile? image)  $default,) {final _that = this;
switch (_that) {
case _ProductRequestModel():
return $default(_that.productId,_that.serviceId,_that.name,_that.description,_that.color,_that.purchasePrice,_that.price,_that.salePrice,_that.category,_that.model,_that.registrationNumber,_that.pollutionExpiry,_that.insuranceExpiry,_that.fitnessExpiry,_that.barcode,_that.variants,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  int? productId, @JsonKey(name: 'shop_service_id', includeIfNull: false)  int? serviceId, @JsonKey(includeIfNull: false)  String? name, @JsonKey(includeIfNull: false)  String? description, @JsonKey(includeIfNull: false)  String? color, @JsonKey(name: 'purchase_price', includeIfNull: false)  int? purchasePrice, @JsonKey(includeIfNull: false)  int? price, @JsonKey(name: 'sale_price', includeIfNull: false)  int? salePrice, @JsonKey(includeIfNull: false)  String? category, @JsonKey(includeIfNull: false)  String? model, @JsonKey(includeFromJson: false, includeToJson: false)  String? registrationNumber, @JsonKey(includeFromJson: false, includeToJson: false)  String? pollutionExpiry, @JsonKey(includeFromJson: false, includeToJson: false)  String? insuranceExpiry, @JsonKey(includeFromJson: false, includeToJson: false)  String? fitnessExpiry, @JsonKey(includeFromJson: false, includeToJson: false)  String? barcode, @JsonKey(toJson: _variantsToJson, includeIfNull: false)  List<ProductVariantModel>? variants, @JsonKey(includeFromJson: false, includeToJson: false)  XFile? image)?  $default,) {final _that = this;
switch (_that) {
case _ProductRequestModel() when $default != null:
return $default(_that.productId,_that.serviceId,_that.name,_that.description,_that.color,_that.purchasePrice,_that.price,_that.salePrice,_that.category,_that.model,_that.registrationNumber,_that.pollutionExpiry,_that.insuranceExpiry,_that.fitnessExpiry,_that.barcode,_that.variants,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductRequestModel implements ProductRequestModel {
  const _ProductRequestModel({@JsonKey(includeIfNull: false) this.productId, @JsonKey(name: 'shop_service_id', includeIfNull: false) this.serviceId, @JsonKey(includeIfNull: false) this.name, @JsonKey(includeIfNull: false) this.description, @JsonKey(includeIfNull: false) this.color, @JsonKey(name: 'purchase_price', includeIfNull: false) this.purchasePrice, @JsonKey(includeIfNull: false) this.price, @JsonKey(name: 'sale_price', includeIfNull: false) this.salePrice, @JsonKey(includeIfNull: false) this.category, @JsonKey(includeIfNull: false) this.model, @JsonKey(includeFromJson: false, includeToJson: false) this.registrationNumber, @JsonKey(includeFromJson: false, includeToJson: false) this.pollutionExpiry, @JsonKey(includeFromJson: false, includeToJson: false) this.insuranceExpiry, @JsonKey(includeFromJson: false, includeToJson: false) this.fitnessExpiry, @JsonKey(includeFromJson: false, includeToJson: false) this.barcode, @JsonKey(toJson: _variantsToJson, includeIfNull: false)  List<ProductVariantModel>? variants, @JsonKey(includeFromJson: false, includeToJson: false) this.image}): _variants = variants;
  factory _ProductRequestModel.fromJson(Map<String, dynamic> json) => _$ProductRequestModelFromJson(json);

@override@JsonKey(includeIfNull: false) final  int? productId;
@override@JsonKey(name: 'shop_service_id', includeIfNull: false) final  int? serviceId;
@override@JsonKey(includeIfNull: false) final  String? name;
@override@JsonKey(includeIfNull: false) final  String? description;
@override@JsonKey(includeIfNull: false) final  String? color;
@override@JsonKey(name: 'purchase_price', includeIfNull: false) final  int? purchasePrice;
@override@JsonKey(includeIfNull: false) final  int? price;
@override@JsonKey(name: 'sale_price', includeIfNull: false) final  int? salePrice;
@override@JsonKey(includeIfNull: false) final  String? category;
@override@JsonKey(includeIfNull: false) final  String? model;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? registrationNumber;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? pollutionExpiry;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? insuranceExpiry;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? fitnessExpiry;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? barcode;
 final  List<ProductVariantModel>? _variants;
@override@JsonKey(toJson: _variantsToJson, includeIfNull: false) List<ProductVariantModel>? get variants {
  final value = _variants;
  if (value == null) return null;
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeFromJson: false, includeToJson: false) final  XFile? image;

/// Create a copy of ProductRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductRequestModelCopyWith<_ProductRequestModel> get copyWith => __$ProductRequestModelCopyWithImpl<_ProductRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductRequestModel&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.color, color) || other.color == color)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.price, price) || other.price == price)&&(identical(other.salePrice, salePrice) || other.salePrice == salePrice)&&(identical(other.category, category) || other.category == category)&&(identical(other.model, model) || other.model == model)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.pollutionExpiry, pollutionExpiry) || other.pollutionExpiry == pollutionExpiry)&&(identical(other.insuranceExpiry, insuranceExpiry) || other.insuranceExpiry == insuranceExpiry)&&(identical(other.fitnessExpiry, fitnessExpiry) || other.fitnessExpiry == fitnessExpiry)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&const DeepCollectionEquality().equals(other.variants, _variants)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,productId,serviceId,name,description,color,purchasePrice,price,salePrice,category,model,registrationNumber,pollutionExpiry,insuranceExpiry,fitnessExpiry,barcode,const DeepCollectionEquality().hash(_variants),image);
}

@override
String toString() {
    return 'ProductRequestModel(productId: $productId, serviceId: $serviceId, name: $name, description: $description, color: $color, purchasePrice: $purchasePrice, price: $price, salePrice: $salePrice, category: $category, model: $model, registrationNumber: $registrationNumber, pollutionExpiry: $pollutionExpiry, insuranceExpiry: $insuranceExpiry, fitnessExpiry: $fitnessExpiry, barcode: $barcode, variants: $variants, image: $image)';
}


}

/// @nodoc
abstract mixin class _$ProductRequestModelCopyWith<$Res> implements $ProductRequestModelCopyWith<$Res> {
  factory _$ProductRequestModelCopyWith(_ProductRequestModel value, $Res Function(_ProductRequestModel) _then) = __$ProductRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) int? productId,@JsonKey(name: 'shop_service_id', includeIfNull: false) int? serviceId,@JsonKey(includeIfNull: false) String? name,@JsonKey(includeIfNull: false) String? description,@JsonKey(includeIfNull: false) String? color,@JsonKey(name: 'purchase_price', includeIfNull: false) int? purchasePrice,@JsonKey(includeIfNull: false) int? price,@JsonKey(name: 'sale_price', includeIfNull: false) int? salePrice,@JsonKey(includeIfNull: false) String? category,@JsonKey(includeIfNull: false) String? model,@JsonKey(includeFromJson: false, includeToJson: false) String? registrationNumber,@JsonKey(includeFromJson: false, includeToJson: false) String? pollutionExpiry,@JsonKey(includeFromJson: false, includeToJson: false) String? insuranceExpiry,@JsonKey(includeFromJson: false, includeToJson: false) String? fitnessExpiry,@JsonKey(includeFromJson: false, includeToJson: false) String? barcode,@JsonKey(toJson: _variantsToJson, includeIfNull: false) List<ProductVariantModel>? variants,@JsonKey(includeFromJson: false, includeToJson: false) XFile? image
});




}
/// @nodoc
class __$ProductRequestModelCopyWithImpl<$Res>
    implements _$ProductRequestModelCopyWith<$Res> {
  __$ProductRequestModelCopyWithImpl(this._self, this._then);

  final _ProductRequestModel _self;
  final $Res Function(_ProductRequestModel) _then;

/// Create a copy of ProductRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = freezed,Object? serviceId = freezed,Object? name = freezed,Object? description = freezed,Object? color = freezed,Object? purchasePrice = freezed,Object? price = freezed,Object? salePrice = freezed,Object? category = freezed,Object? model = freezed,Object? registrationNumber = freezed,Object? pollutionExpiry = freezed,Object? insuranceExpiry = freezed,Object? fitnessExpiry = freezed,Object? barcode = freezed,Object? variants = freezed,Object? image = freezed,}) {
  return _then(_ProductRequestModel(
productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,purchasePrice: freezed == purchasePrice ? _self.purchasePrice : purchasePrice // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,salePrice: freezed == salePrice ? _self.salePrice : salePrice // ignore: cast_nullable_to_non_nullable
as int?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,pollutionExpiry: freezed == pollutionExpiry ? _self.pollutionExpiry : pollutionExpiry // ignore: cast_nullable_to_non_nullable
as String?,insuranceExpiry: freezed == insuranceExpiry ? _self.insuranceExpiry : insuranceExpiry // ignore: cast_nullable_to_non_nullable
as String?,fitnessExpiry: freezed == fitnessExpiry ? _self.fitnessExpiry : fitnessExpiry // ignore: cast_nullable_to_non_nullable
as String?,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,variants: freezed == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<ProductVariantModel>?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as XFile?,
  ));
}


}

// dart format on
