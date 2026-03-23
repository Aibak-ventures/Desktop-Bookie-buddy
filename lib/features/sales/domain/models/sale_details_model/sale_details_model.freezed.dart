// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SaleDetailsModel {

 int get id;@JsonKey(name: 'client') ClientModel? get client;@JsonKey(name: 'client_phone') dynamic get clientPhone;@JsonKey(name: 'address', defaultValue: '') String get address;@JsonKey(name: 'description') String get description;@JsonKey(name: 'sale_date') String get saleDate;@JsonKey(name: 'created_at', defaultValue: '') String get createdAt;@JsonKey(name: 'total_amount') int get totalAmount;@JsonKey(name: 'discount') int get discountAmount;@JsonKey(name: 'paid_amount') int get paidAmount;@JsonKey(name: 'shop_sale_id', defaultValue: '') String get invoiceId;@JsonKey(name: 'balance_due') int get balanceDueAmount;@JsonKey(name: 'items') List<ProductSaleInfoModel> get products;@JsonKey(name: 'method', fromJson: PaymentMethod.fromJson, readValue: _paymentMethodReadValue) PaymentMethod get paymentMethod;@JsonKey(name: 'staff_id') int? get staffId;@JsonKey(name: 'staff_name') String? get staffName;
/// Create a copy of SaleDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleDetailsModelCopyWith<SaleDetailsModel> get copyWith => _$SaleDetailsModelCopyWithImpl<SaleDetailsModel>(this as SaleDetailsModel, _$identity);

  /// Serializes this SaleDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleDetailsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.client, client) || other.client == client)&&const DeepCollectionEquality().equals(other.clientPhone, clientPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.balanceDueAmount, balanceDueAmount) || other.balanceDueAmount == balanceDueAmount)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,client,const DeepCollectionEquality().hash(clientPhone),address,description,saleDate,createdAt,totalAmount,discountAmount,paidAmount,invoiceId,balanceDueAmount,const DeepCollectionEquality().hash(products),paymentMethod,staffId,staffName);

@override
String toString() {
  return 'SaleDetailsModel(id: $id, client: $client, clientPhone: $clientPhone, address: $address, description: $description, saleDate: $saleDate, createdAt: $createdAt, totalAmount: $totalAmount, discountAmount: $discountAmount, paidAmount: $paidAmount, invoiceId: $invoiceId, balanceDueAmount: $balanceDueAmount, products: $products, paymentMethod: $paymentMethod, staffId: $staffId, staffName: $staffName)';
}


}

/// @nodoc
abstract mixin class $SaleDetailsModelCopyWith<$Res>  {
  factory $SaleDetailsModelCopyWith(SaleDetailsModel value, $Res Function(SaleDetailsModel) _then) = _$SaleDetailsModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'client') ClientModel? client,@JsonKey(name: 'client_phone') dynamic clientPhone,@JsonKey(name: 'address', defaultValue: '') String address,@JsonKey(name: 'description') String description,@JsonKey(name: 'sale_date') String saleDate,@JsonKey(name: 'created_at', defaultValue: '') String createdAt,@JsonKey(name: 'total_amount') int totalAmount,@JsonKey(name: 'discount') int discountAmount,@JsonKey(name: 'paid_amount') int paidAmount,@JsonKey(name: 'shop_sale_id', defaultValue: '') String invoiceId,@JsonKey(name: 'balance_due') int balanceDueAmount,@JsonKey(name: 'items') List<ProductSaleInfoModel> products,@JsonKey(name: 'method', fromJson: PaymentMethod.fromJson, readValue: _paymentMethodReadValue) PaymentMethod paymentMethod,@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'staff_name') String? staffName
});


$ClientModelCopyWith<$Res>? get client;

}
/// @nodoc
class _$SaleDetailsModelCopyWithImpl<$Res>
    implements $SaleDetailsModelCopyWith<$Res> {
  _$SaleDetailsModelCopyWithImpl(this._self, this._then);

  final SaleDetailsModel _self;
  final $Res Function(SaleDetailsModel) _then;

/// Create a copy of SaleDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? client = freezed,Object? clientPhone = freezed,Object? address = null,Object? description = null,Object? saleDate = null,Object? createdAt = null,Object? totalAmount = null,Object? discountAmount = null,Object? paidAmount = null,Object? invoiceId = null,Object? balanceDueAmount = null,Object? products = null,Object? paymentMethod = null,Object? staffId = freezed,Object? staffName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientModel?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
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
as List<ProductSaleInfoModel>,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SaleDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientModelCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $ClientModelCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// Adds pattern-matching-related methods to [SaleDetailsModel].
extension SaleDetailsModelPatterns on SaleDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _SaleDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _SaleDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'client')  ClientModel? client, @JsonKey(name: 'client_phone')  dynamic clientPhone, @JsonKey(name: 'address', defaultValue: '')  String address, @JsonKey(name: 'description')  String description, @JsonKey(name: 'sale_date')  String saleDate, @JsonKey(name: 'created_at', defaultValue: '')  String createdAt, @JsonKey(name: 'total_amount')  int totalAmount, @JsonKey(name: 'discount')  int discountAmount, @JsonKey(name: 'paid_amount')  int paidAmount, @JsonKey(name: 'shop_sale_id', defaultValue: '')  String invoiceId, @JsonKey(name: 'balance_due')  int balanceDueAmount, @JsonKey(name: 'items')  List<ProductSaleInfoModel> products, @JsonKey(name: 'method', fromJson: PaymentMethod.fromJson, readValue: _paymentMethodReadValue)  PaymentMethod paymentMethod, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'staff_name')  String? staffName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleDetailsModel() when $default != null:
return $default(_that.id,_that.client,_that.clientPhone,_that.address,_that.description,_that.saleDate,_that.createdAt,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.invoiceId,_that.balanceDueAmount,_that.products,_that.paymentMethod,_that.staffId,_that.staffName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'client')  ClientModel? client, @JsonKey(name: 'client_phone')  dynamic clientPhone, @JsonKey(name: 'address', defaultValue: '')  String address, @JsonKey(name: 'description')  String description, @JsonKey(name: 'sale_date')  String saleDate, @JsonKey(name: 'created_at', defaultValue: '')  String createdAt, @JsonKey(name: 'total_amount')  int totalAmount, @JsonKey(name: 'discount')  int discountAmount, @JsonKey(name: 'paid_amount')  int paidAmount, @JsonKey(name: 'shop_sale_id', defaultValue: '')  String invoiceId, @JsonKey(name: 'balance_due')  int balanceDueAmount, @JsonKey(name: 'items')  List<ProductSaleInfoModel> products, @JsonKey(name: 'method', fromJson: PaymentMethod.fromJson, readValue: _paymentMethodReadValue)  PaymentMethod paymentMethod, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'staff_name')  String? staffName)  $default,) {final _that = this;
switch (_that) {
case _SaleDetailsModel():
return $default(_that.id,_that.client,_that.clientPhone,_that.address,_that.description,_that.saleDate,_that.createdAt,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.invoiceId,_that.balanceDueAmount,_that.products,_that.paymentMethod,_that.staffId,_that.staffName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'client')  ClientModel? client, @JsonKey(name: 'client_phone')  dynamic clientPhone, @JsonKey(name: 'address', defaultValue: '')  String address, @JsonKey(name: 'description')  String description, @JsonKey(name: 'sale_date')  String saleDate, @JsonKey(name: 'created_at', defaultValue: '')  String createdAt, @JsonKey(name: 'total_amount')  int totalAmount, @JsonKey(name: 'discount')  int discountAmount, @JsonKey(name: 'paid_amount')  int paidAmount, @JsonKey(name: 'shop_sale_id', defaultValue: '')  String invoiceId, @JsonKey(name: 'balance_due')  int balanceDueAmount, @JsonKey(name: 'items')  List<ProductSaleInfoModel> products, @JsonKey(name: 'method', fromJson: PaymentMethod.fromJson, readValue: _paymentMethodReadValue)  PaymentMethod paymentMethod, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'staff_name')  String? staffName)?  $default,) {final _that = this;
switch (_that) {
case _SaleDetailsModel() when $default != null:
return $default(_that.id,_that.client,_that.clientPhone,_that.address,_that.description,_that.saleDate,_that.createdAt,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.invoiceId,_that.balanceDueAmount,_that.products,_that.paymentMethod,_that.staffId,_that.staffName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaleDetailsModel implements SaleDetailsModel {
  const _SaleDetailsModel({required this.id, @JsonKey(name: 'client') this.client, @JsonKey(name: 'client_phone') this.clientPhone, @JsonKey(name: 'address', defaultValue: '') required this.address, @JsonKey(name: 'description') required this.description, @JsonKey(name: 'sale_date') required this.saleDate, @JsonKey(name: 'created_at', defaultValue: '') required this.createdAt, @JsonKey(name: 'total_amount') required this.totalAmount, @JsonKey(name: 'discount') required this.discountAmount, @JsonKey(name: 'paid_amount') required this.paidAmount, @JsonKey(name: 'shop_sale_id', defaultValue: '') required this.invoiceId, @JsonKey(name: 'balance_due') required this.balanceDueAmount, @JsonKey(name: 'items') required final  List<ProductSaleInfoModel> products, @JsonKey(name: 'method', fromJson: PaymentMethod.fromJson, readValue: _paymentMethodReadValue) this.paymentMethod = PaymentMethod.cash, @JsonKey(name: 'staff_id') this.staffId, @JsonKey(name: 'staff_name') this.staffName}): _products = products;
  factory _SaleDetailsModel.fromJson(Map<String, dynamic> json) => _$SaleDetailsModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'client') final  ClientModel? client;
@override@JsonKey(name: 'client_phone') final  dynamic clientPhone;
@override@JsonKey(name: 'address', defaultValue: '') final  String address;
@override@JsonKey(name: 'description') final  String description;
@override@JsonKey(name: 'sale_date') final  String saleDate;
@override@JsonKey(name: 'created_at', defaultValue: '') final  String createdAt;
@override@JsonKey(name: 'total_amount') final  int totalAmount;
@override@JsonKey(name: 'discount') final  int discountAmount;
@override@JsonKey(name: 'paid_amount') final  int paidAmount;
@override@JsonKey(name: 'shop_sale_id', defaultValue: '') final  String invoiceId;
@override@JsonKey(name: 'balance_due') final  int balanceDueAmount;
 final  List<ProductSaleInfoModel> _products;
@override@JsonKey(name: 'items') List<ProductSaleInfoModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override@JsonKey(name: 'method', fromJson: PaymentMethod.fromJson, readValue: _paymentMethodReadValue) final  PaymentMethod paymentMethod;
@override@JsonKey(name: 'staff_id') final  int? staffId;
@override@JsonKey(name: 'staff_name') final  String? staffName;

/// Create a copy of SaleDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleDetailsModelCopyWith<_SaleDetailsModel> get copyWith => __$SaleDetailsModelCopyWithImpl<_SaleDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaleDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleDetailsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.client, client) || other.client == client)&&const DeepCollectionEquality().equals(other.clientPhone, clientPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.balanceDueAmount, balanceDueAmount) || other.balanceDueAmount == balanceDueAmount)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,client,const DeepCollectionEquality().hash(clientPhone),address,description,saleDate,createdAt,totalAmount,discountAmount,paidAmount,invoiceId,balanceDueAmount,const DeepCollectionEquality().hash(_products),paymentMethod,staffId,staffName);

@override
String toString() {
  return 'SaleDetailsModel(id: $id, client: $client, clientPhone: $clientPhone, address: $address, description: $description, saleDate: $saleDate, createdAt: $createdAt, totalAmount: $totalAmount, discountAmount: $discountAmount, paidAmount: $paidAmount, invoiceId: $invoiceId, balanceDueAmount: $balanceDueAmount, products: $products, paymentMethod: $paymentMethod, staffId: $staffId, staffName: $staffName)';
}


}

/// @nodoc
abstract mixin class _$SaleDetailsModelCopyWith<$Res> implements $SaleDetailsModelCopyWith<$Res> {
  factory _$SaleDetailsModelCopyWith(_SaleDetailsModel value, $Res Function(_SaleDetailsModel) _then) = __$SaleDetailsModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'client') ClientModel? client,@JsonKey(name: 'client_phone') dynamic clientPhone,@JsonKey(name: 'address', defaultValue: '') String address,@JsonKey(name: 'description') String description,@JsonKey(name: 'sale_date') String saleDate,@JsonKey(name: 'created_at', defaultValue: '') String createdAt,@JsonKey(name: 'total_amount') int totalAmount,@JsonKey(name: 'discount') int discountAmount,@JsonKey(name: 'paid_amount') int paidAmount,@JsonKey(name: 'shop_sale_id', defaultValue: '') String invoiceId,@JsonKey(name: 'balance_due') int balanceDueAmount,@JsonKey(name: 'items') List<ProductSaleInfoModel> products,@JsonKey(name: 'method', fromJson: PaymentMethod.fromJson, readValue: _paymentMethodReadValue) PaymentMethod paymentMethod,@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'staff_name') String? staffName
});


@override $ClientModelCopyWith<$Res>? get client;

}
/// @nodoc
class __$SaleDetailsModelCopyWithImpl<$Res>
    implements _$SaleDetailsModelCopyWith<$Res> {
  __$SaleDetailsModelCopyWithImpl(this._self, this._then);

  final _SaleDetailsModel _self;
  final $Res Function(_SaleDetailsModel) _then;

/// Create a copy of SaleDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? client = freezed,Object? clientPhone = freezed,Object? address = null,Object? description = null,Object? saleDate = null,Object? createdAt = null,Object? totalAmount = null,Object? discountAmount = null,Object? paidAmount = null,Object? invoiceId = null,Object? balanceDueAmount = null,Object? products = null,Object? paymentMethod = null,Object? staffId = freezed,Object? staffName = freezed,}) {
  return _then(_SaleDetailsModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientModel?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
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
as List<ProductSaleInfoModel>,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SaleDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientModelCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $ClientModelCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// @nodoc
mixin _$ProductSaleInfoModel {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'product_id') int get productId;@JsonKey(name: 'variant_id') int get variantId;@JsonKey(name: 'product_name') String get name;@JsonKey(name: 'variant') String? get variantAttribute;@JsonKey(name: 'quantity') int get quantity;@JsonKey(name: 'price') int get price;@JsonKey(name: 'subtotal') int get subtotal;@JsonKey(name: 'thumbnail') String? get image;@JsonKey(name: 'color') String? get color;@JsonKey(name: 'category') String? get category;@JsonKey(name: 'model') String? get model;@JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString) MainServiceType? get mainServiceType;
/// Create a copy of ProductSaleInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductSaleInfoModelCopyWith<ProductSaleInfoModel> get copyWith => _$ProductSaleInfoModelCopyWithImpl<ProductSaleInfoModel>(this as ProductSaleInfoModel, _$identity);

  /// Serializes this ProductSaleInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductSaleInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.variantAttribute, variantAttribute) || other.variantAttribute == variantAttribute)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.image, image) || other.image == image)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.model, model) || other.model == model)&&(identical(other.mainServiceType, mainServiceType) || other.mainServiceType == mainServiceType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,variantId,name,variantAttribute,quantity,price,subtotal,image,color,category,model,mainServiceType);

@override
String toString() {
  return 'ProductSaleInfoModel(id: $id, productId: $productId, variantId: $variantId, name: $name, variantAttribute: $variantAttribute, quantity: $quantity, price: $price, subtotal: $subtotal, image: $image, color: $color, category: $category, model: $model, mainServiceType: $mainServiceType)';
}


}

/// @nodoc
abstract mixin class $ProductSaleInfoModelCopyWith<$Res>  {
  factory $ProductSaleInfoModelCopyWith(ProductSaleInfoModel value, $Res Function(ProductSaleInfoModel) _then) = _$ProductSaleInfoModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'product_id') int productId,@JsonKey(name: 'variant_id') int variantId,@JsonKey(name: 'product_name') String name,@JsonKey(name: 'variant') String? variantAttribute,@JsonKey(name: 'quantity') int quantity,@JsonKey(name: 'price') int price,@JsonKey(name: 'subtotal') int subtotal,@JsonKey(name: 'thumbnail') String? image,@JsonKey(name: 'color') String? color,@JsonKey(name: 'category') String? category,@JsonKey(name: 'model') String? model,@JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString) MainServiceType? mainServiceType
});




}
/// @nodoc
class _$ProductSaleInfoModelCopyWithImpl<$Res>
    implements $ProductSaleInfoModelCopyWith<$Res> {
  _$ProductSaleInfoModelCopyWithImpl(this._self, this._then);

  final ProductSaleInfoModel _self;
  final $Res Function(ProductSaleInfoModel) _then;

/// Create a copy of ProductSaleInfoModel
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


/// Adds pattern-matching-related methods to [ProductSaleInfoModel].
extension ProductSaleInfoModelPatterns on ProductSaleInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductSaleInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductSaleInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductSaleInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductSaleInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductSaleInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductSaleInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'product_id')  int productId, @JsonKey(name: 'variant_id')  int variantId, @JsonKey(name: 'product_name')  String name, @JsonKey(name: 'variant')  String? variantAttribute, @JsonKey(name: 'quantity')  int quantity, @JsonKey(name: 'price')  int price, @JsonKey(name: 'subtotal')  int subtotal, @JsonKey(name: 'thumbnail')  String? image, @JsonKey(name: 'color')  String? color, @JsonKey(name: 'category')  String? category, @JsonKey(name: 'model')  String? model, @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString)  MainServiceType? mainServiceType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductSaleInfoModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'product_id')  int productId, @JsonKey(name: 'variant_id')  int variantId, @JsonKey(name: 'product_name')  String name, @JsonKey(name: 'variant')  String? variantAttribute, @JsonKey(name: 'quantity')  int quantity, @JsonKey(name: 'price')  int price, @JsonKey(name: 'subtotal')  int subtotal, @JsonKey(name: 'thumbnail')  String? image, @JsonKey(name: 'color')  String? color, @JsonKey(name: 'category')  String? category, @JsonKey(name: 'model')  String? model, @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString)  MainServiceType? mainServiceType)  $default,) {final _that = this;
switch (_that) {
case _ProductSaleInfoModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'product_id')  int productId, @JsonKey(name: 'variant_id')  int variantId, @JsonKey(name: 'product_name')  String name, @JsonKey(name: 'variant')  String? variantAttribute, @JsonKey(name: 'quantity')  int quantity, @JsonKey(name: 'price')  int price, @JsonKey(name: 'subtotal')  int subtotal, @JsonKey(name: 'thumbnail')  String? image, @JsonKey(name: 'color')  String? color, @JsonKey(name: 'category')  String? category, @JsonKey(name: 'model')  String? model, @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString)  MainServiceType? mainServiceType)?  $default,) {final _that = this;
switch (_that) {
case _ProductSaleInfoModel() when $default != null:
return $default(_that.id,_that.productId,_that.variantId,_that.name,_that.variantAttribute,_that.quantity,_that.price,_that.subtotal,_that.image,_that.color,_that.category,_that.model,_that.mainServiceType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductSaleInfoModel implements ProductSaleInfoModel {
  const _ProductSaleInfoModel({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'product_id') required this.productId, @JsonKey(name: 'variant_id') required this.variantId, @JsonKey(name: 'product_name') required this.name, @JsonKey(name: 'variant') this.variantAttribute, @JsonKey(name: 'quantity') required this.quantity, @JsonKey(name: 'price') required this.price, @JsonKey(name: 'subtotal') required this.subtotal, @JsonKey(name: 'thumbnail') this.image, @JsonKey(name: 'color') this.color, @JsonKey(name: 'category') this.category, @JsonKey(name: 'model') this.model, @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString) this.mainServiceType});
  factory _ProductSaleInfoModel.fromJson(Map<String, dynamic> json) => _$ProductSaleInfoModelFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'product_id') final  int productId;
@override@JsonKey(name: 'variant_id') final  int variantId;
@override@JsonKey(name: 'product_name') final  String name;
@override@JsonKey(name: 'variant') final  String? variantAttribute;
@override@JsonKey(name: 'quantity') final  int quantity;
@override@JsonKey(name: 'price') final  int price;
@override@JsonKey(name: 'subtotal') final  int subtotal;
@override@JsonKey(name: 'thumbnail') final  String? image;
@override@JsonKey(name: 'color') final  String? color;
@override@JsonKey(name: 'category') final  String? category;
@override@JsonKey(name: 'model') final  String? model;
@override@JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString) final  MainServiceType? mainServiceType;

/// Create a copy of ProductSaleInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductSaleInfoModelCopyWith<_ProductSaleInfoModel> get copyWith => __$ProductSaleInfoModelCopyWithImpl<_ProductSaleInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductSaleInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductSaleInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.name, name) || other.name == name)&&(identical(other.variantAttribute, variantAttribute) || other.variantAttribute == variantAttribute)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.price, price) || other.price == price)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.image, image) || other.image == image)&&(identical(other.color, color) || other.color == color)&&(identical(other.category, category) || other.category == category)&&(identical(other.model, model) || other.model == model)&&(identical(other.mainServiceType, mainServiceType) || other.mainServiceType == mainServiceType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,variantId,name,variantAttribute,quantity,price,subtotal,image,color,category,model,mainServiceType);

@override
String toString() {
  return 'ProductSaleInfoModel(id: $id, productId: $productId, variantId: $variantId, name: $name, variantAttribute: $variantAttribute, quantity: $quantity, price: $price, subtotal: $subtotal, image: $image, color: $color, category: $category, model: $model, mainServiceType: $mainServiceType)';
}


}

/// @nodoc
abstract mixin class _$ProductSaleInfoModelCopyWith<$Res> implements $ProductSaleInfoModelCopyWith<$Res> {
  factory _$ProductSaleInfoModelCopyWith(_ProductSaleInfoModel value, $Res Function(_ProductSaleInfoModel) _then) = __$ProductSaleInfoModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'product_id') int productId,@JsonKey(name: 'variant_id') int variantId,@JsonKey(name: 'product_name') String name,@JsonKey(name: 'variant') String? variantAttribute,@JsonKey(name: 'quantity') int quantity,@JsonKey(name: 'price') int price,@JsonKey(name: 'subtotal') int subtotal,@JsonKey(name: 'thumbnail') String? image,@JsonKey(name: 'color') String? color,@JsonKey(name: 'category') String? category,@JsonKey(name: 'model') String? model,@JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString) MainServiceType? mainServiceType
});




}
/// @nodoc
class __$ProductSaleInfoModelCopyWithImpl<$Res>
    implements _$ProductSaleInfoModelCopyWith<$Res> {
  __$ProductSaleInfoModelCopyWithImpl(this._self, this._then);

  final _ProductSaleInfoModel _self;
  final $Res Function(_ProductSaleInfoModel) _then;

/// Create a copy of ProductSaleInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? variantId = null,Object? name = null,Object? variantAttribute = freezed,Object? quantity = null,Object? price = null,Object? subtotal = null,Object? image = freezed,Object? color = freezed,Object? category = freezed,Object? model = freezed,Object? mainServiceType = freezed,}) {
  return _then(_ProductSaleInfoModel(
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
