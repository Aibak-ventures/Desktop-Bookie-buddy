// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingRequestModel {

@JsonKey(name: 'client_id') int? get clientId;@JsonKey(name: 'staff_id') int? get staffId;@JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false) ClientRequestModel? get client;@JsonKey(name: 'client_address') String? get address;@JsonKey(name: 'booked_date') String? get bookedDate;@JsonKey(name: 'pickup_date') String? get pickupDate;@JsonKey(name: 'return_date') String? get returnDate;@JsonKey(name: 'cooling_period_end') String? get coolingPeriodDate;@JsonKey(name: 'advance_amount') int? get advanceAmount;@JsonKey(name: 'security_amount') int? get securityAmount;@JsonKey(name: 'security_amount_is_paid') bool? get isSecurityPaid;@JsonKey(name: 'security_paid_at') String? get securityPaidDate;@JsonKey(name: 'discount_amount') int? get discountAmount;@JsonKey(name: 'purchase_mode') String? get purchaseMode;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'payments') List<BookingPaymentRequestModel>? get payments;@JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson) DeliveryStatus? get deliveryStatus;@JsonKey(name: 'booking_status', toJson: BookingStatus.toJson) BookingStatus? get bookingStatus;@JsonKey(name: 'variants', toJson: _productsToJson) List<ProductSelectedModel>? get products;@JsonKey(name: 'details') BookingOtherDetailsModel? get otherDetails;@JsonKey(name: 'additional_charges') List<AdditionalChargesModel>? get additionalCharges;@JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false) int? get serviceId;@JsonKey(name: 'pickup_time', toJson: _pickupTimeToJson, includeFromJson: false) TimeOfDay? get pickupTime;@JsonKey(name: 'return_time', toJson: _returnTimeToJson, includeFromJson: false) TimeOfDay? get returnTime;@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) bool get sendPdfToWhatsApp;@JsonKey(name: 'cooling_period_type', toJson: CoolingPeriodMode.tryToJson) CoolingPeriodMode? get coolingPeriodType;@JsonKey(name: 'security_account_id') int? get securityPaymentAccountId;@JsonKey(name: 'account_id') int? get oldBookingAccountId;@JsonKey(name: 'tax_amount') int? get taxAmount;
/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingRequestModelCopyWith<BookingRequestModel> get copyWith => _$BookingRequestModelCopyWithImpl<BookingRequestModel>(this as BookingRequestModel, _$identity);

  /// Serializes this BookingRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BookingRequestModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingRequestModel&&(identical(other.clientId, _this.clientId) || other.clientId == _this.clientId)&&(identical(other.staffId, _this.staffId) || other.staffId == _this.staffId)&&(identical(other.client, _this.client) || other.client == _this.client)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.bookedDate, _this.bookedDate) || other.bookedDate == _this.bookedDate)&&(identical(other.pickupDate, _this.pickupDate) || other.pickupDate == _this.pickupDate)&&(identical(other.returnDate, _this.returnDate) || other.returnDate == _this.returnDate)&&(identical(other.coolingPeriodDate, _this.coolingPeriodDate) || other.coolingPeriodDate == _this.coolingPeriodDate)&&(identical(other.advanceAmount, _this.advanceAmount) || other.advanceAmount == _this.advanceAmount)&&(identical(other.securityAmount, _this.securityAmount) || other.securityAmount == _this.securityAmount)&&(identical(other.isSecurityPaid, _this.isSecurityPaid) || other.isSecurityPaid == _this.isSecurityPaid)&&(identical(other.securityPaidDate, _this.securityPaidDate) || other.securityPaidDate == _this.securityPaidDate)&&(identical(other.discountAmount, _this.discountAmount) || other.discountAmount == _this.discountAmount)&&(identical(other.purchaseMode, _this.purchaseMode) || other.purchaseMode == _this.purchaseMode)&&(identical(other.description, _this.description) || other.description == _this.description)&&const DeepCollectionEquality().equals(other.payments, _this.payments)&&(identical(other.deliveryStatus, _this.deliveryStatus) || other.deliveryStatus == _this.deliveryStatus)&&(identical(other.bookingStatus, _this.bookingStatus) || other.bookingStatus == _this.bookingStatus)&&const DeepCollectionEquality().equals(other.products, _this.products)&&(identical(other.otherDetails, _this.otherDetails) || other.otherDetails == _this.otherDetails)&&const DeepCollectionEquality().equals(other.additionalCharges, _this.additionalCharges)&&(identical(other.serviceId, _this.serviceId) || other.serviceId == _this.serviceId)&&(identical(other.pickupTime, _this.pickupTime) || other.pickupTime == _this.pickupTime)&&(identical(other.returnTime, _this.returnTime) || other.returnTime == _this.returnTime)&&(identical(other.sendPdfToWhatsApp, _this.sendPdfToWhatsApp) || other.sendPdfToWhatsApp == _this.sendPdfToWhatsApp)&&(identical(other.coolingPeriodType, _this.coolingPeriodType) || other.coolingPeriodType == _this.coolingPeriodType)&&(identical(other.securityPaymentAccountId, _this.securityPaymentAccountId) || other.securityPaymentAccountId == _this.securityPaymentAccountId)&&(identical(other.oldBookingAccountId, _this.oldBookingAccountId) || other.oldBookingAccountId == _this.oldBookingAccountId)&&(identical(other.taxAmount, _this.taxAmount) || other.taxAmount == _this.taxAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BookingRequestModel;
  return Object.hashAll([runtimeType,_this.clientId,_this.staffId,_this.client,_this.address,_this.bookedDate,_this.pickupDate,_this.returnDate,_this.coolingPeriodDate,_this.advanceAmount,_this.securityAmount,_this.isSecurityPaid,_this.securityPaidDate,_this.discountAmount,_this.purchaseMode,_this.description,const DeepCollectionEquality().hash(_this.payments),_this.deliveryStatus,_this.bookingStatus,const DeepCollectionEquality().hash(_this.products),_this.otherDetails,const DeepCollectionEquality().hash(_this.additionalCharges),_this.serviceId,_this.pickupTime,_this.returnTime,_this.sendPdfToWhatsApp,_this.coolingPeriodType,_this.securityPaymentAccountId,_this.oldBookingAccountId,_this.taxAmount]);
}

@override
String toString() {
  final _this = this as BookingRequestModel;
  return 'BookingRequestModel(clientId: ${_this.clientId}, staffId: ${_this.staffId}, client: ${_this.client}, address: ${_this.address}, bookedDate: ${_this.bookedDate}, pickupDate: ${_this.pickupDate}, returnDate: ${_this.returnDate}, coolingPeriodDate: ${_this.coolingPeriodDate}, advanceAmount: ${_this.advanceAmount}, securityAmount: ${_this.securityAmount}, isSecurityPaid: ${_this.isSecurityPaid}, securityPaidDate: ${_this.securityPaidDate}, discountAmount: ${_this.discountAmount}, purchaseMode: ${_this.purchaseMode}, description: ${_this.description}, payments: ${_this.payments}, deliveryStatus: ${_this.deliveryStatus}, bookingStatus: ${_this.bookingStatus}, products: ${_this.products}, otherDetails: ${_this.otherDetails}, additionalCharges: ${_this.additionalCharges}, serviceId: ${_this.serviceId}, pickupTime: ${_this.pickupTime}, returnTime: ${_this.returnTime}, sendPdfToWhatsApp: ${_this.sendPdfToWhatsApp}, coolingPeriodType: ${_this.coolingPeriodType}, securityPaymentAccountId: ${_this.securityPaymentAccountId}, oldBookingAccountId: ${_this.oldBookingAccountId}, taxAmount: ${_this.taxAmount})';
}


}

/// @nodoc
abstract mixin class $BookingRequestModelCopyWith<$Res>  {
  factory $BookingRequestModelCopyWith(BookingRequestModel value, $Res Function(BookingRequestModel) _then) = _$BookingRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'client_id') int? clientId,@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false) ClientRequestModel? client,@JsonKey(name: 'client_address') String? address,@JsonKey(name: 'booked_date') String? bookedDate,@JsonKey(name: 'pickup_date') String? pickupDate,@JsonKey(name: 'return_date') String? returnDate,@JsonKey(name: 'cooling_period_end') String? coolingPeriodDate,@JsonKey(name: 'advance_amount') int? advanceAmount,@JsonKey(name: 'security_amount') int? securityAmount,@JsonKey(name: 'security_amount_is_paid') bool? isSecurityPaid,@JsonKey(name: 'security_paid_at') String? securityPaidDate,@JsonKey(name: 'discount_amount') int? discountAmount,@JsonKey(name: 'purchase_mode') String? purchaseMode,@JsonKey(name: 'description') String? description,@JsonKey(name: 'payments') List<BookingPaymentRequestModel>? payments,@JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson) DeliveryStatus? deliveryStatus,@JsonKey(name: 'booking_status', toJson: BookingStatus.toJson) BookingStatus? bookingStatus,@JsonKey(name: 'variants', toJson: _productsToJson) List<ProductSelectedModel>? products,@JsonKey(name: 'details') BookingOtherDetailsModel? otherDetails,@JsonKey(name: 'additional_charges') List<AdditionalChargesModel>? additionalCharges,@JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false) int? serviceId,@JsonKey(name: 'pickup_time', toJson: _pickupTimeToJson, includeFromJson: false) TimeOfDay? pickupTime,@JsonKey(name: 'return_time', toJson: _returnTimeToJson, includeFromJson: false) TimeOfDay? returnTime,@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) bool sendPdfToWhatsApp,@JsonKey(name: 'cooling_period_type', toJson: CoolingPeriodMode.tryToJson) CoolingPeriodMode? coolingPeriodType,@JsonKey(name: 'security_account_id') int? securityPaymentAccountId,@JsonKey(name: 'account_id') int? oldBookingAccountId,@JsonKey(name: 'tax_amount') int? taxAmount
});


$ClientRequestModelCopyWith<$Res>? get client;$BookingOtherDetailsModelCopyWith<$Res>? get otherDetails;

}
/// @nodoc
class _$BookingRequestModelCopyWithImpl<$Res>
    implements $BookingRequestModelCopyWith<$Res> {
  _$BookingRequestModelCopyWithImpl(this._self, this._then);

  final BookingRequestModel _self;
  final $Res Function(BookingRequestModel) _then;

/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = freezed,Object? staffId = freezed,Object? client = freezed,Object? address = freezed,Object? bookedDate = freezed,Object? pickupDate = freezed,Object? returnDate = freezed,Object? coolingPeriodDate = freezed,Object? advanceAmount = freezed,Object? securityAmount = freezed,Object? isSecurityPaid = freezed,Object? securityPaidDate = freezed,Object? discountAmount = freezed,Object? purchaseMode = freezed,Object? description = freezed,Object? payments = freezed,Object? deliveryStatus = freezed,Object? bookingStatus = freezed,Object? products = freezed,Object? otherDetails = freezed,Object? additionalCharges = freezed,Object? serviceId = freezed,Object? pickupTime = freezed,Object? returnTime = freezed,Object? sendPdfToWhatsApp = null,Object? coolingPeriodType = freezed,Object? securityPaymentAccountId = freezed,Object? oldBookingAccountId = freezed,Object? taxAmount = freezed,}) {
  return _then(BookingRequestModel(
clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientRequestModel?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,bookedDate: freezed == bookedDate ? _self.bookedDate : bookedDate // ignore: cast_nullable_to_non_nullable
as String?,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,returnDate: freezed == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String?,coolingPeriodDate: freezed == coolingPeriodDate ? _self.coolingPeriodDate : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
as String?,advanceAmount: freezed == advanceAmount ? _self.advanceAmount : advanceAmount // ignore: cast_nullable_to_non_nullable
as int?,securityAmount: freezed == securityAmount ? _self.securityAmount : securityAmount // ignore: cast_nullable_to_non_nullable
as int?,isSecurityPaid: freezed == isSecurityPaid ? _self.isSecurityPaid : isSecurityPaid // ignore: cast_nullable_to_non_nullable
as bool?,securityPaidDate: freezed == securityPaidDate ? _self.securityPaidDate : securityPaidDate // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,purchaseMode: freezed == purchaseMode ? _self.purchaseMode : purchaseMode // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,payments: freezed == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<BookingPaymentRequestModel>?,deliveryStatus: freezed == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus?,bookingStatus: freezed == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus?,products: freezed == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductSelectedModel>?,otherDetails: freezed == otherDetails ? _self.otherDetails : otherDetails // ignore: cast_nullable_to_non_nullable
as BookingOtherDetailsModel?,additionalCharges: freezed == additionalCharges ? _self.additionalCharges : additionalCharges // ignore: cast_nullable_to_non_nullable
as List<AdditionalChargesModel>?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,pickupTime: freezed == pickupTime ? _self.pickupTime : pickupTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,returnTime: freezed == returnTime ? _self.returnTime : returnTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,sendPdfToWhatsApp: null == sendPdfToWhatsApp ? _self.sendPdfToWhatsApp : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
as bool,coolingPeriodType: freezed == coolingPeriodType ? _self.coolingPeriodType : coolingPeriodType // ignore: cast_nullable_to_non_nullable
as CoolingPeriodMode?,securityPaymentAccountId: freezed == securityPaymentAccountId ? _self.securityPaymentAccountId : securityPaymentAccountId // ignore: cast_nullable_to_non_nullable
as int?,oldBookingAccountId: freezed == oldBookingAccountId ? _self.oldBookingAccountId : oldBookingAccountId // ignore: cast_nullable_to_non_nullable
as int?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientRequestModelCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $ClientRequestModelCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingOtherDetailsModelCopyWith<$Res>? get otherDetails {
    if (_self.otherDetails == null) {
    return null;
  }

  return $BookingOtherDetailsModelCopyWith<$Res>(_self.otherDetails!, (value) {
    return _then(_self.copyWith(otherDetails: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingRequestModel].
extension BookingRequestModelPatterns on BookingRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'client_id')  int? clientId, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false)  ClientRequestModel? client, @JsonKey(name: 'client_address')  String? address, @JsonKey(name: 'booked_date')  String? bookedDate, @JsonKey(name: 'pickup_date')  String? pickupDate, @JsonKey(name: 'return_date')  String? returnDate, @JsonKey(name: 'cooling_period_end')  String? coolingPeriodDate, @JsonKey(name: 'advance_amount')  int? advanceAmount, @JsonKey(name: 'security_amount')  int? securityAmount, @JsonKey(name: 'security_amount_is_paid')  bool? isSecurityPaid, @JsonKey(name: 'security_paid_at')  String? securityPaidDate, @JsonKey(name: 'discount_amount')  int? discountAmount, @JsonKey(name: 'purchase_mode')  String? purchaseMode, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'payments')  List<BookingPaymentRequestModel>? payments, @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson)  DeliveryStatus? deliveryStatus, @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson)  BookingStatus? bookingStatus, @JsonKey(name: 'variants', toJson: _productsToJson)  List<ProductSelectedModel>? products, @JsonKey(name: 'details')  BookingOtherDetailsModel? otherDetails, @JsonKey(name: 'additional_charges')  List<AdditionalChargesModel>? additionalCharges, @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false)  int? serviceId, @JsonKey(name: 'pickup_time', toJson: _pickupTimeToJson, includeFromJson: false)  TimeOfDay? pickupTime, @JsonKey(name: 'return_time', toJson: _returnTimeToJson, includeFromJson: false)  TimeOfDay? returnTime, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)  bool sendPdfToWhatsApp, @JsonKey(name: 'cooling_period_type', toJson: CoolingPeriodMode.tryToJson)  CoolingPeriodMode? coolingPeriodType, @JsonKey(name: 'security_account_id')  int? securityPaymentAccountId, @JsonKey(name: 'account_id')  int? oldBookingAccountId, @JsonKey(name: 'tax_amount')  int? taxAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingRequestModel() when $default != null:
return $default(_that.clientId,_that.staffId,_that.client,_that.address,_that.bookedDate,_that.pickupDate,_that.returnDate,_that.coolingPeriodDate,_that.advanceAmount,_that.securityAmount,_that.isSecurityPaid,_that.securityPaidDate,_that.discountAmount,_that.purchaseMode,_that.description,_that.payments,_that.deliveryStatus,_that.bookingStatus,_that.products,_that.otherDetails,_that.additionalCharges,_that.serviceId,_that.pickupTime,_that.returnTime,_that.sendPdfToWhatsApp,_that.coolingPeriodType,_that.securityPaymentAccountId,_that.oldBookingAccountId,_that.taxAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'client_id')  int? clientId, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false)  ClientRequestModel? client, @JsonKey(name: 'client_address')  String? address, @JsonKey(name: 'booked_date')  String? bookedDate, @JsonKey(name: 'pickup_date')  String? pickupDate, @JsonKey(name: 'return_date')  String? returnDate, @JsonKey(name: 'cooling_period_end')  String? coolingPeriodDate, @JsonKey(name: 'advance_amount')  int? advanceAmount, @JsonKey(name: 'security_amount')  int? securityAmount, @JsonKey(name: 'security_amount_is_paid')  bool? isSecurityPaid, @JsonKey(name: 'security_paid_at')  String? securityPaidDate, @JsonKey(name: 'discount_amount')  int? discountAmount, @JsonKey(name: 'purchase_mode')  String? purchaseMode, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'payments')  List<BookingPaymentRequestModel>? payments, @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson)  DeliveryStatus? deliveryStatus, @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson)  BookingStatus? bookingStatus, @JsonKey(name: 'variants', toJson: _productsToJson)  List<ProductSelectedModel>? products, @JsonKey(name: 'details')  BookingOtherDetailsModel? otherDetails, @JsonKey(name: 'additional_charges')  List<AdditionalChargesModel>? additionalCharges, @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false)  int? serviceId, @JsonKey(name: 'pickup_time', toJson: _pickupTimeToJson, includeFromJson: false)  TimeOfDay? pickupTime, @JsonKey(name: 'return_time', toJson: _returnTimeToJson, includeFromJson: false)  TimeOfDay? returnTime, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)  bool sendPdfToWhatsApp, @JsonKey(name: 'cooling_period_type', toJson: CoolingPeriodMode.tryToJson)  CoolingPeriodMode? coolingPeriodType, @JsonKey(name: 'security_account_id')  int? securityPaymentAccountId, @JsonKey(name: 'account_id')  int? oldBookingAccountId, @JsonKey(name: 'tax_amount')  int? taxAmount)  $default,) {final _that = this;
switch (_that) {
case _BookingRequestModel():
return $default(_that.clientId,_that.staffId,_that.client,_that.address,_that.bookedDate,_that.pickupDate,_that.returnDate,_that.coolingPeriodDate,_that.advanceAmount,_that.securityAmount,_that.isSecurityPaid,_that.securityPaidDate,_that.discountAmount,_that.purchaseMode,_that.description,_that.payments,_that.deliveryStatus,_that.bookingStatus,_that.products,_that.otherDetails,_that.additionalCharges,_that.serviceId,_that.pickupTime,_that.returnTime,_that.sendPdfToWhatsApp,_that.coolingPeriodType,_that.securityPaymentAccountId,_that.oldBookingAccountId,_that.taxAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'client_id')  int? clientId, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false)  ClientRequestModel? client, @JsonKey(name: 'client_address')  String? address, @JsonKey(name: 'booked_date')  String? bookedDate, @JsonKey(name: 'pickup_date')  String? pickupDate, @JsonKey(name: 'return_date')  String? returnDate, @JsonKey(name: 'cooling_period_end')  String? coolingPeriodDate, @JsonKey(name: 'advance_amount')  int? advanceAmount, @JsonKey(name: 'security_amount')  int? securityAmount, @JsonKey(name: 'security_amount_is_paid')  bool? isSecurityPaid, @JsonKey(name: 'security_paid_at')  String? securityPaidDate, @JsonKey(name: 'discount_amount')  int? discountAmount, @JsonKey(name: 'purchase_mode')  String? purchaseMode, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'payments')  List<BookingPaymentRequestModel>? payments, @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson)  DeliveryStatus? deliveryStatus, @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson)  BookingStatus? bookingStatus, @JsonKey(name: 'variants', toJson: _productsToJson)  List<ProductSelectedModel>? products, @JsonKey(name: 'details')  BookingOtherDetailsModel? otherDetails, @JsonKey(name: 'additional_charges')  List<AdditionalChargesModel>? additionalCharges, @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false)  int? serviceId, @JsonKey(name: 'pickup_time', toJson: _pickupTimeToJson, includeFromJson: false)  TimeOfDay? pickupTime, @JsonKey(name: 'return_time', toJson: _returnTimeToJson, includeFromJson: false)  TimeOfDay? returnTime, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)  bool sendPdfToWhatsApp, @JsonKey(name: 'cooling_period_type', toJson: CoolingPeriodMode.tryToJson)  CoolingPeriodMode? coolingPeriodType, @JsonKey(name: 'security_account_id')  int? securityPaymentAccountId, @JsonKey(name: 'account_id')  int? oldBookingAccountId, @JsonKey(name: 'tax_amount')  int? taxAmount)?  $default,) {final _that = this;
switch (_that) {
case _BookingRequestModel() when $default != null:
return $default(_that.clientId,_that.staffId,_that.client,_that.address,_that.bookedDate,_that.pickupDate,_that.returnDate,_that.coolingPeriodDate,_that.advanceAmount,_that.securityAmount,_that.isSecurityPaid,_that.securityPaidDate,_that.discountAmount,_that.purchaseMode,_that.description,_that.payments,_that.deliveryStatus,_that.bookingStatus,_that.products,_that.otherDetails,_that.additionalCharges,_that.serviceId,_that.pickupTime,_that.returnTime,_that.sendPdfToWhatsApp,_that.coolingPeriodType,_that.securityPaymentAccountId,_that.oldBookingAccountId,_that.taxAmount);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _BookingRequestModel implements BookingRequestModel {
  const _BookingRequestModel({@JsonKey(name: 'client_id') this.clientId, @JsonKey(name: 'staff_id') this.staffId, @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false) this.client, @JsonKey(name: 'client_address') this.address, @JsonKey(name: 'booked_date') this.bookedDate, @JsonKey(name: 'pickup_date') this.pickupDate, @JsonKey(name: 'return_date') this.returnDate, @JsonKey(name: 'cooling_period_end') this.coolingPeriodDate, @JsonKey(name: 'advance_amount') this.advanceAmount, @JsonKey(name: 'security_amount') this.securityAmount, @JsonKey(name: 'security_amount_is_paid') this.isSecurityPaid, @JsonKey(name: 'security_paid_at') this.securityPaidDate, @JsonKey(name: 'discount_amount') this.discountAmount, @JsonKey(name: 'purchase_mode') this.purchaseMode, @JsonKey(name: 'description') this.description, @JsonKey(name: 'payments')  List<BookingPaymentRequestModel>? payments, @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson) this.deliveryStatus, @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson) this.bookingStatus, @JsonKey(name: 'variants', toJson: _productsToJson)  List<ProductSelectedModel>? products, @JsonKey(name: 'details') this.otherDetails, @JsonKey(name: 'additional_charges')  List<AdditionalChargesModel>? additionalCharges, @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false) this.serviceId, @JsonKey(name: 'pickup_time', toJson: _pickupTimeToJson, includeFromJson: false) this.pickupTime, @JsonKey(name: 'return_time', toJson: _returnTimeToJson, includeFromJson: false) this.returnTime, @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) this.sendPdfToWhatsApp = false, @JsonKey(name: 'cooling_period_type', toJson: CoolingPeriodMode.tryToJson) this.coolingPeriodType, @JsonKey(name: 'security_account_id') this.securityPaymentAccountId, @JsonKey(name: 'account_id') this.oldBookingAccountId, @JsonKey(name: 'tax_amount') this.taxAmount}): _payments = payments,_products = products,_additionalCharges = additionalCharges;
  factory _BookingRequestModel.fromJson(Map<String, dynamic> json) => _$BookingRequestModelFromJson(json);

@override@JsonKey(name: 'client_id') final  int? clientId;
@override@JsonKey(name: 'staff_id') final  int? staffId;
@override@JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false) final  ClientRequestModel? client;
@override@JsonKey(name: 'client_address') final  String? address;
@override@JsonKey(name: 'booked_date') final  String? bookedDate;
@override@JsonKey(name: 'pickup_date') final  String? pickupDate;
@override@JsonKey(name: 'return_date') final  String? returnDate;
@override@JsonKey(name: 'cooling_period_end') final  String? coolingPeriodDate;
@override@JsonKey(name: 'advance_amount') final  int? advanceAmount;
@override@JsonKey(name: 'security_amount') final  int? securityAmount;
@override@JsonKey(name: 'security_amount_is_paid') final  bool? isSecurityPaid;
@override@JsonKey(name: 'security_paid_at') final  String? securityPaidDate;
@override@JsonKey(name: 'discount_amount') final  int? discountAmount;
@override@JsonKey(name: 'purchase_mode') final  String? purchaseMode;
@override@JsonKey(name: 'description') final  String? description;
 final  List<BookingPaymentRequestModel>? _payments;
@override@JsonKey(name: 'payments') List<BookingPaymentRequestModel>? get payments {
  final value = _payments;
  if (value == null) return null;
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson) final  DeliveryStatus? deliveryStatus;
@override@JsonKey(name: 'booking_status', toJson: BookingStatus.toJson) final  BookingStatus? bookingStatus;
 final  List<ProductSelectedModel>? _products;
@override@JsonKey(name: 'variants', toJson: _productsToJson) List<ProductSelectedModel>? get products {
  final value = _products;
  if (value == null) return null;
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'details') final  BookingOtherDetailsModel? otherDetails;
 final  List<AdditionalChargesModel>? _additionalCharges;
@override@JsonKey(name: 'additional_charges') List<AdditionalChargesModel>? get additionalCharges {
  final value = _additionalCharges;
  if (value == null) return null;
  if (_additionalCharges is EqualUnmodifiableListView) return _additionalCharges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false) final  int? serviceId;
@override@JsonKey(name: 'pickup_time', toJson: _pickupTimeToJson, includeFromJson: false) final  TimeOfDay? pickupTime;
@override@JsonKey(name: 'return_time', toJson: _returnTimeToJson, includeFromJson: false) final  TimeOfDay? returnTime;
@override@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) final  bool sendPdfToWhatsApp;
@override@JsonKey(name: 'cooling_period_type', toJson: CoolingPeriodMode.tryToJson) final  CoolingPeriodMode? coolingPeriodType;
@override@JsonKey(name: 'security_account_id') final  int? securityPaymentAccountId;
@override@JsonKey(name: 'account_id') final  int? oldBookingAccountId;
@override@JsonKey(name: 'tax_amount') final  int? taxAmount;

/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingRequestModelCopyWith<_BookingRequestModel> get copyWith => __$BookingRequestModelCopyWithImpl<_BookingRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingRequestModel&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.client, client) || other.client == client)&&(identical(other.address, address) || other.address == address)&&(identical(other.bookedDate, bookedDate) || other.bookedDate == bookedDate)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.coolingPeriodDate, coolingPeriodDate) || other.coolingPeriodDate == coolingPeriodDate)&&(identical(other.advanceAmount, advanceAmount) || other.advanceAmount == advanceAmount)&&(identical(other.securityAmount, securityAmount) || other.securityAmount == securityAmount)&&(identical(other.isSecurityPaid, isSecurityPaid) || other.isSecurityPaid == isSecurityPaid)&&(identical(other.securityPaidDate, securityPaidDate) || other.securityPaidDate == securityPaidDate)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.purchaseMode, purchaseMode) || other.purchaseMode == purchaseMode)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.payments, _payments)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&const DeepCollectionEquality().equals(other.products, _products)&&(identical(other.otherDetails, otherDetails) || other.otherDetails == otherDetails)&&const DeepCollectionEquality().equals(other.additionalCharges, _additionalCharges)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.pickupTime, pickupTime) || other.pickupTime == pickupTime)&&(identical(other.returnTime, returnTime) || other.returnTime == returnTime)&&(identical(other.sendPdfToWhatsApp, sendPdfToWhatsApp) || other.sendPdfToWhatsApp == sendPdfToWhatsApp)&&(identical(other.coolingPeriodType, coolingPeriodType) || other.coolingPeriodType == coolingPeriodType)&&(identical(other.securityPaymentAccountId, securityPaymentAccountId) || other.securityPaymentAccountId == securityPaymentAccountId)&&(identical(other.oldBookingAccountId, oldBookingAccountId) || other.oldBookingAccountId == oldBookingAccountId)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,clientId,staffId,client,address,bookedDate,pickupDate,returnDate,coolingPeriodDate,advanceAmount,securityAmount,isSecurityPaid,securityPaidDate,discountAmount,purchaseMode,description,const DeepCollectionEquality().hash(_payments),deliveryStatus,bookingStatus,const DeepCollectionEquality().hash(_products),otherDetails,const DeepCollectionEquality().hash(_additionalCharges),serviceId,pickupTime,returnTime,sendPdfToWhatsApp,coolingPeriodType,securityPaymentAccountId,oldBookingAccountId,taxAmount]);
}

@override
String toString() {
    return 'BookingRequestModel(clientId: $clientId, staffId: $staffId, client: $client, address: $address, bookedDate: $bookedDate, pickupDate: $pickupDate, returnDate: $returnDate, coolingPeriodDate: $coolingPeriodDate, advanceAmount: $advanceAmount, securityAmount: $securityAmount, isSecurityPaid: $isSecurityPaid, securityPaidDate: $securityPaidDate, discountAmount: $discountAmount, purchaseMode: $purchaseMode, description: $description, payments: $payments, deliveryStatus: $deliveryStatus, bookingStatus: $bookingStatus, products: $products, otherDetails: $otherDetails, additionalCharges: $additionalCharges, serviceId: $serviceId, pickupTime: $pickupTime, returnTime: $returnTime, sendPdfToWhatsApp: $sendPdfToWhatsApp, coolingPeriodType: $coolingPeriodType, securityPaymentAccountId: $securityPaymentAccountId, oldBookingAccountId: $oldBookingAccountId, taxAmount: $taxAmount)';
}


}

/// @nodoc
abstract mixin class _$BookingRequestModelCopyWith<$Res> implements $BookingRequestModelCopyWith<$Res> {
  factory _$BookingRequestModelCopyWith(_BookingRequestModel value, $Res Function(_BookingRequestModel) _then) = __$BookingRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'client_id') int? clientId,@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false) ClientRequestModel? client,@JsonKey(name: 'client_address') String? address,@JsonKey(name: 'booked_date') String? bookedDate,@JsonKey(name: 'pickup_date') String? pickupDate,@JsonKey(name: 'return_date') String? returnDate,@JsonKey(name: 'cooling_period_end') String? coolingPeriodDate,@JsonKey(name: 'advance_amount') int? advanceAmount,@JsonKey(name: 'security_amount') int? securityAmount,@JsonKey(name: 'security_amount_is_paid') bool? isSecurityPaid,@JsonKey(name: 'security_paid_at') String? securityPaidDate,@JsonKey(name: 'discount_amount') int? discountAmount,@JsonKey(name: 'purchase_mode') String? purchaseMode,@JsonKey(name: 'description') String? description,@JsonKey(name: 'payments') List<BookingPaymentRequestModel>? payments,@JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson) DeliveryStatus? deliveryStatus,@JsonKey(name: 'booking_status', toJson: BookingStatus.toJson) BookingStatus? bookingStatus,@JsonKey(name: 'variants', toJson: _productsToJson) List<ProductSelectedModel>? products,@JsonKey(name: 'details') BookingOtherDetailsModel? otherDetails,@JsonKey(name: 'additional_charges') List<AdditionalChargesModel>? additionalCharges,@JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false) int? serviceId,@JsonKey(name: 'pickup_time', toJson: _pickupTimeToJson, includeFromJson: false) TimeOfDay? pickupTime,@JsonKey(name: 'return_time', toJson: _returnTimeToJson, includeFromJson: false) TimeOfDay? returnTime,@JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false) bool sendPdfToWhatsApp,@JsonKey(name: 'cooling_period_type', toJson: CoolingPeriodMode.tryToJson) CoolingPeriodMode? coolingPeriodType,@JsonKey(name: 'security_account_id') int? securityPaymentAccountId,@JsonKey(name: 'account_id') int? oldBookingAccountId,@JsonKey(name: 'tax_amount') int? taxAmount
});


@override $ClientRequestModelCopyWith<$Res>? get client;@override $BookingOtherDetailsModelCopyWith<$Res>? get otherDetails;

}
/// @nodoc
class __$BookingRequestModelCopyWithImpl<$Res>
    implements _$BookingRequestModelCopyWith<$Res> {
  __$BookingRequestModelCopyWithImpl(this._self, this._then);

  final _BookingRequestModel _self;
  final $Res Function(_BookingRequestModel) _then;

/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = freezed,Object? staffId = freezed,Object? client = freezed,Object? address = freezed,Object? bookedDate = freezed,Object? pickupDate = freezed,Object? returnDate = freezed,Object? coolingPeriodDate = freezed,Object? advanceAmount = freezed,Object? securityAmount = freezed,Object? isSecurityPaid = freezed,Object? securityPaidDate = freezed,Object? discountAmount = freezed,Object? purchaseMode = freezed,Object? description = freezed,Object? payments = freezed,Object? deliveryStatus = freezed,Object? bookingStatus = freezed,Object? products = freezed,Object? otherDetails = freezed,Object? additionalCharges = freezed,Object? serviceId = freezed,Object? pickupTime = freezed,Object? returnTime = freezed,Object? sendPdfToWhatsApp = null,Object? coolingPeriodType = freezed,Object? securityPaymentAccountId = freezed,Object? oldBookingAccountId = freezed,Object? taxAmount = freezed,}) {
  return _then(_BookingRequestModel(
clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientRequestModel?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,bookedDate: freezed == bookedDate ? _self.bookedDate : bookedDate // ignore: cast_nullable_to_non_nullable
as String?,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,returnDate: freezed == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String?,coolingPeriodDate: freezed == coolingPeriodDate ? _self.coolingPeriodDate : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
as String?,advanceAmount: freezed == advanceAmount ? _self.advanceAmount : advanceAmount // ignore: cast_nullable_to_non_nullable
as int?,securityAmount: freezed == securityAmount ? _self.securityAmount : securityAmount // ignore: cast_nullable_to_non_nullable
as int?,isSecurityPaid: freezed == isSecurityPaid ? _self.isSecurityPaid : isSecurityPaid // ignore: cast_nullable_to_non_nullable
as bool?,securityPaidDate: freezed == securityPaidDate ? _self.securityPaidDate : securityPaidDate // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,purchaseMode: freezed == purchaseMode ? _self.purchaseMode : purchaseMode // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,payments: freezed == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<BookingPaymentRequestModel>?,deliveryStatus: freezed == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus?,bookingStatus: freezed == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus?,products: freezed == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductSelectedModel>?,otherDetails: freezed == otherDetails ? _self.otherDetails : otherDetails // ignore: cast_nullable_to_non_nullable
as BookingOtherDetailsModel?,additionalCharges: freezed == additionalCharges ? _self._additionalCharges : additionalCharges // ignore: cast_nullable_to_non_nullable
as List<AdditionalChargesModel>?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,pickupTime: freezed == pickupTime ? _self.pickupTime : pickupTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,returnTime: freezed == returnTime ? _self.returnTime : returnTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,sendPdfToWhatsApp: null == sendPdfToWhatsApp ? _self.sendPdfToWhatsApp : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
as bool,coolingPeriodType: freezed == coolingPeriodType ? _self.coolingPeriodType : coolingPeriodType // ignore: cast_nullable_to_non_nullable
as CoolingPeriodMode?,securityPaymentAccountId: freezed == securityPaymentAccountId ? _self.securityPaymentAccountId : securityPaymentAccountId // ignore: cast_nullable_to_non_nullable
as int?,oldBookingAccountId: freezed == oldBookingAccountId ? _self.oldBookingAccountId : oldBookingAccountId // ignore: cast_nullable_to_non_nullable
as int?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientRequestModelCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $ClientRequestModelCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of BookingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingOtherDetailsModelCopyWith<$Res>? get otherDetails {
    if (_self.otherDetails == null) {
    return null;
  }

  return $BookingOtherDetailsModelCopyWith<$Res>(_self.otherDetails!, (value) {
    return _then(_self.copyWith(otherDetails: value));
  });
}
}

// dart format on
