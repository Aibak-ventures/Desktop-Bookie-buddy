// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductRequestEntity {

 int? get productId; int? get serviceId; String? get name; String? get description; String? get color; int? get purchasePrice; int? get price; int? get salePrice; String? get category; String? get model; String? get registrationNumber; String? get pollutionExpiry; String? get insuranceExpiry; String? get fitnessExpiry; String? get barcode; List<ProductVariantEntity>? get variants; XFile? get image;
/// Create a copy of ProductRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductRequestEntityCopyWith<ProductRequestEntity> get copyWith => _$ProductRequestEntityCopyWithImpl<ProductRequestEntity>(this as ProductRequestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductRequestEntity&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.color, color) || other.color == color)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.price, price) || other.price == price)&&(identical(other.salePrice, salePrice) || other.salePrice == salePrice)&&(identical(other.category, category) || other.category == category)&&(identical(other.model, model) || other.model == model)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.pollutionExpiry, pollutionExpiry) || other.pollutionExpiry == pollutionExpiry)&&(identical(other.insuranceExpiry, insuranceExpiry) || other.insuranceExpiry == insuranceExpiry)&&(identical(other.fitnessExpiry, fitnessExpiry) || other.fitnessExpiry == fitnessExpiry)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&const DeepCollectionEquality().equals(other.variants, variants)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,productId,serviceId,name,description,color,purchasePrice,price,salePrice,category,model,registrationNumber,pollutionExpiry,insuranceExpiry,fitnessExpiry,barcode,const DeepCollectionEquality().hash(variants),image);

@override
String toString() {
  return 'ProductRequestEntity(productId: $productId, serviceId: $serviceId, name: $name, description: $description, color: $color, purchasePrice: $purchasePrice, price: $price, salePrice: $salePrice, category: $category, model: $model, registrationNumber: $registrationNumber, pollutionExpiry: $pollutionExpiry, insuranceExpiry: $insuranceExpiry, fitnessExpiry: $fitnessExpiry, barcode: $barcode, variants: $variants, image: $image)';
}


}

/// @nodoc
abstract mixin class $ProductRequestEntityCopyWith<$Res>  {
  factory $ProductRequestEntityCopyWith(ProductRequestEntity value, $Res Function(ProductRequestEntity) _then) = _$ProductRequestEntityCopyWithImpl;
@useResult
$Res call({
 int? productId, int? serviceId, String? name, String? description, String? color, int? purchasePrice, int? price, int? salePrice, String? category, String? model, String? registrationNumber, String? pollutionExpiry, String? insuranceExpiry, String? fitnessExpiry, String? barcode, List<ProductVariantEntity>? variants, XFile? image
});




}
/// @nodoc
class _$ProductRequestEntityCopyWithImpl<$Res>
    implements $ProductRequestEntityCopyWith<$Res> {
  _$ProductRequestEntityCopyWithImpl(this._self, this._then);

  final ProductRequestEntity _self;
  final $Res Function(ProductRequestEntity) _then;

/// Create a copy of ProductRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = freezed,Object? serviceId = freezed,Object? name = freezed,Object? description = freezed,Object? color = freezed,Object? purchasePrice = freezed,Object? price = freezed,Object? salePrice = freezed,Object? category = freezed,Object? model = freezed,Object? registrationNumber = freezed,Object? pollutionExpiry = freezed,Object? insuranceExpiry = freezed,Object? fitnessExpiry = freezed,Object? barcode = freezed,Object? variants = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
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
as List<ProductVariantEntity>?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as XFile?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductRequestEntity].
extension ProductRequestEntityPatterns on ProductRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProductRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProductRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? productId,  int? serviceId,  String? name,  String? description,  String? color,  int? purchasePrice,  int? price,  int? salePrice,  String? category,  String? model,  String? registrationNumber,  String? pollutionExpiry,  String? insuranceExpiry,  String? fitnessExpiry,  String? barcode,  List<ProductVariantEntity>? variants,  XFile? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductRequestEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? productId,  int? serviceId,  String? name,  String? description,  String? color,  int? purchasePrice,  int? price,  int? salePrice,  String? category,  String? model,  String? registrationNumber,  String? pollutionExpiry,  String? insuranceExpiry,  String? fitnessExpiry,  String? barcode,  List<ProductVariantEntity>? variants,  XFile? image)  $default,) {final _that = this;
switch (_that) {
case _ProductRequestEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? productId,  int? serviceId,  String? name,  String? description,  String? color,  int? purchasePrice,  int? price,  int? salePrice,  String? category,  String? model,  String? registrationNumber,  String? pollutionExpiry,  String? insuranceExpiry,  String? fitnessExpiry,  String? barcode,  List<ProductVariantEntity>? variants,  XFile? image)?  $default,) {final _that = this;
switch (_that) {
case _ProductRequestEntity() when $default != null:
return $default(_that.productId,_that.serviceId,_that.name,_that.description,_that.color,_that.purchasePrice,_that.price,_that.salePrice,_that.category,_that.model,_that.registrationNumber,_that.pollutionExpiry,_that.insuranceExpiry,_that.fitnessExpiry,_that.barcode,_that.variants,_that.image);case _:
  return null;

}
}

}

/// @nodoc


class _ProductRequestEntity implements ProductRequestEntity {
  const _ProductRequestEntity({this.productId, this.serviceId, this.name, this.description, this.color, this.purchasePrice, this.price, this.salePrice, this.category, this.model, this.registrationNumber, this.pollutionExpiry, this.insuranceExpiry, this.fitnessExpiry, this.barcode, final  List<ProductVariantEntity>? variants, this.image}): _variants = variants;
  

@override final  int? productId;
@override final  int? serviceId;
@override final  String? name;
@override final  String? description;
@override final  String? color;
@override final  int? purchasePrice;
@override final  int? price;
@override final  int? salePrice;
@override final  String? category;
@override final  String? model;
@override final  String? registrationNumber;
@override final  String? pollutionExpiry;
@override final  String? insuranceExpiry;
@override final  String? fitnessExpiry;
@override final  String? barcode;
 final  List<ProductVariantEntity>? _variants;
@override List<ProductVariantEntity>? get variants {
  final value = _variants;
  if (value == null) return null;
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  XFile? image;

/// Create a copy of ProductRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductRequestEntityCopyWith<_ProductRequestEntity> get copyWith => __$ProductRequestEntityCopyWithImpl<_ProductRequestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductRequestEntity&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.color, color) || other.color == color)&&(identical(other.purchasePrice, purchasePrice) || other.purchasePrice == purchasePrice)&&(identical(other.price, price) || other.price == price)&&(identical(other.salePrice, salePrice) || other.salePrice == salePrice)&&(identical(other.category, category) || other.category == category)&&(identical(other.model, model) || other.model == model)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.pollutionExpiry, pollutionExpiry) || other.pollutionExpiry == pollutionExpiry)&&(identical(other.insuranceExpiry, insuranceExpiry) || other.insuranceExpiry == insuranceExpiry)&&(identical(other.fitnessExpiry, fitnessExpiry) || other.fitnessExpiry == fitnessExpiry)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&const DeepCollectionEquality().equals(other._variants, _variants)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,productId,serviceId,name,description,color,purchasePrice,price,salePrice,category,model,registrationNumber,pollutionExpiry,insuranceExpiry,fitnessExpiry,barcode,const DeepCollectionEquality().hash(_variants),image);

@override
String toString() {
  return 'ProductRequestEntity(productId: $productId, serviceId: $serviceId, name: $name, description: $description, color: $color, purchasePrice: $purchasePrice, price: $price, salePrice: $salePrice, category: $category, model: $model, registrationNumber: $registrationNumber, pollutionExpiry: $pollutionExpiry, insuranceExpiry: $insuranceExpiry, fitnessExpiry: $fitnessExpiry, barcode: $barcode, variants: $variants, image: $image)';
}


}

/// @nodoc
abstract mixin class _$ProductRequestEntityCopyWith<$Res> implements $ProductRequestEntityCopyWith<$Res> {
  factory _$ProductRequestEntityCopyWith(_ProductRequestEntity value, $Res Function(_ProductRequestEntity) _then) = __$ProductRequestEntityCopyWithImpl;
@override @useResult
$Res call({
 int? productId, int? serviceId, String? name, String? description, String? color, int? purchasePrice, int? price, int? salePrice, String? category, String? model, String? registrationNumber, String? pollutionExpiry, String? insuranceExpiry, String? fitnessExpiry, String? barcode, List<ProductVariantEntity>? variants, XFile? image
});




}
/// @nodoc
class __$ProductRequestEntityCopyWithImpl<$Res>
    implements _$ProductRequestEntityCopyWith<$Res> {
  __$ProductRequestEntityCopyWithImpl(this._self, this._then);

  final _ProductRequestEntity _self;
  final $Res Function(_ProductRequestEntity) _then;

/// Create a copy of ProductRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = freezed,Object? serviceId = freezed,Object? name = freezed,Object? description = freezed,Object? color = freezed,Object? purchasePrice = freezed,Object? price = freezed,Object? salePrice = freezed,Object? category = freezed,Object? model = freezed,Object? registrationNumber = freezed,Object? pollutionExpiry = freezed,Object? insuranceExpiry = freezed,Object? fitnessExpiry = freezed,Object? barcode = freezed,Object? variants = freezed,Object? image = freezed,}) {
  return _then(_ProductRequestEntity(
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
as List<ProductVariantEntity>?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as XFile?,
  ));
}


}

// dart format on
