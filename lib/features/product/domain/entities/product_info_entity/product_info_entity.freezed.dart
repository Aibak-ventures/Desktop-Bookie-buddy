// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_info_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductInfoEntity {

 int get id; int? get productId; int? get variantId; String get name; String? get image; MainServiceType? get mainServiceType; String? get variantAttribute; String? get color; String? get category; String? get model; int get quantity; int get amount; List<MeasurementValueEntity> get measurements; int? get stock; int? get remainingStock;
/// Create a copy of ProductInfoEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductInfoEntityCopyWith<ProductInfoEntity> get copyWith => _$ProductInfoEntityCopyWithImpl<ProductInfoEntity>(this as ProductInfoEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductInfoEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.mainServiceType, mainServiceType) || other.mainServiceType == mainServiceType)&&(identical(other.variantAttribute, variantAttribute) || other.variantAttribute == variantAttribute)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.model, model) || other.model == model)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other.measurements, measurements)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.remainingStock, remainingStock) || other.remainingStock == remainingStock));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,variantId,name,image,mainServiceType,variantAttribute,color,category,model,quantity,amount,const DeepCollectionEquality().hash(measurements),stock,remainingStock);

@override
String toString() {
  return 'ProductInfoEntity(id: $id, productId: $productId, variantId: $variantId, name: $name, image: $image, mainServiceType: $mainServiceType, variantAttribute: $variantAttribute, color: $color, category: $category, model: $model, quantity: $quantity, amount: $amount, measurements: $measurements, stock: $stock, remainingStock: $remainingStock)';
}


}

/// @nodoc
abstract mixin class $ProductInfoEntityCopyWith<$Res>  {
  factory $ProductInfoEntityCopyWith(ProductInfoEntity value, $Res Function(ProductInfoEntity) _then) = _$ProductInfoEntityCopyWithImpl;
@useResult
$Res call({
 int id, int? productId, int? variantId, String name, String? image, MainServiceType? mainServiceType, String? variantAttribute, String? color, String? category, String? model, int quantity, int amount, List<MeasurementValueEntity> measurements, int? stock, int? remainingStock
});




}
/// @nodoc
class _$ProductInfoEntityCopyWithImpl<$Res>
    implements $ProductInfoEntityCopyWith<$Res> {
  _$ProductInfoEntityCopyWithImpl(this._self, this._then);

  final ProductInfoEntity _self;
  final $Res Function(ProductInfoEntity) _then;

/// Create a copy of ProductInfoEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = freezed,Object? variantId = freezed,Object? name = null,Object? image = freezed,Object? mainServiceType = freezed,Object? variantAttribute = freezed,Object? color = freezed,Object? category = freezed,Object? model = freezed,Object? quantity = null,Object? amount = null,Object? measurements = null,Object? stock = freezed,Object? remainingStock = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,variantId: freezed == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,mainServiceType: freezed == mainServiceType ? _self.mainServiceType : mainServiceType // ignore: cast_nullable_to_non_nullable
as MainServiceType?,variantAttribute: freezed == variantAttribute ? _self.variantAttribute : variantAttribute // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,measurements: null == measurements ? _self.measurements : measurements // ignore: cast_nullable_to_non_nullable
as List<MeasurementValueEntity>,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,remainingStock: freezed == remainingStock ? _self.remainingStock : remainingStock // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductInfoEntity].
extension ProductInfoEntityPatterns on ProductInfoEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductInfoEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductInfoEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductInfoEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProductInfoEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductInfoEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProductInfoEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? productId,  int? variantId,  String name,  String? image,  MainServiceType? mainServiceType,  String? variantAttribute,  String? color,  String? category,  String? model,  int quantity,  int amount,  List<MeasurementValueEntity> measurements,  int? stock,  int? remainingStock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductInfoEntity() when $default != null:
return $default(_that.id,_that.productId,_that.variantId,_that.name,_that.image,_that.mainServiceType,_that.variantAttribute,_that.color,_that.category,_that.model,_that.quantity,_that.amount,_that.measurements,_that.stock,_that.remainingStock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? productId,  int? variantId,  String name,  String? image,  MainServiceType? mainServiceType,  String? variantAttribute,  String? color,  String? category,  String? model,  int quantity,  int amount,  List<MeasurementValueEntity> measurements,  int? stock,  int? remainingStock)  $default,) {final _that = this;
switch (_that) {
case _ProductInfoEntity():
return $default(_that.id,_that.productId,_that.variantId,_that.name,_that.image,_that.mainServiceType,_that.variantAttribute,_that.color,_that.category,_that.model,_that.quantity,_that.amount,_that.measurements,_that.stock,_that.remainingStock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? productId,  int? variantId,  String name,  String? image,  MainServiceType? mainServiceType,  String? variantAttribute,  String? color,  String? category,  String? model,  int quantity,  int amount,  List<MeasurementValueEntity> measurements,  int? stock,  int? remainingStock)?  $default,) {final _that = this;
switch (_that) {
case _ProductInfoEntity() when $default != null:
return $default(_that.id,_that.productId,_that.variantId,_that.name,_that.image,_that.mainServiceType,_that.variantAttribute,_that.color,_that.category,_that.model,_that.quantity,_that.amount,_that.measurements,_that.stock,_that.remainingStock);case _:
  return null;

}
}

}

/// @nodoc


class _ProductInfoEntity implements ProductInfoEntity {
  const _ProductInfoEntity({required this.id, required this.productId, required this.variantId, required this.name, required this.image, this.mainServiceType, this.variantAttribute, this.color, this.category, this.model, required this.quantity, required this.amount, final  List<MeasurementValueEntity> measurements = const [], this.stock, this.remainingStock}): _measurements = measurements;
  

@override final  int id;
@override final  int? productId;
@override final  int? variantId;
@override final  String name;
@override final  String? image;
@override final  MainServiceType? mainServiceType;
@override final  String? variantAttribute;
@override final  String? color;
@override final  String? category;
@override final  String? model;
@override final  int quantity;
@override final  int amount;
 final  List<MeasurementValueEntity> _measurements;
@override@JsonKey() List<MeasurementValueEntity> get measurements {
  if (_measurements is EqualUnmodifiableListView) return _measurements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_measurements);
}

@override final  int? stock;
@override final  int? remainingStock;

/// Create a copy of ProductInfoEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductInfoEntityCopyWith<_ProductInfoEntity> get copyWith => __$ProductInfoEntityCopyWithImpl<_ProductInfoEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductInfoEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.mainServiceType, mainServiceType) || other.mainServiceType == mainServiceType)&&(identical(other.variantAttribute, variantAttribute) || other.variantAttribute == variantAttribute)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.model, model) || other.model == model)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other._measurements, _measurements)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.remainingStock, remainingStock) || other.remainingStock == remainingStock));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,variantId,name,image,mainServiceType,variantAttribute,color,category,model,quantity,amount,const DeepCollectionEquality().hash(_measurements),stock,remainingStock);

@override
String toString() {
  return 'ProductInfoEntity(id: $id, productId: $productId, variantId: $variantId, name: $name, image: $image, mainServiceType: $mainServiceType, variantAttribute: $variantAttribute, color: $color, category: $category, model: $model, quantity: $quantity, amount: $amount, measurements: $measurements, stock: $stock, remainingStock: $remainingStock)';
}


}

/// @nodoc
abstract mixin class _$ProductInfoEntityCopyWith<$Res> implements $ProductInfoEntityCopyWith<$Res> {
  factory _$ProductInfoEntityCopyWith(_ProductInfoEntity value, $Res Function(_ProductInfoEntity) _then) = __$ProductInfoEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int? productId, int? variantId, String name, String? image, MainServiceType? mainServiceType, String? variantAttribute, String? color, String? category, String? model, int quantity, int amount, List<MeasurementValueEntity> measurements, int? stock, int? remainingStock
});




}
/// @nodoc
class __$ProductInfoEntityCopyWithImpl<$Res>
    implements _$ProductInfoEntityCopyWith<$Res> {
  __$ProductInfoEntityCopyWithImpl(this._self, this._then);

  final _ProductInfoEntity _self;
  final $Res Function(_ProductInfoEntity) _then;

/// Create a copy of ProductInfoEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = freezed,Object? variantId = freezed,Object? name = null,Object? image = freezed,Object? mainServiceType = freezed,Object? variantAttribute = freezed,Object? color = freezed,Object? category = freezed,Object? model = freezed,Object? quantity = null,Object? amount = null,Object? measurements = null,Object? stock = freezed,Object? remainingStock = freezed,}) {
  return _then(_ProductInfoEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,variantId: freezed == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,mainServiceType: freezed == mainServiceType ? _self.mainServiceType : mainServiceType // ignore: cast_nullable_to_non_nullable
as MainServiceType?,variantAttribute: freezed == variantAttribute ? _self.variantAttribute : variantAttribute // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,measurements: null == measurements ? _self._measurements : measurements // ignore: cast_nullable_to_non_nullable
as List<MeasurementValueEntity>,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,remainingStock: freezed == remainingStock ? _self.remainingStock : remainingStock // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
