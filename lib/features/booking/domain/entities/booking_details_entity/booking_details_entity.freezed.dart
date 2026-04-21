// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingDetailsEntity {

 int get id; String get invoiceId; String? get pickupDate; String get returnDate; String? get pickupTime; String? get returnTime; String? get coolingPeriodDate; String? get coolingPeriodType; int get totalAmount; int? get discountAmount; int get paidAmount; int? get securityAmount; PurchaseMode get purchaseMode; BookingStatus get bookingStatus; PaymentStatus get paymentStatus; DeliveryStatus get deliveryStatus; String? get staffName; int? get staffId; BookingOtherDetailsEntity get otherDetails; String get bookedDate; String? get bookingCompletedDate; String? get address; ClientEntity get client; String? get description; List<dynamic> get documents; List<ProductInfoEntity> get bookedItems; List<AdditionalChargesEntity> get additionalCharges; List<BookingPaymentHistoryEntity> get payments; List<dynamic> get refunds; double get totalRefunded; double get refundableBalance; SecuritySummaryEntity get securitySummary; PaymentMethod? get securityPaymentMethod;
/// Create a copy of BookingDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDetailsEntityCopyWith<BookingDetailsEntity> get copyWith => _$BookingDetailsEntityCopyWithImpl<BookingDetailsEntity>(this as BookingDetailsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.pickupTime, pickupTime) || other.pickupTime == pickupTime)&&(identical(other.returnTime, returnTime) || other.returnTime == returnTime)&&(identical(other.coolingPeriodDate, coolingPeriodDate) || other.coolingPeriodDate == coolingPeriodDate)&&(identical(other.coolingPeriodType, coolingPeriodType) || other.coolingPeriodType == coolingPeriodType)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.securityAmount, securityAmount) || other.securityAmount == securityAmount)&&(identical(other.purchaseMode, purchaseMode) || other.purchaseMode == purchaseMode)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.otherDetails, otherDetails) || other.otherDetails == otherDetails)&&(identical(other.bookedDate, bookedDate) || other.bookedDate == bookedDate)&&(identical(other.bookingCompletedDate, bookingCompletedDate) || other.bookingCompletedDate == bookingCompletedDate)&&(identical(other.address, address) || other.address == address)&&(identical(other.client, client) || other.client == client)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.documents, documents)&&const DeepCollectionEquality().equals(other.bookedItems, bookedItems)&&const DeepCollectionEquality().equals(other.additionalCharges, additionalCharges)&&const DeepCollectionEquality().equals(other.payments, payments)&&const DeepCollectionEquality().equals(other.refunds, refunds)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded)&&(identical(other.refundableBalance, refundableBalance) || other.refundableBalance == refundableBalance)&&(identical(other.securitySummary, securitySummary) || other.securitySummary == securitySummary)&&(identical(other.securityPaymentMethod, securityPaymentMethod) || other.securityPaymentMethod == securityPaymentMethod));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,invoiceId,pickupDate,returnDate,pickupTime,returnTime,coolingPeriodDate,coolingPeriodType,totalAmount,discountAmount,paidAmount,securityAmount,purchaseMode,bookingStatus,paymentStatus,deliveryStatus,staffName,staffId,otherDetails,bookedDate,bookingCompletedDate,address,client,description,const DeepCollectionEquality().hash(documents),const DeepCollectionEquality().hash(bookedItems),const DeepCollectionEquality().hash(additionalCharges),const DeepCollectionEquality().hash(payments),const DeepCollectionEquality().hash(refunds),totalRefunded,refundableBalance,securitySummary,securityPaymentMethod]);

@override
String toString() {
  return 'BookingDetailsEntity(id: $id, invoiceId: $invoiceId, pickupDate: $pickupDate, returnDate: $returnDate, pickupTime: $pickupTime, returnTime: $returnTime, coolingPeriodDate: $coolingPeriodDate, coolingPeriodType: $coolingPeriodType, totalAmount: $totalAmount, discountAmount: $discountAmount, paidAmount: $paidAmount, securityAmount: $securityAmount, purchaseMode: $purchaseMode, bookingStatus: $bookingStatus, paymentStatus: $paymentStatus, deliveryStatus: $deliveryStatus, staffName: $staffName, staffId: $staffId, otherDetails: $otherDetails, bookedDate: $bookedDate, bookingCompletedDate: $bookingCompletedDate, address: $address, client: $client, description: $description, documents: $documents, bookedItems: $bookedItems, additionalCharges: $additionalCharges, payments: $payments, refunds: $refunds, totalRefunded: $totalRefunded, refundableBalance: $refundableBalance, securitySummary: $securitySummary, securityPaymentMethod: $securityPaymentMethod)';
}


}

/// @nodoc
abstract mixin class $BookingDetailsEntityCopyWith<$Res>  {
  factory $BookingDetailsEntityCopyWith(BookingDetailsEntity value, $Res Function(BookingDetailsEntity) _then) = _$BookingDetailsEntityCopyWithImpl;
@useResult
$Res call({
 int id, String invoiceId, String? pickupDate, String returnDate, String? pickupTime, String? returnTime, String? coolingPeriodDate, String? coolingPeriodType, int totalAmount, int? discountAmount, int paidAmount, int? securityAmount, PurchaseMode purchaseMode, BookingStatus bookingStatus, PaymentStatus paymentStatus, DeliveryStatus deliveryStatus, String? staffName, int? staffId, BookingOtherDetailsEntity otherDetails, String bookedDate, String? bookingCompletedDate, String? address, ClientEntity client, String? description, List<dynamic> documents, List<ProductInfoEntity> bookedItems, List<AdditionalChargesEntity> additionalCharges, List<BookingPaymentHistoryEntity> payments, List<dynamic> refunds, double totalRefunded, double refundableBalance, SecuritySummaryEntity securitySummary, PaymentMethod? securityPaymentMethod
});


$BookingOtherDetailsEntityCopyWith<$Res> get otherDetails;$ClientEntityCopyWith<$Res> get client;$SecuritySummaryEntityCopyWith<$Res> get securitySummary;

}
/// @nodoc
class _$BookingDetailsEntityCopyWithImpl<$Res>
    implements $BookingDetailsEntityCopyWith<$Res> {
  _$BookingDetailsEntityCopyWithImpl(this._self, this._then);

  final BookingDetailsEntity _self;
  final $Res Function(BookingDetailsEntity) _then;

/// Create a copy of BookingDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? invoiceId = null,Object? pickupDate = freezed,Object? returnDate = null,Object? pickupTime = freezed,Object? returnTime = freezed,Object? coolingPeriodDate = freezed,Object? coolingPeriodType = freezed,Object? totalAmount = null,Object? discountAmount = freezed,Object? paidAmount = null,Object? securityAmount = freezed,Object? purchaseMode = null,Object? bookingStatus = null,Object? paymentStatus = null,Object? deliveryStatus = null,Object? staffName = freezed,Object? staffId = freezed,Object? otherDetails = null,Object? bookedDate = null,Object? bookingCompletedDate = freezed,Object? address = freezed,Object? client = null,Object? description = freezed,Object? documents = null,Object? bookedItems = null,Object? additionalCharges = null,Object? payments = null,Object? refunds = null,Object? totalRefunded = null,Object? refundableBalance = null,Object? securitySummary = null,Object? securityPaymentMethod = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,returnDate: null == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String,pickupTime: freezed == pickupTime ? _self.pickupTime : pickupTime // ignore: cast_nullable_to_non_nullable
as String?,returnTime: freezed == returnTime ? _self.returnTime : returnTime // ignore: cast_nullable_to_non_nullable
as String?,coolingPeriodDate: freezed == coolingPeriodDate ? _self.coolingPeriodDate : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
as String?,coolingPeriodType: freezed == coolingPeriodType ? _self.coolingPeriodType : coolingPeriodType // ignore: cast_nullable_to_non_nullable
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
as BookingOtherDetailsEntity,bookedDate: null == bookedDate ? _self.bookedDate : bookedDate // ignore: cast_nullable_to_non_nullable
as String,bookingCompletedDate: freezed == bookingCompletedDate ? _self.bookingCompletedDate : bookingCompletedDate // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,client: null == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientEntity,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<dynamic>,bookedItems: null == bookedItems ? _self.bookedItems : bookedItems // ignore: cast_nullable_to_non_nullable
as List<ProductInfoEntity>,additionalCharges: null == additionalCharges ? _self.additionalCharges : additionalCharges // ignore: cast_nullable_to_non_nullable
as List<AdditionalChargesEntity>,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<BookingPaymentHistoryEntity>,refunds: null == refunds ? _self.refunds : refunds // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as double,refundableBalance: null == refundableBalance ? _self.refundableBalance : refundableBalance // ignore: cast_nullable_to_non_nullable
as double,securitySummary: null == securitySummary ? _self.securitySummary : securitySummary // ignore: cast_nullable_to_non_nullable
as SecuritySummaryEntity,securityPaymentMethod: freezed == securityPaymentMethod ? _self.securityPaymentMethod : securityPaymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,
  ));
}
/// Create a copy of BookingDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingOtherDetailsEntityCopyWith<$Res> get otherDetails {
  
  return $BookingOtherDetailsEntityCopyWith<$Res>(_self.otherDetails, (value) {
    return _then(_self.copyWith(otherDetails: value));
  });
}/// Create a copy of BookingDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientEntityCopyWith<$Res> get client {
  
  return $ClientEntityCopyWith<$Res>(_self.client, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of BookingDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecuritySummaryEntityCopyWith<$Res> get securitySummary {
  
  return $SecuritySummaryEntityCopyWith<$Res>(_self.securitySummary, (value) {
    return _then(_self.copyWith(securitySummary: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingDetailsEntity].
extension BookingDetailsEntityPatterns on BookingDetailsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDetailsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDetailsEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDetailsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String invoiceId,  String? pickupDate,  String returnDate,  String? pickupTime,  String? returnTime,  String? coolingPeriodDate,  String? coolingPeriodType,  int totalAmount,  int? discountAmount,  int paidAmount,  int? securityAmount,  PurchaseMode purchaseMode,  BookingStatus bookingStatus,  PaymentStatus paymentStatus,  DeliveryStatus deliveryStatus,  String? staffName,  int? staffId,  BookingOtherDetailsEntity otherDetails,  String bookedDate,  String? bookingCompletedDate,  String? address,  ClientEntity client,  String? description,  List<dynamic> documents,  List<ProductInfoEntity> bookedItems,  List<AdditionalChargesEntity> additionalCharges,  List<BookingPaymentHistoryEntity> payments,  List<dynamic> refunds,  double totalRefunded,  double refundableBalance,  SecuritySummaryEntity securitySummary,  PaymentMethod? securityPaymentMethod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDetailsEntity() when $default != null:
return $default(_that.id,_that.invoiceId,_that.pickupDate,_that.returnDate,_that.pickupTime,_that.returnTime,_that.coolingPeriodDate,_that.coolingPeriodType,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.securityAmount,_that.purchaseMode,_that.bookingStatus,_that.paymentStatus,_that.deliveryStatus,_that.staffName,_that.staffId,_that.otherDetails,_that.bookedDate,_that.bookingCompletedDate,_that.address,_that.client,_that.description,_that.documents,_that.bookedItems,_that.additionalCharges,_that.payments,_that.refunds,_that.totalRefunded,_that.refundableBalance,_that.securitySummary,_that.securityPaymentMethod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String invoiceId,  String? pickupDate,  String returnDate,  String? pickupTime,  String? returnTime,  String? coolingPeriodDate,  String? coolingPeriodType,  int totalAmount,  int? discountAmount,  int paidAmount,  int? securityAmount,  PurchaseMode purchaseMode,  BookingStatus bookingStatus,  PaymentStatus paymentStatus,  DeliveryStatus deliveryStatus,  String? staffName,  int? staffId,  BookingOtherDetailsEntity otherDetails,  String bookedDate,  String? bookingCompletedDate,  String? address,  ClientEntity client,  String? description,  List<dynamic> documents,  List<ProductInfoEntity> bookedItems,  List<AdditionalChargesEntity> additionalCharges,  List<BookingPaymentHistoryEntity> payments,  List<dynamic> refunds,  double totalRefunded,  double refundableBalance,  SecuritySummaryEntity securitySummary,  PaymentMethod? securityPaymentMethod)  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsEntity():
return $default(_that.id,_that.invoiceId,_that.pickupDate,_that.returnDate,_that.pickupTime,_that.returnTime,_that.coolingPeriodDate,_that.coolingPeriodType,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.securityAmount,_that.purchaseMode,_that.bookingStatus,_that.paymentStatus,_that.deliveryStatus,_that.staffName,_that.staffId,_that.otherDetails,_that.bookedDate,_that.bookingCompletedDate,_that.address,_that.client,_that.description,_that.documents,_that.bookedItems,_that.additionalCharges,_that.payments,_that.refunds,_that.totalRefunded,_that.refundableBalance,_that.securitySummary,_that.securityPaymentMethod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String invoiceId,  String? pickupDate,  String returnDate,  String? pickupTime,  String? returnTime,  String? coolingPeriodDate,  String? coolingPeriodType,  int totalAmount,  int? discountAmount,  int paidAmount,  int? securityAmount,  PurchaseMode purchaseMode,  BookingStatus bookingStatus,  PaymentStatus paymentStatus,  DeliveryStatus deliveryStatus,  String? staffName,  int? staffId,  BookingOtherDetailsEntity otherDetails,  String bookedDate,  String? bookingCompletedDate,  String? address,  ClientEntity client,  String? description,  List<dynamic> documents,  List<ProductInfoEntity> bookedItems,  List<AdditionalChargesEntity> additionalCharges,  List<BookingPaymentHistoryEntity> payments,  List<dynamic> refunds,  double totalRefunded,  double refundableBalance,  SecuritySummaryEntity securitySummary,  PaymentMethod? securityPaymentMethod)?  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsEntity() when $default != null:
return $default(_that.id,_that.invoiceId,_that.pickupDate,_that.returnDate,_that.pickupTime,_that.returnTime,_that.coolingPeriodDate,_that.coolingPeriodType,_that.totalAmount,_that.discountAmount,_that.paidAmount,_that.securityAmount,_that.purchaseMode,_that.bookingStatus,_that.paymentStatus,_that.deliveryStatus,_that.staffName,_that.staffId,_that.otherDetails,_that.bookedDate,_that.bookingCompletedDate,_that.address,_that.client,_that.description,_that.documents,_that.bookedItems,_that.additionalCharges,_that.payments,_that.refunds,_that.totalRefunded,_that.refundableBalance,_that.securitySummary,_that.securityPaymentMethod);case _:
  return null;

}
}

}

/// @nodoc


class _BookingDetailsEntity implements BookingDetailsEntity {
  const _BookingDetailsEntity({required this.id, required this.invoiceId, required this.pickupDate, required this.returnDate, this.pickupTime, this.returnTime, this.coolingPeriodDate, this.coolingPeriodType, required this.totalAmount, this.discountAmount, required this.paidAmount, this.securityAmount, required this.purchaseMode, required this.bookingStatus, required this.paymentStatus, required this.deliveryStatus, this.staffName, this.staffId, required this.otherDetails, required this.bookedDate, this.bookingCompletedDate, this.address, required this.client, this.description, final  List<dynamic> documents = const [], required final  List<ProductInfoEntity> bookedItems, final  List<AdditionalChargesEntity> additionalCharges = const [], final  List<BookingPaymentHistoryEntity> payments = const [], final  List<dynamic> refunds = const [], this.totalRefunded = 0.0, this.refundableBalance = 0.0, this.securitySummary = SecuritySummaryEntity.empty, this.securityPaymentMethod}): _documents = documents,_bookedItems = bookedItems,_additionalCharges = additionalCharges,_payments = payments,_refunds = refunds;
  

@override final  int id;
@override final  String invoiceId;
@override final  String? pickupDate;
@override final  String returnDate;
@override final  String? pickupTime;
@override final  String? returnTime;
@override final  String? coolingPeriodDate;
@override final  String? coolingPeriodType;
@override final  int totalAmount;
@override final  int? discountAmount;
@override final  int paidAmount;
@override final  int? securityAmount;
@override final  PurchaseMode purchaseMode;
@override final  BookingStatus bookingStatus;
@override final  PaymentStatus paymentStatus;
@override final  DeliveryStatus deliveryStatus;
@override final  String? staffName;
@override final  int? staffId;
@override final  BookingOtherDetailsEntity otherDetails;
@override final  String bookedDate;
@override final  String? bookingCompletedDate;
@override final  String? address;
@override final  ClientEntity client;
@override final  String? description;
 final  List<dynamic> _documents;
@override@JsonKey() List<dynamic> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}

 final  List<ProductInfoEntity> _bookedItems;
@override List<ProductInfoEntity> get bookedItems {
  if (_bookedItems is EqualUnmodifiableListView) return _bookedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookedItems);
}

 final  List<AdditionalChargesEntity> _additionalCharges;
@override@JsonKey() List<AdditionalChargesEntity> get additionalCharges {
  if (_additionalCharges is EqualUnmodifiableListView) return _additionalCharges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_additionalCharges);
}

 final  List<BookingPaymentHistoryEntity> _payments;
@override@JsonKey() List<BookingPaymentHistoryEntity> get payments {
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

@override@JsonKey() final  double totalRefunded;
@override@JsonKey() final  double refundableBalance;
@override@JsonKey() final  SecuritySummaryEntity securitySummary;
@override final  PaymentMethod? securityPaymentMethod;

/// Create a copy of BookingDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDetailsEntityCopyWith<_BookingDetailsEntity> get copyWith => __$BookingDetailsEntityCopyWithImpl<_BookingDetailsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDetailsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.pickupTime, pickupTime) || other.pickupTime == pickupTime)&&(identical(other.returnTime, returnTime) || other.returnTime == returnTime)&&(identical(other.coolingPeriodDate, coolingPeriodDate) || other.coolingPeriodDate == coolingPeriodDate)&&(identical(other.coolingPeriodType, coolingPeriodType) || other.coolingPeriodType == coolingPeriodType)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.securityAmount, securityAmount) || other.securityAmount == securityAmount)&&(identical(other.purchaseMode, purchaseMode) || other.purchaseMode == purchaseMode)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.otherDetails, otherDetails) || other.otherDetails == otherDetails)&&(identical(other.bookedDate, bookedDate) || other.bookedDate == bookedDate)&&(identical(other.bookingCompletedDate, bookingCompletedDate) || other.bookingCompletedDate == bookingCompletedDate)&&(identical(other.address, address) || other.address == address)&&(identical(other.client, client) || other.client == client)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._documents, _documents)&&const DeepCollectionEquality().equals(other._bookedItems, _bookedItems)&&const DeepCollectionEquality().equals(other._additionalCharges, _additionalCharges)&&const DeepCollectionEquality().equals(other._payments, _payments)&&const DeepCollectionEquality().equals(other._refunds, _refunds)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded)&&(identical(other.refundableBalance, refundableBalance) || other.refundableBalance == refundableBalance)&&(identical(other.securitySummary, securitySummary) || other.securitySummary == securitySummary)&&(identical(other.securityPaymentMethod, securityPaymentMethod) || other.securityPaymentMethod == securityPaymentMethod));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,invoiceId,pickupDate,returnDate,pickupTime,returnTime,coolingPeriodDate,coolingPeriodType,totalAmount,discountAmount,paidAmount,securityAmount,purchaseMode,bookingStatus,paymentStatus,deliveryStatus,staffName,staffId,otherDetails,bookedDate,bookingCompletedDate,address,client,description,const DeepCollectionEquality().hash(_documents),const DeepCollectionEquality().hash(_bookedItems),const DeepCollectionEquality().hash(_additionalCharges),const DeepCollectionEquality().hash(_payments),const DeepCollectionEquality().hash(_refunds),totalRefunded,refundableBalance,securitySummary,securityPaymentMethod]);

@override
String toString() {
  return 'BookingDetailsEntity(id: $id, invoiceId: $invoiceId, pickupDate: $pickupDate, returnDate: $returnDate, pickupTime: $pickupTime, returnTime: $returnTime, coolingPeriodDate: $coolingPeriodDate, coolingPeriodType: $coolingPeriodType, totalAmount: $totalAmount, discountAmount: $discountAmount, paidAmount: $paidAmount, securityAmount: $securityAmount, purchaseMode: $purchaseMode, bookingStatus: $bookingStatus, paymentStatus: $paymentStatus, deliveryStatus: $deliveryStatus, staffName: $staffName, staffId: $staffId, otherDetails: $otherDetails, bookedDate: $bookedDate, bookingCompletedDate: $bookingCompletedDate, address: $address, client: $client, description: $description, documents: $documents, bookedItems: $bookedItems, additionalCharges: $additionalCharges, payments: $payments, refunds: $refunds, totalRefunded: $totalRefunded, refundableBalance: $refundableBalance, securitySummary: $securitySummary, securityPaymentMethod: $securityPaymentMethod)';
}


}

/// @nodoc
abstract mixin class _$BookingDetailsEntityCopyWith<$Res> implements $BookingDetailsEntityCopyWith<$Res> {
  factory _$BookingDetailsEntityCopyWith(_BookingDetailsEntity value, $Res Function(_BookingDetailsEntity) _then) = __$BookingDetailsEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String invoiceId, String? pickupDate, String returnDate, String? pickupTime, String? returnTime, String? coolingPeriodDate, String? coolingPeriodType, int totalAmount, int? discountAmount, int paidAmount, int? securityAmount, PurchaseMode purchaseMode, BookingStatus bookingStatus, PaymentStatus paymentStatus, DeliveryStatus deliveryStatus, String? staffName, int? staffId, BookingOtherDetailsEntity otherDetails, String bookedDate, String? bookingCompletedDate, String? address, ClientEntity client, String? description, List<dynamic> documents, List<ProductInfoEntity> bookedItems, List<AdditionalChargesEntity> additionalCharges, List<BookingPaymentHistoryEntity> payments, List<dynamic> refunds, double totalRefunded, double refundableBalance, SecuritySummaryEntity securitySummary, PaymentMethod? securityPaymentMethod
});


@override $BookingOtherDetailsEntityCopyWith<$Res> get otherDetails;@override $ClientEntityCopyWith<$Res> get client;@override $SecuritySummaryEntityCopyWith<$Res> get securitySummary;

}
/// @nodoc
class __$BookingDetailsEntityCopyWithImpl<$Res>
    implements _$BookingDetailsEntityCopyWith<$Res> {
  __$BookingDetailsEntityCopyWithImpl(this._self, this._then);

  final _BookingDetailsEntity _self;
  final $Res Function(_BookingDetailsEntity) _then;

/// Create a copy of BookingDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? invoiceId = null,Object? pickupDate = freezed,Object? returnDate = null,Object? pickupTime = freezed,Object? returnTime = freezed,Object? coolingPeriodDate = freezed,Object? coolingPeriodType = freezed,Object? totalAmount = null,Object? discountAmount = freezed,Object? paidAmount = null,Object? securityAmount = freezed,Object? purchaseMode = null,Object? bookingStatus = null,Object? paymentStatus = null,Object? deliveryStatus = null,Object? staffName = freezed,Object? staffId = freezed,Object? otherDetails = null,Object? bookedDate = null,Object? bookingCompletedDate = freezed,Object? address = freezed,Object? client = null,Object? description = freezed,Object? documents = null,Object? bookedItems = null,Object? additionalCharges = null,Object? payments = null,Object? refunds = null,Object? totalRefunded = null,Object? refundableBalance = null,Object? securitySummary = null,Object? securityPaymentMethod = freezed,}) {
  return _then(_BookingDetailsEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,returnDate: null == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String,pickupTime: freezed == pickupTime ? _self.pickupTime : pickupTime // ignore: cast_nullable_to_non_nullable
as String?,returnTime: freezed == returnTime ? _self.returnTime : returnTime // ignore: cast_nullable_to_non_nullable
as String?,coolingPeriodDate: freezed == coolingPeriodDate ? _self.coolingPeriodDate : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
as String?,coolingPeriodType: freezed == coolingPeriodType ? _self.coolingPeriodType : coolingPeriodType // ignore: cast_nullable_to_non_nullable
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
as BookingOtherDetailsEntity,bookedDate: null == bookedDate ? _self.bookedDate : bookedDate // ignore: cast_nullable_to_non_nullable
as String,bookingCompletedDate: freezed == bookingCompletedDate ? _self.bookingCompletedDate : bookingCompletedDate // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,client: null == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as ClientEntity,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<dynamic>,bookedItems: null == bookedItems ? _self._bookedItems : bookedItems // ignore: cast_nullable_to_non_nullable
as List<ProductInfoEntity>,additionalCharges: null == additionalCharges ? _self._additionalCharges : additionalCharges // ignore: cast_nullable_to_non_nullable
as List<AdditionalChargesEntity>,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<BookingPaymentHistoryEntity>,refunds: null == refunds ? _self._refunds : refunds // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as double,refundableBalance: null == refundableBalance ? _self.refundableBalance : refundableBalance // ignore: cast_nullable_to_non_nullable
as double,securitySummary: null == securitySummary ? _self.securitySummary : securitySummary // ignore: cast_nullable_to_non_nullable
as SecuritySummaryEntity,securityPaymentMethod: freezed == securityPaymentMethod ? _self.securityPaymentMethod : securityPaymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,
  ));
}

/// Create a copy of BookingDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingOtherDetailsEntityCopyWith<$Res> get otherDetails {
  
  return $BookingOtherDetailsEntityCopyWith<$Res>(_self.otherDetails, (value) {
    return _then(_self.copyWith(otherDetails: value));
  });
}/// Create a copy of BookingDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientEntityCopyWith<$Res> get client {
  
  return $ClientEntityCopyWith<$Res>(_self.client, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of BookingDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecuritySummaryEntityCopyWith<$Res> get securitySummary {
  
  return $SecuritySummaryEntityCopyWith<$Res>(_self.securitySummary, (value) {
    return _then(_self.copyWith(securitySummary: value));
  });
}
}

// dart format on
