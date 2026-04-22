// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingRequestEntity {

 int? get clientId; int? get staffId; ClientRequestEntity? get client; String? get address; String? get bookedDate; String? get pickupDate; String? get returnDate; String? get coolingPeriodDate; int? get advanceAmount; int? get securityAmount; int? get discountAmount; String? get purchaseMode; String? get description; DeliveryStatus? get deliveryStatus; BookingStatus? get bookingStatus; List<ProductSelectedEntity>? get products; BookingOtherDetailsEntity? get otherDetails; List<AdditionalChargesEntity>? get additionalCharges; int? get serviceId; TimeOfDay? get pickupTime; TimeOfDay? get returnTime; bool get sendPdfToWhatsApp; String? get runningKilometers; String? get coolingPeriodType; int? get securityPaymentAccountId; List<BookingPaymentRequestEntity>? get payments; int? get oldBookingAccountId;
/// Create a copy of BookingRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingRequestEntityCopyWith<BookingRequestEntity> get copyWith => _$BookingRequestEntityCopyWithImpl<BookingRequestEntity>(this as BookingRequestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingRequestEntity&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.client, client) || other.client == client)&&(identical(other.address, address) || other.address == address)&&(identical(other.bookedDate, bookedDate) || other.bookedDate == bookedDate)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.coolingPeriodDate, coolingPeriodDate) || other.coolingPeriodDate == coolingPeriodDate)&&(identical(other.advanceAmount, advanceAmount) || other.advanceAmount == advanceAmount)&&(identical(other.securityAmount, securityAmount) || other.securityAmount == securityAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.purchaseMode, purchaseMode) || other.purchaseMode == purchaseMode)&&(identical(other.description, description) || other.description == description)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.otherDetails, otherDetails) || other.otherDetails == otherDetails)&&const DeepCollectionEquality().equals(other.additionalCharges, additionalCharges)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.pickupTime, pickupTime) || other.pickupTime == pickupTime)&&(identical(other.returnTime, returnTime) || other.returnTime == returnTime)&&(identical(other.sendPdfToWhatsApp, sendPdfToWhatsApp) || other.sendPdfToWhatsApp == sendPdfToWhatsApp)&&(identical(other.runningKilometers, runningKilometers) || other.runningKilometers == runningKilometers)&&(identical(other.coolingPeriodType, coolingPeriodType) || other.coolingPeriodType == coolingPeriodType)&&(identical(other.securityPaymentAccountId, securityPaymentAccountId) || other.securityPaymentAccountId == securityPaymentAccountId)&&const DeepCollectionEquality().equals(other.payments, payments)&&(identical(other.oldBookingAccountId, oldBookingAccountId) || other.oldBookingAccountId == oldBookingAccountId));
}


@override
int get hashCode => Object.hashAll([runtimeType,clientId,staffId,client,address,bookedDate,pickupDate,returnDate,coolingPeriodDate,advanceAmount,securityAmount,discountAmount,purchaseMode,description,deliveryStatus,bookingStatus,const DeepCollectionEquality().hash(products),otherDetails,const DeepCollectionEquality().hash(additionalCharges),serviceId,pickupTime,returnTime,sendPdfToWhatsApp,runningKilometers,coolingPeriodType,securityPaymentAccountId,const DeepCollectionEquality().hash(payments),oldBookingAccountId]);

@override
String toString() {
  return 'BookingRequestEntity(clientId: $clientId, staffId: $staffId, client: $client, address: $address, bookedDate: $bookedDate, pickupDate: $pickupDate, returnDate: $returnDate, coolingPeriodDate: $coolingPeriodDate, advanceAmount: $advanceAmount, securityAmount: $securityAmount, discountAmount: $discountAmount, purchaseMode: $purchaseMode, description: $description, deliveryStatus: $deliveryStatus, bookingStatus: $bookingStatus, products: $products, otherDetails: $otherDetails, additionalCharges: $additionalCharges, serviceId: $serviceId, pickupTime: $pickupTime, returnTime: $returnTime, sendPdfToWhatsApp: $sendPdfToWhatsApp, runningKilometers: $runningKilometers, coolingPeriodType: $coolingPeriodType, securityPaymentAccountId: $securityPaymentAccountId, payments: $payments, oldBookingAccountId: $oldBookingAccountId)';
}


}

/// @nodoc
abstract mixin class $BookingRequestEntityCopyWith<$Res>  {
  factory $BookingRequestEntityCopyWith(BookingRequestEntity value, $Res Function(BookingRequestEntity) _then) = _$BookingRequestEntityCopyWithImpl;
@useResult
$Res call({
 int? clientId, int? staffId, ClientRequestEntity? client, String? address, String? bookedDate, String? pickupDate, String? returnDate, String? coolingPeriodDate, int? advanceAmount, int? securityAmount, int? discountAmount, String? purchaseMode, String? description, DeliveryStatus? deliveryStatus, BookingStatus? bookingStatus, List<ProductSelectedEntity>? products, BookingOtherDetailsEntity? otherDetails, List<AdditionalChargesEntity>? additionalCharges, int? serviceId, TimeOfDay? pickupTime, TimeOfDay? returnTime, bool sendPdfToWhatsApp, String? runningKilometers, String? coolingPeriodType, int? securityPaymentAccountId, List<BookingPaymentRequestEntity>? payments, int? oldBookingAccountId
});


$ClientRequestEntityCopyWith<$Res>? get client;$BookingOtherDetailsEntityCopyWith<$Res>? get otherDetails;

}
/// @nodoc
class _$BookingRequestEntityCopyWithImpl<$Res>
    implements $BookingRequestEntityCopyWith<$Res> {
  _$BookingRequestEntityCopyWithImpl(this._self, this._then);

  final BookingRequestEntity _self;
  final $Res Function(BookingRequestEntity) _then;

/// Create a copy of BookingRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = freezed,Object? staffId = freezed,Object? client = freezed,Object? address = freezed,Object? bookedDate = freezed,Object? pickupDate = freezed,Object? returnDate = freezed,Object? coolingPeriodDate = freezed,Object? advanceAmount = freezed,Object? securityAmount = freezed,Object? discountAmount = freezed,Object? purchaseMode = freezed,Object? description = freezed,Object? deliveryStatus = freezed,Object? bookingStatus = freezed,Object? products = freezed,Object? otherDetails = freezed,Object? additionalCharges = freezed,Object? serviceId = freezed,Object? pickupTime = freezed,Object? returnTime = freezed,Object? sendPdfToWhatsApp = null,Object? runningKilometers = freezed,Object? coolingPeriodType = freezed,Object? securityPaymentAccountId = freezed,Object? payments = freezed,Object? oldBookingAccountId = freezed,}) {
  return _then(_self.copyWith(
clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientRequestEntity?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,bookedDate: freezed == bookedDate ? _self.bookedDate : bookedDate // ignore: cast_nullable_to_non_nullable
as String?,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,returnDate: freezed == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String?,coolingPeriodDate: freezed == coolingPeriodDate ? _self.coolingPeriodDate : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
as String?,advanceAmount: freezed == advanceAmount ? _self.advanceAmount : advanceAmount // ignore: cast_nullable_to_non_nullable
as int?,securityAmount: freezed == securityAmount ? _self.securityAmount : securityAmount // ignore: cast_nullable_to_non_nullable
as int?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,purchaseMode: freezed == purchaseMode ? _self.purchaseMode : purchaseMode // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,deliveryStatus: freezed == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus?,bookingStatus: freezed == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus?,products: freezed == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductSelectedEntity>?,otherDetails: freezed == otherDetails ? _self.otherDetails : otherDetails // ignore: cast_nullable_to_non_nullable
as BookingOtherDetailsEntity?,additionalCharges: freezed == additionalCharges ? _self.additionalCharges : additionalCharges // ignore: cast_nullable_to_non_nullable
as List<AdditionalChargesEntity>?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,pickupTime: freezed == pickupTime ? _self.pickupTime : pickupTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,returnTime: freezed == returnTime ? _self.returnTime : returnTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,sendPdfToWhatsApp: null == sendPdfToWhatsApp ? _self.sendPdfToWhatsApp : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
as bool,runningKilometers: freezed == runningKilometers ? _self.runningKilometers : runningKilometers // ignore: cast_nullable_to_non_nullable
as String?,coolingPeriodType: freezed == coolingPeriodType ? _self.coolingPeriodType : coolingPeriodType // ignore: cast_nullable_to_non_nullable
as String?,securityPaymentAccountId: freezed == securityPaymentAccountId ? _self.securityPaymentAccountId : securityPaymentAccountId // ignore: cast_nullable_to_non_nullable
as int?,payments: freezed == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<BookingPaymentRequestEntity>?,oldBookingAccountId: freezed == oldBookingAccountId ? _self.oldBookingAccountId : oldBookingAccountId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of BookingRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientRequestEntityCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $ClientRequestEntityCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of BookingRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingOtherDetailsEntityCopyWith<$Res>? get otherDetails {
    if (_self.otherDetails == null) {
    return null;
  }

  return $BookingOtherDetailsEntityCopyWith<$Res>(_self.otherDetails!, (value) {
    return _then(_self.copyWith(otherDetails: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingRequestEntity].
extension BookingRequestEntityPatterns on BookingRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookingRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookingRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? clientId,  int? staffId,  ClientRequestEntity? client,  String? address,  String? bookedDate,  String? pickupDate,  String? returnDate,  String? coolingPeriodDate,  int? advanceAmount,  int? securityAmount,  int? discountAmount,  String? purchaseMode,  String? description,  DeliveryStatus? deliveryStatus,  BookingStatus? bookingStatus,  List<ProductSelectedEntity>? products,  BookingOtherDetailsEntity? otherDetails,  List<AdditionalChargesEntity>? additionalCharges,  int? serviceId,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool sendPdfToWhatsApp,  String? runningKilometers,  String? coolingPeriodType,  int? securityPaymentAccountId,  List<BookingPaymentRequestEntity>? payments,  int? oldBookingAccountId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingRequestEntity() when $default != null:
return $default(_that.clientId,_that.staffId,_that.client,_that.address,_that.bookedDate,_that.pickupDate,_that.returnDate,_that.coolingPeriodDate,_that.advanceAmount,_that.securityAmount,_that.discountAmount,_that.purchaseMode,_that.description,_that.deliveryStatus,_that.bookingStatus,_that.products,_that.otherDetails,_that.additionalCharges,_that.serviceId,_that.pickupTime,_that.returnTime,_that.sendPdfToWhatsApp,_that.runningKilometers,_that.coolingPeriodType,_that.securityPaymentAccountId,_that.payments,_that.oldBookingAccountId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? clientId,  int? staffId,  ClientRequestEntity? client,  String? address,  String? bookedDate,  String? pickupDate,  String? returnDate,  String? coolingPeriodDate,  int? advanceAmount,  int? securityAmount,  int? discountAmount,  String? purchaseMode,  String? description,  DeliveryStatus? deliveryStatus,  BookingStatus? bookingStatus,  List<ProductSelectedEntity>? products,  BookingOtherDetailsEntity? otherDetails,  List<AdditionalChargesEntity>? additionalCharges,  int? serviceId,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool sendPdfToWhatsApp,  String? runningKilometers,  String? coolingPeriodType,  int? securityPaymentAccountId,  List<BookingPaymentRequestEntity>? payments,  int? oldBookingAccountId)  $default,) {final _that = this;
switch (_that) {
case _BookingRequestEntity():
return $default(_that.clientId,_that.staffId,_that.client,_that.address,_that.bookedDate,_that.pickupDate,_that.returnDate,_that.coolingPeriodDate,_that.advanceAmount,_that.securityAmount,_that.discountAmount,_that.purchaseMode,_that.description,_that.deliveryStatus,_that.bookingStatus,_that.products,_that.otherDetails,_that.additionalCharges,_that.serviceId,_that.pickupTime,_that.returnTime,_that.sendPdfToWhatsApp,_that.runningKilometers,_that.coolingPeriodType,_that.securityPaymentAccountId,_that.payments,_that.oldBookingAccountId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? clientId,  int? staffId,  ClientRequestEntity? client,  String? address,  String? bookedDate,  String? pickupDate,  String? returnDate,  String? coolingPeriodDate,  int? advanceAmount,  int? securityAmount,  int? discountAmount,  String? purchaseMode,  String? description,  DeliveryStatus? deliveryStatus,  BookingStatus? bookingStatus,  List<ProductSelectedEntity>? products,  BookingOtherDetailsEntity? otherDetails,  List<AdditionalChargesEntity>? additionalCharges,  int? serviceId,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool sendPdfToWhatsApp,  String? runningKilometers,  String? coolingPeriodType,  int? securityPaymentAccountId,  List<BookingPaymentRequestEntity>? payments,  int? oldBookingAccountId)?  $default,) {final _that = this;
switch (_that) {
case _BookingRequestEntity() when $default != null:
return $default(_that.clientId,_that.staffId,_that.client,_that.address,_that.bookedDate,_that.pickupDate,_that.returnDate,_that.coolingPeriodDate,_that.advanceAmount,_that.securityAmount,_that.discountAmount,_that.purchaseMode,_that.description,_that.deliveryStatus,_that.bookingStatus,_that.products,_that.otherDetails,_that.additionalCharges,_that.serviceId,_that.pickupTime,_that.returnTime,_that.sendPdfToWhatsApp,_that.runningKilometers,_that.coolingPeriodType,_that.securityPaymentAccountId,_that.payments,_that.oldBookingAccountId);case _:
  return null;

}
}

}

/// @nodoc


class _BookingRequestEntity implements BookingRequestEntity {
  const _BookingRequestEntity({this.clientId, this.staffId, this.client, this.address, this.bookedDate, this.pickupDate, this.returnDate, this.coolingPeriodDate, this.advanceAmount, this.securityAmount, this.discountAmount, this.purchaseMode, this.description, this.deliveryStatus, this.bookingStatus, final  List<ProductSelectedEntity>? products, this.otherDetails, final  List<AdditionalChargesEntity>? additionalCharges, this.serviceId, this.pickupTime, this.returnTime, this.sendPdfToWhatsApp = false, this.runningKilometers, this.coolingPeriodType, this.securityPaymentAccountId, final  List<BookingPaymentRequestEntity>? payments, this.oldBookingAccountId}): _products = products,_additionalCharges = additionalCharges,_payments = payments;
  

@override final  int? clientId;
@override final  int? staffId;
@override final  ClientRequestEntity? client;
@override final  String? address;
@override final  String? bookedDate;
@override final  String? pickupDate;
@override final  String? returnDate;
@override final  String? coolingPeriodDate;
@override final  int? advanceAmount;
@override final  int? securityAmount;
@override final  int? discountAmount;
@override final  String? purchaseMode;
@override final  String? description;
@override final  DeliveryStatus? deliveryStatus;
@override final  BookingStatus? bookingStatus;
 final  List<ProductSelectedEntity>? _products;
@override List<ProductSelectedEntity>? get products {
  final value = _products;
  if (value == null) return null;
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  BookingOtherDetailsEntity? otherDetails;
 final  List<AdditionalChargesEntity>? _additionalCharges;
@override List<AdditionalChargesEntity>? get additionalCharges {
  final value = _additionalCharges;
  if (value == null) return null;
  if (_additionalCharges is EqualUnmodifiableListView) return _additionalCharges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? serviceId;
@override final  TimeOfDay? pickupTime;
@override final  TimeOfDay? returnTime;
@override@JsonKey() final  bool sendPdfToWhatsApp;
@override final  String? runningKilometers;
@override final  String? coolingPeriodType;
@override final  int? securityPaymentAccountId;
 final  List<BookingPaymentRequestEntity>? _payments;
@override List<BookingPaymentRequestEntity>? get payments {
  final value = _payments;
  if (value == null) return null;
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? oldBookingAccountId;

/// Create a copy of BookingRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingRequestEntityCopyWith<_BookingRequestEntity> get copyWith => __$BookingRequestEntityCopyWithImpl<_BookingRequestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingRequestEntity&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.client, client) || other.client == client)&&(identical(other.address, address) || other.address == address)&&(identical(other.bookedDate, bookedDate) || other.bookedDate == bookedDate)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.coolingPeriodDate, coolingPeriodDate) || other.coolingPeriodDate == coolingPeriodDate)&&(identical(other.advanceAmount, advanceAmount) || other.advanceAmount == advanceAmount)&&(identical(other.securityAmount, securityAmount) || other.securityAmount == securityAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.purchaseMode, purchaseMode) || other.purchaseMode == purchaseMode)&&(identical(other.description, description) || other.description == description)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.otherDetails, otherDetails) || other.otherDetails == otherDetails)&&const DeepCollectionEquality().equals(other._additionalCharges, _additionalCharges)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.pickupTime, pickupTime) || other.pickupTime == pickupTime)&&(identical(other.returnTime, returnTime) || other.returnTime == returnTime)&&(identical(other.sendPdfToWhatsApp, sendPdfToWhatsApp) || other.sendPdfToWhatsApp == sendPdfToWhatsApp)&&(identical(other.runningKilometers, runningKilometers) || other.runningKilometers == runningKilometers)&&(identical(other.coolingPeriodType, coolingPeriodType) || other.coolingPeriodType == coolingPeriodType)&&(identical(other.securityPaymentAccountId, securityPaymentAccountId) || other.securityPaymentAccountId == securityPaymentAccountId)&&const DeepCollectionEquality().equals(other._payments, _payments)&&(identical(other.oldBookingAccountId, oldBookingAccountId) || other.oldBookingAccountId == oldBookingAccountId));
}


@override
int get hashCode => Object.hashAll([runtimeType,clientId,staffId,client,address,bookedDate,pickupDate,returnDate,coolingPeriodDate,advanceAmount,securityAmount,discountAmount,purchaseMode,description,deliveryStatus,bookingStatus,const DeepCollectionEquality().hash(_products),otherDetails,const DeepCollectionEquality().hash(_additionalCharges),serviceId,pickupTime,returnTime,sendPdfToWhatsApp,runningKilometers,coolingPeriodType,securityPaymentAccountId,const DeepCollectionEquality().hash(_payments),oldBookingAccountId]);

@override
String toString() {
  return 'BookingRequestEntity(clientId: $clientId, staffId: $staffId, client: $client, address: $address, bookedDate: $bookedDate, pickupDate: $pickupDate, returnDate: $returnDate, coolingPeriodDate: $coolingPeriodDate, advanceAmount: $advanceAmount, securityAmount: $securityAmount, discountAmount: $discountAmount, purchaseMode: $purchaseMode, description: $description, deliveryStatus: $deliveryStatus, bookingStatus: $bookingStatus, products: $products, otherDetails: $otherDetails, additionalCharges: $additionalCharges, serviceId: $serviceId, pickupTime: $pickupTime, returnTime: $returnTime, sendPdfToWhatsApp: $sendPdfToWhatsApp, runningKilometers: $runningKilometers, coolingPeriodType: $coolingPeriodType, securityPaymentAccountId: $securityPaymentAccountId, payments: $payments, oldBookingAccountId: $oldBookingAccountId)';
}


}

/// @nodoc
abstract mixin class _$BookingRequestEntityCopyWith<$Res> implements $BookingRequestEntityCopyWith<$Res> {
  factory _$BookingRequestEntityCopyWith(_BookingRequestEntity value, $Res Function(_BookingRequestEntity) _then) = __$BookingRequestEntityCopyWithImpl;
@override @useResult
$Res call({
 int? clientId, int? staffId, ClientRequestEntity? client, String? address, String? bookedDate, String? pickupDate, String? returnDate, String? coolingPeriodDate, int? advanceAmount, int? securityAmount, int? discountAmount, String? purchaseMode, String? description, DeliveryStatus? deliveryStatus, BookingStatus? bookingStatus, List<ProductSelectedEntity>? products, BookingOtherDetailsEntity? otherDetails, List<AdditionalChargesEntity>? additionalCharges, int? serviceId, TimeOfDay? pickupTime, TimeOfDay? returnTime, bool sendPdfToWhatsApp, String? runningKilometers, String? coolingPeriodType, int? securityPaymentAccountId, List<BookingPaymentRequestEntity>? payments, int? oldBookingAccountId
});


@override $ClientRequestEntityCopyWith<$Res>? get client;@override $BookingOtherDetailsEntityCopyWith<$Res>? get otherDetails;

}
/// @nodoc
class __$BookingRequestEntityCopyWithImpl<$Res>
    implements _$BookingRequestEntityCopyWith<$Res> {
  __$BookingRequestEntityCopyWithImpl(this._self, this._then);

  final _BookingRequestEntity _self;
  final $Res Function(_BookingRequestEntity) _then;

/// Create a copy of BookingRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = freezed,Object? staffId = freezed,Object? client = freezed,Object? address = freezed,Object? bookedDate = freezed,Object? pickupDate = freezed,Object? returnDate = freezed,Object? coolingPeriodDate = freezed,Object? advanceAmount = freezed,Object? securityAmount = freezed,Object? discountAmount = freezed,Object? purchaseMode = freezed,Object? description = freezed,Object? deliveryStatus = freezed,Object? bookingStatus = freezed,Object? products = freezed,Object? otherDetails = freezed,Object? additionalCharges = freezed,Object? serviceId = freezed,Object? pickupTime = freezed,Object? returnTime = freezed,Object? sendPdfToWhatsApp = null,Object? runningKilometers = freezed,Object? coolingPeriodType = freezed,Object? securityPaymentAccountId = freezed,Object? payments = freezed,Object? oldBookingAccountId = freezed,}) {
  return _then(_BookingRequestEntity(
clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientRequestEntity?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,bookedDate: freezed == bookedDate ? _self.bookedDate : bookedDate // ignore: cast_nullable_to_non_nullable
as String?,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,returnDate: freezed == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String?,coolingPeriodDate: freezed == coolingPeriodDate ? _self.coolingPeriodDate : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
as String?,advanceAmount: freezed == advanceAmount ? _self.advanceAmount : advanceAmount // ignore: cast_nullable_to_non_nullable
as int?,securityAmount: freezed == securityAmount ? _self.securityAmount : securityAmount // ignore: cast_nullable_to_non_nullable
as int?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,purchaseMode: freezed == purchaseMode ? _self.purchaseMode : purchaseMode // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,deliveryStatus: freezed == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus?,bookingStatus: freezed == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus?,products: freezed == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductSelectedEntity>?,otherDetails: freezed == otherDetails ? _self.otherDetails : otherDetails // ignore: cast_nullable_to_non_nullable
as BookingOtherDetailsEntity?,additionalCharges: freezed == additionalCharges ? _self._additionalCharges : additionalCharges // ignore: cast_nullable_to_non_nullable
as List<AdditionalChargesEntity>?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,pickupTime: freezed == pickupTime ? _self.pickupTime : pickupTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,returnTime: freezed == returnTime ? _self.returnTime : returnTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,sendPdfToWhatsApp: null == sendPdfToWhatsApp ? _self.sendPdfToWhatsApp : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
as bool,runningKilometers: freezed == runningKilometers ? _self.runningKilometers : runningKilometers // ignore: cast_nullable_to_non_nullable
as String?,coolingPeriodType: freezed == coolingPeriodType ? _self.coolingPeriodType : coolingPeriodType // ignore: cast_nullable_to_non_nullable
as String?,securityPaymentAccountId: freezed == securityPaymentAccountId ? _self.securityPaymentAccountId : securityPaymentAccountId // ignore: cast_nullable_to_non_nullable
as int?,payments: freezed == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<BookingPaymentRequestEntity>?,oldBookingAccountId: freezed == oldBookingAccountId ? _self.oldBookingAccountId : oldBookingAccountId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of BookingRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientRequestEntityCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $ClientRequestEntityCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of BookingRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingOtherDetailsEntityCopyWith<$Res>? get otherDetails {
    if (_self.otherDetails == null) {
    return null;
  }

  return $BookingOtherDetailsEntityCopyWith<$Res>(_self.otherDetails!, (value) {
    return _then(_self.copyWith(otherDetails: value));
  });
}
}

// dart format on
