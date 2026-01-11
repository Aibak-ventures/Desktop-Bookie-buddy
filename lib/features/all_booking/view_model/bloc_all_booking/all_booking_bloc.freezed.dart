// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_booking_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllBookingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? status, String? startDate,
            String? endDate, String? searchQuery)
        loadBookings,
    required TResult Function() loadNextPageBookings,
    required TResult Function(DesktopBookingItemModel? booking,
            bool shouldRefresh, bool isDeleted)
        updateBooking,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? status, String? startDate, String? endDate,
            String? searchQuery)?
        loadBookings,
    TResult? Function()? loadNextPageBookings,
    TResult? Function(DesktopBookingItemModel? booking, bool shouldRefresh,
            bool isDeleted)?
        updateBooking,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? status, String? startDate, String? endDate,
            String? searchQuery)?
        loadBookings,
    TResult Function()? loadNextPageBookings,
    TResult Function(DesktopBookingItemModel? booking, bool shouldRefresh,
            bool isDeleted)?
        updateBooking,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextPageBookings value) loadNextPageBookings,
    required TResult Function(_UpdateBooking value) updateBooking,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllBookingEventCopyWith<$Res> {
  factory $AllBookingEventCopyWith(
          AllBookingEvent value, $Res Function(AllBookingEvent) then) =
      _$AllBookingEventCopyWithImpl<$Res, AllBookingEvent>;
}

/// @nodoc
class _$AllBookingEventCopyWithImpl<$Res, $Val extends AllBookingEvent>
    implements $AllBookingEventCopyWith<$Res> {
  _$AllBookingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllBookingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadBookingsImplCopyWith<$Res> {
  factory _$$LoadBookingsImplCopyWith(
          _$LoadBookingsImpl value, $Res Function(_$LoadBookingsImpl) then) =
      __$$LoadBookingsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? status,
      String? startDate,
      String? endDate,
      String? searchQuery});
}

/// @nodoc
class __$$LoadBookingsImplCopyWithImpl<$Res>
    extends _$AllBookingEventCopyWithImpl<$Res, _$LoadBookingsImpl>
    implements _$$LoadBookingsImplCopyWith<$Res> {
  __$$LoadBookingsImplCopyWithImpl(
      _$LoadBookingsImpl _value, $Res Function(_$LoadBookingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(_$LoadBookingsImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadBookingsImpl implements _LoadBookings {
  const _$LoadBookingsImpl(
      {this.status, this.startDate, this.endDate, this.searchQuery});

  @override
  final String? status;
  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final String? searchQuery;

  @override
  String toString() {
    return 'AllBookingEvent.loadBookings(status: $status, startDate: $startDate, endDate: $endDate, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadBookingsImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, startDate, endDate, searchQuery);

  /// Create a copy of AllBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadBookingsImplCopyWith<_$LoadBookingsImpl> get copyWith =>
      __$$LoadBookingsImplCopyWithImpl<_$LoadBookingsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? status, String? startDate,
            String? endDate, String? searchQuery)
        loadBookings,
    required TResult Function() loadNextPageBookings,
    required TResult Function(DesktopBookingItemModel? booking,
            bool shouldRefresh, bool isDeleted)
        updateBooking,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
  }) {
    return loadBookings(status, startDate, endDate, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? status, String? startDate, String? endDate,
            String? searchQuery)?
        loadBookings,
    TResult? Function()? loadNextPageBookings,
    TResult? Function(DesktopBookingItemModel? booking, bool shouldRefresh,
            bool isDeleted)?
        updateBooking,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
  }) {
    return loadBookings?.call(status, startDate, endDate, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? status, String? startDate, String? endDate,
            String? searchQuery)?
        loadBookings,
    TResult Function()? loadNextPageBookings,
    TResult Function(DesktopBookingItemModel? booking, bool shouldRefresh,
            bool isDeleted)?
        updateBooking,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    required TResult orElse(),
  }) {
    if (loadBookings != null) {
      return loadBookings(status, startDate, endDate, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextPageBookings value) loadNextPageBookings,
    required TResult Function(_UpdateBooking value) updateBooking,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
  }) {
    return loadBookings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
  }) {
    return loadBookings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    required TResult orElse(),
  }) {
    if (loadBookings != null) {
      return loadBookings(this);
    }
    return orElse();
  }
}

abstract class _LoadBookings implements AllBookingEvent {
  const factory _LoadBookings(
      {final String? status,
      final String? startDate,
      final String? endDate,
      final String? searchQuery}) = _$LoadBookingsImpl;

  String? get status;
  String? get startDate;
  String? get endDate;
  String? get searchQuery;

  /// Create a copy of AllBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadBookingsImplCopyWith<_$LoadBookingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPageBookingsImplCopyWith<$Res> {
  factory _$$LoadNextPageBookingsImplCopyWith(_$LoadNextPageBookingsImpl value,
          $Res Function(_$LoadNextPageBookingsImpl) then) =
      __$$LoadNextPageBookingsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPageBookingsImplCopyWithImpl<$Res>
    extends _$AllBookingEventCopyWithImpl<$Res, _$LoadNextPageBookingsImpl>
    implements _$$LoadNextPageBookingsImplCopyWith<$Res> {
  __$$LoadNextPageBookingsImplCopyWithImpl(_$LoadNextPageBookingsImpl _value,
      $Res Function(_$LoadNextPageBookingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageBookingsImpl implements _LoadNextPageBookings {
  const _$LoadNextPageBookingsImpl();

  @override
  String toString() {
    return 'AllBookingEvent.loadNextPageBookings()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextPageBookingsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? status, String? startDate,
            String? endDate, String? searchQuery)
        loadBookings,
    required TResult Function() loadNextPageBookings,
    required TResult Function(DesktopBookingItemModel? booking,
            bool shouldRefresh, bool isDeleted)
        updateBooking,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
  }) {
    return loadNextPageBookings();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? status, String? startDate, String? endDate,
            String? searchQuery)?
        loadBookings,
    TResult? Function()? loadNextPageBookings,
    TResult? Function(DesktopBookingItemModel? booking, bool shouldRefresh,
            bool isDeleted)?
        updateBooking,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
  }) {
    return loadNextPageBookings?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? status, String? startDate, String? endDate,
            String? searchQuery)?
        loadBookings,
    TResult Function()? loadNextPageBookings,
    TResult Function(DesktopBookingItemModel? booking, bool shouldRefresh,
            bool isDeleted)?
        updateBooking,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    required TResult orElse(),
  }) {
    if (loadNextPageBookings != null) {
      return loadNextPageBookings();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextPageBookings value) loadNextPageBookings,
    required TResult Function(_UpdateBooking value) updateBooking,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
  }) {
    return loadNextPageBookings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
  }) {
    return loadNextPageBookings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    required TResult orElse(),
  }) {
    if (loadNextPageBookings != null) {
      return loadNextPageBookings(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageBookings implements AllBookingEvent {
  const factory _LoadNextPageBookings() = _$LoadNextPageBookingsImpl;
}

/// @nodoc
abstract class _$$UpdateBookingImplCopyWith<$Res> {
  factory _$$UpdateBookingImplCopyWith(
          _$UpdateBookingImpl value, $Res Function(_$UpdateBookingImpl) then) =
      __$$UpdateBookingImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {DesktopBookingItemModel? booking, bool shouldRefresh, bool isDeleted});

  $DesktopBookingItemModelCopyWith<$Res>? get booking;
}

/// @nodoc
class __$$UpdateBookingImplCopyWithImpl<$Res>
    extends _$AllBookingEventCopyWithImpl<$Res, _$UpdateBookingImpl>
    implements _$$UpdateBookingImplCopyWith<$Res> {
  __$$UpdateBookingImplCopyWithImpl(
      _$UpdateBookingImpl _value, $Res Function(_$UpdateBookingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? booking = freezed,
    Object? shouldRefresh = null,
    Object? isDeleted = null,
  }) {
    return _then(_$UpdateBookingImpl(
      freezed == booking
          ? _value.booking
          : booking // ignore: cast_nullable_to_non_nullable
              as DesktopBookingItemModel?,
      shouldRefresh: null == shouldRefresh
          ? _value.shouldRefresh
          : shouldRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of AllBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DesktopBookingItemModelCopyWith<$Res>? get booking {
    if (_value.booking == null) {
      return null;
    }

    return $DesktopBookingItemModelCopyWith<$Res>(_value.booking!, (value) {
      return _then(_value.copyWith(booking: value));
    });
  }
}

/// @nodoc

class _$UpdateBookingImpl implements _UpdateBooking {
  const _$UpdateBookingImpl(this.booking,
      {this.shouldRefresh = false, this.isDeleted = false});

  @override
  final DesktopBookingItemModel? booking;
  @override
  @JsonKey()
  final bool shouldRefresh;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'AllBookingEvent.updateBooking(booking: $booking, shouldRefresh: $shouldRefresh, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateBookingImpl &&
            (identical(other.booking, booking) || other.booking == booking) &&
            (identical(other.shouldRefresh, shouldRefresh) ||
                other.shouldRefresh == shouldRefresh) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, booking, shouldRefresh, isDeleted);

  /// Create a copy of AllBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBookingImplCopyWith<_$UpdateBookingImpl> get copyWith =>
      __$$UpdateBookingImplCopyWithImpl<_$UpdateBookingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? status, String? startDate,
            String? endDate, String? searchQuery)
        loadBookings,
    required TResult Function() loadNextPageBookings,
    required TResult Function(DesktopBookingItemModel? booking,
            bool shouldRefresh, bool isDeleted)
        updateBooking,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
  }) {
    return updateBooking(booking, shouldRefresh, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? status, String? startDate, String? endDate,
            String? searchQuery)?
        loadBookings,
    TResult? Function()? loadNextPageBookings,
    TResult? Function(DesktopBookingItemModel? booking, bool shouldRefresh,
            bool isDeleted)?
        updateBooking,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
  }) {
    return updateBooking?.call(booking, shouldRefresh, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? status, String? startDate, String? endDate,
            String? searchQuery)?
        loadBookings,
    TResult Function()? loadNextPageBookings,
    TResult Function(DesktopBookingItemModel? booking, bool shouldRefresh,
            bool isDeleted)?
        updateBooking,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
    required TResult orElse(),
  }) {
    if (updateBooking != null) {
      return updateBooking(booking, shouldRefresh, isDeleted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextPageBookings value) loadNextPageBookings,
    required TResult Function(_UpdateBooking value) updateBooking,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
  }) {
    return updateBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
  }) {
    return updateBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    required TResult orElse(),
  }) {
    if (updateBooking != null) {
      return updateBooking(this);
    }
    return orElse();
  }
}

abstract class _UpdateBooking implements AllBookingEvent {
  const factory _UpdateBooking(final DesktopBookingItemModel? booking,
      {final bool shouldRefresh, final bool isDeleted}) = _$UpdateBookingImpl;

  DesktopBookingItemModel? get booking;
  bool get shouldRefresh;
  bool get isDeleted;

  /// Create a copy of AllBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateBookingImplCopyWith<_$UpdateBookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateDeliveryStatusImplCopyWith<$Res> {
  factory _$$UpdateDeliveryStatusImplCopyWith(_$UpdateDeliveryStatusImpl value,
          $Res Function(_$UpdateDeliveryStatusImpl) then) =
      __$$UpdateDeliveryStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int bookingId, DeliveryStatus deliveryStatus});
}

/// @nodoc
class __$$UpdateDeliveryStatusImplCopyWithImpl<$Res>
    extends _$AllBookingEventCopyWithImpl<$Res, _$UpdateDeliveryStatusImpl>
    implements _$$UpdateDeliveryStatusImplCopyWith<$Res> {
  __$$UpdateDeliveryStatusImplCopyWithImpl(_$UpdateDeliveryStatusImpl _value,
      $Res Function(_$UpdateDeliveryStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingEvent
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
    return 'AllBookingEvent.updateDeliveryStatus(bookingId: $bookingId, deliveryStatus: $deliveryStatus)';
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

  /// Create a copy of AllBookingEvent
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
    required TResult Function(String? status, String? startDate,
            String? endDate, String? searchQuery)
        loadBookings,
    required TResult Function() loadNextPageBookings,
    required TResult Function(DesktopBookingItemModel? booking,
            bool shouldRefresh, bool isDeleted)
        updateBooking,
    required TResult Function(int bookingId, DeliveryStatus deliveryStatus)
        updateDeliveryStatus,
  }) {
    return updateDeliveryStatus(bookingId, deliveryStatus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? status, String? startDate, String? endDate,
            String? searchQuery)?
        loadBookings,
    TResult? Function()? loadNextPageBookings,
    TResult? Function(DesktopBookingItemModel? booking, bool shouldRefresh,
            bool isDeleted)?
        updateBooking,
    TResult? Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
  }) {
    return updateDeliveryStatus?.call(bookingId, deliveryStatus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? status, String? startDate, String? endDate,
            String? searchQuery)?
        loadBookings,
    TResult Function()? loadNextPageBookings,
    TResult Function(DesktopBookingItemModel? booking, bool shouldRefresh,
            bool isDeleted)?
        updateBooking,
    TResult Function(int bookingId, DeliveryStatus deliveryStatus)?
        updateDeliveryStatus,
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
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextPageBookings value) loadNextPageBookings,
    required TResult Function(_UpdateBooking value) updateBooking,
    required TResult Function(_UpdateDeliveryStatus value) updateDeliveryStatus,
  }) {
    return updateDeliveryStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
    TResult? Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
  }) {
    return updateDeliveryStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    TResult Function(_UpdateDeliveryStatus value)? updateDeliveryStatus,
    required TResult orElse(),
  }) {
    if (updateDeliveryStatus != null) {
      return updateDeliveryStatus(this);
    }
    return orElse();
  }
}

abstract class _UpdateDeliveryStatus implements AllBookingEvent {
  const factory _UpdateDeliveryStatus(
          {required final int bookingId,
          required final DeliveryStatus deliveryStatus}) =
      _$UpdateDeliveryStatusImpl;

  int get bookingId;
  DeliveryStatus get deliveryStatus;

  /// Create a copy of AllBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDeliveryStatusImplCopyWith<_$UpdateDeliveryStatusImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AllBookingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllBookingStateCopyWith<$Res> {
  factory $AllBookingStateCopyWith(
          AllBookingState value, $Res Function(AllBookingState) then) =
      _$AllBookingStateCopyWithImpl<$Res, AllBookingState>;
}

/// @nodoc
class _$AllBookingStateCopyWithImpl<$Res, $Val extends AllBookingState>
    implements $AllBookingStateCopyWith<$Res> {
  _$AllBookingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllBookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AllBookingStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AllBookingState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)
        loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AllBookingState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AllBookingStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AllBookingState.loading()';
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
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)?
        loaded,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AllBookingState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<DesktopBookingItemModel> bookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
      String? status,
      StatusCountsModel? statusCounts});

  $StatusCountsModelCopyWith<$Res>? get statusCounts;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$AllBookingStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookings = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? searchQuery = freezed,
    Object? status = freezed,
    Object? statusCounts = freezed,
  }) {
    return _then(_$LoadedImpl(
      bookings: null == bookings
          ? _value._bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<DesktopBookingItemModel>,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isPaginating: null == isPaginating
          ? _value.isPaginating
          : isPaginating // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      statusCounts: freezed == statusCounts
          ? _value.statusCounts
          : statusCounts // ignore: cast_nullable_to_non_nullable
              as StatusCountsModel?,
    ));
  }

  /// Create a copy of AllBookingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatusCountsModelCopyWith<$Res>? get statusCounts {
    if (_value.statusCounts == null) {
      return null;
    }

    return $StatusCountsModelCopyWith<$Res>(_value.statusCounts!, (value) {
      return _then(_value.copyWith(statusCounts: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<DesktopBookingItemModel> bookings,
      this.nextPageUrl,
      this.isPaginating = false,
      this.startDate,
      this.endDate,
      this.searchQuery,
      this.status,
      this.statusCounts})
      : _bookings = bookings;

  final List<DesktopBookingItemModel> _bookings;
  @override
  List<DesktopBookingItemModel> get bookings {
    if (_bookings is EqualUnmodifiableListView) return _bookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookings);
  }

  @override
  final String? nextPageUrl;
  @override
  @JsonKey()
  final bool isPaginating;
  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final String? searchQuery;
  @override
  final String? status;
  @override
  final StatusCountsModel? statusCounts;

  @override
  String toString() {
    return 'AllBookingState.loaded(bookings: $bookings, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, startDate: $startDate, endDate: $endDate, searchQuery: $searchQuery, status: $status, statusCounts: $statusCounts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._bookings, _bookings) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.isPaginating, isPaginating) ||
                other.isPaginating == isPaginating) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusCounts, statusCounts) ||
                other.statusCounts == statusCounts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_bookings),
      nextPageUrl,
      isPaginating,
      startDate,
      endDate,
      searchQuery,
      status,
      statusCounts);

  /// Create a copy of AllBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(bookings, nextPageUrl, isPaginating, startDate, endDate,
        searchQuery, status, statusCounts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(bookings, nextPageUrl, isPaginating, startDate, endDate,
        searchQuery, status, statusCounts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(bookings, nextPageUrl, isPaginating, startDate, endDate,
          searchQuery, status, statusCounts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements AllBookingState {
  const factory _Loaded(
      {required final List<DesktopBookingItemModel> bookings,
      final String? nextPageUrl,
      final bool isPaginating,
      final String? startDate,
      final String? endDate,
      final String? searchQuery,
      final String? status,
      final StatusCountsModel? statusCounts}) = _$LoadedImpl;

  List<DesktopBookingItemModel> get bookings;
  String? get nextPageUrl;
  bool get isPaginating;
  String? get startDate;
  String? get endDate;
  String? get searchQuery;
  String? get status;
  StatusCountsModel? get statusCounts;

  /// Create a copy of AllBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
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
    extends _$AllBookingStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingState
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
    return 'AllBookingState.error(error: $error)';
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

  /// Create a copy of AllBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<DesktopBookingItemModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery,
            String? status,
            StatusCountsModel? statusCounts)?
        loaded,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AllBookingState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of AllBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
