// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_sales_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestSalesModel {

@JsonKey(name: 'staff_id') int? get staffId;@JsonKey(name: 'client_phone') String? get clientPhone;@JsonKey(name: 'client_address') String? get clientAddress;@JsonKey(name: 'sale_date') String? get saleDate;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'send_invoice') bool get sendInvoice;@JsonKey(name: 'variants') List<Map<String, dynamic>>? get variants;@JsonKey(name: 'paid_amount') int? get paidAmount;@JsonKey(name: 'account_id') int? get accountId;@JsonKey(name: 'discount') int? get discount;@JsonKey(name: 'decrease_stock') bool get decreaseStock;
/// Create a copy of RequestSalesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestSalesModelCopyWith<RequestSalesModel> get copyWith => _$RequestSalesModelCopyWithImpl<RequestSalesModel>(this as RequestSalesModel, _$identity);

  /// Serializes this RequestSalesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestSalesModel&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.clientPhone, clientPhone) || other.clientPhone == clientPhone)&&(identical(other.clientAddress, clientAddress) || other.clientAddress == clientAddress)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.sendInvoice, sendInvoice) || other.sendInvoice == sendInvoice)&&const DeepCollectionEquality().equals(other.variants, variants)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.decreaseStock, decreaseStock) || other.decreaseStock == decreaseStock));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,staffId,clientPhone,clientAddress,saleDate,description,sendInvoice,const DeepCollectionEquality().hash(variants),paidAmount,accountId,discount,decreaseStock);

@override
String toString() {
  return 'RequestSalesModel(staffId: $staffId, clientPhone: $clientPhone, clientAddress: $clientAddress, saleDate: $saleDate, description: $description, sendInvoice: $sendInvoice, variants: $variants, paidAmount: $paidAmount, accountId: $accountId, discount: $discount, decreaseStock: $decreaseStock)';
}


}

/// @nodoc
abstract mixin class $RequestSalesModelCopyWith<$Res>  {
  factory $RequestSalesModelCopyWith(RequestSalesModel value, $Res Function(RequestSalesModel) _then) = _$RequestSalesModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'client_phone') String? clientPhone,@JsonKey(name: 'client_address') String? clientAddress,@JsonKey(name: 'sale_date') String? saleDate,@JsonKey(name: 'description') String? description,@JsonKey(name: 'send_invoice') bool sendInvoice,@JsonKey(name: 'variants') List<Map<String, dynamic>>? variants,@JsonKey(name: 'paid_amount') int? paidAmount,@JsonKey(name: 'account_id') int? accountId,@JsonKey(name: 'discount') int? discount,@JsonKey(name: 'decrease_stock') bool decreaseStock
});




}
/// @nodoc
class _$RequestSalesModelCopyWithImpl<$Res>
    implements $RequestSalesModelCopyWith<$Res> {
  _$RequestSalesModelCopyWithImpl(this._self, this._then);

  final RequestSalesModel _self;
  final $Res Function(RequestSalesModel) _then;

/// Create a copy of RequestSalesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? staffId = freezed,Object? clientPhone = freezed,Object? clientAddress = freezed,Object? saleDate = freezed,Object? description = freezed,Object? sendInvoice = null,Object? variants = freezed,Object? paidAmount = freezed,Object? accountId = freezed,Object? discount = freezed,Object? decreaseStock = null,}) {
  return _then(_self.copyWith(
staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as String?,clientAddress: freezed == clientAddress ? _self.clientAddress : clientAddress // ignore: cast_nullable_to_non_nullable
as String?,saleDate: freezed == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sendInvoice: null == sendInvoice ? _self.sendInvoice : sendInvoice // ignore: cast_nullable_to_non_nullable
as bool,variants: freezed == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,paidAmount: freezed == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,discount: freezed == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int?,decreaseStock: null == decreaseStock ? _self.decreaseStock : decreaseStock // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestSalesModel].
extension RequestSalesModelPatterns on RequestSalesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestSalesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestSalesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestSalesModel value)  $default,){
final _that = this;
switch (_that) {
case _RequestSalesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestSalesModel value)?  $default,){
final _that = this;
switch (_that) {
case _RequestSalesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client_phone')  String? clientPhone, @JsonKey(name: 'client_address')  String? clientAddress, @JsonKey(name: 'sale_date')  String? saleDate, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'send_invoice')  bool sendInvoice, @JsonKey(name: 'variants')  List<Map<String, dynamic>>? variants, @JsonKey(name: 'paid_amount')  int? paidAmount, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'discount')  int? discount, @JsonKey(name: 'decrease_stock')  bool decreaseStock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestSalesModel() when $default != null:
return $default(_that.staffId,_that.clientPhone,_that.clientAddress,_that.saleDate,_that.description,_that.sendInvoice,_that.variants,_that.paidAmount,_that.accountId,_that.discount,_that.decreaseStock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client_phone')  String? clientPhone, @JsonKey(name: 'client_address')  String? clientAddress, @JsonKey(name: 'sale_date')  String? saleDate, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'send_invoice')  bool sendInvoice, @JsonKey(name: 'variants')  List<Map<String, dynamic>>? variants, @JsonKey(name: 'paid_amount')  int? paidAmount, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'discount')  int? discount, @JsonKey(name: 'decrease_stock')  bool decreaseStock)  $default,) {final _that = this;
switch (_that) {
case _RequestSalesModel():
return $default(_that.staffId,_that.clientPhone,_that.clientAddress,_that.saleDate,_that.description,_that.sendInvoice,_that.variants,_that.paidAmount,_that.accountId,_that.discount,_that.decreaseStock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client_phone')  String? clientPhone, @JsonKey(name: 'client_address')  String? clientAddress, @JsonKey(name: 'sale_date')  String? saleDate, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'send_invoice')  bool sendInvoice, @JsonKey(name: 'variants')  List<Map<String, dynamic>>? variants, @JsonKey(name: 'paid_amount')  int? paidAmount, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'discount')  int? discount, @JsonKey(name: 'decrease_stock')  bool decreaseStock)?  $default,) {final _that = this;
switch (_that) {
case _RequestSalesModel() when $default != null:
return $default(_that.staffId,_that.clientPhone,_that.clientAddress,_that.saleDate,_that.description,_that.sendInvoice,_that.variants,_that.paidAmount,_that.accountId,_that.discount,_that.decreaseStock);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _RequestSalesModel implements RequestSalesModel {
  const _RequestSalesModel({@JsonKey(name: 'staff_id') this.staffId, @JsonKey(name: 'client_phone') this.clientPhone, @JsonKey(name: 'client_address') this.clientAddress, @JsonKey(name: 'sale_date') this.saleDate, @JsonKey(name: 'description') this.description, @JsonKey(name: 'send_invoice') this.sendInvoice = false, @JsonKey(name: 'variants') final  List<Map<String, dynamic>>? variants, @JsonKey(name: 'paid_amount') this.paidAmount, @JsonKey(name: 'account_id') this.accountId, @JsonKey(name: 'discount') this.discount, @JsonKey(name: 'decrease_stock') this.decreaseStock = false}): _variants = variants;
  factory _RequestSalesModel.fromJson(Map<String, dynamic> json) => _$RequestSalesModelFromJson(json);

@override@JsonKey(name: 'staff_id') final  int? staffId;
@override@JsonKey(name: 'client_phone') final  String? clientPhone;
@override@JsonKey(name: 'client_address') final  String? clientAddress;
@override@JsonKey(name: 'sale_date') final  String? saleDate;
@override@JsonKey(name: 'description') final  String? description;
@override@JsonKey(name: 'send_invoice') final  bool sendInvoice;
 final  List<Map<String, dynamic>>? _variants;
@override@JsonKey(name: 'variants') List<Map<String, dynamic>>? get variants {
  final value = _variants;
  if (value == null) return null;
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'paid_amount') final  int? paidAmount;
@override@JsonKey(name: 'account_id') final  int? accountId;
@override@JsonKey(name: 'discount') final  int? discount;
@override@JsonKey(name: 'decrease_stock') final  bool decreaseStock;

/// Create a copy of RequestSalesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestSalesModelCopyWith<_RequestSalesModel> get copyWith => __$RequestSalesModelCopyWithImpl<_RequestSalesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestSalesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestSalesModel&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.clientPhone, clientPhone) || other.clientPhone == clientPhone)&&(identical(other.clientAddress, clientAddress) || other.clientAddress == clientAddress)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.sendInvoice, sendInvoice) || other.sendInvoice == sendInvoice)&&const DeepCollectionEquality().equals(other._variants, _variants)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.decreaseStock, decreaseStock) || other.decreaseStock == decreaseStock));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,staffId,clientPhone,clientAddress,saleDate,description,sendInvoice,const DeepCollectionEquality().hash(_variants),paidAmount,accountId,discount,decreaseStock);

@override
String toString() {
  return 'RequestSalesModel(staffId: $staffId, clientPhone: $clientPhone, clientAddress: $clientAddress, saleDate: $saleDate, description: $description, sendInvoice: $sendInvoice, variants: $variants, paidAmount: $paidAmount, accountId: $accountId, discount: $discount, decreaseStock: $decreaseStock)';
}


}

/// @nodoc
abstract mixin class _$RequestSalesModelCopyWith<$Res> implements $RequestSalesModelCopyWith<$Res> {
  factory _$RequestSalesModelCopyWith(_RequestSalesModel value, $Res Function(_RequestSalesModel) _then) = __$RequestSalesModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'client_phone') String? clientPhone,@JsonKey(name: 'client_address') String? clientAddress,@JsonKey(name: 'sale_date') String? saleDate,@JsonKey(name: 'description') String? description,@JsonKey(name: 'send_invoice') bool sendInvoice,@JsonKey(name: 'variants') List<Map<String, dynamic>>? variants,@JsonKey(name: 'paid_amount') int? paidAmount,@JsonKey(name: 'account_id') int? accountId,@JsonKey(name: 'discount') int? discount,@JsonKey(name: 'decrease_stock') bool decreaseStock
});




}
/// @nodoc
class __$RequestSalesModelCopyWithImpl<$Res>
    implements _$RequestSalesModelCopyWith<$Res> {
  __$RequestSalesModelCopyWithImpl(this._self, this._then);

  final _RequestSalesModel _self;
  final $Res Function(_RequestSalesModel) _then;

/// Create a copy of RequestSalesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? staffId = freezed,Object? clientPhone = freezed,Object? clientAddress = freezed,Object? saleDate = freezed,Object? description = freezed,Object? sendInvoice = null,Object? variants = freezed,Object? paidAmount = freezed,Object? accountId = freezed,Object? discount = freezed,Object? decreaseStock = null,}) {
  return _then(_RequestSalesModel(
staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as String?,clientAddress: freezed == clientAddress ? _self.clientAddress : clientAddress // ignore: cast_nullable_to_non_nullable
as String?,saleDate: freezed == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sendInvoice: null == sendInvoice ? _self.sendInvoice : sendInvoice // ignore: cast_nullable_to_non_nullable
as bool,variants: freezed == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,paidAmount: freezed == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,discount: freezed == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int?,decreaseStock: null == decreaseStock ? _self.decreaseStock : decreaseStock // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
