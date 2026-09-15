// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductInfoModel {

@JsonKey(name: 'id', readValue: _idCustomRead) int get id;@JsonKey(name: 'product_id') int? get productId;@JsonKey(name: 'variant_id') int? get variantId;@JsonKey(name: 'product_name') String get name;@JsonKey(readValue: _readProductImage) String? get image;@JsonKey(readValue: _readProductThumbnail) String? get thumbnailImage;@JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString, toJson: MainServiceType.toJson) MainServiceType? get mainServiceType;@JsonKey(name: 'variant_attribute') String? get variantAttribute; String? get color; String? get category; String? get model; int get quantity;@JsonKey(defaultValue: 0) int get amount;@JsonKey(name: 'fabric_length', defaultValue: 0.0) double get fabricLength;@JsonKey(name: 'attributes') ProductAttributesModel get attributes;@JsonKey(name: 'measurements', fromJson: _parseMeasurements) List<MeasurementValueModel> get measurements; int? get stock;@JsonKey(name: 'remaining_stock') int? get remainingStock;@JsonKey(name: 'return_status', fromJson: ProductDeliveryStatus.fromJson, toJson: ProductDeliveryStatus.toJson, defaultValue: ProductDeliveryStatus.notReturned) ProductDeliveryStatus get deliveryStatus;@JsonKey(name: 'returned_at') String? get returnedAt;
/// Create a copy of ProductInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductInfoModelCopyWith<ProductInfoModel> get copyWith => _$ProductInfoModelCopyWithImpl<ProductInfoModel>(this as ProductInfoModel, _$identity);

  /// Serializes this ProductInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.thumbnailImage, thumbnailImage) || other.thumbnailImage == thumbnailImage)&&(identical(other.mainServiceType, mainServiceType) || other.mainServiceType == mainServiceType)&&(identical(other.variantAttribute, variantAttribute) || other.variantAttribute == variantAttribute)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.model, model) || other.model == model)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fabricLength, fabricLength) || other.fabricLength == fabricLength)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&const DeepCollectionEquality().equals(other.measurements, measurements)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.remainingStock, remainingStock) || other.remainingStock == remainingStock)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.returnedAt, returnedAt) || other.returnedAt == returnedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,productId,variantId,name,image,thumbnailImage,mainServiceType,variantAttribute,color,category,model,quantity,amount,fabricLength,attributes,const DeepCollectionEquality().hash(measurements),stock,remainingStock,deliveryStatus,returnedAt]);

@override
String toString() {
  return 'ProductInfoModel(id: $id, productId: $productId, variantId: $variantId, name: $name, image: $image, thumbnailImage: $thumbnailImage, mainServiceType: $mainServiceType, variantAttribute: $variantAttribute, color: $color, category: $category, model: $model, quantity: $quantity, amount: $amount, fabricLength: $fabricLength, attributes: $attributes, measurements: $measurements, stock: $stock, remainingStock: $remainingStock, deliveryStatus: $deliveryStatus, returnedAt: $returnedAt)';
}


}

/// @nodoc
abstract mixin class $ProductInfoModelCopyWith<$Res>  {
  factory $ProductInfoModelCopyWith(ProductInfoModel value, $Res Function(ProductInfoModel) _then) = _$ProductInfoModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id', readValue: _idCustomRead) int id,@JsonKey(name: 'product_id') int? productId,@JsonKey(name: 'variant_id') int? variantId,@JsonKey(name: 'product_name') String name,@JsonKey(readValue: _readProductImage) String? image,@JsonKey(readValue: _readProductThumbnail) String? thumbnailImage,@JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString, toJson: MainServiceType.toJson) MainServiceType? mainServiceType,@JsonKey(name: 'variant_attribute') String? variantAttribute, String? color, String? category, String? model, int quantity,@JsonKey(defaultValue: 0) int amount,@JsonKey(name: 'fabric_length', defaultValue: 0.0) double fabricLength,@JsonKey(name: 'attributes') ProductAttributesModel attributes,@JsonKey(name: 'measurements', fromJson: _parseMeasurements) List<MeasurementValueModel> measurements, int? stock,@JsonKey(name: 'remaining_stock') int? remainingStock,@JsonKey(name: 'return_status', fromJson: ProductDeliveryStatus.fromJson, toJson: ProductDeliveryStatus.toJson, defaultValue: ProductDeliveryStatus.notReturned) ProductDeliveryStatus deliveryStatus,@JsonKey(name: 'returned_at') String? returnedAt
});


$ProductAttributesModelCopyWith<$Res> get attributes;

}
/// @nodoc
class _$ProductInfoModelCopyWithImpl<$Res>
    implements $ProductInfoModelCopyWith<$Res> {
  _$ProductInfoModelCopyWithImpl(this._self, this._then);

  final ProductInfoModel _self;
  final $Res Function(ProductInfoModel) _then;

/// Create a copy of ProductInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = freezed,Object? variantId = freezed,Object? name = null,Object? image = freezed,Object? thumbnailImage = freezed,Object? mainServiceType = freezed,Object? variantAttribute = freezed,Object? color = freezed,Object? category = freezed,Object? model = freezed,Object? quantity = null,Object? amount = null,Object? fabricLength = null,Object? attributes = null,Object? measurements = null,Object? stock = freezed,Object? remainingStock = freezed,Object? deliveryStatus = null,Object? returnedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,variantId: freezed == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,thumbnailImage: freezed == thumbnailImage ? _self.thumbnailImage : thumbnailImage // ignore: cast_nullable_to_non_nullable
as String?,mainServiceType: freezed == mainServiceType ? _self.mainServiceType : mainServiceType // ignore: cast_nullable_to_non_nullable
as MainServiceType?,variantAttribute: freezed == variantAttribute ? _self.variantAttribute : variantAttribute // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,fabricLength: null == fabricLength ? _self.fabricLength : fabricLength // ignore: cast_nullable_to_non_nullable
as double,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as ProductAttributesModel,measurements: null == measurements ? _self.measurements : measurements // ignore: cast_nullable_to_non_nullable
as List<MeasurementValueModel>,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,remainingStock: freezed == remainingStock ? _self.remainingStock : remainingStock // ignore: cast_nullable_to_non_nullable
as int?,deliveryStatus: null == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as ProductDeliveryStatus,returnedAt: freezed == returnedAt ? _self.returnedAt : returnedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProductInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductAttributesModelCopyWith<$Res> get attributes {
  
  return $ProductAttributesModelCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductInfoModel].
extension ProductInfoModelPatterns on ProductInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', readValue: _idCustomRead)  int id, @JsonKey(name: 'product_id')  int? productId, @JsonKey(name: 'variant_id')  int? variantId, @JsonKey(name: 'product_name')  String name, @JsonKey(readValue: _readProductImage)  String? image, @JsonKey(readValue: _readProductThumbnail)  String? thumbnailImage, @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString, toJson: MainServiceType.toJson)  MainServiceType? mainServiceType, @JsonKey(name: 'variant_attribute')  String? variantAttribute,  String? color,  String? category,  String? model,  int quantity, @JsonKey(defaultValue: 0)  int amount, @JsonKey(name: 'fabric_length', defaultValue: 0.0)  double fabricLength, @JsonKey(name: 'attributes')  ProductAttributesModel attributes, @JsonKey(name: 'measurements', fromJson: _parseMeasurements)  List<MeasurementValueModel> measurements,  int? stock, @JsonKey(name: 'remaining_stock')  int? remainingStock, @JsonKey(name: 'return_status', fromJson: ProductDeliveryStatus.fromJson, toJson: ProductDeliveryStatus.toJson, defaultValue: ProductDeliveryStatus.notReturned)  ProductDeliveryStatus deliveryStatus, @JsonKey(name: 'returned_at')  String? returnedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductInfoModel() when $default != null:
return $default(_that.id,_that.productId,_that.variantId,_that.name,_that.image,_that.thumbnailImage,_that.mainServiceType,_that.variantAttribute,_that.color,_that.category,_that.model,_that.quantity,_that.amount,_that.fabricLength,_that.attributes,_that.measurements,_that.stock,_that.remainingStock,_that.deliveryStatus,_that.returnedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', readValue: _idCustomRead)  int id, @JsonKey(name: 'product_id')  int? productId, @JsonKey(name: 'variant_id')  int? variantId, @JsonKey(name: 'product_name')  String name, @JsonKey(readValue: _readProductImage)  String? image, @JsonKey(readValue: _readProductThumbnail)  String? thumbnailImage, @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString, toJson: MainServiceType.toJson)  MainServiceType? mainServiceType, @JsonKey(name: 'variant_attribute')  String? variantAttribute,  String? color,  String? category,  String? model,  int quantity, @JsonKey(defaultValue: 0)  int amount, @JsonKey(name: 'fabric_length', defaultValue: 0.0)  double fabricLength, @JsonKey(name: 'attributes')  ProductAttributesModel attributes, @JsonKey(name: 'measurements', fromJson: _parseMeasurements)  List<MeasurementValueModel> measurements,  int? stock, @JsonKey(name: 'remaining_stock')  int? remainingStock, @JsonKey(name: 'return_status', fromJson: ProductDeliveryStatus.fromJson, toJson: ProductDeliveryStatus.toJson, defaultValue: ProductDeliveryStatus.notReturned)  ProductDeliveryStatus deliveryStatus, @JsonKey(name: 'returned_at')  String? returnedAt)  $default,) {final _that = this;
switch (_that) {
case _ProductInfoModel():
return $default(_that.id,_that.productId,_that.variantId,_that.name,_that.image,_that.thumbnailImage,_that.mainServiceType,_that.variantAttribute,_that.color,_that.category,_that.model,_that.quantity,_that.amount,_that.fabricLength,_that.attributes,_that.measurements,_that.stock,_that.remainingStock,_that.deliveryStatus,_that.returnedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id', readValue: _idCustomRead)  int id, @JsonKey(name: 'product_id')  int? productId, @JsonKey(name: 'variant_id')  int? variantId, @JsonKey(name: 'product_name')  String name, @JsonKey(readValue: _readProductImage)  String? image, @JsonKey(readValue: _readProductThumbnail)  String? thumbnailImage, @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString, toJson: MainServiceType.toJson)  MainServiceType? mainServiceType, @JsonKey(name: 'variant_attribute')  String? variantAttribute,  String? color,  String? category,  String? model,  int quantity, @JsonKey(defaultValue: 0)  int amount, @JsonKey(name: 'fabric_length', defaultValue: 0.0)  double fabricLength, @JsonKey(name: 'attributes')  ProductAttributesModel attributes, @JsonKey(name: 'measurements', fromJson: _parseMeasurements)  List<MeasurementValueModel> measurements,  int? stock, @JsonKey(name: 'remaining_stock')  int? remainingStock, @JsonKey(name: 'return_status', fromJson: ProductDeliveryStatus.fromJson, toJson: ProductDeliveryStatus.toJson, defaultValue: ProductDeliveryStatus.notReturned)  ProductDeliveryStatus deliveryStatus, @JsonKey(name: 'returned_at')  String? returnedAt)?  $default,) {final _that = this;
switch (_that) {
case _ProductInfoModel() when $default != null:
return $default(_that.id,_that.productId,_that.variantId,_that.name,_that.image,_that.thumbnailImage,_that.mainServiceType,_that.variantAttribute,_that.color,_that.category,_that.model,_that.quantity,_that.amount,_that.fabricLength,_that.attributes,_that.measurements,_that.stock,_that.remainingStock,_that.deliveryStatus,_that.returnedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductInfoModel implements ProductInfoModel {
  const _ProductInfoModel({@JsonKey(name: 'id', readValue: _idCustomRead) required this.id, @JsonKey(name: 'product_id') required this.productId, @JsonKey(name: 'variant_id') required this.variantId, @JsonKey(name: 'product_name') required this.name, @JsonKey(readValue: _readProductImage) required this.image, @JsonKey(readValue: _readProductThumbnail) this.thumbnailImage, @JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString, toJson: MainServiceType.toJson) this.mainServiceType, @JsonKey(name: 'variant_attribute') this.variantAttribute, this.color, this.category, this.model, required this.quantity, @JsonKey(defaultValue: 0) required this.amount, @JsonKey(name: 'fabric_length', defaultValue: 0.0) this.fabricLength = 0.0, @JsonKey(name: 'attributes') this.attributes = const ProductAttributesModel(), @JsonKey(name: 'measurements', fromJson: _parseMeasurements) final  List<MeasurementValueModel> measurements = const [], this.stock, @JsonKey(name: 'remaining_stock') this.remainingStock, @JsonKey(name: 'return_status', fromJson: ProductDeliveryStatus.fromJson, toJson: ProductDeliveryStatus.toJson, defaultValue: ProductDeliveryStatus.notReturned) this.deliveryStatus = ProductDeliveryStatus.notReturned, @JsonKey(name: 'returned_at') this.returnedAt}): _measurements = measurements;
  factory _ProductInfoModel.fromJson(Map<String, dynamic> json) => _$ProductInfoModelFromJson(json);

@override@JsonKey(name: 'id', readValue: _idCustomRead) final  int id;
@override@JsonKey(name: 'product_id') final  int? productId;
@override@JsonKey(name: 'variant_id') final  int? variantId;
@override@JsonKey(name: 'product_name') final  String name;
@override@JsonKey(readValue: _readProductImage) final  String? image;
@override@JsonKey(readValue: _readProductThumbnail) final  String? thumbnailImage;
@override@JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString, toJson: MainServiceType.toJson) final  MainServiceType? mainServiceType;
@override@JsonKey(name: 'variant_attribute') final  String? variantAttribute;
@override final  String? color;
@override final  String? category;
@override final  String? model;
@override final  int quantity;
@override@JsonKey(defaultValue: 0) final  int amount;
@override@JsonKey(name: 'fabric_length', defaultValue: 0.0) final  double fabricLength;
@override@JsonKey(name: 'attributes') final  ProductAttributesModel attributes;
 final  List<MeasurementValueModel> _measurements;
@override@JsonKey(name: 'measurements', fromJson: _parseMeasurements) List<MeasurementValueModel> get measurements {
  if (_measurements is EqualUnmodifiableListView) return _measurements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_measurements);
}

@override final  int? stock;
@override@JsonKey(name: 'remaining_stock') final  int? remainingStock;
@override@JsonKey(name: 'return_status', fromJson: ProductDeliveryStatus.fromJson, toJson: ProductDeliveryStatus.toJson, defaultValue: ProductDeliveryStatus.notReturned) final  ProductDeliveryStatus deliveryStatus;
@override@JsonKey(name: 'returned_at') final  String? returnedAt;

/// Create a copy of ProductInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductInfoModelCopyWith<_ProductInfoModel> get copyWith => __$ProductInfoModelCopyWithImpl<_ProductInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.thumbnailImage, thumbnailImage) || other.thumbnailImage == thumbnailImage)&&(identical(other.mainServiceType, mainServiceType) || other.mainServiceType == mainServiceType)&&(identical(other.variantAttribute, variantAttribute) || other.variantAttribute == variantAttribute)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.model, model) || other.model == model)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fabricLength, fabricLength) || other.fabricLength == fabricLength)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&const DeepCollectionEquality().equals(other._measurements, _measurements)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.remainingStock, remainingStock) || other.remainingStock == remainingStock)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.returnedAt, returnedAt) || other.returnedAt == returnedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,productId,variantId,name,image,thumbnailImage,mainServiceType,variantAttribute,color,category,model,quantity,amount,fabricLength,attributes,const DeepCollectionEquality().hash(_measurements),stock,remainingStock,deliveryStatus,returnedAt]);

@override
String toString() {
  return 'ProductInfoModel(id: $id, productId: $productId, variantId: $variantId, name: $name, image: $image, thumbnailImage: $thumbnailImage, mainServiceType: $mainServiceType, variantAttribute: $variantAttribute, color: $color, category: $category, model: $model, quantity: $quantity, amount: $amount, fabricLength: $fabricLength, attributes: $attributes, measurements: $measurements, stock: $stock, remainingStock: $remainingStock, deliveryStatus: $deliveryStatus, returnedAt: $returnedAt)';
}


}

/// @nodoc
abstract mixin class _$ProductInfoModelCopyWith<$Res> implements $ProductInfoModelCopyWith<$Res> {
  factory _$ProductInfoModelCopyWith(_ProductInfoModel value, $Res Function(_ProductInfoModel) _then) = __$ProductInfoModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id', readValue: _idCustomRead) int id,@JsonKey(name: 'product_id') int? productId,@JsonKey(name: 'variant_id') int? variantId,@JsonKey(name: 'product_name') String name,@JsonKey(readValue: _readProductImage) String? image,@JsonKey(readValue: _readProductThumbnail) String? thumbnailImage,@JsonKey(name: 'main_service_name', fromJson: MainServiceType.fromString, toJson: MainServiceType.toJson) MainServiceType? mainServiceType,@JsonKey(name: 'variant_attribute') String? variantAttribute, String? color, String? category, String? model, int quantity,@JsonKey(defaultValue: 0) int amount,@JsonKey(name: 'fabric_length', defaultValue: 0.0) double fabricLength,@JsonKey(name: 'attributes') ProductAttributesModel attributes,@JsonKey(name: 'measurements', fromJson: _parseMeasurements) List<MeasurementValueModel> measurements, int? stock,@JsonKey(name: 'remaining_stock') int? remainingStock,@JsonKey(name: 'return_status', fromJson: ProductDeliveryStatus.fromJson, toJson: ProductDeliveryStatus.toJson, defaultValue: ProductDeliveryStatus.notReturned) ProductDeliveryStatus deliveryStatus,@JsonKey(name: 'returned_at') String? returnedAt
});


@override $ProductAttributesModelCopyWith<$Res> get attributes;

}
/// @nodoc
class __$ProductInfoModelCopyWithImpl<$Res>
    implements _$ProductInfoModelCopyWith<$Res> {
  __$ProductInfoModelCopyWithImpl(this._self, this._then);

  final _ProductInfoModel _self;
  final $Res Function(_ProductInfoModel) _then;

/// Create a copy of ProductInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = freezed,Object? variantId = freezed,Object? name = null,Object? image = freezed,Object? thumbnailImage = freezed,Object? mainServiceType = freezed,Object? variantAttribute = freezed,Object? color = freezed,Object? category = freezed,Object? model = freezed,Object? quantity = null,Object? amount = null,Object? fabricLength = null,Object? attributes = null,Object? measurements = null,Object? stock = freezed,Object? remainingStock = freezed,Object? deliveryStatus = null,Object? returnedAt = freezed,}) {
  return _then(_ProductInfoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,variantId: freezed == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,thumbnailImage: freezed == thumbnailImage ? _self.thumbnailImage : thumbnailImage // ignore: cast_nullable_to_non_nullable
as String?,mainServiceType: freezed == mainServiceType ? _self.mainServiceType : mainServiceType // ignore: cast_nullable_to_non_nullable
as MainServiceType?,variantAttribute: freezed == variantAttribute ? _self.variantAttribute : variantAttribute // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,fabricLength: null == fabricLength ? _self.fabricLength : fabricLength // ignore: cast_nullable_to_non_nullable
as double,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as ProductAttributesModel,measurements: null == measurements ? _self._measurements : measurements // ignore: cast_nullable_to_non_nullable
as List<MeasurementValueModel>,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,remainingStock: freezed == remainingStock ? _self.remainingStock : remainingStock // ignore: cast_nullable_to_non_nullable
as int?,deliveryStatus: null == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as ProductDeliveryStatus,returnedAt: freezed == returnedAt ? _self.returnedAt : returnedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProductInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductAttributesModelCopyWith<$Res> get attributes {
  
  return $ProductAttributesModelCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

// dart format on
