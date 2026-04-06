// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'desktop_booking_item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DesktopBookingItemEntity {

 int get id; String get shopBookingId; String get client; String get pickupDate; String get returnDate; bool get paymentStatus; String? get staffName; String? get staffColor; DeliveryStatus? get deliveryStatus; String get createdAt; String get bookedItems; int get advanceAmount; int get remainingAmount;
/// Create a copy of DesktopBookingItemEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DesktopBookingItemEntityCopyWith<DesktopBookingItemEntity> get copyWith => _$DesktopBookingItemEntityCopyWithImpl<DesktopBookingItemEntity>(this as DesktopBookingItemEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DesktopBookingItemEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.shopBookingId, shopBookingId) || other.shopBookingId == shopBookingId)&&(identical(other.client, client) || other.client == client)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.staffColor, staffColor) || other.staffColor == staffColor)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.bookedItems, bookedItems) || other.bookedItems == bookedItems)&&(identical(other.advanceAmount, advanceAmount) || other.advanceAmount == advanceAmount)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopBookingId,client,pickupDate,returnDate,paymentStatus,staffName,staffColor,deliveryStatus,createdAt,bookedItems,advanceAmount,remainingAmount);

@override
String toString() {
  return 'DesktopBookingItemEntity(id: $id, shopBookingId: $shopBookingId, client: $client, pickupDate: $pickupDate, returnDate: $returnDate, paymentStatus: $paymentStatus, staffName: $staffName, staffColor: $staffColor, deliveryStatus: $deliveryStatus, createdAt: $createdAt, bookedItems: $bookedItems, advanceAmount: $advanceAmount, remainingAmount: $remainingAmount)';
}


}

/// @nodoc
abstract mixin class $DesktopBookingItemEntityCopyWith<$Res>  {
  factory $DesktopBookingItemEntityCopyWith(DesktopBookingItemEntity value, $Res Function(DesktopBookingItemEntity) _then) = _$DesktopBookingItemEntityCopyWithImpl;
@useResult
$Res call({
 int id, String shopBookingId, String client, String pickupDate, String returnDate, bool paymentStatus, String? staffName, String? staffColor, DeliveryStatus? deliveryStatus, String createdAt, String bookedItems, int advanceAmount, int remainingAmount
});




}
/// @nodoc
class _$DesktopBookingItemEntityCopyWithImpl<$Res>
    implements $DesktopBookingItemEntityCopyWith<$Res> {
  _$DesktopBookingItemEntityCopyWithImpl(this._self, this._then);

  final DesktopBookingItemEntity _self;
  final $Res Function(DesktopBookingItemEntity) _then;

/// Create a copy of DesktopBookingItemEntity
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


/// Adds pattern-matching-related methods to [DesktopBookingItemEntity].
extension DesktopBookingItemEntityPatterns on DesktopBookingItemEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DesktopBookingItemEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DesktopBookingItemEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DesktopBookingItemEntity value)  $default,){
final _that = this;
switch (_that) {
case _DesktopBookingItemEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DesktopBookingItemEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DesktopBookingItemEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String shopBookingId,  String client,  String pickupDate,  String returnDate,  bool paymentStatus,  String? staffName,  String? staffColor,  DeliveryStatus? deliveryStatus,  String createdAt,  String bookedItems,  int advanceAmount,  int remainingAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DesktopBookingItemEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String shopBookingId,  String client,  String pickupDate,  String returnDate,  bool paymentStatus,  String? staffName,  String? staffColor,  DeliveryStatus? deliveryStatus,  String createdAt,  String bookedItems,  int advanceAmount,  int remainingAmount)  $default,) {final _that = this;
switch (_that) {
case _DesktopBookingItemEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String shopBookingId,  String client,  String pickupDate,  String returnDate,  bool paymentStatus,  String? staffName,  String? staffColor,  DeliveryStatus? deliveryStatus,  String createdAt,  String bookedItems,  int advanceAmount,  int remainingAmount)?  $default,) {final _that = this;
switch (_that) {
case _DesktopBookingItemEntity() when $default != null:
return $default(_that.id,_that.shopBookingId,_that.client,_that.pickupDate,_that.returnDate,_that.paymentStatus,_that.staffName,_that.staffColor,_that.deliveryStatus,_that.createdAt,_that.bookedItems,_that.advanceAmount,_that.remainingAmount);case _:
  return null;

}
}

}

/// @nodoc


class _DesktopBookingItemEntity implements DesktopBookingItemEntity {
  const _DesktopBookingItemEntity({required this.id, required this.shopBookingId, required this.client, required this.pickupDate, required this.returnDate, required this.paymentStatus, this.staffName, this.staffColor, this.deliveryStatus, required this.createdAt, required this.bookedItems, required this.advanceAmount, required this.remainingAmount});
  

@override final  int id;
@override final  String shopBookingId;
@override final  String client;
@override final  String pickupDate;
@override final  String returnDate;
@override final  bool paymentStatus;
@override final  String? staffName;
@override final  String? staffColor;
@override final  DeliveryStatus? deliveryStatus;
@override final  String createdAt;
@override final  String bookedItems;
@override final  int advanceAmount;
@override final  int remainingAmount;

/// Create a copy of DesktopBookingItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DesktopBookingItemEntityCopyWith<_DesktopBookingItemEntity> get copyWith => __$DesktopBookingItemEntityCopyWithImpl<_DesktopBookingItemEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DesktopBookingItemEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.shopBookingId, shopBookingId) || other.shopBookingId == shopBookingId)&&(identical(other.client, client) || other.client == client)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.staffColor, staffColor) || other.staffColor == staffColor)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.bookedItems, bookedItems) || other.bookedItems == bookedItems)&&(identical(other.advanceAmount, advanceAmount) || other.advanceAmount == advanceAmount)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount));
}


@override
int get hashCode => Object.hash(runtimeType,id,shopBookingId,client,pickupDate,returnDate,paymentStatus,staffName,staffColor,deliveryStatus,createdAt,bookedItems,advanceAmount,remainingAmount);

@override
String toString() {
  return 'DesktopBookingItemEntity(id: $id, shopBookingId: $shopBookingId, client: $client, pickupDate: $pickupDate, returnDate: $returnDate, paymentStatus: $paymentStatus, staffName: $staffName, staffColor: $staffColor, deliveryStatus: $deliveryStatus, createdAt: $createdAt, bookedItems: $bookedItems, advanceAmount: $advanceAmount, remainingAmount: $remainingAmount)';
}


}

/// @nodoc
abstract mixin class _$DesktopBookingItemEntityCopyWith<$Res> implements $DesktopBookingItemEntityCopyWith<$Res> {
  factory _$DesktopBookingItemEntityCopyWith(_DesktopBookingItemEntity value, $Res Function(_DesktopBookingItemEntity) _then) = __$DesktopBookingItemEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String shopBookingId, String client, String pickupDate, String returnDate, bool paymentStatus, String? staffName, String? staffColor, DeliveryStatus? deliveryStatus, String createdAt, String bookedItems, int advanceAmount, int remainingAmount
});




}
/// @nodoc
class __$DesktopBookingItemEntityCopyWithImpl<$Res>
    implements _$DesktopBookingItemEntityCopyWith<$Res> {
  __$DesktopBookingItemEntityCopyWithImpl(this._self, this._then);

  final _DesktopBookingItemEntity _self;
  final $Res Function(_DesktopBookingItemEntity) _then;

/// Create a copy of DesktopBookingItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shopBookingId = null,Object? client = null,Object? pickupDate = null,Object? returnDate = null,Object? paymentStatus = null,Object? staffName = freezed,Object? staffColor = freezed,Object? deliveryStatus = freezed,Object? createdAt = null,Object? bookedItems = null,Object? advanceAmount = null,Object? remainingAmount = null,}) {
  return _then(_DesktopBookingItemEntity(
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
