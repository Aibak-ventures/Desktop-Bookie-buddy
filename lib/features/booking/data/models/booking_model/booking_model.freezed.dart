// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingsModel {

@JsonKey(name: 'id', readValue: _idCustomRead) int? get id;@JsonKey(name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead) String get clientName;@JsonKey(name: 'booking_status', fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, readValue: _bookingStatusCustomRead) BookingStatus get bookingStatus;@JsonKey(name: 'booking_date') String? get bookedDate;@JsonKey(name: 'pickup_date') String? get pickupDate;@JsonKey(name: 'return_date') String? get returnDate;@JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked) DeliveryStatus get deliveryStatus;@JsonKey(name: 'payment_status', defaultValue: PaymentStatus.pending, fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson) PaymentStatus get paymentStatus;@JsonKey(name: 'shop_booking_id') String? get shopBookingId;@JsonKey(name: 'staff_name') String? get staffName;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead) List<String> get bookedItems;@JsonKey(name: 'type') String? get type;
/// Create a copy of BookingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingsModelCopyWith<BookingsModel> get copyWith => _$BookingsModelCopyWithImpl<BookingsModel>(this as BookingsModel, _$identity);

  /// Serializes this BookingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.bookedDate, bookedDate) || other.bookedDate == bookedDate)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.shopBookingId, shopBookingId) || other.shopBookingId == shopBookingId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.bookedItems, bookedItems)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,clientName,bookingStatus,bookedDate,pickupDate,returnDate,deliveryStatus,paymentStatus,shopBookingId,staffName,createdAt,const DeepCollectionEquality().hash(bookedItems),type);

@override
String toString() {
  return 'BookingsModel(id: $id, clientName: $clientName, bookingStatus: $bookingStatus, bookedDate: $bookedDate, pickupDate: $pickupDate, returnDate: $returnDate, deliveryStatus: $deliveryStatus, paymentStatus: $paymentStatus, shopBookingId: $shopBookingId, staffName: $staffName, createdAt: $createdAt, bookedItems: $bookedItems, type: $type)';
}


}

/// @nodoc
abstract mixin class $BookingsModelCopyWith<$Res>  {
  factory $BookingsModelCopyWith(BookingsModel value, $Res Function(BookingsModel) _then) = _$BookingsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id', readValue: _idCustomRead) int? id,@JsonKey(name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead) String clientName,@JsonKey(name: 'booking_status', fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, readValue: _bookingStatusCustomRead) BookingStatus bookingStatus,@JsonKey(name: 'booking_date') String? bookedDate,@JsonKey(name: 'pickup_date') String? pickupDate,@JsonKey(name: 'return_date') String? returnDate,@JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked) DeliveryStatus deliveryStatus,@JsonKey(name: 'payment_status', defaultValue: PaymentStatus.pending, fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson) PaymentStatus paymentStatus,@JsonKey(name: 'shop_booking_id') String? shopBookingId,@JsonKey(name: 'staff_name') String? staffName,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead) List<String> bookedItems,@JsonKey(name: 'type') String? type
});




}
/// @nodoc
class _$BookingsModelCopyWithImpl<$Res>
    implements $BookingsModelCopyWith<$Res> {
  _$BookingsModelCopyWithImpl(this._self, this._then);

  final BookingsModel _self;
  final $Res Function(BookingsModel) _then;

/// Create a copy of BookingsModel
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


/// Adds pattern-matching-related methods to [BookingsModel].
extension BookingsModelPatterns on BookingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingsModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', readValue: _idCustomRead)  int? id, @JsonKey(name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead)  String clientName, @JsonKey(name: 'booking_status', fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, readValue: _bookingStatusCustomRead)  BookingStatus bookingStatus, @JsonKey(name: 'booking_date')  String? bookedDate, @JsonKey(name: 'pickup_date')  String? pickupDate, @JsonKey(name: 'return_date')  String? returnDate, @JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked)  DeliveryStatus deliveryStatus, @JsonKey(name: 'payment_status', defaultValue: PaymentStatus.pending, fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson)  PaymentStatus paymentStatus, @JsonKey(name: 'shop_booking_id')  String? shopBookingId, @JsonKey(name: 'staff_name')  String? staffName, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead)  List<String> bookedItems, @JsonKey(name: 'type')  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingsModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', readValue: _idCustomRead)  int? id, @JsonKey(name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead)  String clientName, @JsonKey(name: 'booking_status', fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, readValue: _bookingStatusCustomRead)  BookingStatus bookingStatus, @JsonKey(name: 'booking_date')  String? bookedDate, @JsonKey(name: 'pickup_date')  String? pickupDate, @JsonKey(name: 'return_date')  String? returnDate, @JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked)  DeliveryStatus deliveryStatus, @JsonKey(name: 'payment_status', defaultValue: PaymentStatus.pending, fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson)  PaymentStatus paymentStatus, @JsonKey(name: 'shop_booking_id')  String? shopBookingId, @JsonKey(name: 'staff_name')  String? staffName, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead)  List<String> bookedItems, @JsonKey(name: 'type')  String? type)  $default,) {final _that = this;
switch (_that) {
case _BookingsModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id', readValue: _idCustomRead)  int? id, @JsonKey(name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead)  String clientName, @JsonKey(name: 'booking_status', fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, readValue: _bookingStatusCustomRead)  BookingStatus bookingStatus, @JsonKey(name: 'booking_date')  String? bookedDate, @JsonKey(name: 'pickup_date')  String? pickupDate, @JsonKey(name: 'return_date')  String? returnDate, @JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked)  DeliveryStatus deliveryStatus, @JsonKey(name: 'payment_status', defaultValue: PaymentStatus.pending, fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson)  PaymentStatus paymentStatus, @JsonKey(name: 'shop_booking_id')  String? shopBookingId, @JsonKey(name: 'staff_name')  String? staffName, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead)  List<String> bookedItems, @JsonKey(name: 'type')  String? type)?  $default,) {final _that = this;
switch (_that) {
case _BookingsModel() when $default != null:
return $default(_that.id,_that.clientName,_that.bookingStatus,_that.bookedDate,_that.pickupDate,_that.returnDate,_that.deliveryStatus,_that.paymentStatus,_that.shopBookingId,_that.staffName,_that.createdAt,_that.bookedItems,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingsModel implements BookingsModel {
  const _BookingsModel({@JsonKey(name: 'id', readValue: _idCustomRead) this.id, @JsonKey(name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead) required this.clientName, @JsonKey(name: 'booking_status', fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, readValue: _bookingStatusCustomRead) required this.bookingStatus, @JsonKey(name: 'booking_date') this.bookedDate, @JsonKey(name: 'pickup_date') this.pickupDate, @JsonKey(name: 'return_date') this.returnDate, @JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked) required this.deliveryStatus, @JsonKey(name: 'payment_status', defaultValue: PaymentStatus.pending, fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson) required this.paymentStatus, @JsonKey(name: 'shop_booking_id') this.shopBookingId, @JsonKey(name: 'staff_name') this.staffName, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead) final  List<String> bookedItems = const [], @JsonKey(name: 'type') this.type}): _bookedItems = bookedItems;
  factory _BookingsModel.fromJson(Map<String, dynamic> json) => _$BookingsModelFromJson(json);

@override@JsonKey(name: 'id', readValue: _idCustomRead) final  int? id;
@override@JsonKey(name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead) final  String clientName;
@override@JsonKey(name: 'booking_status', fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, readValue: _bookingStatusCustomRead) final  BookingStatus bookingStatus;
@override@JsonKey(name: 'booking_date') final  String? bookedDate;
@override@JsonKey(name: 'pickup_date') final  String? pickupDate;
@override@JsonKey(name: 'return_date') final  String? returnDate;
@override@JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked) final  DeliveryStatus deliveryStatus;
@override@JsonKey(name: 'payment_status', defaultValue: PaymentStatus.pending, fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson) final  PaymentStatus paymentStatus;
@override@JsonKey(name: 'shop_booking_id') final  String? shopBookingId;
@override@JsonKey(name: 'staff_name') final  String? staffName;
@override@JsonKey(name: 'created_at') final  String? createdAt;
 final  List<String> _bookedItems;
@override@JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead) List<String> get bookedItems {
  if (_bookedItems is EqualUnmodifiableListView) return _bookedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookedItems);
}

@override@JsonKey(name: 'type') final  String? type;

/// Create a copy of BookingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingsModelCopyWith<_BookingsModel> get copyWith => __$BookingsModelCopyWithImpl<_BookingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.bookedDate, bookedDate) || other.bookedDate == bookedDate)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.shopBookingId, shopBookingId) || other.shopBookingId == shopBookingId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._bookedItems, _bookedItems)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,clientName,bookingStatus,bookedDate,pickupDate,returnDate,deliveryStatus,paymentStatus,shopBookingId,staffName,createdAt,const DeepCollectionEquality().hash(_bookedItems),type);

@override
String toString() {
  return 'BookingsModel(id: $id, clientName: $clientName, bookingStatus: $bookingStatus, bookedDate: $bookedDate, pickupDate: $pickupDate, returnDate: $returnDate, deliveryStatus: $deliveryStatus, paymentStatus: $paymentStatus, shopBookingId: $shopBookingId, staffName: $staffName, createdAt: $createdAt, bookedItems: $bookedItems, type: $type)';
}


}

/// @nodoc
abstract mixin class _$BookingsModelCopyWith<$Res> implements $BookingsModelCopyWith<$Res> {
  factory _$BookingsModelCopyWith(_BookingsModel value, $Res Function(_BookingsModel) _then) = __$BookingsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id', readValue: _idCustomRead) int? id,@JsonKey(name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead) String clientName,@JsonKey(name: 'booking_status', fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, readValue: _bookingStatusCustomRead) BookingStatus bookingStatus,@JsonKey(name: 'booking_date') String? bookedDate,@JsonKey(name: 'pickup_date') String? pickupDate,@JsonKey(name: 'return_date') String? returnDate,@JsonKey(name: 'delivery_status', fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked) DeliveryStatus deliveryStatus,@JsonKey(name: 'payment_status', defaultValue: PaymentStatus.pending, fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson) PaymentStatus paymentStatus,@JsonKey(name: 'shop_booking_id') String? shopBookingId,@JsonKey(name: 'staff_name') String? staffName,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead) List<String> bookedItems,@JsonKey(name: 'type') String? type
});




}
/// @nodoc
class __$BookingsModelCopyWithImpl<$Res>
    implements _$BookingsModelCopyWith<$Res> {
  __$BookingsModelCopyWithImpl(this._self, this._then);

  final _BookingsModel _self;
  final $Res Function(_BookingsModel) _then;

/// Create a copy of BookingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? clientName = null,Object? bookingStatus = null,Object? bookedDate = freezed,Object? pickupDate = freezed,Object? returnDate = freezed,Object? deliveryStatus = null,Object? paymentStatus = null,Object? shopBookingId = freezed,Object? staffName = freezed,Object? createdAt = freezed,Object? bookedItems = null,Object? type = freezed,}) {
  return _then(_BookingsModel(
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
