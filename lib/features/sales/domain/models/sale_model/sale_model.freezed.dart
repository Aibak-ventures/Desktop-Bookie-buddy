// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SaleModel {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'shop_sale_id') String? get shopSaleId;@JsonKey(name: 'client_name') String? get clientName;@JsonKey(name: 'client_phone') dynamic get clientPhone;// Can be String or int
@JsonKey(name: 'total_amount') int get totalAmount;@JsonKey(name: 'paid_amount') int get paidAmount;@JsonKey(name: 'discount') int get discountAmount;@JsonKey(name: 'sale_date') String get saleDate;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'products') String get products;// Changed from List<String> to String
@JsonKey(name: 'staff_color', unknownEnumValue: null) String? get staffColor;// Note: API sometimes returns "staff_col lor" with space - handled by fromJson
@JsonKey(name: 'staff_name') String? get staffName;
/// Create a copy of SaleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleModelCopyWith<SaleModel> get copyWith => _$SaleModelCopyWithImpl<SaleModel>(this as SaleModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopSaleId, shopSaleId) || other.shopSaleId == shopSaleId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&const DeepCollectionEquality().equals(other.clientPhone, clientPhone)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.products, products) || other.products == products)&&(identical(other.staffColor, staffColor) || other.staffColor == staffColor)&&(identical(other.staffName, staffName) || other.staffName == staffName));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopSaleId,clientName,const DeepCollectionEquality().hash(clientPhone),totalAmount,paidAmount,discountAmount,saleDate,createdAt,products,staffColor,staffName);

@override
String toString() {
  return 'SaleModel(id: $id, shopSaleId: $shopSaleId, clientName: $clientName, clientPhone: $clientPhone, totalAmount: $totalAmount, paidAmount: $paidAmount, discountAmount: $discountAmount, saleDate: $saleDate, createdAt: $createdAt, products: $products, staffColor: $staffColor, staffName: $staffName)';
}


}

/// @nodoc
abstract mixin class $SaleModelCopyWith<$Res>  {
  factory $SaleModelCopyWith(SaleModel value, $Res Function(SaleModel) _then) = _$SaleModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'shop_sale_id') String? shopSaleId,@JsonKey(name: 'client_name') String? clientName,@JsonKey(name: 'client_phone') dynamic clientPhone,@JsonKey(name: 'total_amount') int totalAmount,@JsonKey(name: 'paid_amount') int paidAmount,@JsonKey(name: 'discount') int discountAmount,@JsonKey(name: 'sale_date') String saleDate,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'products') String products,@JsonKey(name: 'staff_color', unknownEnumValue: null) String? staffColor,@JsonKey(name: 'staff_name') String? staffName
});




}
/// @nodoc
class _$SaleModelCopyWithImpl<$Res>
    implements $SaleModelCopyWith<$Res> {
  _$SaleModelCopyWithImpl(this._self, this._then);

  final SaleModel _self;
  final $Res Function(SaleModel) _then;

/// Create a copy of SaleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shopSaleId = freezed,Object? clientName = freezed,Object? clientPhone = freezed,Object? totalAmount = null,Object? paidAmount = null,Object? discountAmount = null,Object? saleDate = null,Object? createdAt = null,Object? products = null,Object? staffColor = freezed,Object? staffName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shopSaleId: freezed == shopSaleId ? _self.shopSaleId : shopSaleId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as dynamic,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int,saleDate: null == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as String,staffColor: freezed == staffColor ? _self.staffColor : staffColor // ignore: cast_nullable_to_non_nullable
as String?,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleModel].
extension SaleModelPatterns on SaleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleModel value)  $default,){
final _that = this;
switch (_that) {
case _SaleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleModel value)?  $default,){
final _that = this;
switch (_that) {
case _SaleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'shop_sale_id')  String? shopSaleId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'client_phone')  dynamic clientPhone, @JsonKey(name: 'total_amount')  int totalAmount, @JsonKey(name: 'paid_amount')  int paidAmount, @JsonKey(name: 'discount')  int discountAmount, @JsonKey(name: 'sale_date')  String saleDate, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'products')  String products, @JsonKey(name: 'staff_color', unknownEnumValue: null)  String? staffColor, @JsonKey(name: 'staff_name')  String? staffName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleModel() when $default != null:
return $default(_that.id,_that.shopSaleId,_that.clientName,_that.clientPhone,_that.totalAmount,_that.paidAmount,_that.discountAmount,_that.saleDate,_that.createdAt,_that.products,_that.staffColor,_that.staffName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'shop_sale_id')  String? shopSaleId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'client_phone')  dynamic clientPhone, @JsonKey(name: 'total_amount')  int totalAmount, @JsonKey(name: 'paid_amount')  int paidAmount, @JsonKey(name: 'discount')  int discountAmount, @JsonKey(name: 'sale_date')  String saleDate, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'products')  String products, @JsonKey(name: 'staff_color', unknownEnumValue: null)  String? staffColor, @JsonKey(name: 'staff_name')  String? staffName)  $default,) {final _that = this;
switch (_that) {
case _SaleModel():
return $default(_that.id,_that.shopSaleId,_that.clientName,_that.clientPhone,_that.totalAmount,_that.paidAmount,_that.discountAmount,_that.saleDate,_that.createdAt,_that.products,_that.staffColor,_that.staffName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'shop_sale_id')  String? shopSaleId, @JsonKey(name: 'client_name')  String? clientName, @JsonKey(name: 'client_phone')  dynamic clientPhone, @JsonKey(name: 'total_amount')  int totalAmount, @JsonKey(name: 'paid_amount')  int paidAmount, @JsonKey(name: 'discount')  int discountAmount, @JsonKey(name: 'sale_date')  String saleDate, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'products')  String products, @JsonKey(name: 'staff_color', unknownEnumValue: null)  String? staffColor, @JsonKey(name: 'staff_name')  String? staffName)?  $default,) {final _that = this;
switch (_that) {
case _SaleModel() when $default != null:
return $default(_that.id,_that.shopSaleId,_that.clientName,_that.clientPhone,_that.totalAmount,_that.paidAmount,_that.discountAmount,_that.saleDate,_that.createdAt,_that.products,_that.staffColor,_that.staffName);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SaleModel implements SaleModel {
  const _SaleModel({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'shop_sale_id') this.shopSaleId, @JsonKey(name: 'client_name') this.clientName, @JsonKey(name: 'client_phone') this.clientPhone, @JsonKey(name: 'total_amount') required this.totalAmount, @JsonKey(name: 'paid_amount') required this.paidAmount, @JsonKey(name: 'discount') required this.discountAmount, @JsonKey(name: 'sale_date') required this.saleDate, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'products') required this.products, @JsonKey(name: 'staff_color', unknownEnumValue: null) this.staffColor, @JsonKey(name: 'staff_name') this.staffName});
  

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'shop_sale_id') final  String? shopSaleId;
@override@JsonKey(name: 'client_name') final  String? clientName;
@override@JsonKey(name: 'client_phone') final  dynamic clientPhone;
// Can be String or int
@override@JsonKey(name: 'total_amount') final  int totalAmount;
@override@JsonKey(name: 'paid_amount') final  int paidAmount;
@override@JsonKey(name: 'discount') final  int discountAmount;
@override@JsonKey(name: 'sale_date') final  String saleDate;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'products') final  String products;
// Changed from List<String> to String
@override@JsonKey(name: 'staff_color', unknownEnumValue: null) final  String? staffColor;
// Note: API sometimes returns "staff_col lor" with space - handled by fromJson
@override@JsonKey(name: 'staff_name') final  String? staffName;

/// Create a copy of SaleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleModelCopyWith<_SaleModel> get copyWith => __$SaleModelCopyWithImpl<_SaleModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopSaleId, shopSaleId) || other.shopSaleId == shopSaleId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&const DeepCollectionEquality().equals(other.clientPhone, clientPhone)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.products, products) || other.products == products)&&(identical(other.staffColor, staffColor) || other.staffColor == staffColor)&&(identical(other.staffName, staffName) || other.staffName == staffName));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopSaleId,clientName,const DeepCollectionEquality().hash(clientPhone),totalAmount,paidAmount,discountAmount,saleDate,createdAt,products,staffColor,staffName);

@override
String toString() {
  return 'SaleModel(id: $id, shopSaleId: $shopSaleId, clientName: $clientName, clientPhone: $clientPhone, totalAmount: $totalAmount, paidAmount: $paidAmount, discountAmount: $discountAmount, saleDate: $saleDate, createdAt: $createdAt, products: $products, staffColor: $staffColor, staffName: $staffName)';
}


}

/// @nodoc
abstract mixin class _$SaleModelCopyWith<$Res> implements $SaleModelCopyWith<$Res> {
  factory _$SaleModelCopyWith(_SaleModel value, $Res Function(_SaleModel) _then) = __$SaleModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'shop_sale_id') String? shopSaleId,@JsonKey(name: 'client_name') String? clientName,@JsonKey(name: 'client_phone') dynamic clientPhone,@JsonKey(name: 'total_amount') int totalAmount,@JsonKey(name: 'paid_amount') int paidAmount,@JsonKey(name: 'discount') int discountAmount,@JsonKey(name: 'sale_date') String saleDate,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'products') String products,@JsonKey(name: 'staff_color', unknownEnumValue: null) String? staffColor,@JsonKey(name: 'staff_name') String? staffName
});




}
/// @nodoc
class __$SaleModelCopyWithImpl<$Res>
    implements _$SaleModelCopyWith<$Res> {
  __$SaleModelCopyWithImpl(this._self, this._then);

  final _SaleModel _self;
  final $Res Function(_SaleModel) _then;

/// Create a copy of SaleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shopSaleId = freezed,Object? clientName = freezed,Object? clientPhone = freezed,Object? totalAmount = null,Object? paidAmount = null,Object? discountAmount = null,Object? saleDate = null,Object? createdAt = null,Object? products = null,Object? staffColor = freezed,Object? staffName = freezed,}) {
  return _then(_SaleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shopSaleId: freezed == shopSaleId ? _self.shopSaleId : shopSaleId // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as dynamic,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int,saleDate: null == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as String,staffColor: freezed == staffColor ? _self.staffColor : staffColor // ignore: cast_nullable_to_non_nullable
as String?,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
