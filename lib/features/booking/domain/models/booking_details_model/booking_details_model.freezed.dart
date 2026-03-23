// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingDetailsModel {

 int get id;@JsonKey(name: 'shop_booking_id') String get invoiceId; String? get pickupDate; String get returnDate;@JsonKey(name: 'cooling_period_end') String? get coolingPeriodDate; int get totalAmount; int? get discountAmount;@JsonKey(name: 'advance_amount') int get paidAmount; int? get securityAmount;@JsonKey(fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal) PurchaseMode get purchaseMode;@JsonKey(fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, defaultValue: BookingStatus.upcoming) BookingStatus get bookingStatus;@JsonKey(fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson, defaultValue: PaymentStatus.pending) PaymentStatus get paymentStatus;@JsonKey(fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked) DeliveryStatus get deliveryStatus;@JsonKey(name: 'staff_name') String? get staffName;@JsonKey(name: 'staff_id') int? get staffId;@JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty) BookingOtherDetailsModel get otherDetails;@JsonKey(name: 'created_at') String get bookedDate;@JsonKey(name: 'completed_at') String? get bookingCompletedDate;@JsonKey(name: 'client_address') String? get address; ClientModel get client; String? get description; List<dynamic> get documents; List<ProductInfoModel> get bookedItems;@JsonKey(name: 'additional_charges') List<AdditionalChargesModel> get additionalCharges;@JsonKey(name: 'payments') List<BookingDetailsPaymentHistoryModel> get payments; List<dynamic> get refunds;@JsonKey(name: 'total_refunded') double get totalRefunded;@JsonKey(name: 'refundable_balance') double get refundableBalance;@JsonKey(name: 'security_summary') SecuritySummaryModel get securitySummary;
/// Create a copy of BookingDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDetailsModelCopyWith<BookingDetailsModel> get copyWith => _$BookingDetailsModelCopyWithImpl<BookingDetailsModel>(this as BookingDetailsModel, _$identity);

  /// Serializes this BookingDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.coolingPeriodDate, coolingPeriodDate) || other.coolingPeriodDate == coolingPeriodDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.securityAmount, securityAmount) || other.securityAmount == securityAmount)&&(identical(other.purchaseMode, purchaseMode) || other.purchaseMode == purchaseMode)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.otherDetails, otherDetails) || other.otherDetails == otherDetails)&&(identical(other.bookedDate, bookedDate) || other.bookedDate == bookedDate)&&(identical(other.bookingCompletedDate, bookingCompletedDate) || other.bookingCompletedDate == bookingCompletedDate)&&(identical(other.address, address) || other.address == address)&&(identical(other.client, client) || other.client == client)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.documents, documents)&&const DeepCollectionEquality().equals(other.bookedItems, bookedItems)&&const DeepCollectionEquality().equals(other.additionalCharges, additionalCharges)&&const DeepCollectionEquality().equals(other.payments, payments)&&const DeepCollectionEquality().equals(other.refunds, refunds)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded)&&(identical(other.refundableBalance, refundableBalance) || other.refundableBalance == refundableBalance)&&(identical(other.securitySummary, securitySummary) || other.securitySummary == securitySummary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,invoiceId,pickupDate,returnDate,coolingPeriodDate,totalAmount,discountAmount,paidAmount,securityAmount,purchaseMode,bookingStatus,paymentStatus,deliveryStatus,staffName,staffId,otherDetails,bookedDate,bookingCompletedDate,address,client,description,const DeepCollectionEquality().hash(documents),const DeepCollectionEquality().hash(bookedItems),const DeepCollectionEquality().hash(additionalCharges),const DeepCollectionEquality().hash(payments),const DeepCollectionEquality().hash(refunds),totalRefunded,refundableBalance,securitySummary]);

@override
String toString() {
  return 'BookingDetailsModel(id: $id, invoiceId: $invoiceId, pickupDate: $pickupDate, returnDate: $returnDate, coolingPeriodDate: $coolingPeriodDate, totalAmount: $totalAmount, discountAmount: $discountAmount, paidAmount: $paidAmount, securityAmount: $securityAmount, purchaseMode: $purchaseMode, bookingStatus: $bookingStatus, paymentStatus: $paymentStatus, deliveryStatus: $deliveryStatus, staffName: $staffName, staffId: $staffId, otherDetails: $otherDetails, bookedDate: $bookedDate, bookingCompletedDate: $bookingCompletedDate, address: $address, client: $client, description: $description, documents: $documents, bookedItems: $bookedItems, additionalCharges: $additionalCharges, payments: $payments, refunds: $refunds, totalRefunded: $totalRefunded, refundableBalance: $refundableBalance, securitySummary: $securitySummary)';
}


}

/// @nodoc
abstract mixin class $BookingDetailsModelCopyWith<$Res>  {
  factory $BookingDetailsModelCopyWith(BookingDetailsModel value, $Res Function(BookingDetailsModel) _then) = _$BookingDetailsModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'shop_booking_id') String invoiceId, String? pickupDate, String returnDate,@JsonKey(name: 'cooling_period_end') String? coolingPeriodDate, int totalAmount, int? discountAmount,@JsonKey(name: 'advance_amount') int paidAmount, int? securityAmount,@JsonKey(fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal) PurchaseMode purchaseMode,@JsonKey(fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, defaultValue: BookingStatus.upcoming) BookingStatus bookingStatus,@JsonKey(fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson, defaultValue: PaymentStatus.pending) PaymentStatus paymentStatus,@JsonKey(fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked) DeliveryStatus deliveryStatus,@JsonKey(name: 'staff_name') String? staffName,@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty) BookingOtherDetailsModel otherDetails,@JsonKey(name: 'created_at') String bookedDate,@JsonKey(name: 'completed_at') String? bookingCompletedDate,@JsonKey(name: 'client_address') String? address, ClientModel client, String? description, List<dynamic> documents, List<ProductInfoModel> bookedItems,@JsonKey(name: 'additional_charges') List<AdditionalChargesModel> additionalCharges,@JsonKey(name: 'payments') List<BookingDetailsPaymentHistoryModel> payments, List<dynamic> refunds,@JsonKey(name: 'total_refunded') double totalRefunded,@JsonKey(name: 'refundable_balance') double refundableBalance,@JsonKey(name: 'security_summary') SecuritySummaryModel securitySummary
});


$BookingOtherDetailsModelCopyWith<$Res> get otherDetails;$ClientModelCopyWith<$Res> get client;$SecuritySummaryModelCopyWith<$Res> get securitySummary;

}
/// @nodoc
class _$BookingDetailsModelCopyWithImpl<$Res>
    implements $BookingDetailsModelCopyWith<$Res> {
  _$BookingDetailsModelCopyWithImpl(this._self, this._then);

  final BookingDetailsModel _self;
  final $Res Function(BookingDetailsModel) _then;

/// Create a copy of BookingDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? invoiceId = null,Object? pickupDate = freezed,Object? returnDate = null,Object? coolingPeriodDate = freezed,Object? totalAmount = null,Object? discountAmount = freezed,Object? paidAmount = null,Object? securityAmount = freezed,Object? purchaseMode = null,Object? bookingStatus = null,Object? paymentStatus = null,Object? deliveryStatus = null,Object? staffName = freezed,Object? staffId = freezed,Object? otherDetails = null,Object? bookedDate = null,Object? bookingCompletedDate = freezed,Object? address = freezed,Object? client = null,Object? description = freezed,Object? documents = null,Object? bookedItems = null,Object? additionalCharges = null,Object? payments = null,Object? refunds = null,Object? totalRefunded = null,Object? refundableBalance = null,Object? securitySummary = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,returnDate: null == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String,coolingPeriodDate: freezed == coolingPeriodDate ? _self.coolingPeriodDate : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,securityAmount: freezed == securityAmount ? _self.securityAmount : securityAmount // ignore: cast_nullable_to_non_nullable
as int?,purchaseMode: null == purchaseMode ? _self.purchaseMode : purchaseMode // ignore: cast_nullable_to_non_nullable
as PurchaseMode,bookingStatus: null == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,deliveryStatus: null == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,otherDetails: null == otherDetails ? _self.otherDetails : otherDetails // ignore: cast_nullable_to_non_nullable
as BookingOtherDetailsModel,bookedDate: null == bookedDate ? _self.bookedDate : bookedDate // ignore: cast_nullable_to_non_nullable
as String,bookingCompletedDate: freezed == bookingCompletedDate ? _self.bookingCompletedDate : bookingCompletedDate // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,client: null == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientModel,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<dynamic>,bookedItems: null == bookedItems ? _self.bookedItems : bookedItems // ignore: cast_nullable_to_non_nullable
as List<ProductInfoModel>,additionalCharges: null == additionalCharges ? _self.additionalCharges : additionalCharges // ignore: cast_nullable_to_non_nullable
as List<AdditionalChargesModel>,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<BookingDetailsPaymentHistoryModel>,refunds: null == refunds ? _self.refunds : refunds // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as double,refundableBalance: null == refundableBalance ? _self.refundableBalance : refundableBalance // ignore: cast_nullable_to_non_nullable
as double,securitySummary: null == securitySummary ? _self.securitySummary : securitySummary // ignore: cast_nullable_to_non_nullable
as SecuritySummaryModel,
  ));
}
/// Create a copy of BookingDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingOtherDetailsModelCopyWith<$Res> get otherDetails {
  
  return $BookingOtherDetailsModelCopyWith<$Res>(_self.otherDetails, (value) {
    return _then(_self.copyWith(otherDetails: value));
  });
}/// Create a copy of BookingDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientModelCopyWith<$Res> get client {
  
  return $ClientModelCopyWith<$Res>(_self.client, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of BookingDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecuritySummaryModelCopyWith<$Res> get securitySummary {
  
  return $SecuritySummaryModelCopyWith<$Res>(_self.securitySummary, (value) {
    return _then(_self.copyWith(securitySummary: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingDetailsModel].
extension BookingDetailsModelPatterns on BookingDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'shop_booking_id')  String invoiceId,  String? pickupDate,  String returnDate, @JsonKey(name: 'cooling_period_end')  String? coolingPeriodDate,  int totalAmount,  int? discountAmount, @JsonKey(name: 'advance_amount')  int paidAmount,  int? securityAmount, @JsonKey(fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal)  PurchaseMode purchaseMode, @JsonKey(fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, defaultValue: BookingStatus.upcoming)  BookingStatus bookingStatus, @JsonKey(fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson, defaultValue: PaymentStatus.pending)  PaymentStatus paymentStatus, @JsonKey(fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked)  DeliveryStatus deliveryStatus, @JsonKey(name: 'staff_name')  String? staffName, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)  BookingOtherDetailsModel otherDetails, @JsonKey(name: 'created_at')  String bookedDate, @JsonKey(name: 'completed_at')  String? bookingCompletedDate, @JsonKey(name: 'client_address')  String? address,  ClientModel client,  String? description,  List<dynamic> documents,  List<ProductInfoModel> bookedItems, @JsonKey(name: 'additional_charges')  List<AdditionalChargesModel> additionalCharges, @JsonKey(name: 'payments')  List<BookingDetailsPaymentHistoryModel> payments,  List<dynamic> refunds, @JsonKey(name: 'total_refunded')  double totalRefunded, @JsonKey(name: 'refundable_balance')  double refundableBalance, @JsonKey(name: 'security_summary')  SecuritySummaryModel securitySummary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDetailsModel() when $default != null:
return $default(_that.id,_that.invoiceId,_that.pickupDate,_that.returnDate,_that.coolingPeriodDate,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.securityAmount,_that.purchaseMode,_that.bookingStatus,_that.paymentStatus,_that.deliveryStatus,_that.staffName,_that.staffId,_that.otherDetails,_that.bookedDate,_that.bookingCompletedDate,_that.address,_that.client,_that.description,_that.documents,_that.bookedItems,_that.additionalCharges,_that.payments,_that.refunds,_that.totalRefunded,_that.refundableBalance,_that.securitySummary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'shop_booking_id')  String invoiceId,  String? pickupDate,  String returnDate, @JsonKey(name: 'cooling_period_end')  String? coolingPeriodDate,  int totalAmount,  int? discountAmount, @JsonKey(name: 'advance_amount')  int paidAmount,  int? securityAmount, @JsonKey(fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal)  PurchaseMode purchaseMode, @JsonKey(fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, defaultValue: BookingStatus.upcoming)  BookingStatus bookingStatus, @JsonKey(fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson, defaultValue: PaymentStatus.pending)  PaymentStatus paymentStatus, @JsonKey(fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked)  DeliveryStatus deliveryStatus, @JsonKey(name: 'staff_name')  String? staffName, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)  BookingOtherDetailsModel otherDetails, @JsonKey(name: 'created_at')  String bookedDate, @JsonKey(name: 'completed_at')  String? bookingCompletedDate, @JsonKey(name: 'client_address')  String? address,  ClientModel client,  String? description,  List<dynamic> documents,  List<ProductInfoModel> bookedItems, @JsonKey(name: 'additional_charges')  List<AdditionalChargesModel> additionalCharges, @JsonKey(name: 'payments')  List<BookingDetailsPaymentHistoryModel> payments,  List<dynamic> refunds, @JsonKey(name: 'total_refunded')  double totalRefunded, @JsonKey(name: 'refundable_balance')  double refundableBalance, @JsonKey(name: 'security_summary')  SecuritySummaryModel securitySummary)  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsModel():
return $default(_that.id,_that.invoiceId,_that.pickupDate,_that.returnDate,_that.coolingPeriodDate,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.securityAmount,_that.purchaseMode,_that.bookingStatus,_that.paymentStatus,_that.deliveryStatus,_that.staffName,_that.staffId,_that.otherDetails,_that.bookedDate,_that.bookingCompletedDate,_that.address,_that.client,_that.description,_that.documents,_that.bookedItems,_that.additionalCharges,_that.payments,_that.refunds,_that.totalRefunded,_that.refundableBalance,_that.securitySummary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'shop_booking_id')  String invoiceId,  String? pickupDate,  String returnDate, @JsonKey(name: 'cooling_period_end')  String? coolingPeriodDate,  int totalAmount,  int? discountAmount, @JsonKey(name: 'advance_amount')  int paidAmount,  int? securityAmount, @JsonKey(fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal)  PurchaseMode purchaseMode, @JsonKey(fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, defaultValue: BookingStatus.upcoming)  BookingStatus bookingStatus, @JsonKey(fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson, defaultValue: PaymentStatus.pending)  PaymentStatus paymentStatus, @JsonKey(fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked)  DeliveryStatus deliveryStatus, @JsonKey(name: 'staff_name')  String? staffName, @JsonKey(name: 'staff_id')  int? staffId, @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)  BookingOtherDetailsModel otherDetails, @JsonKey(name: 'created_at')  String bookedDate, @JsonKey(name: 'completed_at')  String? bookingCompletedDate, @JsonKey(name: 'client_address')  String? address,  ClientModel client,  String? description,  List<dynamic> documents,  List<ProductInfoModel> bookedItems, @JsonKey(name: 'additional_charges')  List<AdditionalChargesModel> additionalCharges, @JsonKey(name: 'payments')  List<BookingDetailsPaymentHistoryModel> payments,  List<dynamic> refunds, @JsonKey(name: 'total_refunded')  double totalRefunded, @JsonKey(name: 'refundable_balance')  double refundableBalance, @JsonKey(name: 'security_summary')  SecuritySummaryModel securitySummary)?  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsModel() when $default != null:
return $default(_that.id,_that.invoiceId,_that.pickupDate,_that.returnDate,_that.coolingPeriodDate,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.securityAmount,_that.purchaseMode,_that.bookingStatus,_that.paymentStatus,_that.deliveryStatus,_that.staffName,_that.staffId,_that.otherDetails,_that.bookedDate,_that.bookingCompletedDate,_that.address,_that.client,_that.description,_that.documents,_that.bookedItems,_that.additionalCharges,_that.payments,_that.refunds,_that.totalRefunded,_that.refundableBalance,_that.securitySummary);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _BookingDetailsModel implements BookingDetailsModel {
  const _BookingDetailsModel({required this.id, @JsonKey(name: 'shop_booking_id') required this.invoiceId, required this.pickupDate, required this.returnDate, @JsonKey(name: 'cooling_period_end') this.coolingPeriodDate, required this.totalAmount, this.discountAmount, @JsonKey(name: 'advance_amount') required this.paidAmount, this.securityAmount, @JsonKey(fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal) required this.purchaseMode, @JsonKey(fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, defaultValue: BookingStatus.upcoming) required this.bookingStatus, @JsonKey(fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson, defaultValue: PaymentStatus.pending) required this.paymentStatus, @JsonKey(fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked) required this.deliveryStatus, @JsonKey(name: 'staff_name') this.staffName, @JsonKey(name: 'staff_id') this.staffId, @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty) required this.otherDetails, @JsonKey(name: 'created_at') required this.bookedDate, @JsonKey(name: 'completed_at') this.bookingCompletedDate, @JsonKey(name: 'client_address') this.address, required this.client, this.description, final  List<dynamic> documents = const [], required final  List<ProductInfoModel> bookedItems, @JsonKey(name: 'additional_charges') final  List<AdditionalChargesModel> additionalCharges = const [], @JsonKey(name: 'payments') final  List<BookingDetailsPaymentHistoryModel> payments = const [], final  List<dynamic> refunds = const [], @JsonKey(name: 'total_refunded') this.totalRefunded = 0.0, @JsonKey(name: 'refundable_balance') this.refundableBalance = 0.0, @JsonKey(name: 'security_summary') this.securitySummary = SecuritySummaryModel.empty}): _documents = documents,_bookedItems = bookedItems,_additionalCharges = additionalCharges,_payments = payments,_refunds = refunds;
  factory _BookingDetailsModel.fromJson(Map<String, dynamic> json) => _$BookingDetailsModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'shop_booking_id') final  String invoiceId;
@override final  String? pickupDate;
@override final  String returnDate;
@override@JsonKey(name: 'cooling_period_end') final  String? coolingPeriodDate;
@override final  int totalAmount;
@override final  int? discountAmount;
@override@JsonKey(name: 'advance_amount') final  int paidAmount;
@override final  int? securityAmount;
@override@JsonKey(fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal) final  PurchaseMode purchaseMode;
@override@JsonKey(fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, defaultValue: BookingStatus.upcoming) final  BookingStatus bookingStatus;
@override@JsonKey(fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson, defaultValue: PaymentStatus.pending) final  PaymentStatus paymentStatus;
@override@JsonKey(fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked) final  DeliveryStatus deliveryStatus;
@override@JsonKey(name: 'staff_name') final  String? staffName;
@override@JsonKey(name: 'staff_id') final  int? staffId;
@override@JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty) final  BookingOtherDetailsModel otherDetails;
@override@JsonKey(name: 'created_at') final  String bookedDate;
@override@JsonKey(name: 'completed_at') final  String? bookingCompletedDate;
@override@JsonKey(name: 'client_address') final  String? address;
@override final  ClientModel client;
@override final  String? description;
 final  List<dynamic> _documents;
@override@JsonKey() List<dynamic> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}

 final  List<ProductInfoModel> _bookedItems;
@override List<ProductInfoModel> get bookedItems {
  if (_bookedItems is EqualUnmodifiableListView) return _bookedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookedItems);
}

 final  List<AdditionalChargesModel> _additionalCharges;
@override@JsonKey(name: 'additional_charges') List<AdditionalChargesModel> get additionalCharges {
  if (_additionalCharges is EqualUnmodifiableListView) return _additionalCharges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_additionalCharges);
}

 final  List<BookingDetailsPaymentHistoryModel> _payments;
@override@JsonKey(name: 'payments') List<BookingDetailsPaymentHistoryModel> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}

 final  List<dynamic> _refunds;
@override@JsonKey() List<dynamic> get refunds {
  if (_refunds is EqualUnmodifiableListView) return _refunds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_refunds);
}

@override@JsonKey(name: 'total_refunded') final  double totalRefunded;
@override@JsonKey(name: 'refundable_balance') final  double refundableBalance;
@override@JsonKey(name: 'security_summary') final  SecuritySummaryModel securitySummary;

/// Create a copy of BookingDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDetailsModelCopyWith<_BookingDetailsModel> get copyWith => __$BookingDetailsModelCopyWithImpl<_BookingDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDetailsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.coolingPeriodDate, coolingPeriodDate) || other.coolingPeriodDate == coolingPeriodDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.securityAmount, securityAmount) || other.securityAmount == securityAmount)&&(identical(other.purchaseMode, purchaseMode) || other.purchaseMode == purchaseMode)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.otherDetails, otherDetails) || other.otherDetails == otherDetails)&&(identical(other.bookedDate, bookedDate) || other.bookedDate == bookedDate)&&(identical(other.bookingCompletedDate, bookingCompletedDate) || other.bookingCompletedDate == bookingCompletedDate)&&(identical(other.address, address) || other.address == address)&&(identical(other.client, client) || other.client == client)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._documents, _documents)&&const DeepCollectionEquality().equals(other._bookedItems, _bookedItems)&&const DeepCollectionEquality().equals(other._additionalCharges, _additionalCharges)&&const DeepCollectionEquality().equals(other._payments, _payments)&&const DeepCollectionEquality().equals(other._refunds, _refunds)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded)&&(identical(other.refundableBalance, refundableBalance) || other.refundableBalance == refundableBalance)&&(identical(other.securitySummary, securitySummary) || other.securitySummary == securitySummary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,invoiceId,pickupDate,returnDate,coolingPeriodDate,totalAmount,discountAmount,paidAmount,securityAmount,purchaseMode,bookingStatus,paymentStatus,deliveryStatus,staffName,staffId,otherDetails,bookedDate,bookingCompletedDate,address,client,description,const DeepCollectionEquality().hash(_documents),const DeepCollectionEquality().hash(_bookedItems),const DeepCollectionEquality().hash(_additionalCharges),const DeepCollectionEquality().hash(_payments),const DeepCollectionEquality().hash(_refunds),totalRefunded,refundableBalance,securitySummary]);

@override
String toString() {
  return 'BookingDetailsModel(id: $id, invoiceId: $invoiceId, pickupDate: $pickupDate, returnDate: $returnDate, coolingPeriodDate: $coolingPeriodDate, totalAmount: $totalAmount, discountAmount: $discountAmount, paidAmount: $paidAmount, securityAmount: $securityAmount, purchaseMode: $purchaseMode, bookingStatus: $bookingStatus, paymentStatus: $paymentStatus, deliveryStatus: $deliveryStatus, staffName: $staffName, staffId: $staffId, otherDetails: $otherDetails, bookedDate: $bookedDate, bookingCompletedDate: $bookingCompletedDate, address: $address, client: $client, description: $description, documents: $documents, bookedItems: $bookedItems, additionalCharges: $additionalCharges, payments: $payments, refunds: $refunds, totalRefunded: $totalRefunded, refundableBalance: $refundableBalance, securitySummary: $securitySummary)';
}


}

/// @nodoc
abstract mixin class _$BookingDetailsModelCopyWith<$Res> implements $BookingDetailsModelCopyWith<$Res> {
  factory _$BookingDetailsModelCopyWith(_BookingDetailsModel value, $Res Function(_BookingDetailsModel) _then) = __$BookingDetailsModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'shop_booking_id') String invoiceId, String? pickupDate, String returnDate,@JsonKey(name: 'cooling_period_end') String? coolingPeriodDate, int totalAmount, int? discountAmount,@JsonKey(name: 'advance_amount') int paidAmount, int? securityAmount,@JsonKey(fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal) PurchaseMode purchaseMode,@JsonKey(fromJson: BookingStatus.fromString, toJson: BookingStatus.toJson, defaultValue: BookingStatus.upcoming) BookingStatus bookingStatus,@JsonKey(fromJson: PaymentStatus.fromBool, toJson: PaymentStatus.toJson, defaultValue: PaymentStatus.pending) PaymentStatus paymentStatus,@JsonKey(fromJson: DeliveryStatus.fromString, toJson: DeliveryStatus.toJson, defaultValue: DeliveryStatus.booked) DeliveryStatus deliveryStatus,@JsonKey(name: 'staff_name') String? staffName,@JsonKey(name: 'staff_id') int? staffId,@JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty) BookingOtherDetailsModel otherDetails,@JsonKey(name: 'created_at') String bookedDate,@JsonKey(name: 'completed_at') String? bookingCompletedDate,@JsonKey(name: 'client_address') String? address, ClientModel client, String? description, List<dynamic> documents, List<ProductInfoModel> bookedItems,@JsonKey(name: 'additional_charges') List<AdditionalChargesModel> additionalCharges,@JsonKey(name: 'payments') List<BookingDetailsPaymentHistoryModel> payments, List<dynamic> refunds,@JsonKey(name: 'total_refunded') double totalRefunded,@JsonKey(name: 'refundable_balance') double refundableBalance,@JsonKey(name: 'security_summary') SecuritySummaryModel securitySummary
});


@override $BookingOtherDetailsModelCopyWith<$Res> get otherDetails;@override $ClientModelCopyWith<$Res> get client;@override $SecuritySummaryModelCopyWith<$Res> get securitySummary;

}
/// @nodoc
class __$BookingDetailsModelCopyWithImpl<$Res>
    implements _$BookingDetailsModelCopyWith<$Res> {
  __$BookingDetailsModelCopyWithImpl(this._self, this._then);

  final _BookingDetailsModel _self;
  final $Res Function(_BookingDetailsModel) _then;

/// Create a copy of BookingDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? invoiceId = null,Object? pickupDate = freezed,Object? returnDate = null,Object? coolingPeriodDate = freezed,Object? totalAmount = null,Object? discountAmount = freezed,Object? paidAmount = null,Object? securityAmount = freezed,Object? purchaseMode = null,Object? bookingStatus = null,Object? paymentStatus = null,Object? deliveryStatus = null,Object? staffName = freezed,Object? staffId = freezed,Object? otherDetails = null,Object? bookedDate = null,Object? bookingCompletedDate = freezed,Object? address = freezed,Object? client = null,Object? description = freezed,Object? documents = null,Object? bookedItems = null,Object? additionalCharges = null,Object? payments = null,Object? refunds = null,Object? totalRefunded = null,Object? refundableBalance = null,Object? securitySummary = null,}) {
  return _then(_BookingDetailsModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,returnDate: null == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String,coolingPeriodDate: freezed == coolingPeriodDate ? _self.coolingPeriodDate : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as int?,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,securityAmount: freezed == securityAmount ? _self.securityAmount : securityAmount // ignore: cast_nullable_to_non_nullable
as int?,purchaseMode: null == purchaseMode ? _self.purchaseMode : purchaseMode // ignore: cast_nullable_to_non_nullable
as PurchaseMode,bookingStatus: null == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,deliveryStatus: null == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,staffName: freezed == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String?,staffId: freezed == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int?,otherDetails: null == otherDetails ? _self.otherDetails : otherDetails // ignore: cast_nullable_to_non_nullable
as BookingOtherDetailsModel,bookedDate: null == bookedDate ? _self.bookedDate : bookedDate // ignore: cast_nullable_to_non_nullable
as String,bookingCompletedDate: freezed == bookingCompletedDate ? _self.bookingCompletedDate : bookingCompletedDate // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,client: null == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientModel,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<dynamic>,bookedItems: null == bookedItems ? _self._bookedItems : bookedItems // ignore: cast_nullable_to_non_nullable
as List<ProductInfoModel>,additionalCharges: null == additionalCharges ? _self._additionalCharges : additionalCharges // ignore: cast_nullable_to_non_nullable
as List<AdditionalChargesModel>,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<BookingDetailsPaymentHistoryModel>,refunds: null == refunds ? _self._refunds : refunds // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as double,refundableBalance: null == refundableBalance ? _self.refundableBalance : refundableBalance // ignore: cast_nullable_to_non_nullable
as double,securitySummary: null == securitySummary ? _self.securitySummary : securitySummary // ignore: cast_nullable_to_non_nullable
as SecuritySummaryModel,
  ));
}

/// Create a copy of BookingDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingOtherDetailsModelCopyWith<$Res> get otherDetails {
  
  return $BookingOtherDetailsModelCopyWith<$Res>(_self.otherDetails, (value) {
    return _then(_self.copyWith(otherDetails: value));
  });
}/// Create a copy of BookingDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientModelCopyWith<$Res> get client {
  
  return $ClientModelCopyWith<$Res>(_self.client, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of BookingDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecuritySummaryModelCopyWith<$Res> get securitySummary {
  
  return $SecuritySummaryModelCopyWith<$Res>(_self.securitySummary, (value) {
    return _then(_self.copyWith(securitySummary: value));
  });
}
}

// dart format on
