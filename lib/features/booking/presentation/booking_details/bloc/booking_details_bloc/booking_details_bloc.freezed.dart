// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingDetailsEvent {

 int get bookingId;
/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDetailsEventCopyWith<BookingDetailsEvent> get copyWith => _$BookingDetailsEventCopyWithImpl<BookingDetailsEvent>(this as BookingDetailsEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsEvent&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId);

@override
String toString() {
  return 'BookingDetailsEvent(bookingId: $bookingId)';
}


}

/// @nodoc
abstract mixin class $BookingDetailsEventCopyWith<$Res>  {
  factory $BookingDetailsEventCopyWith(BookingDetailsEvent value, $Res Function(BookingDetailsEvent) _then) = _$BookingDetailsEventCopyWithImpl;
@useResult
$Res call({
 int bookingId
});




}
/// @nodoc
class _$BookingDetailsEventCopyWithImpl<$Res>
    implements $BookingDetailsEventCopyWith<$Res> {
  _$BookingDetailsEventCopyWithImpl(this._self, this._then);

  final BookingDetailsEvent _self;
  final $Res Function(BookingDetailsEvent) _then;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookingId = null,}) {
  return _then(_self.copyWith(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingDetailsEvent].
extension BookingDetailsEventPatterns on BookingDetailsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchBookingDetails value)?  fetchBookingDetails,TResult Function( _UpdateDeliveryStatus value)?  updateDeliveryStatus,TResult Function( _UpdateBookingStatus value)?  updateBookingStatus,TResult Function( _UpdatePayment value)?  updatePayment,TResult Function( _DeletePayment value)?  deletePayment,TResult Function( _CancelBooking value)?  cancelBooking,TResult Function( _DeleteBooking value)?  deleteBooking,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchBookingDetails() when fetchBookingDetails != null:
return fetchBookingDetails(_that);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that);case _UpdateBookingStatus() when updateBookingStatus != null:
return updateBookingStatus(_that);case _UpdatePayment() when updatePayment != null:
return updatePayment(_that);case _DeletePayment() when deletePayment != null:
return deletePayment(_that);case _CancelBooking() when cancelBooking != null:
return cancelBooking(_that);case _DeleteBooking() when deleteBooking != null:
return deleteBooking(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchBookingDetails value)  fetchBookingDetails,required TResult Function( _UpdateDeliveryStatus value)  updateDeliveryStatus,required TResult Function( _UpdateBookingStatus value)  updateBookingStatus,required TResult Function( _UpdatePayment value)  updatePayment,required TResult Function( _DeletePayment value)  deletePayment,required TResult Function( _CancelBooking value)  cancelBooking,required TResult Function( _DeleteBooking value)  deleteBooking,}){
final _that = this;
switch (_that) {
case _FetchBookingDetails():
return fetchBookingDetails(_that);case _UpdateDeliveryStatus():
return updateDeliveryStatus(_that);case _UpdateBookingStatus():
return updateBookingStatus(_that);case _UpdatePayment():
return updatePayment(_that);case _DeletePayment():
return deletePayment(_that);case _CancelBooking():
return cancelBooking(_that);case _DeleteBooking():
return deleteBooking(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchBookingDetails value)?  fetchBookingDetails,TResult? Function( _UpdateDeliveryStatus value)?  updateDeliveryStatus,TResult? Function( _UpdateBookingStatus value)?  updateBookingStatus,TResult? Function( _UpdatePayment value)?  updatePayment,TResult? Function( _DeletePayment value)?  deletePayment,TResult? Function( _CancelBooking value)?  cancelBooking,TResult? Function( _DeleteBooking value)?  deleteBooking,}){
final _that = this;
switch (_that) {
case _FetchBookingDetails() when fetchBookingDetails != null:
return fetchBookingDetails(_that);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that);case _UpdateBookingStatus() when updateBookingStatus != null:
return updateBookingStatus(_that);case _UpdatePayment() when updatePayment != null:
return updatePayment(_that);case _DeletePayment() when deletePayment != null:
return deletePayment(_that);case _CancelBooking() when cancelBooking != null:
return cancelBooking(_that);case _DeleteBooking() when deleteBooking != null:
return deleteBooking(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int bookingId)?  fetchBookingDetails,TResult Function( int bookingId,  DeliveryStatus deliveryStatus)?  updateDeliveryStatus,TResult Function( int bookingId,  BookingStatus bookingStatus)?  updateBookingStatus,TResult Function( int bookingId,  int amount,  int accountId)?  updatePayment,TResult Function( int bookingId,  int paymentId)?  deletePayment,TResult Function( int bookingId,  int? refundAmount,  int? accountId)?  cancelBooking,TResult Function( int bookingId)?  deleteBooking,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchBookingDetails() when fetchBookingDetails != null:
return fetchBookingDetails(_that.bookingId);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that.bookingId,_that.deliveryStatus);case _UpdateBookingStatus() when updateBookingStatus != null:
return updateBookingStatus(_that.bookingId,_that.bookingStatus);case _UpdatePayment() when updatePayment != null:
return updatePayment(_that.bookingId,_that.amount,_that.accountId);case _DeletePayment() when deletePayment != null:
return deletePayment(_that.bookingId,_that.paymentId);case _CancelBooking() when cancelBooking != null:
return cancelBooking(_that.bookingId,_that.refundAmount,_that.accountId);case _DeleteBooking() when deleteBooking != null:
return deleteBooking(_that.bookingId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int bookingId)  fetchBookingDetails,required TResult Function( int bookingId,  DeliveryStatus deliveryStatus)  updateDeliveryStatus,required TResult Function( int bookingId,  BookingStatus bookingStatus)  updateBookingStatus,required TResult Function( int bookingId,  int amount,  int accountId)  updatePayment,required TResult Function( int bookingId,  int paymentId)  deletePayment,required TResult Function( int bookingId,  int? refundAmount,  int? accountId)  cancelBooking,required TResult Function( int bookingId)  deleteBooking,}) {final _that = this;
switch (_that) {
case _FetchBookingDetails():
return fetchBookingDetails(_that.bookingId);case _UpdateDeliveryStatus():
return updateDeliveryStatus(_that.bookingId,_that.deliveryStatus);case _UpdateBookingStatus():
return updateBookingStatus(_that.bookingId,_that.bookingStatus);case _UpdatePayment():
return updatePayment(_that.bookingId,_that.amount,_that.accountId);case _DeletePayment():
return deletePayment(_that.bookingId,_that.paymentId);case _CancelBooking():
return cancelBooking(_that.bookingId,_that.refundAmount,_that.accountId);case _DeleteBooking():
return deleteBooking(_that.bookingId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int bookingId)?  fetchBookingDetails,TResult? Function( int bookingId,  DeliveryStatus deliveryStatus)?  updateDeliveryStatus,TResult? Function( int bookingId,  BookingStatus bookingStatus)?  updateBookingStatus,TResult? Function( int bookingId,  int amount,  int accountId)?  updatePayment,TResult? Function( int bookingId,  int paymentId)?  deletePayment,TResult? Function( int bookingId,  int? refundAmount,  int? accountId)?  cancelBooking,TResult? Function( int bookingId)?  deleteBooking,}) {final _that = this;
switch (_that) {
case _FetchBookingDetails() when fetchBookingDetails != null:
return fetchBookingDetails(_that.bookingId);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that.bookingId,_that.deliveryStatus);case _UpdateBookingStatus() when updateBookingStatus != null:
return updateBookingStatus(_that.bookingId,_that.bookingStatus);case _UpdatePayment() when updatePayment != null:
return updatePayment(_that.bookingId,_that.amount,_that.accountId);case _DeletePayment() when deletePayment != null:
return deletePayment(_that.bookingId,_that.paymentId);case _CancelBooking() when cancelBooking != null:
return cancelBooking(_that.bookingId,_that.refundAmount,_that.accountId);case _DeleteBooking() when deleteBooking != null:
return deleteBooking(_that.bookingId);case _:
  return null;

}
}

}

/// @nodoc


class _FetchBookingDetails implements BookingDetailsEvent {
  const _FetchBookingDetails(this.bookingId);
  

@override final  int bookingId;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchBookingDetailsCopyWith<_FetchBookingDetails> get copyWith => __$FetchBookingDetailsCopyWithImpl<_FetchBookingDetails>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchBookingDetails&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId);

@override
String toString() {
  return 'BookingDetailsEvent.fetchBookingDetails(bookingId: $bookingId)';
}


}

/// @nodoc
abstract mixin class _$FetchBookingDetailsCopyWith<$Res> implements $BookingDetailsEventCopyWith<$Res> {
  factory _$FetchBookingDetailsCopyWith(_FetchBookingDetails value, $Res Function(_FetchBookingDetails) _then) = __$FetchBookingDetailsCopyWithImpl;
@override @useResult
$Res call({
 int bookingId
});




}
/// @nodoc
class __$FetchBookingDetailsCopyWithImpl<$Res>
    implements _$FetchBookingDetailsCopyWith<$Res> {
  __$FetchBookingDetailsCopyWithImpl(this._self, this._then);

  final _FetchBookingDetails _self;
  final $Res Function(_FetchBookingDetails) _then;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,}) {
  return _then(_FetchBookingDetails(
null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _UpdateDeliveryStatus implements BookingDetailsEvent {
  const _UpdateDeliveryStatus({required this.bookingId, required this.deliveryStatus});
  

@override final  int bookingId;
 final  DeliveryStatus deliveryStatus;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateDeliveryStatusCopyWith<_UpdateDeliveryStatus> get copyWith => __$UpdateDeliveryStatusCopyWithImpl<_UpdateDeliveryStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateDeliveryStatus&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId,deliveryStatus);

@override
String toString() {
  return 'BookingDetailsEvent.updateDeliveryStatus(bookingId: $bookingId, deliveryStatus: $deliveryStatus)';
}


}

/// @nodoc
abstract mixin class _$UpdateDeliveryStatusCopyWith<$Res> implements $BookingDetailsEventCopyWith<$Res> {
  factory _$UpdateDeliveryStatusCopyWith(_UpdateDeliveryStatus value, $Res Function(_UpdateDeliveryStatus) _then) = __$UpdateDeliveryStatusCopyWithImpl;
@override @useResult
$Res call({
 int bookingId, DeliveryStatus deliveryStatus
});




}
/// @nodoc
class __$UpdateDeliveryStatusCopyWithImpl<$Res>
    implements _$UpdateDeliveryStatusCopyWith<$Res> {
  __$UpdateDeliveryStatusCopyWithImpl(this._self, this._then);

  final _UpdateDeliveryStatus _self;
  final $Res Function(_UpdateDeliveryStatus) _then;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,Object? deliveryStatus = null,}) {
  return _then(_UpdateDeliveryStatus(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,deliveryStatus: null == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,
  ));
}


}

/// @nodoc


class _UpdateBookingStatus implements BookingDetailsEvent {
  const _UpdateBookingStatus({required this.bookingId, required this.bookingStatus});
  

@override final  int bookingId;
 final  BookingStatus bookingStatus;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateBookingStatusCopyWith<_UpdateBookingStatus> get copyWith => __$UpdateBookingStatusCopyWithImpl<_UpdateBookingStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateBookingStatus&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.bookingStatus, bookingStatus) || other.bookingStatus == bookingStatus));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId,bookingStatus);

@override
String toString() {
  return 'BookingDetailsEvent.updateBookingStatus(bookingId: $bookingId, bookingStatus: $bookingStatus)';
}


}

/// @nodoc
abstract mixin class _$UpdateBookingStatusCopyWith<$Res> implements $BookingDetailsEventCopyWith<$Res> {
  factory _$UpdateBookingStatusCopyWith(_UpdateBookingStatus value, $Res Function(_UpdateBookingStatus) _then) = __$UpdateBookingStatusCopyWithImpl;
@override @useResult
$Res call({
 int bookingId, BookingStatus bookingStatus
});




}
/// @nodoc
class __$UpdateBookingStatusCopyWithImpl<$Res>
    implements _$UpdateBookingStatusCopyWith<$Res> {
  __$UpdateBookingStatusCopyWithImpl(this._self, this._then);

  final _UpdateBookingStatus _self;
  final $Res Function(_UpdateBookingStatus) _then;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,Object? bookingStatus = null,}) {
  return _then(_UpdateBookingStatus(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,bookingStatus: null == bookingStatus ? _self.bookingStatus : bookingStatus // ignore: cast_nullable_to_non_nullable
as BookingStatus,
  ));
}


}

/// @nodoc


class _UpdatePayment implements BookingDetailsEvent {
  const _UpdatePayment({required this.bookingId, required this.amount, required this.accountId});
  

@override final  int bookingId;
 final  int amount;
 final  int accountId;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatePaymentCopyWith<_UpdatePayment> get copyWith => __$UpdatePaymentCopyWithImpl<_UpdatePayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatePayment&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountId, accountId) || other.accountId == accountId));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId,amount,accountId);

@override
String toString() {
  return 'BookingDetailsEvent.updatePayment(bookingId: $bookingId, amount: $amount, accountId: $accountId)';
}


}

/// @nodoc
abstract mixin class _$UpdatePaymentCopyWith<$Res> implements $BookingDetailsEventCopyWith<$Res> {
  factory _$UpdatePaymentCopyWith(_UpdatePayment value, $Res Function(_UpdatePayment) _then) = __$UpdatePaymentCopyWithImpl;
@override @useResult
$Res call({
 int bookingId, int amount, int accountId
});




}
/// @nodoc
class __$UpdatePaymentCopyWithImpl<$Res>
    implements _$UpdatePaymentCopyWith<$Res> {
  __$UpdatePaymentCopyWithImpl(this._self, this._then);

  final _UpdatePayment _self;
  final $Res Function(_UpdatePayment) _then;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,Object? amount = null,Object? accountId = null,}) {
  return _then(_UpdatePayment(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _DeletePayment implements BookingDetailsEvent {
  const _DeletePayment({required this.bookingId, required this.paymentId});
  

@override final  int bookingId;
 final  int paymentId;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeletePaymentCopyWith<_DeletePayment> get copyWith => __$DeletePaymentCopyWithImpl<_DeletePayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeletePayment&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId,paymentId);

@override
String toString() {
  return 'BookingDetailsEvent.deletePayment(bookingId: $bookingId, paymentId: $paymentId)';
}


}

/// @nodoc
abstract mixin class _$DeletePaymentCopyWith<$Res> implements $BookingDetailsEventCopyWith<$Res> {
  factory _$DeletePaymentCopyWith(_DeletePayment value, $Res Function(_DeletePayment) _then) = __$DeletePaymentCopyWithImpl;
@override @useResult
$Res call({
 int bookingId, int paymentId
});




}
/// @nodoc
class __$DeletePaymentCopyWithImpl<$Res>
    implements _$DeletePaymentCopyWith<$Res> {
  __$DeletePaymentCopyWithImpl(this._self, this._then);

  final _DeletePayment _self;
  final $Res Function(_DeletePayment) _then;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,Object? paymentId = null,}) {
  return _then(_DeletePayment(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _CancelBooking implements BookingDetailsEvent {
  const _CancelBooking({required this.bookingId, this.refundAmount, this.accountId});
  

@override final  int bookingId;
 final  int? refundAmount;
 final  int? accountId;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancelBookingCopyWith<_CancelBooking> get copyWith => __$CancelBookingCopyWithImpl<_CancelBooking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelBooking&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.refundAmount, refundAmount) || other.refundAmount == refundAmount)&&(identical(other.accountId, accountId) || other.accountId == accountId));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId,refundAmount,accountId);

@override
String toString() {
  return 'BookingDetailsEvent.cancelBooking(bookingId: $bookingId, refundAmount: $refundAmount, accountId: $accountId)';
}


}

/// @nodoc
abstract mixin class _$CancelBookingCopyWith<$Res> implements $BookingDetailsEventCopyWith<$Res> {
  factory _$CancelBookingCopyWith(_CancelBooking value, $Res Function(_CancelBooking) _then) = __$CancelBookingCopyWithImpl;
@override @useResult
$Res call({
 int bookingId, int? refundAmount, int? accountId
});




}
/// @nodoc
class __$CancelBookingCopyWithImpl<$Res>
    implements _$CancelBookingCopyWith<$Res> {
  __$CancelBookingCopyWithImpl(this._self, this._then);

  final _CancelBooking _self;
  final $Res Function(_CancelBooking) _then;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,Object? refundAmount = freezed,Object? accountId = freezed,}) {
  return _then(_CancelBooking(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,refundAmount: freezed == refundAmount ? _self.refundAmount : refundAmount // ignore: cast_nullable_to_non_nullable
as int?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _DeleteBooking implements BookingDetailsEvent {
  const _DeleteBooking(this.bookingId);
  

@override final  int bookingId;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteBookingCopyWith<_DeleteBooking> get copyWith => __$DeleteBookingCopyWithImpl<_DeleteBooking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteBooking&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId);

@override
String toString() {
  return 'BookingDetailsEvent.deleteBooking(bookingId: $bookingId)';
}


}

/// @nodoc
abstract mixin class _$DeleteBookingCopyWith<$Res> implements $BookingDetailsEventCopyWith<$Res> {
  factory _$DeleteBookingCopyWith(_DeleteBooking value, $Res Function(_DeleteBooking) _then) = __$DeleteBookingCopyWithImpl;
@override @useResult
$Res call({
 int bookingId
});




}
/// @nodoc
class __$DeleteBookingCopyWithImpl<$Res>
    implements _$DeleteBookingCopyWith<$Res> {
  __$DeleteBookingCopyWithImpl(this._self, this._then);

  final _DeleteBooking _self;
  final $Res Function(_DeleteBooking) _then;

/// Create a copy of BookingDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookingId = null,}) {
  return _then(_DeleteBooking(
null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$BookingDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingDetailsState()';
}


}

/// @nodoc
class $BookingDetailsStateCopyWith<$Res>  {
$BookingDetailsStateCopyWith(BookingDetailsState _, $Res Function(BookingDetailsState) __);
}


/// Adds pattern-matching-related methods to [BookingDetailsState].
extension BookingDetailsStatePatterns on BookingDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Success value)?  success,TResult Function( _Failed value)?  failed,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Success() when success != null:
return success(_that);case _Failed() when failed != null:
return failed(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Success value)  success,required TResult Function( _Failed value)  failed,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Success():
return success(_that);case _Failed():
return failed(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Success value)?  success,TResult? Function( _Failed value)?  failed,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Success() when success != null:
return success(_that);case _Failed() when failed != null:
return failed(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( BookingDetailsEntity booking)?  loaded,TResult Function( String message,  bool didPop,  bool needRefresh)?  success,TResult Function( String message)?  failed,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.booking);case _Success() when success != null:
return success(_that.message,_that.didPop,_that.needRefresh);case _Failed() when failed != null:
return failed(_that.message);case _Error() when error != null:
return error(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( BookingDetailsEntity booking)  loaded,required TResult Function( String message,  bool didPop,  bool needRefresh)  success,required TResult Function( String message)  failed,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Loaded():
return loaded(_that.booking);case _Success():
return success(_that.message,_that.didPop,_that.needRefresh);case _Failed():
return failed(_that.message);case _Error():
return error(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( BookingDetailsEntity booking)?  loaded,TResult? Function( String message,  bool didPop,  bool needRefresh)?  success,TResult? Function( String message)?  failed,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.booking);case _Success() when success != null:
return success(_that.message,_that.didPop,_that.needRefresh);case _Failed() when failed != null:
return failed(_that.message);case _Error() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Loading implements BookingDetailsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingDetailsState.loading()';
}


}




/// @nodoc


class _Loaded implements BookingDetailsState {
  const _Loaded({required this.booking});
  

 final  BookingDetailsEntity booking;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.booking, booking) || other.booking == booking));
}


@override
int get hashCode => Object.hash(runtimeType,booking);

@override
String toString() {
  return 'BookingDetailsState.loaded(booking: $booking)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $BookingDetailsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 BookingDetailsEntity booking
});


$BookingDetailsEntityCopyWith<$Res> get booking;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? booking = null,}) {
  return _then(_Loaded(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as BookingDetailsEntity,
  ));
}

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingDetailsEntityCopyWith<$Res> get booking {
  
  return $BookingDetailsEntityCopyWith<$Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}

/// @nodoc


class _Success implements BookingDetailsState {
  const _Success(this.message, {this.didPop = false, this.needRefresh = true});
  

 final  String message;
@JsonKey() final  bool didPop;
@JsonKey() final  bool needRefresh;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.message, message) || other.message == message)&&(identical(other.didPop, didPop) || other.didPop == didPop)&&(identical(other.needRefresh, needRefresh) || other.needRefresh == needRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,message,didPop,needRefresh);

@override
String toString() {
  return 'BookingDetailsState.success(message: $message, didPop: $didPop, needRefresh: $needRefresh)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $BookingDetailsStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 String message, bool didPop, bool needRefresh
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? didPop = null,Object? needRefresh = null,}) {
  return _then(_Success(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,didPop: null == didPop ? _self.didPop : didPop // ignore: cast_nullable_to_non_nullable
as bool,needRefresh: null == needRefresh ? _self.needRefresh : needRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Failed implements BookingDetailsState {
  const _Failed(this.message);
  

 final  String message;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailedCopyWith<_Failed> get copyWith => __$FailedCopyWithImpl<_Failed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BookingDetailsState.failed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailedCopyWith<$Res> implements $BookingDetailsStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) _then) = __$FailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailedCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(this._self, this._then);

  final _Failed _self;
  final $Res Function(_Failed) _then;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Error implements BookingDetailsState {
  const _Error(this.error);
  

 final  String error;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'BookingDetailsState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $BookingDetailsStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of BookingDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
