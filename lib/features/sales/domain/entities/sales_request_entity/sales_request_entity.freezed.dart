// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalesRequestEntity {

 int? get id; int? get staffId; String? get clientPhone; String? get address; String? get saleDate; List<ProductSelectedEntity>? get products; bool? get stockCountDecrease; String? get description; int? get discountAmount; int? get paidAmount; PaymentMethod? get paymentMethod; bool get sendPdfToWhatsApp;
/// Create a copy of SalesRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesRequestEntityCopyWith<SalesRequestEntity> get copyWith => _$SalesRequestEntityCopyWithImpl<SalesRequestEntity>(this as SalesRequestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesRequestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.clientPhone, clientPhone) || other.clientPhone == clientPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.stockCountDecrease, stockCountDecrease) || other.stockCountDecrease == stockCountDecrease)&&(identical(other.description, description) || other.description == description)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.sendPdfToWhatsApp, sendPdfToWhatsApp) || other.sendPdfToWhatsApp == sendPdfToWhatsApp));
}


@override
int get hashCode => Object.hash(runtimeType,id,staffId,clientPhone,address,saleDate,const DeepCollectionEquality().hash(products),stockCountDecrease,description,discountAmount,paidAmount,paymentMethod,sendPdfToWhatsApp);

@override
String toString() {
  return 'SalesRequestEntity(id: $id, staffId: $staffId, clientPhone: $clientPhone, address: $address, saleDate: $saleDate, products: $products, stockCountDecrease: $stockCountDecrease, description: $description, discountAmount: $discountAmount, paidAmount: $paidAmount, paymentMethod: $paymentMethod, sendPdfToWhatsApp: $sendPdfToWhatsApp)';
}


}

/// @nodoc
abstract mixin class $SalesRequestEntityCopyWith<$Res>  {
  factory $SalesRequestEntityCopyWith(SalesRequestEntity value, $Res Function(SalesRequestEntity) _then) = _$SalesRequestEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int? staffId, String? clientPhone, String? address, String? saleDate, List<ProductSelectedEntity>? products, bool? stockCountDecrease, String? description, int? discountAmount, int? paidAmount, PaymentMethod? paymentMethod, bool sendPdfToWhatsApp
});




}
/// @nodoc
class _$SalesRequestEntityCopyWithImpl<$Res>
    implements $SalesRequestEntityCopyWith<$Res> {
  _$SalesRequestEntityCopyWithImpl(this._self, this._then);

  final SalesRequestEntity _self;
  final $Res Function(SalesRequestEntity) _then;

/// Create a copy of SalesRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? staffId = freezed,Object? clientPhone = freezed,Object? address = freezed,Object? saleDate = freezed,Object? products = freezed,Object? stockCountDecrease = freezed,Object? description = freezed,Object? discountAmount = freezed,Object? paidAmount = freezed,Object? paymentMethod = freezed,Object? sendPdfToWhatsApp = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,saleDate: freezed == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as String?,products: freezed == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductSelectedEntity>?,stockCountDecrease: freezed == stockCountDecrease ? _self.stockCountDecrease : stockCountDecrease // ignore: cast_nullable_to_non_nullable
as bool?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,paidAmount: freezed == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,sendPdfToWhatsApp: null == sendPdfToWhatsApp ? _self.sendPdfToWhatsApp : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesRequestEntity].
extension SalesRequestEntityPatterns on SalesRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _SalesRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SalesRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? staffId,  String? clientPhone,  String? address,  String? saleDate,  List<ProductSelectedEntity>? products,  bool? stockCountDecrease,  String? description,  int? discountAmount,  int? paidAmount,  PaymentMethod? paymentMethod,  bool sendPdfToWhatsApp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesRequestEntity() when $default != null:
return $default(_that.id,_that.staffId,_that.clientPhone,_that.address,_that.saleDate,_that.products,_that.stockCountDecrease,_that.description,_that.discountAmount,_that.paidAmount,_that.paymentMethod,_that.sendPdfToWhatsApp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? staffId,  String? clientPhone,  String? address,  String? saleDate,  List<ProductSelectedEntity>? products,  bool? stockCountDecrease,  String? description,  int? discountAmount,  int? paidAmount,  PaymentMethod? paymentMethod,  bool sendPdfToWhatsApp)  $default,) {final _that = this;
switch (_that) {
case _SalesRequestEntity():
return $default(_that.id,_that.staffId,_that.clientPhone,_that.address,_that.saleDate,_that.products,_that.stockCountDecrease,_that.description,_that.discountAmount,_that.paidAmount,_that.paymentMethod,_that.sendPdfToWhatsApp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? staffId,  String? clientPhone,  String? address,  String? saleDate,  List<ProductSelectedEntity>? products,  bool? stockCountDecrease,  String? description,  int? discountAmount,  int? paidAmount,  PaymentMethod? paymentMethod,  bool sendPdfToWhatsApp)?  $default,) {final _that = this;
switch (_that) {
case _SalesRequestEntity() when $default != null:
return $default(_that.id,_that.staffId,_that.clientPhone,_that.address,_that.saleDate,_that.products,_that.stockCountDecrease,_that.description,_that.discountAmount,_that.paidAmount,_that.paymentMethod,_that.sendPdfToWhatsApp);case _:
  return null;

}
}

}

/// @nodoc


class _SalesRequestEntity implements SalesRequestEntity {
  const _SalesRequestEntity({this.id, this.staffId, this.clientPhone, this.address, this.saleDate, final  List<ProductSelectedEntity>? products, this.stockCountDecrease, this.description, this.discountAmount, this.paidAmount, this.paymentMethod, this.sendPdfToWhatsApp = false}): _products = products;
  

@override final  int? id;
@override final  int? staffId;
@override final  String? clientPhone;
@override final  String? address;
@override final  String? saleDate;
 final  List<ProductSelectedEntity>? _products;
@override List<ProductSelectedEntity>? get products {
  final value = _products;
  if (value == null) return null;
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool? stockCountDecrease;
@override final  String? description;
@override final  int? discountAmount;
@override final  int? paidAmount;
@override final  PaymentMethod? paymentMethod;
@override@JsonKey() final  bool sendPdfToWhatsApp;

/// Create a copy of SalesRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesRequestEntityCopyWith<_SalesRequestEntity> get copyWith => __$SalesRequestEntityCopyWithImpl<_SalesRequestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesRequestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.clientPhone, clientPhone) || other.clientPhone == clientPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.stockCountDecrease, stockCountDecrease) || other.stockCountDecrease == stockCountDecrease)&&(identical(other.description, description) || other.description == description)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.sendPdfToWhatsApp, sendPdfToWhatsApp) || other.sendPdfToWhatsApp == sendPdfToWhatsApp));
}


@override
int get hashCode => Object.hash(runtimeType,id,staffId,clientPhone,address,saleDate,const DeepCollectionEquality().hash(_products),stockCountDecrease,description,discountAmount,paidAmount,paymentMethod,sendPdfToWhatsApp);

@override
String toString() {
  return 'SalesRequestEntity(id: $id, staffId: $staffId, clientPhone: $clientPhone, address: $address, saleDate: $saleDate, products: $products, stockCountDecrease: $stockCountDecrease, description: $description, discountAmount: $discountAmount, paidAmount: $paidAmount, paymentMethod: $paymentMethod, sendPdfToWhatsApp: $sendPdfToWhatsApp)';
}


}

/// @nodoc
abstract mixin class _$SalesRequestEntityCopyWith<$Res> implements $SalesRequestEntityCopyWith<$Res> {
  factory _$SalesRequestEntityCopyWith(_SalesRequestEntity value, $Res Function(_SalesRequestEntity) _then) = __$SalesRequestEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? staffId, String? clientPhone, String? address, String? saleDate, List<ProductSelectedEntity>? products, bool? stockCountDecrease, String? description, int? discountAmount, int? paidAmount, PaymentMethod? paymentMethod, bool sendPdfToWhatsApp
});




}
/// @nodoc
class __$SalesRequestEntityCopyWithImpl<$Res>
    implements _$SalesRequestEntityCopyWith<$Res> {
  __$SalesRequestEntityCopyWithImpl(this._self, this._then);

  final _SalesRequestEntity _self;
  final $Res Function(_SalesRequestEntity) _then;

/// Create a copy of SalesRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? staffId = freezed,Object? clientPhone = freezed,Object? address = freezed,Object? saleDate = freezed,Object? products = freezed,Object? stockCountDecrease = freezed,Object? description = freezed,Object? discountAmount = freezed,Object? paidAmount = freezed,Object? paymentMethod = freezed,Object? sendPdfToWhatsApp = null,}) {
  return _then(_SalesRequestEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,saleDate: freezed == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as String?,products: freezed == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductSelectedEntity>?,stockCountDecrease: freezed == stockCountDecrease ? _self.stockCountDecrease : stockCountDecrease // ignore: cast_nullable_to_non_nullable
as bool?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,paidAmount: freezed == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,sendPdfToWhatsApp: null == sendPdfToWhatsApp ? _self.sendPdfToWhatsApp : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
