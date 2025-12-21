// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookingDetailsEvent {
  int get bookingId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int bookingId) fetchBookingDetails,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
    required TResult Function(int bookingId, BookingStatus bookingStatus)
        updateBookingStatus,
    required TResult Function(
            int bookingId, int amount, PaymentMethod paymentMethod)
        updatePayment,
    required TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)
        cancelBooking,
    required TResult Function(int bookingId) deleteBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int bookingId)? fetchBookingDetails,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult? Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult? Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult? Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult? Function(int bookingId)? deleteBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int bookingId)? fetchBookingDetails,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult Function(int bookingId)? deleteBooking,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchBookingDetails value) fetchBookingDetails,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
    required TResult Function(_UpdateBookingStatus value) updateBookingStatus,
    required TResult Function(_UpdatePayment value) updatePayment,
    required TResult Function(_CancelBooking value) cancelBooking,
    required TResult Function(_DeleteBooking value) deleteBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult? Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult? Function(_UpdatePayment value)? updatePayment,
    TResult? Function(_CancelBooking value)? cancelBooking,
    TResult? Function(_DeleteBooking value)? deleteBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult Function(_UpdatePayment value)? updatePayment,
    TResult Function(_CancelBooking value)? cancelBooking,
    TResult Function(_DeleteBooking value)? deleteBooking,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingDetailsEventCopyWith<BookingDetailsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingDetailsEventCopyWith<$Res> {
  factory $BookingDetailsEventCopyWith(
          BookingDetailsEvent value, $Res Function(BookingDetailsEvent) then) =
      _$BookingDetailsEventCopyWithImpl<$Res, BookingDetailsEvent>;
  @useResult
  $Res call({int bookingId});
}

/// @nodoc
class _$BookingDetailsEventCopyWithImpl<$Res, $Val extends BookingDetailsEvent>
    implements $BookingDetailsEventCopyWith<$Res> {
  _$BookingDetailsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
  }) {
    return _then(_value.copyWith(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FetchBookingDetailsImplCopyWith<$Res>
    implements $BookingDetailsEventCopyWith<$Res> {
  factory _$$FetchBookingDetailsImplCopyWith(_$FetchBookingDetailsImpl value,
          $Res Function(_$FetchBookingDetailsImpl) then) =
      __$$FetchBookingDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int bookingId});
}

/// @nodoc
class __$$FetchBookingDetailsImplCopyWithImpl<$Res>
    extends _$BookingDetailsEventCopyWithImpl<$Res, _$FetchBookingDetailsImpl>
    implements _$$FetchBookingDetailsImplCopyWith<$Res> {
  __$$FetchBookingDetailsImplCopyWithImpl(_$FetchBookingDetailsImpl _value,
      $Res Function(_$FetchBookingDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
  }) {
    return _then(_$FetchBookingDetailsImpl(
      null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FetchBookingDetailsImpl implements _FetchBookingDetails {
  const _$FetchBookingDetailsImpl(this.bookingId);

  @override
  final int bookingId;

  @override
  String toString() {
    return 'BookingDetailsEvent.fetchBookingDetails(bookingId: $bookingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchBookingDetailsImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bookingId);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchBookingDetailsImplCopyWith<_$FetchBookingDetailsImpl> get copyWith =>
      __$$FetchBookingDetailsImplCopyWithImpl<_$FetchBookingDetailsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int bookingId) fetchBookingDetails,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
    required TResult Function(int bookingId, BookingStatus bookingStatus)
        updateBookingStatus,
    required TResult Function(
            int bookingId, int amount, PaymentMethod paymentMethod)
        updatePayment,
    required TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)
        cancelBooking,
    required TResult Function(int bookingId) deleteBooking,
  }) {
    return fetchBookingDetails(bookingId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int bookingId)? fetchBookingDetails,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult? Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult? Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult? Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult? Function(int bookingId)? deleteBooking,
  }) {
    return fetchBookingDetails?.call(bookingId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int bookingId)? fetchBookingDetails,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult Function(int bookingId)? deleteBooking,
    required TResult orElse(),
  }) {
    if (fetchBookingDetails != null) {
      return fetchBookingDetails(bookingId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchBookingDetails value) fetchBookingDetails,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
    required TResult Function(_UpdateBookingStatus value) updateBookingStatus,
    required TResult Function(_UpdatePayment value) updatePayment,
    required TResult Function(_CancelBooking value) cancelBooking,
    required TResult Function(_DeleteBooking value) deleteBooking,
  }) {
    return fetchBookingDetails(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult? Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult? Function(_UpdatePayment value)? updatePayment,
    TResult? Function(_CancelBooking value)? cancelBooking,
    TResult? Function(_DeleteBooking value)? deleteBooking,
  }) {
    return fetchBookingDetails?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult Function(_UpdatePayment value)? updatePayment,
    TResult Function(_CancelBooking value)? cancelBooking,
    TResult Function(_DeleteBooking value)? deleteBooking,
    required TResult orElse(),
  }) {
    if (fetchBookingDetails != null) {
      return fetchBookingDetails(this);
    }
    return orElse();
  }
}

abstract class _FetchBookingDetails implements BookingDetailsEvent {
  const factory _FetchBookingDetails(final int bookingId) =
      _$FetchBookingDetailsImpl;

  @override
  int get bookingId;

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchBookingDetailsImplCopyWith<_$FetchBookingDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateDeliveryStatusImplCopyWith<$Res>
    implements $BookingDetailsEventCopyWith<$Res> {
  factory _$$UpdateDeliveryStatusImplCopyWith(_$UpdateDeliveryStatusImpl value,
          $Res Function(_$UpdateDeliveryStatusImpl) then) =
      __$$UpdateDeliveryStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int bookingId, DeliveryStatus deliveryStatus});
}

/// @nodoc
class __$$UpdateDeliveryStatusImplCopyWithImpl<$Res>
    extends _$BookingDetailsEventCopyWithImpl<$Res, _$UpdateDeliveryStatusImpl>
    implements _$$UpdateDeliveryStatusImplCopyWith<$Res> {
  __$$UpdateDeliveryStatusImplCopyWithImpl(_$UpdateDeliveryStatusImpl _value,
      $Res Function(_$UpdateDeliveryStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? deliveryStatus = null,
  }) {
    return _then(_$UpdateDeliveryStatusImpl(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      deliveryStatus: null == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as DeliveryStatus,
    ));
  }
}

/// @nodoc

class _$UpdateDeliveryStatusImpl implements _UpdateDeliveryStatus {
  const _$UpdateDeliveryStatusImpl(
      {required this.bookingId, required this.deliveryStatus});

  @override
  final int bookingId;
  @override
  final DeliveryStatus deliveryStatus;

  @override
  String toString() {
    return 'BookingDetailsEvent.updateDeliveryStatus(bookingId: $bookingId, deliveryStatus: $deliveryStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDeliveryStatusImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.deliveryStatus, deliveryStatus) ||
                other.deliveryStatus == deliveryStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bookingId, deliveryStatus);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDeliveryStatusImplCopyWith<_$UpdateDeliveryStatusImpl>
      get copyWith =>
          __$$UpdateDeliveryStatusImplCopyWithImpl<_$UpdateDeliveryStatusImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int bookingId) fetchBookingDetails,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
    required TResult Function(int bookingId, BookingStatus bookingStatus)
        updateBookingStatus,
    required TResult Function(
            int bookingId, int amount, PaymentMethod paymentMethod)
        updatePayment,
    required TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)
        cancelBooking,
    required TResult Function(int bookingId) deleteBooking,
  }) {
    return updateDeliveryStatus(bookingId, deliveryStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int bookingId)? fetchBookingDetails,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult? Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult? Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult? Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult? Function(int bookingId)? deleteBooking,
  }) {
    return updateDeliveryStatus?.call(bookingId, deliveryStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int bookingId)? fetchBookingDetails,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult Function(int bookingId)? deleteBooking,
    required TResult orElse(),
  }) {
    if (updateDeliveryStatus != null) {
      return updateDeliveryStatus(bookingId, deliveryStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchBookingDetails value) fetchBookingDetails,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
    required TResult Function(_UpdateBookingStatus value) updateBookingStatus,
    required TResult Function(_UpdatePayment value) updatePayment,
    required TResult Function(_CancelBooking value) cancelBooking,
    required TResult Function(_DeleteBooking value) deleteBooking,
  }) {
    return updateDeliveryStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult? Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult? Function(_UpdatePayment value)? updatePayment,
    TResult? Function(_CancelBooking value)? cancelBooking,
    TResult? Function(_DeleteBooking value)? deleteBooking,
  }) {
    return updateDeliveryStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult Function(_UpdatePayment value)? updatePayment,
    TResult Function(_CancelBooking value)? cancelBooking,
    TResult Function(_DeleteBooking value)? deleteBooking,
    required TResult orElse(),
  }) {
    if (updateDeliveryStatus != null) {
      return updateDeliveryStatus(this);
    }
    return orElse();
  }
}

abstract class _UpdateDeliveryStatus implements BookingDetailsEvent {
  const factory _UpdateDeliveryStatus(
          {required final int bookingId,
          required final DeliveryStatus deliveryStatus}) =
      _$UpdateDeliveryStatusImpl;

  @override
  int get bookingId;
  DeliveryStatus get deliveryStatus;

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDeliveryStatusImplCopyWith<_$UpdateDeliveryStatusImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateBookingStatusImplCopyWith<$Res>
    implements $BookingDetailsEventCopyWith<$Res> {
  factory _$$UpdateBookingStatusImplCopyWith(_$UpdateBookingStatusImpl value,
          $Res Function(_$UpdateBookingStatusImpl) then) =
      __$$UpdateBookingStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int bookingId, BookingStatus bookingStatus});
}

/// @nodoc
class __$$UpdateBookingStatusImplCopyWithImpl<$Res>
    extends _$BookingDetailsEventCopyWithImpl<$Res, _$UpdateBookingStatusImpl>
    implements _$$UpdateBookingStatusImplCopyWith<$Res> {
  __$$UpdateBookingStatusImplCopyWithImpl(_$UpdateBookingStatusImpl _value,
      $Res Function(_$UpdateBookingStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? bookingStatus = null,
  }) {
    return _then(_$UpdateBookingStatusImpl(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      bookingStatus: null == bookingStatus
          ? _value.bookingStatus
          : bookingStatus // ignore: cast_nullable_to_non_nullable
              as BookingStatus,
    ));
  }
}

/// @nodoc

class _$UpdateBookingStatusImpl implements _UpdateBookingStatus {
  const _$UpdateBookingStatusImpl(
      {required this.bookingId, required this.bookingStatus});

  @override
  final int bookingId;
  @override
  final BookingStatus bookingStatus;

  @override
  String toString() {
    return 'BookingDetailsEvent.updateBookingStatus(bookingId: $bookingId, bookingStatus: $bookingStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateBookingStatusImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.bookingStatus, bookingStatus) ||
                other.bookingStatus == bookingStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bookingId, bookingStatus);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBookingStatusImplCopyWith<_$UpdateBookingStatusImpl> get copyWith =>
      __$$UpdateBookingStatusImplCopyWithImpl<_$UpdateBookingStatusImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int bookingId) fetchBookingDetails,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
    required TResult Function(int bookingId, BookingStatus bookingStatus)
        updateBookingStatus,
    required TResult Function(
            int bookingId, int amount, PaymentMethod paymentMethod)
        updatePayment,
    required TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)
        cancelBooking,
    required TResult Function(int bookingId) deleteBooking,
  }) {
    return updateBookingStatus(bookingId, bookingStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int bookingId)? fetchBookingDetails,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult? Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult? Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult? Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult? Function(int bookingId)? deleteBooking,
  }) {
    return updateBookingStatus?.call(bookingId, bookingStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int bookingId)? fetchBookingDetails,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult Function(int bookingId)? deleteBooking,
    required TResult orElse(),
  }) {
    if (updateBookingStatus != null) {
      return updateBookingStatus(bookingId, bookingStatus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchBookingDetails value) fetchBookingDetails,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
    required TResult Function(_UpdateBookingStatus value) updateBookingStatus,
    required TResult Function(_UpdatePayment value) updatePayment,
    required TResult Function(_CancelBooking value) cancelBooking,
    required TResult Function(_DeleteBooking value) deleteBooking,
  }) {
    return updateBookingStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult? Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult? Function(_UpdatePayment value)? updatePayment,
    TResult? Function(_CancelBooking value)? cancelBooking,
    TResult? Function(_DeleteBooking value)? deleteBooking,
  }) {
    return updateBookingStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult Function(_UpdatePayment value)? updatePayment,
    TResult Function(_CancelBooking value)? cancelBooking,
    TResult Function(_DeleteBooking value)? deleteBooking,
    required TResult orElse(),
  }) {
    if (updateBookingStatus != null) {
      return updateBookingStatus(this);
    }
    return orElse();
  }
}

abstract class _UpdateBookingStatus implements BookingDetailsEvent {
  const factory _UpdateBookingStatus(
      {required final int bookingId,
      required final BookingStatus bookingStatus}) = _$UpdateBookingStatusImpl;

  @override
  int get bookingId;
  BookingStatus get bookingStatus;

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateBookingStatusImplCopyWith<_$UpdateBookingStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatePaymentImplCopyWith<$Res>
    implements $BookingDetailsEventCopyWith<$Res> {
  factory _$$UpdatePaymentImplCopyWith(
          _$UpdatePaymentImpl value, $Res Function(_$UpdatePaymentImpl) then) =
      __$$UpdatePaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int bookingId, int amount, PaymentMethod paymentMethod});
}

/// @nodoc
class __$$UpdatePaymentImplCopyWithImpl<$Res>
    extends _$BookingDetailsEventCopyWithImpl<$Res, _$UpdatePaymentImpl>
    implements _$$UpdatePaymentImplCopyWith<$Res> {
  __$$UpdatePaymentImplCopyWithImpl(
      _$UpdatePaymentImpl _value, $Res Function(_$UpdatePaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? amount = null,
    Object? paymentMethod = null,
  }) {
    return _then(_$UpdatePaymentImpl(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
    ));
  }
}

/// @nodoc

class _$UpdatePaymentImpl implements _UpdatePayment {
  const _$UpdatePaymentImpl(
      {required this.bookingId,
      required this.amount,
      required this.paymentMethod});

  @override
  final int bookingId;
  @override
  final int amount;
  @override
  final PaymentMethod paymentMethod;

  @override
  String toString() {
    return 'BookingDetailsEvent.updatePayment(bookingId: $bookingId, amount: $amount, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePaymentImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, bookingId, amount, paymentMethod);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePaymentImplCopyWith<_$UpdatePaymentImpl> get copyWith =>
      __$$UpdatePaymentImplCopyWithImpl<_$UpdatePaymentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int bookingId) fetchBookingDetails,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
    required TResult Function(int bookingId, BookingStatus bookingStatus)
        updateBookingStatus,
    required TResult Function(
            int bookingId, int amount, PaymentMethod paymentMethod)
        updatePayment,
    required TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)
        cancelBooking,
    required TResult Function(int bookingId) deleteBooking,
  }) {
    return updatePayment(bookingId, amount, paymentMethod);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int bookingId)? fetchBookingDetails,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult? Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult? Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult? Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult? Function(int bookingId)? deleteBooking,
  }) {
    return updatePayment?.call(bookingId, amount, paymentMethod);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int bookingId)? fetchBookingDetails,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult Function(int bookingId)? deleteBooking,
    required TResult orElse(),
  }) {
    if (updatePayment != null) {
      return updatePayment(bookingId, amount, paymentMethod);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchBookingDetails value) fetchBookingDetails,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
    required TResult Function(_UpdateBookingStatus value) updateBookingStatus,
    required TResult Function(_UpdatePayment value) updatePayment,
    required TResult Function(_CancelBooking value) cancelBooking,
    required TResult Function(_DeleteBooking value) deleteBooking,
  }) {
    return updatePayment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult? Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult? Function(_UpdatePayment value)? updatePayment,
    TResult? Function(_CancelBooking value)? cancelBooking,
    TResult? Function(_DeleteBooking value)? deleteBooking,
  }) {
    return updatePayment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult Function(_UpdatePayment value)? updatePayment,
    TResult Function(_CancelBooking value)? cancelBooking,
    TResult Function(_DeleteBooking value)? deleteBooking,
    required TResult orElse(),
  }) {
    if (updatePayment != null) {
      return updatePayment(this);
    }
    return orElse();
  }
}

abstract class _UpdatePayment implements BookingDetailsEvent {
  const factory _UpdatePayment(
      {required final int bookingId,
      required final int amount,
      required final PaymentMethod paymentMethod}) = _$UpdatePaymentImpl;

  @override
  int get bookingId;
  int get amount;
  PaymentMethod get paymentMethod;

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePaymentImplCopyWith<_$UpdatePaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelBookingImplCopyWith<$Res>
    implements $BookingDetailsEventCopyWith<$Res> {
  factory _$$CancelBookingImplCopyWith(
          _$CancelBookingImpl value, $Res Function(_$CancelBookingImpl) then) =
      __$$CancelBookingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int bookingId,
      int refundAmount,
      PaymentMethod paymentMethod,
      String refundReason});
}

/// @nodoc
class __$$CancelBookingImplCopyWithImpl<$Res>
    extends _$BookingDetailsEventCopyWithImpl<$Res, _$CancelBookingImpl>
    implements _$$CancelBookingImplCopyWith<$Res> {
  __$$CancelBookingImplCopyWithImpl(
      _$CancelBookingImpl _value, $Res Function(_$CancelBookingImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? refundAmount = null,
    Object? paymentMethod = null,
    Object? refundReason = null,
  }) {
    return _then(_$CancelBookingImpl(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      refundAmount: null == refundAmount
          ? _value.refundAmount
          : refundAmount // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      refundReason: null == refundReason
          ? _value.refundReason
          : refundReason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CancelBookingImpl implements _CancelBooking {
  const _$CancelBookingImpl(
      {required this.bookingId,
      required this.refundAmount,
      required this.paymentMethod,
      required this.refundReason});

  @override
  final int bookingId;
  @override
  final int refundAmount;
  @override
  final PaymentMethod paymentMethod;
  @override
  final String refundReason;

  @override
  String toString() {
    return 'BookingDetailsEvent.cancelBooking(bookingId: $bookingId, refundAmount: $refundAmount, paymentMethod: $paymentMethod, refundReason: $refundReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelBookingImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.refundAmount, refundAmount) ||
                other.refundAmount == refundAmount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.refundReason, refundReason) ||
                other.refundReason == refundReason));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, bookingId, refundAmount, paymentMethod, refundReason);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelBookingImplCopyWith<_$CancelBookingImpl> get copyWith =>
      __$$CancelBookingImplCopyWithImpl<_$CancelBookingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int bookingId) fetchBookingDetails,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
    required TResult Function(int bookingId, BookingStatus bookingStatus)
        updateBookingStatus,
    required TResult Function(
            int bookingId, int amount, PaymentMethod paymentMethod)
        updatePayment,
    required TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)
        cancelBooking,
    required TResult Function(int bookingId) deleteBooking,
  }) {
    return cancelBooking(bookingId, refundAmount, paymentMethod, refundReason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int bookingId)? fetchBookingDetails,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult? Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult? Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult? Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult? Function(int bookingId)? deleteBooking,
  }) {
    return cancelBooking?.call(
        bookingId, refundAmount, paymentMethod, refundReason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int bookingId)? fetchBookingDetails,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult Function(int bookingId)? deleteBooking,
    required TResult orElse(),
  }) {
    if (cancelBooking != null) {
      return cancelBooking(
          bookingId, refundAmount, paymentMethod, refundReason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchBookingDetails value) fetchBookingDetails,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
    required TResult Function(_UpdateBookingStatus value) updateBookingStatus,
    required TResult Function(_UpdatePayment value) updatePayment,
    required TResult Function(_CancelBooking value) cancelBooking,
    required TResult Function(_DeleteBooking value) deleteBooking,
  }) {
    return cancelBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult? Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult? Function(_UpdatePayment value)? updatePayment,
    TResult? Function(_CancelBooking value)? cancelBooking,
    TResult? Function(_DeleteBooking value)? deleteBooking,
  }) {
    return cancelBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult Function(_UpdatePayment value)? updatePayment,
    TResult Function(_CancelBooking value)? cancelBooking,
    TResult Function(_DeleteBooking value)? deleteBooking,
    required TResult orElse(),
  }) {
    if (cancelBooking != null) {
      return cancelBooking(this);
    }
    return orElse();
  }
}

abstract class _CancelBooking implements BookingDetailsEvent {
  const factory _CancelBooking(
      {required final int bookingId,
      required final int refundAmount,
      required final PaymentMethod paymentMethod,
      required final String refundReason}) = _$CancelBookingImpl;

  @override
  int get bookingId;
  int get refundAmount;
  PaymentMethod get paymentMethod;
  String get refundReason;

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelBookingImplCopyWith<_$CancelBookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteBookingImplCopyWith<$Res>
    implements $BookingDetailsEventCopyWith<$Res> {
  factory _$$DeleteBookingImplCopyWith(
          _$DeleteBookingImpl value, $Res Function(_$DeleteBookingImpl) then) =
      __$$DeleteBookingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int bookingId});
}

/// @nodoc
class __$$DeleteBookingImplCopyWithImpl<$Res>
    extends _$BookingDetailsEventCopyWithImpl<$Res, _$DeleteBookingImpl>
    implements _$$DeleteBookingImplCopyWith<$Res> {
  __$$DeleteBookingImplCopyWithImpl(
      _$DeleteBookingImpl _value, $Res Function(_$DeleteBookingImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
  }) {
    return _then(_$DeleteBookingImpl(
      null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DeleteBookingImpl implements _DeleteBooking {
  const _$DeleteBookingImpl(this.bookingId);

  @override
  final int bookingId;

  @override
  String toString() {
    return 'BookingDetailsEvent.deleteBooking(bookingId: $bookingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteBookingImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bookingId);

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteBookingImplCopyWith<_$DeleteBookingImpl> get copyWith =>
      __$$DeleteBookingImplCopyWithImpl<_$DeleteBookingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int bookingId) fetchBookingDetails,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
    required TResult Function(int bookingId, BookingStatus bookingStatus)
        updateBookingStatus,
    required TResult Function(
            int bookingId, int amount, PaymentMethod paymentMethod)
        updatePayment,
    required TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)
        cancelBooking,
    required TResult Function(int bookingId) deleteBooking,
  }) {
    return deleteBooking(bookingId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int bookingId)? fetchBookingDetails,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult? Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult? Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult? Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult? Function(int bookingId)? deleteBooking,
  }) {
    return deleteBooking?.call(bookingId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int bookingId)? fetchBookingDetails,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    TResult Function(int bookingId, BookingStatus bookingStatus)?
        updateBookingStatus,
    TResult Function(int bookingId, int amount, PaymentMethod paymentMethod)?
        updatePayment,
    TResult Function(int bookingId, int refundAmount,
            PaymentMethod paymentMethod, String refundReason)?
        cancelBooking,
    TResult Function(int bookingId)? deleteBooking,
    required TResult orElse(),
  }) {
    if (deleteBooking != null) {
      return deleteBooking(bookingId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchBookingDetails value) fetchBookingDetails,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
    required TResult Function(_UpdateBookingStatus value) updateBookingStatus,
    required TResult Function(_UpdatePayment value) updatePayment,
    required TResult Function(_CancelBooking value) cancelBooking,
    required TResult Function(_DeleteBooking value) deleteBooking,
  }) {
    return deleteBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult? Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult? Function(_UpdatePayment value)? updatePayment,
    TResult? Function(_CancelBooking value)? cancelBooking,
    TResult? Function(_DeleteBooking value)? deleteBooking,
  }) {
    return deleteBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchBookingDetails value)? fetchBookingDetails,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    TResult Function(_UpdateBookingStatus value)? updateBookingStatus,
    TResult Function(_UpdatePayment value)? updatePayment,
    TResult Function(_CancelBooking value)? cancelBooking,
    TResult Function(_DeleteBooking value)? deleteBooking,
    required TResult orElse(),
  }) {
    if (deleteBooking != null) {
      return deleteBooking(this);
    }
    return orElse();
  }
}

abstract class _DeleteBooking implements BookingDetailsEvent {
  const factory _DeleteBooking(final int bookingId) = _$DeleteBookingImpl;

  @override
  int get bookingId;

  /// Create a copy of BookingDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteBookingImplCopyWith<_$DeleteBookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BookingDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(BookingDetailsModel booking) loaded,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
    required TResult Function(String message) failed,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(BookingDetailsModel booking)? loaded,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
    TResult? Function(String message)? failed,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(BookingDetailsModel booking)? loaded,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    TResult Function(String message)? failed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingDetailsStateCopyWith<$Res> {
  factory $BookingDetailsStateCopyWith(
          BookingDetailsState value, $Res Function(BookingDetailsState) then) =
      _$BookingDetailsStateCopyWithImpl<$Res, BookingDetailsState>;
}

/// @nodoc
class _$BookingDetailsStateCopyWithImpl<$Res, $Val extends BookingDetailsState>
    implements $BookingDetailsStateCopyWith<$Res> {
  _$BookingDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$BookingDetailsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'BookingDetailsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(BookingDetailsModel booking) loaded,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
    required TResult Function(String message) failed,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(BookingDetailsModel booking)? loaded,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
    TResult? Function(String message)? failed,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(BookingDetailsModel booking)? loaded,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    TResult Function(String message)? failed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements BookingDetailsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BookingDetailsModel booking});

  $BookingDetailsModelCopyWith<$Res> get booking;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$BookingDetailsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? booking = null,
  }) {
    return _then(_$LoadedImpl(
      booking: null == booking
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as BookingDetailsModel,
    ));
  }

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookingDetailsModelCopyWith<$Res> get booking {
    return $BookingDetailsModelCopyWith<$Res>(_value.booking, (value) {
      return _then(_value.copyWith(booking: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({required this.booking});

  @override
  final BookingDetailsModel booking;

  @override
  String toString() {
    return 'BookingDetailsState.loaded(booking: $booking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.booking, booking) || other.booking == booking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, booking);

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(BookingDetailsModel booking) loaded,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
    required TResult Function(String message) failed,
    required TResult Function(String error) error,
  }) {
    return loaded(booking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(BookingDetailsModel booking)? loaded,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
    TResult? Function(String message)? failed,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(booking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(BookingDetailsModel booking)? loaded,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    TResult Function(String message)? failed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(booking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements BookingDetailsState {
  const factory _Loaded({required final BookingDetailsModel booking}) =
      _$LoadedImpl;

  BookingDetailsModel get booking;

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, bool didPop, bool needRefresh});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$BookingDetailsStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? didPop = null,
    Object? needRefresh = null,
  }) {
    return _then(_$SuccessImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      didPop: null == didPop
          ? _value.didPop
          : didPop // ignore: cast_nullable_to_non_nullable
              as bool,
      needRefresh: null == needRefresh
          ? _value.needRefresh
          : needRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.message,
      {this.didPop = false, this.needRefresh = true});

  @override
  final String message;
  @override
  @JsonKey()
  final bool didPop;
  @override
  @JsonKey()
  final bool needRefresh;

  @override
  String toString() {
    return 'BookingDetailsState.success(message: $message, didPop: $didPop, needRefresh: $needRefresh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.didPop, didPop) || other.didPop == didPop) &&
            (identical(other.needRefresh, needRefresh) ||
                other.needRefresh == needRefresh));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, didPop, needRefresh);

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(BookingDetailsModel booking) loaded,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
    required TResult Function(String message) failed,
    required TResult Function(String error) error,
  }) {
    return success(message, didPop, needRefresh);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(BookingDetailsModel booking)? loaded,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
    TResult? Function(String message)? failed,
    TResult? Function(String error)? error,
  }) {
    return success?.call(message, didPop, needRefresh);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(BookingDetailsModel booking)? loaded,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    TResult Function(String message)? failed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message, didPop, needRefresh);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements BookingDetailsState {
  const factory _Success(final String message,
      {final bool didPop, final bool needRefresh}) = _$SuccessImpl;

  String get message;
  bool get didPop;
  bool get needRefresh;

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$BookingDetailsStateCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$FailedImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImpl implements _Failed {
  const _$FailedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BookingDetailsState.failed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      __$$FailedImplCopyWithImpl<_$FailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(BookingDetailsModel booking) loaded,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
    required TResult Function(String message) failed,
    required TResult Function(String error) error,
  }) {
    return failed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(BookingDetailsModel booking)? loaded,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
    TResult? Function(String message)? failed,
    TResult? Function(String error)? error,
  }) {
    return failed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(BookingDetailsModel booking)? loaded,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    TResult Function(String message)? failed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Error value) error,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Error value)? error,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements BookingDetailsState {
  const factory _Failed(final String message) = _$FailedImpl;

  String get message;

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailedImplCopyWith<_$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$BookingDetailsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'BookingDetailsState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(BookingDetailsModel booking) loaded,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
    required TResult Function(String message) failed,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(BookingDetailsModel booking)? loaded,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
    TResult? Function(String message)? failed,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(BookingDetailsModel booking)? loaded,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    TResult Function(String message)? failed,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements BookingDetailsState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of BookingDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
