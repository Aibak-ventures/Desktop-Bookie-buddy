// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SaleEntity {

 int get id; String? get shopSaleId; String? get clientName; dynamic get clientPhone; int get totalAmount; int get paidAmount; int get discountAmount; String get saleDate; String get createdAt; String get products; String? get staffColor; String? get staffName;
/// Create a copy of SaleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleEntityCopyWith<SaleEntity> get copyWith => _$SaleEntityCopyWithImpl<SaleEntity>(this as SaleEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.shopSaleId, shopSaleId) || other.shopSaleId == shopSaleId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&const DeepCollectionEquality().equals(other.clientPhone, clientPhone)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.products, products) || other.products == products)&&(identical(other.staffColor, staffColor) || other.staffColor == staffColor)&&(identical(other.staffName, staffName) || other.staffName == staffName));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopSaleId,clientName,const DeepCollectionEquality().hash(clientPhone),totalAmount,paidAmount,discountAmount,saleDate,createdAt,products,staffColor,staffName);

@override
String toString() {
  return 'SaleEntity(id: $id, shopSaleId: $shopSaleId, clientName: $clientName, clientPhone: $clientPhone, totalAmount: $totalAmount, paidAmount: $paidAmount, discountAmount: $discountAmount, saleDate: $saleDate, createdAt: $createdAt, products: $products, staffColor: $staffColor, staffName: $staffName)';
}


}

/// @nodoc
abstract mixin class $SaleEntityCopyWith<$Res>  {
  factory $SaleEntityCopyWith(SaleEntity value, $Res Function(SaleEntity) _then) = _$SaleEntityCopyWithImpl;
@useResult
$Res call({
 int id, String? shopSaleId, String? clientName, dynamic clientPhone, int totalAmount, int paidAmount, int discountAmount, String saleDate, String createdAt, String products, String? staffColor, String? staffName
});




}
/// @nodoc
class _$SaleEntityCopyWithImpl<$Res>
    implements $SaleEntityCopyWith<$Res> {
  _$SaleEntityCopyWithImpl(this._self, this._then);

  final SaleEntity _self;
  final $Res Function(SaleEntity) _then;

/// Create a copy of SaleEntity
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


/// Adds pattern-matching-related methods to [SaleEntity].
extension SaleEntityPatterns on SaleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleEntity value)  $default,){
final _that = this;
switch (_that) {
case _SaleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SaleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? shopSaleId,  String? clientName,  dynamic clientPhone,  int totalAmount,  int paidAmount,  int discountAmount,  String saleDate,  String createdAt,  String products,  String? staffColor,  String? staffName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? shopSaleId,  String? clientName,  dynamic clientPhone,  int totalAmount,  int paidAmount,  int discountAmount,  String saleDate,  String createdAt,  String products,  String? staffColor,  String? staffName)  $default,) {final _that = this;
switch (_that) {
case _SaleEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? shopSaleId,  String? clientName,  dynamic clientPhone,  int totalAmount,  int paidAmount,  int discountAmount,  String saleDate,  String createdAt,  String products,  String? staffColor,  String? staffName)?  $default,) {final _that = this;
switch (_that) {
case _SaleEntity() when $default != null:
return $default(_that.id,_that.shopSaleId,_that.clientName,_that.clientPhone,_that.totalAmount,_that.paidAmount,_that.discountAmount,_that.saleDate,_that.createdAt,_that.products,_that.staffColor,_that.staffName);case _:
  return null;

}
}

}

/// @nodoc


class _SaleEntity implements SaleEntity {
  const _SaleEntity({required this.id, this.shopSaleId, this.clientName, this.clientPhone, required this.totalAmount, required this.paidAmount, required this.discountAmount, required this.saleDate, required this.createdAt, required this.products, this.staffColor, this.staffName});
  

@override final  int id;
@override final  String? shopSaleId;
@override final  String? clientName;
@override final  dynamic clientPhone;
@override final  int totalAmount;
@override final  int paidAmount;
@override final  int discountAmount;
@override final  String saleDate;
@override final  String createdAt;
@override final  String products;
@override final  String? staffColor;
@override final  String? staffName;

/// Create a copy of SaleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleEntityCopyWith<_SaleEntity> get copyWith => __$SaleEntityCopyWithImpl<_SaleEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.shopSaleId, shopSaleId) || other.shopSaleId == shopSaleId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&const DeepCollectionEquality().equals(other.clientPhone, clientPhone)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.products, products) || other.products == products)&&(identical(other.staffColor, staffColor) || other.staffColor == staffColor)&&(identical(other.staffName, staffName) || other.staffName == staffName));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopSaleId,clientName,const DeepCollectionEquality().hash(clientPhone),totalAmount,paidAmount,discountAmount,saleDate,createdAt,products,staffColor,staffName);

@override
String toString() {
  return 'SaleEntity(id: $id, shopSaleId: $shopSaleId, clientName: $clientName, clientPhone: $clientPhone, totalAmount: $totalAmount, paidAmount: $paidAmount, discountAmount: $discountAmount, saleDate: $saleDate, createdAt: $createdAt, products: $products, staffColor: $staffColor, staffName: $staffName)';
}


}

/// @nodoc
abstract mixin class _$SaleEntityCopyWith<$Res> implements $SaleEntityCopyWith<$Res> {
  factory _$SaleEntityCopyWith(_SaleEntity value, $Res Function(_SaleEntity) _then) = __$SaleEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String? shopSaleId, String? clientName, dynamic clientPhone, int totalAmount, int paidAmount, int discountAmount, String saleDate, String createdAt, String products, String? staffColor, String? staffName
});




}
/// @nodoc
class __$SaleEntityCopyWithImpl<$Res>
    implements _$SaleEntityCopyWith<$Res> {
  __$SaleEntityCopyWithImpl(this._self, this._then);

  final _SaleEntity _self;
  final $Res Function(_SaleEntity) _then;

/// Create a copy of SaleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shopSaleId = freezed,Object? clientName = freezed,Object? clientPhone = freezed,Object? totalAmount = null,Object? paidAmount = null,Object? discountAmount = null,Object? saleDate = null,Object? createdAt = null,Object? products = null,Object? staffColor = freezed,Object? staffName = freezed,}) {
  return _then(_SaleEntity(
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
