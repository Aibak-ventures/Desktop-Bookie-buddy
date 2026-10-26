// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SalesRequestModel {

@JsonKey(includeToJson: false) int? get id;@JsonKey(name: 'staff_id') int? get staffId;@JsonKey(name: 'client_phone') String? get clientPhone;@JsonKey(name: 'client_address') String? get address;@JsonKey(name: 'sale_date') String? get saleDate;@JsonKey(name: 'variants', toJson: _variantsToJson) List<ProductSelectedModel>? get products;@JsonKey(name: 'decrease_stock') bool? get stockCountDecrease;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'discount') int? get discountAmount;@JsonKey(name: 'paid_amount') int? get paidAmount;@JsonKey(name: 'payments', toJson: _paymentsToJson) List<SalesPaymentRequestModel>? get payments;@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) bool get sendPdfToWhatsApp;@JsonKey(name: 'apply_tax') bool? get isTaxApplied;
/// Create a copy of SalesRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesRequestModelCopyWith<SalesRequestModel> get copyWith => _$SalesRequestModelCopyWithImpl<SalesRequestModel>(this as SalesRequestModel, _$identity);

  /// Serializes this SalesRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SalesRequestModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesRequestModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.staffId, _this.staffId) || other.staffId == _this.staffId)&&(identical(other.clientPhone, _this.clientPhone) || other.clientPhone == _this.clientPhone)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.saleDate, _this.saleDate) || other.saleDate == _this.saleDate)&&const DeepCollectionEquality().equals(other.products, _this.products)&&(identical(other.stockCountDecrease, _this.stockCountDecrease) || other.stockCountDecrease == _this.stockCountDecrease)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.discountAmount, _this.discountAmount) || other.discountAmount == _this.discountAmount)&&(identical(other.paidAmount, _this.paidAmount) || other.paidAmount == _this.paidAmount)&&const DeepCollectionEquality().equals(other.payments, _this.payments)&&(identical(other.sendPdfToWhatsApp, _this.sendPdfToWhatsApp) || other.sendPdfToWhatsApp == _this.sendPdfToWhatsApp)&&(identical(other.isTaxApplied, _this.isTaxApplied) || other.isTaxApplied == _this.isTaxApplied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SalesRequestModel;
  return Object.hash(runtimeType,_this.id,_this.staffId,_this.clientPhone,_this.address,_this.saleDate,const DeepCollectionEquality().hash(_this.products),_this.stockCountDecrease,_this.description,_this.discountAmount,_this.paidAmount,const DeepCollectionEquality().hash(_this.payments),_this.sendPdfToWhatsApp,_this.isTaxApplied);
}

@override
String toString() {
  final _this = this as SalesRequestModel;
  return 'SalesRequestModel(id: ${_this.id}, staffId: ${_this.staffId}, clientPhone: ${_this.clientPhone}, address: ${_this.address}, saleDate: ${_this.saleDate}, products: ${_this.products}, stockCountDecrease: ${_this.stockCountDecrease}, description: ${_this.description}, discountAmount: ${_this.discountAmount}, paidAmount: ${_this.paidAmount}, payments: ${_this.payments}, sendPdfToWhatsApp: ${_this.sendPdfToWhatsApp}, isTaxApplied: ${_this.isTaxApplied})';
}


}

/// @nodoc
abstract mixin class $SalesRequestModelCopyWith<$Res>  {
  factory $SalesRequestModelCopyWith(SalesRequestModel value, $Res Function(SalesRequestModel) _then) = _$SalesRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) int? id,@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'client_phone') String? clientPhone,@JsonKey(name: 'client_address') String? address,@JsonKey(name: 'sale_date') String? saleDate,@JsonKey(name: 'variants', toJson: _variantsToJson) List<ProductSelectedModel>? products,@JsonKey(name: 'decrease_stock') bool? stockCountDecrease,@JsonKey(name: 'description') String? description,@JsonKey(name: 'discount') int? discountAmount,@JsonKey(name: 'paid_amount') int? paidAmount,@JsonKey(name: 'payments', toJson: _paymentsToJson) List<SalesPaymentRequestModel>? payments,@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) bool sendPdfToWhatsApp,@JsonKey(name: 'apply_tax') bool? isTaxApplied
});




}
/// @nodoc
class _$SalesRequestModelCopyWithImpl<$Res>
    implements $SalesRequestModelCopyWith<$Res> {
  _$SalesRequestModelCopyWithImpl(this._self, this._then);

  final SalesRequestModel _self;
  final $Res Function(SalesRequestModel) _then;

/// Create a copy of SalesRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? staffId = freezed,Object? clientPhone = freezed,Object? address = freezed,Object? saleDate = freezed,Object? products = freezed,Object? stockCountDecrease = freezed,Object? description = freezed,Object? discountAmount = freezed,Object? paidAmount = freezed,Object? payments = freezed,Object? sendPdfToWhatsApp = null,Object? isTaxApplied = freezed,}) {
  return _then(SalesRequestModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,saleDate: freezed == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as String?,products: freezed == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductSelectedModel>?,stockCountDecrease: freezed == stockCountDecrease ? _self.stockCountDecrease : stockCountDecrease // ignore: cast_nullable_to_non_nullable
as bool?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,paidAmount: freezed == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int?,payments: freezed == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<SalesPaymentRequestModel>?,sendPdfToWhatsApp: null == sendPdfToWhatsApp ? _self.sendPdfToWhatsApp : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
as bool,isTaxApplied: freezed == isTaxApplied ? _self.isTaxApplied : isTaxApplied // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesRequestModel].
extension SalesRequestModelPatterns on SalesRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _SalesRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _SalesRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int? id, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client_phone')  String? clientPhone, @JsonKey(name: 'client_address')  String? address, @JsonKey(name: 'sale_date')  String? saleDate, @JsonKey(name: 'variants', toJson: _variantsToJson)  List<ProductSelectedModel>? products, @JsonKey(name: 'decrease_stock')  bool? stockCountDecrease, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'discount')  int? discountAmount, @JsonKey(name: 'paid_amount')  int? paidAmount, @JsonKey(name: 'payments', toJson: _paymentsToJson)  List<SalesPaymentRequestModel>? payments, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)  bool sendPdfToWhatsApp, @JsonKey(name: 'apply_tax')  bool? isTaxApplied)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesRequestModel() when $default != null:
return $default(_that.id,_that.staffId,_that.clientPhone,_that.address,_that.saleDate,_that.products,_that.stockCountDecrease,_that.description,_that.discountAmount,_that.paidAmount,_that.payments,_that.sendPdfToWhatsApp,_that.isTaxApplied);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int? id, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client_phone')  String? clientPhone, @JsonKey(name: 'client_address')  String? address, @JsonKey(name: 'sale_date')  String? saleDate, @JsonKey(name: 'variants', toJson: _variantsToJson)  List<ProductSelectedModel>? products, @JsonKey(name: 'decrease_stock')  bool? stockCountDecrease, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'discount')  int? discountAmount, @JsonKey(name: 'paid_amount')  int? paidAmount, @JsonKey(name: 'payments', toJson: _paymentsToJson)  List<SalesPaymentRequestModel>? payments, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)  bool sendPdfToWhatsApp, @JsonKey(name: 'apply_tax')  bool? isTaxApplied)  $default,) {final _that = this;
switch (_that) {
case _SalesRequestModel():
return $default(_that.id,_that.staffId,_that.clientPhone,_that.address,_that.saleDate,_that.products,_that.stockCountDecrease,_that.description,_that.discountAmount,_that.paidAmount,_that.payments,_that.sendPdfToWhatsApp,_that.isTaxApplied);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  int? id, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client_phone')  String? clientPhone, @JsonKey(name: 'client_address')  String? address, @JsonKey(name: 'sale_date')  String? saleDate, @JsonKey(name: 'variants', toJson: _variantsToJson)  List<ProductSelectedModel>? products, @JsonKey(name: 'decrease_stock')  bool? stockCountDecrease, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'discount')  int? discountAmount, @JsonKey(name: 'paid_amount')  int? paidAmount, @JsonKey(name: 'payments', toJson: _paymentsToJson)  List<SalesPaymentRequestModel>? payments, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)  bool sendPdfToWhatsApp, @JsonKey(name: 'apply_tax')  bool? isTaxApplied)?  $default,) {final _that = this;
switch (_that) {
case _SalesRequestModel() when $default != null:
return $default(_that.id,_that.staffId,_that.clientPhone,_that.address,_that.saleDate,_that.products,_that.stockCountDecrease,_that.description,_that.discountAmount,_that.paidAmount,_that.payments,_that.sendPdfToWhatsApp,_that.isTaxApplied);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _SalesRequestModel implements SalesRequestModel {
  const _SalesRequestModel({@JsonKey(includeToJson: false) this.id, @JsonKey(name: 'staff_id') this.staffId, @JsonKey(name: 'client_phone') this.clientPhone, @JsonKey(name: 'client_address') this.address, @JsonKey(name: 'sale_date') this.saleDate, @JsonKey(name: 'variants', toJson: _variantsToJson)  List<ProductSelectedModel>? products, @JsonKey(name: 'decrease_stock') this.stockCountDecrease, @JsonKey(name: 'description') this.description, @JsonKey(name: 'discount') this.discountAmount, @JsonKey(name: 'paid_amount') this.paidAmount, @JsonKey(name: 'payments', toJson: _paymentsToJson)  List<SalesPaymentRequestModel>? payments, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) this.sendPdfToWhatsApp = false, @JsonKey(name: 'apply_tax') this.isTaxApplied}): _products = products,_payments = payments;
  factory _SalesRequestModel.fromJson(Map<String, dynamic> json) => _$SalesRequestModelFromJson(json);

@override@JsonKey(includeToJson: false) final  int? id;
@override@JsonKey(name: 'staff_id') final  int? staffId;
@override@JsonKey(name: 'client_phone') final  String? clientPhone;
@override@JsonKey(name: 'client_address') final  String? address;
@override@JsonKey(name: 'sale_date') final  String? saleDate;
 final  List<ProductSelectedModel>? _products;
@override@JsonKey(name: 'variants', toJson: _variantsToJson) List<ProductSelectedModel>? get products {
  final value = _products;
  if (value == null) return null;
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'decrease_stock') final  bool? stockCountDecrease;
@override@JsonKey(name: 'description') final  String? description;
@override@JsonKey(name: 'discount') final  int? discountAmount;
@override@JsonKey(name: 'paid_amount') final  int? paidAmount;
 final  List<SalesPaymentRequestModel>? _payments;
@override@JsonKey(name: 'payments', toJson: _paymentsToJson) List<SalesPaymentRequestModel>? get payments {
  final value = _payments;
  if (value == null) return null;
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) final  bool sendPdfToWhatsApp;
@override@JsonKey(name: 'apply_tax') final  bool? isTaxApplied;

/// Create a copy of SalesRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesRequestModelCopyWith<_SalesRequestModel> get copyWith => __$SalesRequestModelCopyWithImpl<_SalesRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SalesRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.clientPhone, clientPhone) || other.clientPhone == clientPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&const DeepCollectionEquality().equals(other.products, _products)&&(identical(other.stockCountDecrease, stockCountDecrease) || other.stockCountDecrease == stockCountDecrease)&&(identical(other.description, description) || other.description == description)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&const DeepCollectionEquality().equals(other.payments, _payments)&&(identical(other.sendPdfToWhatsApp, sendPdfToWhatsApp) || other.sendPdfToWhatsApp == sendPdfToWhatsApp)&&(identical(other.isTaxApplied, isTaxApplied) || other.isTaxApplied == isTaxApplied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,staffId,clientPhone,address,saleDate,const DeepCollectionEquality().hash(_products),stockCountDecrease,description,discountAmount,paidAmount,const DeepCollectionEquality().hash(_payments),sendPdfToWhatsApp,isTaxApplied);
}

@override
String toString() {
    return 'SalesRequestModel(id: $id, staffId: $staffId, clientPhone: $clientPhone, address: $address, saleDate: $saleDate, products: $products, stockCountDecrease: $stockCountDecrease, description: $description, discountAmount: $discountAmount, paidAmount: $paidAmount, payments: $payments, sendPdfToWhatsApp: $sendPdfToWhatsApp, isTaxApplied: $isTaxApplied)';
}


}

/// @nodoc
abstract mixin class _$SalesRequestModelCopyWith<$Res> implements $SalesRequestModelCopyWith<$Res> {
  factory _$SalesRequestModelCopyWith(_SalesRequestModel value, $Res Function(_SalesRequestModel) _then) = __$SalesRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) int? id,@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'client_phone') String? clientPhone,@JsonKey(name: 'client_address') String? address,@JsonKey(name: 'sale_date') String? saleDate,@JsonKey(name: 'variants', toJson: _variantsToJson) List<ProductSelectedModel>? products,@JsonKey(name: 'decrease_stock') bool? stockCountDecrease,@JsonKey(name: 'description') String? description,@JsonKey(name: 'discount') int? discountAmount,@JsonKey(name: 'paid_amount') int? paidAmount,@JsonKey(name: 'payments', toJson: _paymentsToJson) List<SalesPaymentRequestModel>? payments,@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) bool sendPdfToWhatsApp,@JsonKey(name: 'apply_tax') bool? isTaxApplied
});




}
/// @nodoc
class __$SalesRequestModelCopyWithImpl<$Res>
    implements _$SalesRequestModelCopyWith<$Res> {
  __$SalesRequestModelCopyWithImpl(this._self, this._then);

  final _SalesRequestModel _self;
  final $Res Function(_SalesRequestModel) _then;

/// Create a copy of SalesRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? staffId = freezed,Object? clientPhone = freezed,Object? address = freezed,Object? saleDate = freezed,Object? products = freezed,Object? stockCountDecrease = freezed,Object? description = freezed,Object? discountAmount = freezed,Object? paidAmount = freezed,Object? payments = freezed,Object? sendPdfToWhatsApp = null,Object? isTaxApplied = freezed,}) {
  return _then(_SalesRequestModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,saleDate: freezed == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as String?,products: freezed == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductSelectedModel>?,stockCountDecrease: freezed == stockCountDecrease ? _self.stockCountDecrease : stockCountDecrease // ignore: cast_nullable_to_non_nullable
as bool?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,paidAmount: freezed == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int?,payments: freezed == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<SalesPaymentRequestModel>?,sendPdfToWhatsApp: null == sendPdfToWhatsApp ? _self.sendPdfToWhatsApp : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
as bool,isTaxApplied: freezed == isTaxApplied ? _self.isTaxApplied : isTaxApplied // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
