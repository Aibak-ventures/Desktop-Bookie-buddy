// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_variant_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductVariantEntity {

 int get id; String get attribute; int get stock; int? get remainingStock; int? get price; int? get salePrice; String? get externalQrCode;
/// Create a copy of ProductVariantEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductVariantEntityCopyWith<ProductVariantEntity> get copyWith => _$ProductVariantEntityCopyWithImpl<ProductVariantEntity>(this as ProductVariantEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductVariantEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.remainingStock, remainingStock) || other.remainingStock == remainingStock)&&(identical(other.price, price) || other.price == price)&&(identical(other.salePrice, salePrice) || other.salePrice == salePrice)&&(identical(other.externalQrCode, externalQrCode) || other.externalQrCode == externalQrCode));
}


@override
int get hashCode => Object.hash(runtimeType,id,attribute,stock,remainingStock,price,salePrice,externalQrCode);

@override
String toString() {
  return 'ProductVariantEntity(id: $id, attribute: $attribute, stock: $stock, remainingStock: $remainingStock, price: $price, salePrice: $salePrice, externalQrCode: $externalQrCode)';
}


}

/// @nodoc
abstract mixin class $ProductVariantEntityCopyWith<$Res>  {
  factory $ProductVariantEntityCopyWith(ProductVariantEntity value, $Res Function(ProductVariantEntity) _then) = _$ProductVariantEntityCopyWithImpl;
@useResult
$Res call({
 int id, String attribute, int stock, int? remainingStock, int? price, int? salePrice, String? externalQrCode
});




}
/// @nodoc
class _$ProductVariantEntityCopyWithImpl<$Res>
    implements $ProductVariantEntityCopyWith<$Res> {
  _$ProductVariantEntityCopyWithImpl(this._self, this._then);

  final ProductVariantEntity _self;
  final $Res Function(ProductVariantEntity) _then;

/// Create a copy of ProductVariantEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? attribute = null,Object? stock = null,Object? remainingStock = freezed,Object? price = freezed,Object? salePrice = freezed,Object? externalQrCode = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,attribute: null == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as String,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,remainingStock: freezed == remainingStock ? _self.remainingStock : remainingStock // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,salePrice: freezed == salePrice ? _self.salePrice : salePrice // ignore: cast_nullable_to_non_nullable
as int?,externalQrCode: freezed == externalQrCode ? _self.externalQrCode : externalQrCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductVariantEntity].
extension ProductVariantEntityPatterns on ProductVariantEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductVariantEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductVariantEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductVariantEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProductVariantEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductVariantEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProductVariantEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String attribute,  int stock,  int? remainingStock,  int? price,  int? salePrice,  String? externalQrCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductVariantEntity() when $default != null:
return $default(_that.id,_that.attribute,_that.stock,_that.remainingStock,_that.price,_that.salePrice,_that.externalQrCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String attribute,  int stock,  int? remainingStock,  int? price,  int? salePrice,  String? externalQrCode)  $default,) {final _that = this;
switch (_that) {
case _ProductVariantEntity():
return $default(_that.id,_that.attribute,_that.stock,_that.remainingStock,_that.price,_that.salePrice,_that.externalQrCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String attribute,  int stock,  int? remainingStock,  int? price,  int? salePrice,  String? externalQrCode)?  $default,) {final _that = this;
switch (_that) {
case _ProductVariantEntity() when $default != null:
return $default(_that.id,_that.attribute,_that.stock,_that.remainingStock,_that.price,_that.salePrice,_that.externalQrCode);case _:
  return null;

}
}

}

/// @nodoc


class _ProductVariantEntity implements ProductVariantEntity {
  const _ProductVariantEntity({required this.id, required this.attribute, required this.stock, this.remainingStock, this.price, this.salePrice, this.externalQrCode});
  

@override final  int id;
@override final  String attribute;
@override final  int stock;
@override final  int? remainingStock;
@override final  int? price;
@override final  int? salePrice;
@override final  String? externalQrCode;

/// Create a copy of ProductVariantEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductVariantEntityCopyWith<_ProductVariantEntity> get copyWith => __$ProductVariantEntityCopyWithImpl<_ProductVariantEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductVariantEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.remainingStock, remainingStock) || other.remainingStock == remainingStock)&&(identical(other.price, price) || other.price == price)&&(identical(other.salePrice, salePrice) || other.salePrice == salePrice)&&(identical(other.externalQrCode, externalQrCode) || other.externalQrCode == externalQrCode));
}


@override
int get hashCode => Object.hash(runtimeType,id,attribute,stock,remainingStock,price,salePrice,externalQrCode);

@override
String toString() {
  return 'ProductVariantEntity(id: $id, attribute: $attribute, stock: $stock, remainingStock: $remainingStock, price: $price, salePrice: $salePrice, externalQrCode: $externalQrCode)';
}


}

/// @nodoc
abstract mixin class _$ProductVariantEntityCopyWith<$Res> implements $ProductVariantEntityCopyWith<$Res> {
  factory _$ProductVariantEntityCopyWith(_ProductVariantEntity value, $Res Function(_ProductVariantEntity) _then) = __$ProductVariantEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String attribute, int stock, int? remainingStock, int? price, int? salePrice, String? externalQrCode
});




}
/// @nodoc
class __$ProductVariantEntityCopyWithImpl<$Res>
    implements _$ProductVariantEntityCopyWith<$Res> {
  __$ProductVariantEntityCopyWithImpl(this._self, this._then);

  final _ProductVariantEntity _self;
  final $Res Function(_ProductVariantEntity) _then;

/// Create a copy of ProductVariantEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? attribute = null,Object? stock = null,Object? remainingStock = freezed,Object? price = freezed,Object? salePrice = freezed,Object? externalQrCode = freezed,}) {
  return _then(_ProductVariantEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,attribute: null == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as String,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,remainingStock: freezed == remainingStock ? _self.remainingStock : remainingStock // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,salePrice: freezed == salePrice ? _self.salePrice : salePrice // ignore: cast_nullable_to_non_nullable
as int?,externalQrCode: freezed == externalQrCode ? _self.externalQrCode : externalQrCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
