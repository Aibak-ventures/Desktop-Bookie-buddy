// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SalesRequestModel {

@JsonKey(includeToJson: false) int? get id;@JsonKey(name: 'staff_id') int? get staffId;@JsonKey(name: 'client_phone') String? get clientPhone;@JsonKey(name: 'client_address') String? get address;@JsonKey(name: 'sale_date') String? get saleDate;@JsonKey(name: 'variants', toJson: _variantsToJson) List<ProductSelectedModel>? get products;@JsonKey(name: 'decrease_stock') bool? get stockCountDecrease;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'discount') int? get discountAmount;@JsonKey(name: 'paid_amount') int? get paidAmount;@JsonKey(name: 'account_id') int? get accountId;@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) bool get sendPdfToWhatsApp;
/// Create a copy of SalesRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesRequestModelCopyWith<SalesRequestModel> get copyWith => _$SalesRequestModelCopyWithImpl<SalesRequestModel>(this as SalesRequestModel, _$identity);

  /// Serializes this SalesRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.clientPhone, clientPhone) || other.clientPhone == clientPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.stockCountDecrease, stockCountDecrease) || other.stockCountDecrease == stockCountDecrease)&&(identical(other.description, description) || other.description == description)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.sendPdfToWhatsApp, sendPdfToWhatsApp) || other.sendPdfToWhatsApp == sendPdfToWhatsApp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,staffId,clientPhone,address,saleDate,const DeepCollectionEquality().hash(products),stockCountDecrease,description,discountAmount,paidAmount,accountId,sendPdfToWhatsApp);

@override
String toString() {
  return 'SalesRequestModel(id: $id, staffId: $staffId, clientPhone: $clientPhone, address: $address, saleDate: $saleDate, products: $products, stockCountDecrease: $stockCountDecrease, description: $description, discountAmount: $discountAmount, paidAmount: $paidAmount, accountId: $accountId, sendPdfToWhatsApp: $sendPdfToWhatsApp)';
}


}

/// @nodoc
abstract mixin class $SalesRequestModelCopyWith<$Res>  {
  factory $SalesRequestModelCopyWith(SalesRequestModel value, $Res Function(SalesRequestModel) _then) = _$SalesRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) int? id,@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'client_phone') String? clientPhone,@JsonKey(name: 'client_address') String? address,@JsonKey(name: 'sale_date') String? saleDate,@JsonKey(name: 'variants', toJson: _variantsToJson) List<ProductSelectedModel>? products,@JsonKey(name: 'decrease_stock') bool? stockCountDecrease,@JsonKey(name: 'description') String? description,@JsonKey(name: 'discount') int? discountAmount,@JsonKey(name: 'paid_amount') int? paidAmount,@JsonKey(name: 'account_id') int? accountId,@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) bool sendPdfToWhatsApp
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? staffId = freezed,Object? clientPhone = freezed,Object? address = freezed,Object? saleDate = freezed,Object? products = freezed,Object? stockCountDecrease = freezed,Object? description = freezed,Object? discountAmount = freezed,Object? paidAmount = freezed,Object? accountId = freezed,Object? sendPdfToWhatsApp = null,}) {
  return _then(_self.copyWith(
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
as int?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,sendPdfToWhatsApp: null == sendPdfToWhatsApp ? _self.sendPdfToWhatsApp : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int? id, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client_phone')  String? clientPhone, @JsonKey(name: 'client_address')  String? address, @JsonKey(name: 'sale_date')  String? saleDate, @JsonKey(name: 'variants', toJson: _variantsToJson)  List<ProductSelectedModel>? products, @JsonKey(name: 'decrease_stock')  bool? stockCountDecrease, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'discount')  int? discountAmount, @JsonKey(name: 'paid_amount')  int? paidAmount, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)  bool sendPdfToWhatsApp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesRequestModel() when $default != null:
return $default(_that.id,_that.staffId,_that.clientPhone,_that.address,_that.saleDate,_that.products,_that.stockCountDecrease,_that.description,_that.discountAmount,_that.paidAmount,_that.accountId,_that.sendPdfToWhatsApp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int? id, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client_phone')  String? clientPhone, @JsonKey(name: 'client_address')  String? address, @JsonKey(name: 'sale_date')  String? saleDate, @JsonKey(name: 'variants', toJson: _variantsToJson)  List<ProductSelectedModel>? products, @JsonKey(name: 'decrease_stock')  bool? stockCountDecrease, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'discount')  int? discountAmount, @JsonKey(name: 'paid_amount')  int? paidAmount, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)  bool sendPdfToWhatsApp)  $default,) {final _that = this;
switch (_that) {
case _SalesRequestModel():
return $default(_that.id,_that.staffId,_that.clientPhone,_that.address,_that.saleDate,_that.products,_that.stockCountDecrease,_that.description,_that.discountAmount,_that.paidAmount,_that.accountId,_that.sendPdfToWhatsApp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  int? id, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client_phone')  String? clientPhone, @JsonKey(name: 'client_address')  String? address, @JsonKey(name: 'sale_date')  String? saleDate, @JsonKey(name: 'variants', toJson: _variantsToJson)  List<ProductSelectedModel>? products, @JsonKey(name: 'decrease_stock')  bool? stockCountDecrease, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'discount')  int? discountAmount, @JsonKey(name: 'paid_amount')  int? paidAmount, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)  bool sendPdfToWhatsApp)?  $default,) {final _that = this;
switch (_that) {
case _SalesRequestModel() when $default != null:
return $default(_that.id,_that.staffId,_that.clientPhone,_that.address,_that.saleDate,_that.products,_that.stockCountDecrease,_that.description,_that.discountAmount,_that.paidAmount,_that.accountId,_that.sendPdfToWhatsApp);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _SalesRequestModel implements SalesRequestModel {
  const _SalesRequestModel({@JsonKey(includeToJson: false) this.id, @JsonKey(name: 'staff_id') this.staffId, @JsonKey(name: 'client_phone') this.clientPhone, @JsonKey(name: 'client_address') this.address, @JsonKey(name: 'sale_date') this.saleDate, @JsonKey(name: 'variants', toJson: _variantsToJson) final  List<ProductSelectedModel>? products, @JsonKey(name: 'decrease_stock') this.stockCountDecrease, @JsonKey(name: 'description') this.description, @JsonKey(name: 'discount') this.discountAmount, @JsonKey(name: 'paid_amount') this.paidAmount, @JsonKey(name: 'account_id') this.accountId, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) this.sendPdfToWhatsApp = false}): _products = products;
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
@override@JsonKey(name: 'account_id') final  int? accountId;
@override@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) final  bool sendPdfToWhatsApp;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.clientPhone, clientPhone) || other.clientPhone == clientPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.stockCountDecrease, stockCountDecrease) || other.stockCountDecrease == stockCountDecrease)&&(identical(other.description, description) || other.description == description)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.sendPdfToWhatsApp, sendPdfToWhatsApp) || other.sendPdfToWhatsApp == sendPdfToWhatsApp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,staffId,clientPhone,address,saleDate,const DeepCollectionEquality().hash(_products),stockCountDecrease,description,discountAmount,paidAmount,accountId,sendPdfToWhatsApp);

@override
String toString() {
  return 'SalesRequestModel(id: $id, staffId: $staffId, clientPhone: $clientPhone, address: $address, saleDate: $saleDate, products: $products, stockCountDecrease: $stockCountDecrease, description: $description, discountAmount: $discountAmount, paidAmount: $paidAmount, accountId: $accountId, sendPdfToWhatsApp: $sendPdfToWhatsApp)';
}


}

/// @nodoc
abstract mixin class _$SalesRequestModelCopyWith<$Res> implements $SalesRequestModelCopyWith<$Res> {
  factory _$SalesRequestModelCopyWith(_SalesRequestModel value, $Res Function(_SalesRequestModel) _then) = __$SalesRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) int? id,@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'client_phone') String? clientPhone,@JsonKey(name: 'client_address') String? address,@JsonKey(name: 'sale_date') String? saleDate,@JsonKey(name: 'variants', toJson: _variantsToJson) List<ProductSelectedModel>? products,@JsonKey(name: 'decrease_stock') bool? stockCountDecrease,@JsonKey(name: 'description') String? description,@JsonKey(name: 'discount') int? discountAmount,@JsonKey(name: 'paid_amount') int? paidAmount,@JsonKey(name: 'account_id') int? accountId,@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) bool sendPdfToWhatsApp
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? staffId = freezed,Object? clientPhone = freezed,Object? address = freezed,Object? saleDate = freezed,Object? products = freezed,Object? stockCountDecrease = freezed,Object? description = freezed,Object? discountAmount = freezed,Object? paidAmount = freezed,Object? accountId = freezed,Object? sendPdfToWhatsApp = null,}) {
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
as int?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,sendPdfToWhatsApp: null == sendPdfToWhatsApp ? _self.sendPdfToWhatsApp : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
