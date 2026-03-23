// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'desktop_booking_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DesktopBookingItemModel {

 int get id;@JsonKey(name: 'shop_booking_id') String get shopBookingId; String get client;@JsonKey(name: 'pickup_date') String get pickupDate;@JsonKey(name: 'return_date') String get returnDate;@JsonKey(name: 'payment_status', fromJson: _paymentStatusFromBool, toJson: _paymentStatusToBool) bool get paymentStatus;@JsonKey(name: 'staff_name') String? get staffName;@JsonKey(name: 'staff_color') String? get staffColor;@JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson) DeliveryStatus? get deliveryStatus;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'booked_items') String get bookedItems;@JsonKey(name: 'advance_amount') int get advanceAmount;@JsonKey(name: 'remaining_amount') int get remainingAmount;
/// Create a copy of DesktopBookingItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DesktopBookingItemModelCopyWith<DesktopBookingItemModel> get copyWith => _$DesktopBookingItemModelCopyWithImpl<DesktopBookingItemModel>(this as DesktopBookingItemModel, _$identity);

  /// Serializes this DesktopBookingItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DesktopBookingItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopBookingId, shopBookingId) || other.shopBookingId == shopBookingId)&&(identical(other.client, client) || other.client == client)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.staffColor, staffColor) || other.staffColor == staffColor)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.bookedItems, bookedItems) || other.bookedItems == bookedItems)&&(identical(other.advanceAmount, advanceAmount) || other.advanceAmount == advanceAmount)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shopBookingId,client,pickupDate,returnDate,paymentStatus,staffName,staffColor,deliveryStatus,createdAt,bookedItems,advanceAmount,remainingAmount);

@override
String toString() {
  return 'DesktopBookingItemModel(id: $id, shopBookingId: $shopBookingId, client: $client, pickupDate: $pickupDate, returnDate: $returnDate, paymentStatus: $paymentStatus, staffName: $staffName, staffColor: $staffColor, deliveryStatus: $deliveryStatus, createdAt: $createdAt, bookedItems: $bookedItems, advanceAmount: $advanceAmount, remainingAmount: $remainingAmount)';
}


}

/// @nodoc
abstract mixin class $DesktopBookingItemModelCopyWith<$Res>  {
  factory $DesktopBookingItemModelCopyWith(DesktopBookingItemModel value, $Res Function(DesktopBookingItemModel) _then) = _$DesktopBookingItemModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'shop_booking_id') String shopBookingId, String client,@JsonKey(name: 'pickup_date') String pickupDate,@JsonKey(name: 'return_date') String returnDate,@JsonKey(name: 'payment_status', fromJson: _paymentStatusFromBool, toJson: _paymentStatusToBool) bool paymentStatus,@JsonKey(name: 'staff_name') String? staffName,@JsonKey(name: 'staff_color') String? staffColor,@JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson) DeliveryStatus? deliveryStatus,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'booked_items') String bookedItems,@JsonKey(name: 'advance_amount') int advanceAmount,@JsonKey(name: 'remaining_amount') int remainingAmount
});




}
/// @nodoc
class _$DesktopBookingItemModelCopyWithImpl<$Res>
    implements $DesktopBookingItemModelCopyWith<$Res> {
  _$DesktopBookingItemModelCopyWithImpl(this._self, this._then);

  final DesktopBookingItemModel _self;
  final $Res Function(DesktopBookingItemModel) _then;

/// Create a copy of DesktopBookingItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shopBookingId = null,Object? client = null,Object? pickupDate = null,Object? returnDate = null,Object? paymentStatus = null,Object? staffName = freezed,Object? staffColor = freezed,Object? deliveryStatus = freezed,Object? createdAt = null,Object? bookedItems = null,Object? advanceAmount = null,Object? remainingAmount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shopBookingId: null == shopBookingId ? _self.shopBookingId : shopBookingId // ignore: cast_nullable_to_non_nullable
as String,client: null == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as String,pickupDate: null == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String,returnDate: null == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as bool,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,staffColor: freezed == staffColor ? _self.staffColor : staffColor // ignore: cast_nullable_to_non_nullable
as String?,deliveryStatus: freezed == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,bookedItems: null == bookedItems ? _self.bookedItems : bookedItems // ignore: cast_nullable_to_non_nullable
as String,advanceAmount: null == advanceAmount ? _self.advanceAmount : advanceAmount // ignore: cast_nullable_to_non_nullable
as int,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DesktopBookingItemModel].
extension DesktopBookingItemModelPatterns on DesktopBookingItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DesktopBookingItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DesktopBookingItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DesktopBookingItemModel value)  $default,){
final _that = this;
switch (_that) {
case _DesktopBookingItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DesktopBookingItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _DesktopBookingItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'shop_booking_id')  String shopBookingId,  String client, @JsonKey(name: 'pickup_date')  String pickupDate, @JsonKey(name: 'return_date')  String returnDate, @JsonKey(name: 'payment_status', fromJson: _paymentStatusFromBool, toJson: _paymentStatusToBool)  bool paymentStatus, @JsonKey(name: 'staff_name')  String? staffName, @JsonKey(name: 'staff_color')  String? staffColor, @JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson)  DeliveryStatus? deliveryStatus, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'booked_items')  String bookedItems, @JsonKey(name: 'advance_amount')  int advanceAmount, @JsonKey(name: 'remaining_amount')  int remainingAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DesktopBookingItemModel() when $default != null:
return $default(_that.id,_that.shopBookingId,_that.client,_that.pickupDate,_that.returnDate,_that.paymentStatus,_that.staffName,_that.staffColor,_that.deliveryStatus,_that.createdAt,_that.bookedItems,_that.advanceAmount,_that.remainingAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'shop_booking_id')  String shopBookingId,  String client, @JsonKey(name: 'pickup_date')  String pickupDate, @JsonKey(name: 'return_date')  String returnDate, @JsonKey(name: 'payment_status', fromJson: _paymentStatusFromBool, toJson: _paymentStatusToBool)  bool paymentStatus, @JsonKey(name: 'staff_name')  String? staffName, @JsonKey(name: 'staff_color')  String? staffColor, @JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson)  DeliveryStatus? deliveryStatus, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'booked_items')  String bookedItems, @JsonKey(name: 'advance_amount')  int advanceAmount, @JsonKey(name: 'remaining_amount')  int remainingAmount)  $default,) {final _that = this;
switch (_that) {
case _DesktopBookingItemModel():
return $default(_that.id,_that.shopBookingId,_that.client,_that.pickupDate,_that.returnDate,_that.paymentStatus,_that.staffName,_that.staffColor,_that.deliveryStatus,_that.createdAt,_that.bookedItems,_that.advanceAmount,_that.remainingAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'shop_booking_id')  String shopBookingId,  String client, @JsonKey(name: 'pickup_date')  String pickupDate, @JsonKey(name: 'return_date')  String returnDate, @JsonKey(name: 'payment_status', fromJson: _paymentStatusFromBool, toJson: _paymentStatusToBool)  bool paymentStatus, @JsonKey(name: 'staff_name')  String? staffName, @JsonKey(name: 'staff_color')  String? staffColor, @JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson)  DeliveryStatus? deliveryStatus, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'booked_items')  String bookedItems, @JsonKey(name: 'advance_amount')  int advanceAmount, @JsonKey(name: 'remaining_amount')  int remainingAmount)?  $default,) {final _that = this;
switch (_that) {
case _DesktopBookingItemModel() when $default != null:
return $default(_that.id,_that.shopBookingId,_that.client,_that.pickupDate,_that.returnDate,_that.paymentStatus,_that.staffName,_that.staffColor,_that.deliveryStatus,_that.createdAt,_that.bookedItems,_that.advanceAmount,_that.remainingAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DesktopBookingItemModel implements DesktopBookingItemModel {
  const _DesktopBookingItemModel({required this.id, @JsonKey(name: 'shop_booking_id') required this.shopBookingId, required this.client, @JsonKey(name: 'pickup_date') required this.pickupDate, @JsonKey(name: 'return_date') required this.returnDate, @JsonKey(name: 'payment_status', fromJson: _paymentStatusFromBool, toJson: _paymentStatusToBool) required this.paymentStatus, @JsonKey(name: 'staff_name') this.staffName, @JsonKey(name: 'staff_color') this.staffColor, @JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson) this.deliveryStatus, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'booked_items') required this.bookedItems, @JsonKey(name: 'advance_amount') required this.advanceAmount, @JsonKey(name: 'remaining_amount') required this.remainingAmount});
  factory _DesktopBookingItemModel.fromJson(Map<String, dynamic> json) => _$DesktopBookingItemModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'shop_booking_id') final  String shopBookingId;
@override final  String client;
@override@JsonKey(name: 'pickup_date') final  String pickupDate;
@override@JsonKey(name: 'return_date') final  String returnDate;
@override@JsonKey(name: 'payment_status', fromJson: _paymentStatusFromBool, toJson: _paymentStatusToBool) final  bool paymentStatus;
@override@JsonKey(name: 'staff_name') final  String? staffName;
@override@JsonKey(name: 'staff_color') final  String? staffColor;
@override@JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson) final  DeliveryStatus? deliveryStatus;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'booked_items') final  String bookedItems;
@override@JsonKey(name: 'advance_amount') final  int advanceAmount;
@override@JsonKey(name: 'remaining_amount') final  int remainingAmount;

/// Create a copy of DesktopBookingItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DesktopBookingItemModelCopyWith<_DesktopBookingItemModel> get copyWith => __$DesktopBookingItemModelCopyWithImpl<_DesktopBookingItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DesktopBookingItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DesktopBookingItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopBookingId, shopBookingId) || other.shopBookingId == shopBookingId)&&(identical(other.client, client) || other.client == client)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.staffColor, staffColor) || other.staffColor == staffColor)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.bookedItems, bookedItems) || other.bookedItems == bookedItems)&&(identical(other.advanceAmount, advanceAmount) || other.advanceAmount == advanceAmount)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shopBookingId,client,pickupDate,returnDate,paymentStatus,staffName,staffColor,deliveryStatus,createdAt,bookedItems,advanceAmount,remainingAmount);

@override
String toString() {
  return 'DesktopBookingItemModel(id: $id, shopBookingId: $shopBookingId, client: $client, pickupDate: $pickupDate, returnDate: $returnDate, paymentStatus: $paymentStatus, staffName: $staffName, staffColor: $staffColor, deliveryStatus: $deliveryStatus, createdAt: $createdAt, bookedItems: $bookedItems, advanceAmount: $advanceAmount, remainingAmount: $remainingAmount)';
}


}

/// @nodoc
abstract mixin class _$DesktopBookingItemModelCopyWith<$Res> implements $DesktopBookingItemModelCopyWith<$Res> {
  factory _$DesktopBookingItemModelCopyWith(_DesktopBookingItemModel value, $Res Function(_DesktopBookingItemModel) _then) = __$DesktopBookingItemModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'shop_booking_id') String shopBookingId, String client,@JsonKey(name: 'pickup_date') String pickupDate,@JsonKey(name: 'return_date') String returnDate,@JsonKey(name: 'payment_status', fromJson: _paymentStatusFromBool, toJson: _paymentStatusToBool) bool paymentStatus,@JsonKey(name: 'staff_name') String? staffName,@JsonKey(name: 'staff_color') String? staffColor,@JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson) DeliveryStatus? deliveryStatus,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'booked_items') String bookedItems,@JsonKey(name: 'advance_amount') int advanceAmount,@JsonKey(name: 'remaining_amount') int remainingAmount
});




}
/// @nodoc
class __$DesktopBookingItemModelCopyWithImpl<$Res>
    implements _$DesktopBookingItemModelCopyWith<$Res> {
  __$DesktopBookingItemModelCopyWithImpl(this._self, this._then);

  final _DesktopBookingItemModel _self;
  final $Res Function(_DesktopBookingItemModel) _then;

/// Create a copy of DesktopBookingItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shopBookingId = null,Object? client = null,Object? pickupDate = null,Object? returnDate = null,Object? paymentStatus = null,Object? staffName = freezed,Object? staffColor = freezed,Object? deliveryStatus = freezed,Object? createdAt = null,Object? bookedItems = null,Object? advanceAmount = null,Object? remainingAmount = null,}) {
  return _then(_DesktopBookingItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shopBookingId: null == shopBookingId ? _self.shopBookingId : shopBookingId // ignore: cast_nullable_to_non_nullable
as String,client: null == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as String,pickupDate: null == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String,returnDate: null == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as bool,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,staffColor: freezed == staffColor ? _self.staffColor : staffColor // ignore: cast_nullable_to_non_nullable
as String?,deliveryStatus: freezed == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,bookedItems: null == bookedItems ? _self.bookedItems : bookedItems // ignore: cast_nullable_to_non_nullable
as String,advanceAmount: null == advanceAmount ? _self.advanceAmount : advanceAmount // ignore: cast_nullable_to_non_nullable
as int,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
