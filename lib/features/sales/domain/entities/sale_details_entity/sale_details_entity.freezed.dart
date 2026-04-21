// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_details_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SaleDetailsEntity {

 int get id; ClientEntity? get client; dynamic get clientPhone; String get address; String get description; String get saleDate; String get createdAt; int get totalAmount; int get discountAmount; int get paidAmount; String get invoiceId; int get balanceDueAmount; List<ProductSaleInfoEntity> get products; int? get accountId; String? get accountName; int? get staffId; String? get staffName;
/// Create a copy of SaleDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleDetailsEntityCopyWith<SaleDetailsEntity> get copyWith => _$SaleDetailsEntityCopyWithImpl<SaleDetailsEntity>(this as SaleDetailsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleDetailsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.client, client) || other.client == client)&&const DeepCollectionEquality().equals(other.clientPhone, clientPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.balanceDueAmount, balanceDueAmount) || other.balanceDueAmount == balanceDueAmount)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName));
}


@override
int get hashCode => Object.hash(runtimeType,id,client,const DeepCollectionEquality().hash(clientPhone),address,description,saleDate,createdAt,totalAmount,discountAmount,paidAmount,invoiceId,balanceDueAmount,const DeepCollectionEquality().hash(products),accountId,accountName,staffId,staffName);

@override
String toString() {
  return 'SaleDetailsEntity(id: $id, client: $client, clientPhone: $clientPhone, address: $address, description: $description, saleDate: $saleDate, createdAt: $createdAt, totalAmount: $totalAmount, discountAmount: $discountAmount, paidAmount: $paidAmount, invoiceId: $invoiceId, balanceDueAmount: $balanceDueAmount, products: $products, accountId: $accountId, accountName: $accountName, staffId: $staffId, staffName: $staffName)';
}


}

/// @nodoc
abstract mixin class $SaleDetailsEntityCopyWith<$Res>  {
  factory $SaleDetailsEntityCopyWith(SaleDetailsEntity value, $Res Function(SaleDetailsEntity) _then) = _$SaleDetailsEntityCopyWithImpl;
@useResult
$Res call({
 int id, ClientEntity? client, dynamic clientPhone, String address, String description, String saleDate, String createdAt, int totalAmount, int discountAmount, int paidAmount, String invoiceId, int balanceDueAmount, List<ProductSaleInfoEntity> products, int? accountId, String? accountName, int? staffId, String? staffName
});


$ClientEntityCopyWith<$Res>? get client;

}
/// @nodoc
class _$SaleDetailsEntityCopyWithImpl<$Res>
    implements $SaleDetailsEntityCopyWith<$Res> {
  _$SaleDetailsEntityCopyWithImpl(this._self, this._then);

  final SaleDetailsEntity _self;
  final $Res Function(SaleDetailsEntity) _then;

/// Create a copy of SaleDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? client = freezed,Object? clientPhone = freezed,Object? address = null,Object? description = null,Object? saleDate = null,Object? createdAt = null,Object? totalAmount = null,Object? discountAmount = null,Object? paidAmount = null,Object? invoiceId = null,Object? balanceDueAmount = null,Object? products = null,Object? accountId = freezed,Object? accountName = freezed,Object? staffId = freezed,Object? staffName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientEntity?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as dynamic,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,saleDate: null == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,balanceDueAmount: null == balanceDueAmount ? _self.balanceDueAmount : balanceDueAmount // ignore: cast_nullable_to_non_nullable
as int,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductSaleInfoEntity>,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SaleDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientEntityCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $ClientEntityCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// Adds pattern-matching-related methods to [SaleDetailsEntity].
extension SaleDetailsEntityPatterns on SaleDetailsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleDetailsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleDetailsEntity value)  $default,){
final _that = this;
switch (_that) {
case _SaleDetailsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleDetailsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SaleDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  ClientEntity? client,  dynamic clientPhone,  String address,  String description,  String saleDate,  String createdAt,  int totalAmount,  int discountAmount,  int paidAmount,  String invoiceId,  int balanceDueAmount,  List<ProductSaleInfoEntity> products,  int? accountId,  String? accountName,  int? staffId,  String? staffName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleDetailsEntity() when $default != null:
return $default(_that.id,_that.client,_that.clientPhone,_that.address,_that.description,_that.saleDate,_that.createdAt,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.invoiceId,_that.balanceDueAmount,_that.products,_that.accountId,_that.accountName,_that.staffId,_that.staffName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  ClientEntity? client,  dynamic clientPhone,  String address,  String description,  String saleDate,  String createdAt,  int totalAmount,  int discountAmount,  int paidAmount,  String invoiceId,  int balanceDueAmount,  List<ProductSaleInfoEntity> products,  int? accountId,  String? accountName,  int? staffId,  String? staffName)  $default,) {final _that = this;
switch (_that) {
case _SaleDetailsEntity():
return $default(_that.id,_that.client,_that.clientPhone,_that.address,_that.description,_that.saleDate,_that.createdAt,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.invoiceId,_that.balanceDueAmount,_that.products,_that.accountId,_that.accountName,_that.staffId,_that.staffName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  ClientEntity? client,  dynamic clientPhone,  String address,  String description,  String saleDate,  String createdAt,  int totalAmount,  int discountAmount,  int paidAmount,  String invoiceId,  int balanceDueAmount,  List<ProductSaleInfoEntity> products,  int? accountId,  String? accountName,  int? staffId,  String? staffName)?  $default,) {final _that = this;
switch (_that) {
case _SaleDetailsEntity() when $default != null:
return $default(_that.id,_that.client,_that.clientPhone,_that.address,_that.description,_that.saleDate,_that.createdAt,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.invoiceId,_that.balanceDueAmount,_that.products,_that.accountId,_that.accountName,_that.staffId,_that.staffName);case _:
  return null;

}
}

}

/// @nodoc


class _SaleDetailsEntity implements SaleDetailsEntity {
  const _SaleDetailsEntity({required this.id, this.client, this.clientPhone, required this.address, required this.description, required this.saleDate, required this.createdAt, required this.totalAmount, required this.discountAmount, required this.paidAmount, required this.invoiceId, required this.balanceDueAmount, required final  List<ProductSaleInfoEntity> products, this.accountId, this.accountName, this.staffId, this.staffName}): _products = products;
  

@override final  int id;
@override final  ClientEntity? client;
@override final  dynamic clientPhone;
@override final  String address;
@override final  String description;
@override final  String saleDate;
@override final  String createdAt;
@override final  int totalAmount;
@override final  int discountAmount;
@override final  int paidAmount;
@override final  String invoiceId;
@override final  int balanceDueAmount;
 final  List<ProductSaleInfoEntity> _products;
@override List<ProductSaleInfoEntity> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override final  int? accountId;
@override final  String? accountName;
@override final  int? staffId;
@override final  String? staffName;

/// Create a copy of SaleDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleDetailsEntityCopyWith<_SaleDetailsEntity> get copyWith => __$SaleDetailsEntityCopyWithImpl<_SaleDetailsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleDetailsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.client, client) || other.client == client)&&const DeepCollectionEquality().equals(other.clientPhone, clientPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.balanceDueAmount, balanceDueAmount) || other.balanceDueAmount == balanceDueAmount)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName));
}


@override
int get hashCode => Object.hash(runtimeType,id,client,const DeepCollectionEquality().hash(clientPhone),address,description,saleDate,createdAt,totalAmount,discountAmount,paidAmount,invoiceId,balanceDueAmount,const DeepCollectionEquality().hash(_products),accountId,accountName,staffId,staffName);

@override
String toString() {
  return 'SaleDetailsEntity(id: $id, client: $client, clientPhone: $clientPhone, address: $address, description: $description, saleDate: $saleDate, createdAt: $createdAt, totalAmount: $totalAmount, discountAmount: $discountAmount, paidAmount: $paidAmount, invoiceId: $invoiceId, balanceDueAmount: $balanceDueAmount, products: $products, accountId: $accountId, accountName: $accountName, staffId: $staffId, staffName: $staffName)';
}


}

/// @nodoc
abstract mixin class _$SaleDetailsEntityCopyWith<$Res> implements $SaleDetailsEntityCopyWith<$Res> {
  factory _$SaleDetailsEntityCopyWith(_SaleDetailsEntity value, $Res Function(_SaleDetailsEntity) _then) = __$SaleDetailsEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, ClientEntity? client, dynamic clientPhone, String address, String description, String saleDate, String createdAt, int totalAmount, int discountAmount, int paidAmount, String invoiceId, int balanceDueAmount, List<ProductSaleInfoEntity> products, int? accountId, String? accountName, int? staffId, String? staffName
});


@override $ClientEntityCopyWith<$Res>? get client;

}
/// @nodoc
class __$SaleDetailsEntityCopyWithImpl<$Res>
    implements _$SaleDetailsEntityCopyWith<$Res> {
  __$SaleDetailsEntityCopyWithImpl(this._self, this._then);

  final _SaleDetailsEntity _self;
  final $Res Function(_SaleDetailsEntity) _then;

/// Create a copy of SaleDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? client = freezed,Object? clientPhone = freezed,Object? address = null,Object? description = null,Object? saleDate = null,Object? createdAt = null,Object? totalAmount = null,Object? discountAmount = null,Object? paidAmount = null,Object? invoiceId = null,Object? balanceDueAmount = null,Object? products = null,Object? accountId = freezed,Object? accountName = freezed,Object? staffId = freezed,Object? staffName = freezed,}) {
  return _then(_SaleDetailsEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientEntity?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as dynamic,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,saleDate: null == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,balanceDueAmount: null == balanceDueAmount ? _self.balanceDueAmount : balanceDueAmount // ignore: cast_nullable_to_non_nullable
as int,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductSaleInfoEntity>,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SaleDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientEntityCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $ClientEntityCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}

/// @nodoc
mixin _$ProductSaleInfoEntity {

 int get id; int get productId; int get variantId; String get name; String? get variantAttribute; int get quantity; int get price; int get subtotal; String? get image; String? get color; String? get category; String? get model; MainServiceType? get mainServiceType;
/// Create a copy of ProductSaleInfoEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductSaleInfoEntityCopyWith<ProductSaleInfoEntity> get copyWith => _$ProductSaleInfoEntityCopyWithImpl<ProductSaleInfoEntity>(this as ProductSaleInfoEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductSaleInfoEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.variantAttribute, variantAttribute) || other.variantAttribute == variantAttribute)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.image, image) || other.image == image)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.model, model) || other.model == model)&&(identical(other.mainServiceType, mainServiceType) || other.mainServiceType == mainServiceType));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,variantId,name,variantAttribute,quantity,price,subtotal,image,color,category,model,mainServiceType);

@override
String toString() {
  return 'ProductSaleInfoEntity(id: $id, productId: $productId, variantId: $variantId, name: $name, variantAttribute: $variantAttribute, quantity: $quantity, price: $price, subtotal: $subtotal, image: $image, color: $color, category: $category, model: $model, mainServiceType: $mainServiceType)';
}


}

/// @nodoc
abstract mixin class $ProductSaleInfoEntityCopyWith<$Res>  {
  factory $ProductSaleInfoEntityCopyWith(ProductSaleInfoEntity value, $Res Function(ProductSaleInfoEntity) _then) = _$ProductSaleInfoEntityCopyWithImpl;
@useResult
$Res call({
 int id, int productId, int variantId, String name, String? variantAttribute, int quantity, int price, int subtotal, String? image, String? color, String? category, String? model, MainServiceType? mainServiceType
});




}
/// @nodoc
class _$ProductSaleInfoEntityCopyWithImpl<$Res>
    implements $ProductSaleInfoEntityCopyWith<$Res> {
  _$ProductSaleInfoEntityCopyWithImpl(this._self, this._then);

  final ProductSaleInfoEntity _self;
  final $Res Function(ProductSaleInfoEntity) _then;

/// Create a copy of ProductSaleInfoEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? variantId = null,Object? name = null,Object? variantAttribute = freezed,Object? quantity = null,Object? price = null,Object? subtotal = null,Object? image = freezed,Object? color = freezed,Object? category = freezed,Object? model = freezed,Object? mainServiceType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,variantId: null == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,variantAttribute: freezed == variantAttribute ? _self.variantAttribute : variantAttribute // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as int,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,mainServiceType: freezed == mainServiceType ? _self.mainServiceType : mainServiceType // ignore: cast_nullable_to_non_nullable
as MainServiceType?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductSaleInfoEntity].
extension ProductSaleInfoEntityPatterns on ProductSaleInfoEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductSaleInfoEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductSaleInfoEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductSaleInfoEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProductSaleInfoEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductSaleInfoEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProductSaleInfoEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int productId,  int variantId,  String name,  String? variantAttribute,  int quantity,  int price,  int subtotal,  String? image,  String? color,  String? category,  String? model,  MainServiceType? mainServiceType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductSaleInfoEntity() when $default != null:
return $default(_that.id,_that.productId,_that.variantId,_that.name,_that.variantAttribute,_that.quantity,_that.price,_that.subtotal,_that.image,_that.color,_that.category,_that.model,_that.mainServiceType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int productId,  int variantId,  String name,  String? variantAttribute,  int quantity,  int price,  int subtotal,  String? image,  String? color,  String? category,  String? model,  MainServiceType? mainServiceType)  $default,) {final _that = this;
switch (_that) {
case _ProductSaleInfoEntity():
return $default(_that.id,_that.productId,_that.variantId,_that.name,_that.variantAttribute,_that.quantity,_that.price,_that.subtotal,_that.image,_that.color,_that.category,_that.model,_that.mainServiceType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int productId,  int variantId,  String name,  String? variantAttribute,  int quantity,  int price,  int subtotal,  String? image,  String? color,  String? category,  String? model,  MainServiceType? mainServiceType)?  $default,) {final _that = this;
switch (_that) {
case _ProductSaleInfoEntity() when $default != null:
return $default(_that.id,_that.productId,_that.variantId,_that.name,_that.variantAttribute,_that.quantity,_that.price,_that.subtotal,_that.image,_that.color,_that.category,_that.model,_that.mainServiceType);case _:
  return null;

}
}

}

/// @nodoc


class _ProductSaleInfoEntity implements ProductSaleInfoEntity {
  const _ProductSaleInfoEntity({required this.id, required this.productId, required this.variantId, required this.name, this.variantAttribute, required this.quantity, required this.price, required this.subtotal, this.image, this.color, this.category, this.model, this.mainServiceType});
  

@override final  int id;
@override final  int productId;
@override final  int variantId;
@override final  String name;
@override final  String? variantAttribute;
@override final  int quantity;
@override final  int price;
@override final  int subtotal;
@override final  String? image;
@override final  String? color;
@override final  String? category;
@override final  String? model;
@override final  MainServiceType? mainServiceType;

/// Create a copy of ProductSaleInfoEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductSaleInfoEntityCopyWith<_ProductSaleInfoEntity> get copyWith => __$ProductSaleInfoEntityCopyWithImpl<_ProductSaleInfoEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductSaleInfoEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.variantAttribute, variantAttribute) || other.variantAttribute == variantAttribute)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.image, image) || other.image == image)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.model, model) || other.model == model)&&(identical(other.mainServiceType, mainServiceType) || other.mainServiceType == mainServiceType));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,variantId,name,variantAttribute,quantity,price,subtotal,image,color,category,model,mainServiceType);

@override
String toString() {
  return 'ProductSaleInfoEntity(id: $id, productId: $productId, variantId: $variantId, name: $name, variantAttribute: $variantAttribute, quantity: $quantity, price: $price, subtotal: $subtotal, image: $image, color: $color, category: $category, model: $model, mainServiceType: $mainServiceType)';
}


}

/// @nodoc
abstract mixin class _$ProductSaleInfoEntityCopyWith<$Res> implements $ProductSaleInfoEntityCopyWith<$Res> {
  factory _$ProductSaleInfoEntityCopyWith(_ProductSaleInfoEntity value, $Res Function(_ProductSaleInfoEntity) _then) = __$ProductSaleInfoEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int productId, int variantId, String name, String? variantAttribute, int quantity, int price, int subtotal, String? image, String? color, String? category, String? model, MainServiceType? mainServiceType
});




}
/// @nodoc
class __$ProductSaleInfoEntityCopyWithImpl<$Res>
    implements _$ProductSaleInfoEntityCopyWith<$Res> {
  __$ProductSaleInfoEntityCopyWithImpl(this._self, this._then);

  final _ProductSaleInfoEntity _self;
  final $Res Function(_ProductSaleInfoEntity) _then;

/// Create a copy of ProductSaleInfoEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? variantId = null,Object? name = null,Object? variantAttribute = freezed,Object? quantity = null,Object? price = null,Object? subtotal = null,Object? image = freezed,Object? color = freezed,Object? category = freezed,Object? model = freezed,Object? mainServiceType = freezed,}) {
  return _then(_ProductSaleInfoEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,variantId: null == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,variantAttribute: freezed == variantAttribute ? _self.variantAttribute : variantAttribute // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as int,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,mainServiceType: freezed == mainServiceType ? _self.mainServiceType : mainServiceType // ignore: cast_nullable_to_non_nullable
as MainServiceType?,
  ));
}


}

// dart format on
