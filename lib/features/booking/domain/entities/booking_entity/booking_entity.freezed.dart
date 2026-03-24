// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingEntity {

 int? get id; String get clientName; BookingStatus get bookingStatus; String? get bookedDate; String? get pickupDate; String? get returnDate; DeliveryStatus get deliveryStatus; PaymentStatus get paymentStatus; String? get shopBookingId; String? get staffName; String? get createdAt; List<String> get bookedItems; String? get type;
/// Create a copy of BookingEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingEntityCopyWith<BookingEntity> get copyWith => _$BookingEntityCopyWithImpl<BookingEntity>(this as BookingEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.bookedDate, bookedDate) || other.bookedDate == bookedDate)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.shopBookingId, shopBookingId) || other.shopBookingId == shopBookingId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.bookedItems, bookedItems)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,id,clientName,bookingStatus,bookedDate,pickupDate,returnDate,deliveryStatus,paymentStatus,shopBookingId,staffName,createdAt,const DeepCollectionEquality().hash(bookedItems),type);

@override
String toString() {
  return 'BookingEntity(id: $id, clientName: $clientName, bookingStatus: $bookingStatus, bookedDate: $bookedDate, pickupDate: $pickupDate, returnDate: $returnDate, deliveryStatus: $deliveryStatus, paymentStatus: $paymentStatus, shopBookingId: $shopBookingId, staffName: $staffName, createdAt: $createdAt, bookedItems: $bookedItems, type: $type)';
}


}

/// @nodoc
abstract mixin class $BookingEntityCopyWith<$Res>  {
  factory $BookingEntityCopyWith(BookingEntity value, $Res Function(BookingEntity) _then) = _$BookingEntityCopyWithImpl;
@useResult
$Res call({
 int? id, String clientName, BookingStatus bookingStatus, String? bookedDate, String? pickupDate, String? returnDate, DeliveryStatus deliveryStatus, PaymentStatus paymentStatus, String? shopBookingId, String? staffName, String? createdAt, List<String> bookedItems, String? type
});




}
/// @nodoc
class _$BookingEntityCopyWithImpl<$Res>
    implements $BookingEntityCopyWith<$Res> {
  _$BookingEntityCopyWithImpl(this._self, this._then);

  final BookingEntity _self;
  final $Res Function(BookingEntity) _then;

/// Create a copy of BookingEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? clientName = null,Object? bookingStatus = null,Object? bookedDate = freezed,Object? pickupDate = freezed,Object? returnDate = freezed,Object? deliveryStatus = null,Object? paymentStatus = null,Object? shopBookingId = freezed,Object? staffName = freezed,Object? createdAt = freezed,Object? bookedItems = null,Object? type = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,bookingStatus: null == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus,bookedDate: freezed == bookedDate ? _self.bookedDate : bookedDate // ignore: cast_nullable_to_non_nullable
as String?,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,returnDate: freezed == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String?,deliveryStatus: null == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,shopBookingId: freezed == shopBookingId ? _self.shopBookingId : shopBookingId // ignore: cast_nullable_to_non_nullable
as String?,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,bookedItems: null == bookedItems ? _self.bookedItems : bookedItems // ignore: cast_nullable_to_non_nullable
as List<String>,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingEntity].
extension BookingEntityPatterns on BookingEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookingEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookingEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String clientName,  BookingStatus bookingStatus,  String? bookedDate,  String? pickupDate,  String? returnDate,  DeliveryStatus deliveryStatus,  PaymentStatus paymentStatus,  String? shopBookingId,  String? staffName,  String? createdAt,  List<String> bookedItems,  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingEntity() when $default != null:
return $default(_that.id,_that.clientName,_that.bookingStatus,_that.bookedDate,_that.pickupDate,_that.returnDate,_that.deliveryStatus,_that.paymentStatus,_that.shopBookingId,_that.staffName,_that.createdAt,_that.bookedItems,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String clientName,  BookingStatus bookingStatus,  String? bookedDate,  String? pickupDate,  String? returnDate,  DeliveryStatus deliveryStatus,  PaymentStatus paymentStatus,  String? shopBookingId,  String? staffName,  String? createdAt,  List<String> bookedItems,  String? type)  $default,) {final _that = this;
switch (_that) {
case _BookingEntity():
return $default(_that.id,_that.clientName,_that.bookingStatus,_that.bookedDate,_that.pickupDate,_that.returnDate,_that.deliveryStatus,_that.paymentStatus,_that.shopBookingId,_that.staffName,_that.createdAt,_that.bookedItems,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String clientName,  BookingStatus bookingStatus,  String? bookedDate,  String? pickupDate,  String? returnDate,  DeliveryStatus deliveryStatus,  PaymentStatus paymentStatus,  String? shopBookingId,  String? staffName,  String? createdAt,  List<String> bookedItems,  String? type)?  $default,) {final _that = this;
switch (_that) {
case _BookingEntity() when $default != null:
return $default(_that.id,_that.clientName,_that.bookingStatus,_that.bookedDate,_that.pickupDate,_that.returnDate,_that.deliveryStatus,_that.paymentStatus,_that.shopBookingId,_that.staffName,_that.createdAt,_that.bookedItems,_that.type);case _:
  return null;

}
}

}

/// @nodoc


class _BookingEntity implements BookingEntity {
  const _BookingEntity({this.id, required this.clientName, required this.bookingStatus, this.bookedDate, this.pickupDate, this.returnDate, required this.deliveryStatus, required this.paymentStatus, this.shopBookingId, this.staffName, this.createdAt, final  List<String> bookedItems = const [], this.type}): _bookedItems = bookedItems;
  

@override final  int? id;
@override final  String clientName;
@override final  BookingStatus bookingStatus;
@override final  String? bookedDate;
@override final  String? pickupDate;
@override final  String? returnDate;
@override final  DeliveryStatus deliveryStatus;
@override final  PaymentStatus paymentStatus;
@override final  String? shopBookingId;
@override final  String? staffName;
@override final  String? createdAt;
 final  List<String> _bookedItems;
@override@JsonKey() List<String> get bookedItems {
  if (_bookedItems is EqualUnmodifiableListView) return _bookedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookedItems);
}

@override final  String? type;

/// Create a copy of BookingEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingEntityCopyWith<_BookingEntity> get copyWith => __$BookingEntityCopyWithImpl<_BookingEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.bookedDate, bookedDate) || other.bookedDate == bookedDate)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.shopBookingId, shopBookingId) || other.shopBookingId == shopBookingId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._bookedItems, _bookedItems)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,id,clientName,bookingStatus,bookedDate,pickupDate,returnDate,deliveryStatus,paymentStatus,shopBookingId,staffName,createdAt,const DeepCollectionEquality().hash(_bookedItems),type);

@override
String toString() {
  return 'BookingEntity(id: $id, clientName: $clientName, bookingStatus: $bookingStatus, bookedDate: $bookedDate, pickupDate: $pickupDate, returnDate: $returnDate, deliveryStatus: $deliveryStatus, paymentStatus: $paymentStatus, shopBookingId: $shopBookingId, staffName: $staffName, createdAt: $createdAt, bookedItems: $bookedItems, type: $type)';
}


}

/// @nodoc
abstract mixin class _$BookingEntityCopyWith<$Res> implements $BookingEntityCopyWith<$Res> {
  factory _$BookingEntityCopyWith(_BookingEntity value, $Res Function(_BookingEntity) _then) = __$BookingEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, String clientName, BookingStatus bookingStatus, String? bookedDate, String? pickupDate, String? returnDate, DeliveryStatus deliveryStatus, PaymentStatus paymentStatus, String? shopBookingId, String? staffName, String? createdAt, List<String> bookedItems, String? type
});




}
/// @nodoc
class __$BookingEntityCopyWithImpl<$Res>
    implements _$BookingEntityCopyWith<$Res> {
  __$BookingEntityCopyWithImpl(this._self, this._then);

  final _BookingEntity _self;
  final $Res Function(_BookingEntity) _then;

/// Create a copy of BookingEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? clientName = null,Object? bookingStatus = null,Object? bookedDate = freezed,Object? pickupDate = freezed,Object? returnDate = freezed,Object? deliveryStatus = null,Object? paymentStatus = null,Object? shopBookingId = freezed,Object? staffName = freezed,Object? createdAt = freezed,Object? bookedItems = null,Object? type = freezed,}) {
  return _then(_BookingEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,bookingStatus: null == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus,bookedDate: freezed == bookedDate ? _self.bookedDate : bookedDate // ignore: cast_nullable_to_non_nullable
as String?,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,returnDate: freezed == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String?,deliveryStatus: null == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,shopBookingId: freezed == shopBookingId ? _self.shopBookingId : shopBookingId // ignore: cast_nullable_to_non_nullable
as String?,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,bookedItems: null == bookedItems ? _self._bookedItems : bookedItems // ignore: cast_nullable_to_non_nullable
as List<String>,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
