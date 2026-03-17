// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_booking_past_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllBookingPastEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? startDate, String? endDate,
            String? searchQuery, bool shouldRefresh)
        loadBookings,
    required TResult Function() loadNextPageBookings,
    required TResult Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)
        updateBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? startDate, String? endDate, String? searchQuery,
            bool shouldRefresh)?
        loadBookings,
    TResult? Function()? loadNextPageBookings,
    TResult? Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)?
        updateBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? startDate, String? endDate, String? searchQuery,
            bool shouldRefresh)?
        loadBookings,
    TResult Function()? loadNextPageBookings,
    TResult Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)?
        updateBooking,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextPageBookings value) loadNextPageBookings,
    required TResult Function(_UpdateBooking value) updateBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllBookingPastEventCopyWith<$Res> {
  factory $AllBookingPastEventCopyWith(
          AllBookingPastEvent value, $Res Function(AllBookingPastEvent) then) =
      _$AllBookingPastEventCopyWithImpl<$Res, AllBookingPastEvent>;
}

/// @nodoc
class _$AllBookingPastEventCopyWithImpl<$Res, $Val extends AllBookingPastEvent>
    implements $AllBookingPastEventCopyWith<$Res> {
  _$AllBookingPastEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllBookingPastEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadBookingsImplCopyWith<$Res> {
  factory _$$LoadBookingsImplCopyWith(
          _$LoadBookingsImpl value, $Res Function(_$LoadBookingsImpl) then) =
      __$$LoadBookingsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? startDate,
      String? endDate,
      String? searchQuery,
      bool shouldRefresh});
}

/// @nodoc
class __$$LoadBookingsImplCopyWithImpl<$Res>
    extends _$AllBookingPastEventCopyWithImpl<$Res, _$LoadBookingsImpl>
    implements _$$LoadBookingsImplCopyWith<$Res> {
  __$$LoadBookingsImplCopyWithImpl(
      _$LoadBookingsImpl _value, $Res Function(_$LoadBookingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingPastEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? searchQuery = freezed,
    Object? shouldRefresh = null,
  }) {
    return _then(_$LoadBookingsImpl(
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
      shouldRefresh: null == shouldRefresh
          ? _value.shouldRefresh
          : shouldRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadBookingsImpl implements _LoadBookings {
  const _$LoadBookingsImpl(
      {this.startDate,
      this.endDate,
      this.searchQuery,
      this.shouldRefresh = true});

  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final String? searchQuery;
  @override
  @JsonKey()
  final bool shouldRefresh;

  @override
  String toString() {
    return 'AllBookingPastEvent.loadBookings(startDate: $startDate, endDate: $endDate, searchQuery: $searchQuery, shouldRefresh: $shouldRefresh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadBookingsImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.shouldRefresh, shouldRefresh) ||
                other.shouldRefresh == shouldRefresh));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, startDate, endDate, searchQuery, shouldRefresh);

  /// Create a copy of AllBookingPastEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadBookingsImplCopyWith<_$LoadBookingsImpl> get copyWith =>
      __$$LoadBookingsImplCopyWithImpl<_$LoadBookingsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? startDate, String? endDate,
            String? searchQuery, bool shouldRefresh)
        loadBookings,
    required TResult Function() loadNextPageBookings,
    required TResult Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)
        updateBooking,
  }) {
    return loadBookings(startDate, endDate, searchQuery, shouldRefresh);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? startDate, String? endDate, String? searchQuery,
            bool shouldRefresh)?
        loadBookings,
    TResult? Function()? loadNextPageBookings,
    TResult? Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)?
        updateBooking,
  }) {
    return loadBookings?.call(startDate, endDate, searchQuery, shouldRefresh);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? startDate, String? endDate, String? searchQuery,
            bool shouldRefresh)?
        loadBookings,
    TResult Function()? loadNextPageBookings,
    TResult Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)?
        updateBooking,
    required TResult orElse(),
  }) {
    if (loadBookings != null) {
      return loadBookings(startDate, endDate, searchQuery, shouldRefresh);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextPageBookings value) loadNextPageBookings,
    required TResult Function(_UpdateBooking value) updateBooking,
  }) {
    return loadBookings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
  }) {
    return loadBookings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    required TResult orElse(),
  }) {
    if (loadBookings != null) {
      return loadBookings(this);
    }
    return orElse();
  }
}

abstract class _LoadBookings implements AllBookingPastEvent {
  const factory _LoadBookings(
      {final String? startDate,
      final String? endDate,
      final String? searchQuery,
      final bool shouldRefresh}) = _$LoadBookingsImpl;

  String? get startDate;
  String? get endDate;
  String? get searchQuery;
  bool get shouldRefresh;

  /// Create a copy of AllBookingPastEvent
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
    extends _$AllBookingPastEventCopyWithImpl<$Res, _$LoadNextPageBookingsImpl>
    implements _$$LoadNextPageBookingsImplCopyWith<$Res> {
  __$$LoadNextPageBookingsImplCopyWithImpl(_$LoadNextPageBookingsImpl _value,
      $Res Function(_$LoadNextPageBookingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingPastEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageBookingsImpl implements _LoadNextPageBookings {
  const _$LoadNextPageBookingsImpl();

  @override
  String toString() {
    return 'AllBookingPastEvent.loadNextPageBookings()';
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
    required TResult Function(String? startDate, String? endDate,
            String? searchQuery, bool shouldRefresh)
        loadBookings,
    required TResult Function() loadNextPageBookings,
    required TResult Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)
        updateBooking,
  }) {
    return loadNextPageBookings();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? startDate, String? endDate, String? searchQuery,
            bool shouldRefresh)?
        loadBookings,
    TResult? Function()? loadNextPageBookings,
    TResult? Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)?
        updateBooking,
  }) {
    return loadNextPageBookings?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? startDate, String? endDate, String? searchQuery,
            bool shouldRefresh)?
        loadBookings,
    TResult Function()? loadNextPageBookings,
    TResult Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)?
        updateBooking,
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
  }) {
    return loadNextPageBookings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
  }) {
    return loadNextPageBookings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    required TResult orElse(),
  }) {
    if (loadNextPageBookings != null) {
      return loadNextPageBookings(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageBookings implements AllBookingPastEvent {
  const factory _LoadNextPageBookings() = _$LoadNextPageBookingsImpl;
}

/// @nodoc
abstract class _$$UpdateBookingImplCopyWith<$Res> {
  factory _$$UpdateBookingImplCopyWith(
          _$UpdateBookingImpl value, $Res Function(_$UpdateBookingImpl) then) =
      __$$UpdateBookingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BookingsModel? booking, bool shouldRefresh, bool isDeleted});

  $BookingsModelCopyWith<$Res>? get booking;
}

/// @nodoc
class __$$UpdateBookingImplCopyWithImpl<$Res>
    extends _$AllBookingPastEventCopyWithImpl<$Res, _$UpdateBookingImpl>
    implements _$$UpdateBookingImplCopyWith<$Res> {
  __$$UpdateBookingImplCopyWithImpl(
      _$UpdateBookingImpl _value, $Res Function(_$UpdateBookingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingPastEvent
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
              as BookingsModel?,
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

  /// Create a copy of AllBookingPastEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookingsModelCopyWith<$Res>? get booking {
    if (_value.booking == null) {
      return null;
    }

    return $BookingsModelCopyWith<$Res>(_value.booking!, (value) {
      return _then(_value.copyWith(booking: value));
    });
  }
}

/// @nodoc

class _$UpdateBookingImpl implements _UpdateBooking {
  const _$UpdateBookingImpl(this.booking,
      {this.shouldRefresh = false, this.isDeleted = false});

  @override
  final BookingsModel? booking;
  @override
  @JsonKey()
  final bool shouldRefresh;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'AllBookingPastEvent.updateBooking(booking: $booking, shouldRefresh: $shouldRefresh, isDeleted: $isDeleted)';
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

  /// Create a copy of AllBookingPastEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBookingImplCopyWith<_$UpdateBookingImpl> get copyWith =>
      __$$UpdateBookingImplCopyWithImpl<_$UpdateBookingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? startDate, String? endDate,
            String? searchQuery, bool shouldRefresh)
        loadBookings,
    required TResult Function() loadNextPageBookings,
    required TResult Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)
        updateBooking,
  }) {
    return updateBooking(booking, shouldRefresh, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? startDate, String? endDate, String? searchQuery,
            bool shouldRefresh)?
        loadBookings,
    TResult? Function()? loadNextPageBookings,
    TResult? Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)?
        updateBooking,
  }) {
    return updateBooking?.call(booking, shouldRefresh, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? startDate, String? endDate, String? searchQuery,
            bool shouldRefresh)?
        loadBookings,
    TResult Function()? loadNextPageBookings,
    TResult Function(
            BookingsModel? booking, bool shouldRefresh, bool isDeleted)?
        updateBooking,
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
  }) {
    return updateBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
  }) {
    return updateBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    required TResult orElse(),
  }) {
    if (updateBooking != null) {
      return updateBooking(this);
    }
    return orElse();
  }
}

abstract class _UpdateBooking implements AllBookingPastEvent {
  const factory _UpdateBooking(final BookingsModel? booking,
      {final bool shouldRefresh, final bool isDeleted}) = _$UpdateBookingImpl;

  BookingsModel? get booking;
  bool get shouldRefresh;
  bool get isDeleted;

  /// Create a copy of AllBookingPastEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateBookingImplCopyWith<_$UpdateBookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AllBookingPastState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllBookingPastStateCopyWith<$Res> {
  factory $AllBookingPastStateCopyWith(
          AllBookingPastState value, $Res Function(AllBookingPastState) then) =
      _$AllBookingPastStateCopyWithImpl<$Res, AllBookingPastState>;
}

/// @nodoc
class _$AllBookingPastStateCopyWithImpl<$Res, $Val extends AllBookingPastState>
    implements $AllBookingPastStateCopyWith<$Res> {
  _$AllBookingPastStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllBookingPastState
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
    extends _$AllBookingPastStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingPastState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AllBookingPastState.loading()';
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
    required TResult Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)?
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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

abstract class _Loading implements AllBookingPastState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<BookingsModel> bookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$AllBookingPastStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingPastState
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
  }) {
    return _then(_$LoadedImpl(
      bookings: null == bookings
          ? _value._bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<BookingsModel>,
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
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<BookingsModel> bookings,
      this.nextPageUrl,
      this.isPaginating = false,
      this.startDate,
      this.endDate,
      this.searchQuery})
      : _bookings = bookings;

  final List<BookingsModel> _bookings;
  @override
  List<BookingsModel> get bookings {
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
  String toString() {
    return 'AllBookingPastState.loaded(bookings: $bookings, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, startDate: $startDate, endDate: $endDate, searchQuery: $searchQuery)';
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
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_bookings),
      nextPageUrl,
      isPaginating,
      startDate,
      endDate,
      searchQuery);

  /// Create a copy of AllBookingPastState
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
    required TResult Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(
        bookings, nextPageUrl, isPaginating, startDate, endDate, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(
        bookings, nextPageUrl, isPaginating, startDate, endDate, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
          bookings, nextPageUrl, isPaginating, startDate, endDate, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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

abstract class _Loaded implements AllBookingPastState {
  const factory _Loaded(
      {required final List<BookingsModel> bookings,
      final String? nextPageUrl,
      final bool isPaginating,
      final String? startDate,
      final String? endDate,
      final String? searchQuery}) = _$LoadedImpl;

  List<BookingsModel> get bookings;
  String? get nextPageUrl;
  bool get isPaginating;
  String? get startDate;
  String? get endDate;
  String? get searchQuery;

  /// Create a copy of AllBookingPastState
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
    extends _$AllBookingPastStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllBookingPastState
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
    return 'AllBookingPastState.error(error: $error)';
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

  /// Create a copy of AllBookingPastState
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
    required TResult Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<BookingsModel> bookings,
            String? nextPageUrl,
            bool isPaginating,
            String? startDate,
            String? endDate,
            String? searchQuery)?
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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

abstract class _Error implements AllBookingPastState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of AllBookingPastState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
