// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'completed_bookings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CompletedBookingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String? startDate,
      String? endDate,
      String? searchQuery,
    )
    loadCompletedBookings,
    required TResult Function() loadNextPageCompletedBookings,
    required TResult Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )
    updateBooking,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? startDate, String? endDate, String? searchQuery)?
    loadCompletedBookings,
    TResult? Function()? loadNextPageCompletedBookings,
    TResult? Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )?
    updateBooking,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? startDate, String? endDate, String? searchQuery)?
    loadCompletedBookings,
    TResult Function()? loadNextPageCompletedBookings,
    TResult Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )?
    updateBooking,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCompletedBookings value)
    loadCompletedBookings,
    required TResult Function(_LoadNextPageCompletedBookings value)
    loadNextPageCompletedBookings,
    required TResult Function(_UpdateBooking value) updateBooking,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCompletedBookings value)? loadCompletedBookings,
    TResult? Function(_LoadNextPageCompletedBookings value)?
    loadNextPageCompletedBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCompletedBookings value)? loadCompletedBookings,
    TResult Function(_LoadNextPageCompletedBookings value)?
    loadNextPageCompletedBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompletedBookingsEventCopyWith<$Res> {
  factory $CompletedBookingsEventCopyWith(
    CompletedBookingsEvent value,
    $Res Function(CompletedBookingsEvent) then,
  ) = _$CompletedBookingsEventCopyWithImpl<$Res, CompletedBookingsEvent>;
}

/// @nodoc
class _$CompletedBookingsEventCopyWithImpl<
  $Res,
  $Val extends CompletedBookingsEvent
>
    implements $CompletedBookingsEventCopyWith<$Res> {
  _$CompletedBookingsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompletedBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadCompletedBookingsImplCopyWith<$Res> {
  factory _$$LoadCompletedBookingsImplCopyWith(
    _$LoadCompletedBookingsImpl value,
    $Res Function(_$LoadCompletedBookingsImpl) then,
  ) = __$$LoadCompletedBookingsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? startDate, String? endDate, String? searchQuery});
}

/// @nodoc
class __$$LoadCompletedBookingsImplCopyWithImpl<$Res>
    extends
        _$CompletedBookingsEventCopyWithImpl<$Res, _$LoadCompletedBookingsImpl>
    implements _$$LoadCompletedBookingsImplCopyWith<$Res> {
  __$$LoadCompletedBookingsImplCopyWithImpl(
    _$LoadCompletedBookingsImpl _value,
    $Res Function(_$LoadCompletedBookingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompletedBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(
      _$LoadCompletedBookingsImpl(
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
      ),
    );
  }
}

/// @nodoc

class _$LoadCompletedBookingsImpl implements _LoadCompletedBookings {
  const _$LoadCompletedBookingsImpl({
    this.startDate,
    this.endDate,
    this.searchQuery,
  });

  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final String? searchQuery;

  @override
  String toString() {
    return 'CompletedBookingsEvent.loadCompletedBookings(startDate: $startDate, endDate: $endDate, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadCompletedBookingsImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate, searchQuery);

  /// Create a copy of CompletedBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadCompletedBookingsImplCopyWith<_$LoadCompletedBookingsImpl>
  get copyWith =>
      __$$LoadCompletedBookingsImplCopyWithImpl<_$LoadCompletedBookingsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String? startDate,
      String? endDate,
      String? searchQuery,
    )
    loadCompletedBookings,
    required TResult Function() loadNextPageCompletedBookings,
    required TResult Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )
    updateBooking,
  }) {
    return loadCompletedBookings(startDate, endDate, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? startDate, String? endDate, String? searchQuery)?
    loadCompletedBookings,
    TResult? Function()? loadNextPageCompletedBookings,
    TResult? Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )?
    updateBooking,
  }) {
    return loadCompletedBookings?.call(startDate, endDate, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? startDate, String? endDate, String? searchQuery)?
    loadCompletedBookings,
    TResult Function()? loadNextPageCompletedBookings,
    TResult Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )?
    updateBooking,
    required TResult orElse(),
  }) {
    if (loadCompletedBookings != null) {
      return loadCompletedBookings(startDate, endDate, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCompletedBookings value)
    loadCompletedBookings,
    required TResult Function(_LoadNextPageCompletedBookings value)
    loadNextPageCompletedBookings,
    required TResult Function(_UpdateBooking value) updateBooking,
  }) {
    return loadCompletedBookings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCompletedBookings value)? loadCompletedBookings,
    TResult? Function(_LoadNextPageCompletedBookings value)?
    loadNextPageCompletedBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
  }) {
    return loadCompletedBookings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCompletedBookings value)? loadCompletedBookings,
    TResult Function(_LoadNextPageCompletedBookings value)?
    loadNextPageCompletedBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    required TResult orElse(),
  }) {
    if (loadCompletedBookings != null) {
      return loadCompletedBookings(this);
    }
    return orElse();
  }
}

abstract class _LoadCompletedBookings implements CompletedBookingsEvent {
  const factory _LoadCompletedBookings({
    final String? startDate,
    final String? endDate,
    final String? searchQuery,
  }) = _$LoadCompletedBookingsImpl;

  String? get startDate;
  String? get endDate;
  String? get searchQuery;

  /// Create a copy of CompletedBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadCompletedBookingsImplCopyWith<_$LoadCompletedBookingsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPageCompletedBookingsImplCopyWith<$Res> {
  factory _$$LoadNextPageCompletedBookingsImplCopyWith(
    _$LoadNextPageCompletedBookingsImpl value,
    $Res Function(_$LoadNextPageCompletedBookingsImpl) then,
  ) = __$$LoadNextPageCompletedBookingsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPageCompletedBookingsImplCopyWithImpl<$Res>
    extends
        _$CompletedBookingsEventCopyWithImpl<
          $Res,
          _$LoadNextPageCompletedBookingsImpl
        >
    implements _$$LoadNextPageCompletedBookingsImplCopyWith<$Res> {
  __$$LoadNextPageCompletedBookingsImplCopyWithImpl(
    _$LoadNextPageCompletedBookingsImpl _value,
    $Res Function(_$LoadNextPageCompletedBookingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompletedBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageCompletedBookingsImpl
    implements _LoadNextPageCompletedBookings {
  const _$LoadNextPageCompletedBookingsImpl();

  @override
  String toString() {
    return 'CompletedBookingsEvent.loadNextPageCompletedBookings()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextPageCompletedBookingsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String? startDate,
      String? endDate,
      String? searchQuery,
    )
    loadCompletedBookings,
    required TResult Function() loadNextPageCompletedBookings,
    required TResult Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )
    updateBooking,
  }) {
    return loadNextPageCompletedBookings();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? startDate, String? endDate, String? searchQuery)?
    loadCompletedBookings,
    TResult? Function()? loadNextPageCompletedBookings,
    TResult? Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )?
    updateBooking,
  }) {
    return loadNextPageCompletedBookings?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? startDate, String? endDate, String? searchQuery)?
    loadCompletedBookings,
    TResult Function()? loadNextPageCompletedBookings,
    TResult Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )?
    updateBooking,
    required TResult orElse(),
  }) {
    if (loadNextPageCompletedBookings != null) {
      return loadNextPageCompletedBookings();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadCompletedBookings value)
    loadCompletedBookings,
    required TResult Function(_LoadNextPageCompletedBookings value)
    loadNextPageCompletedBookings,
    required TResult Function(_UpdateBooking value) updateBooking,
  }) {
    return loadNextPageCompletedBookings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCompletedBookings value)? loadCompletedBookings,
    TResult? Function(_LoadNextPageCompletedBookings value)?
    loadNextPageCompletedBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
  }) {
    return loadNextPageCompletedBookings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCompletedBookings value)? loadCompletedBookings,
    TResult Function(_LoadNextPageCompletedBookings value)?
    loadNextPageCompletedBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    required TResult orElse(),
  }) {
    if (loadNextPageCompletedBookings != null) {
      return loadNextPageCompletedBookings(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageCompletedBookings
    implements CompletedBookingsEvent {
  const factory _LoadNextPageCompletedBookings() =
      _$LoadNextPageCompletedBookingsImpl;
}

/// @nodoc
abstract class _$$UpdateBookingImplCopyWith<$Res> {
  factory _$$UpdateBookingImplCopyWith(
    _$UpdateBookingImpl value,
    $Res Function(_$UpdateBookingImpl) then,
  ) = __$$UpdateBookingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BookingsModel? booking, bool shouldRefresh, bool isDeleted});

  $BookingsModelCopyWith<$Res>? get booking;
}

/// @nodoc
class __$$UpdateBookingImplCopyWithImpl<$Res>
    extends _$CompletedBookingsEventCopyWithImpl<$Res, _$UpdateBookingImpl>
    implements _$$UpdateBookingImplCopyWith<$Res> {
  __$$UpdateBookingImplCopyWithImpl(
    _$UpdateBookingImpl _value,
    $Res Function(_$UpdateBookingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompletedBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? booking = freezed,
    Object? shouldRefresh = null,
    Object? isDeleted = null,
  }) {
    return _then(
      _$UpdateBookingImpl(
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
      ),
    );
  }

  /// Create a copy of CompletedBookingsEvent
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
  const _$UpdateBookingImpl(
    this.booking, {
    this.shouldRefresh = false,
    this.isDeleted = false,
  });

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
    return 'CompletedBookingsEvent.updateBooking(booking: $booking, shouldRefresh: $shouldRefresh, isDeleted: $isDeleted)';
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

  /// Create a copy of CompletedBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBookingImplCopyWith<_$UpdateBookingImpl> get copyWith =>
      __$$UpdateBookingImplCopyWithImpl<_$UpdateBookingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String? startDate,
      String? endDate,
      String? searchQuery,
    )
    loadCompletedBookings,
    required TResult Function() loadNextPageCompletedBookings,
    required TResult Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )
    updateBooking,
  }) {
    return updateBooking(booking, shouldRefresh, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? startDate, String? endDate, String? searchQuery)?
    loadCompletedBookings,
    TResult? Function()? loadNextPageCompletedBookings,
    TResult? Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )?
    updateBooking,
  }) {
    return updateBooking?.call(booking, shouldRefresh, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? startDate, String? endDate, String? searchQuery)?
    loadCompletedBookings,
    TResult Function()? loadNextPageCompletedBookings,
    TResult Function(
      BookingsModel? booking,
      bool shouldRefresh,
      bool isDeleted,
    )?
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
    required TResult Function(_LoadCompletedBookings value)
    loadCompletedBookings,
    required TResult Function(_LoadNextPageCompletedBookings value)
    loadNextPageCompletedBookings,
    required TResult Function(_UpdateBooking value) updateBooking,
  }) {
    return updateBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadCompletedBookings value)? loadCompletedBookings,
    TResult? Function(_LoadNextPageCompletedBookings value)?
    loadNextPageCompletedBookings,
    TResult? Function(_UpdateBooking value)? updateBooking,
  }) {
    return updateBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadCompletedBookings value)? loadCompletedBookings,
    TResult Function(_LoadNextPageCompletedBookings value)?
    loadNextPageCompletedBookings,
    TResult Function(_UpdateBooking value)? updateBooking,
    required TResult orElse(),
  }) {
    if (updateBooking != null) {
      return updateBooking(this);
    }
    return orElse();
  }
}

abstract class _UpdateBooking implements CompletedBookingsEvent {
  const factory _UpdateBooking(
    final BookingsModel? booking, {
    final bool shouldRefresh,
    final bool isDeleted,
  }) = _$UpdateBookingImpl;

  BookingsModel? get booking;
  bool get shouldRefresh;
  bool get isDeleted;

  /// Create a copy of CompletedBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateBookingImplCopyWith<_$UpdateBookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CompletedBookingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )
    loaded,
    required TResult Function(String error) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )?
    loaded,
    TResult? Function(String error)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )?
    loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompletedBookingsStateCopyWith<$Res> {
  factory $CompletedBookingsStateCopyWith(
    CompletedBookingsState value,
    $Res Function(CompletedBookingsState) then,
  ) = _$CompletedBookingsStateCopyWithImpl<$Res, CompletedBookingsState>;
}

/// @nodoc
class _$CompletedBookingsStateCopyWithImpl<
  $Res,
  $Val extends CompletedBookingsState
>
    implements $CompletedBookingsStateCopyWith<$Res> {
  _$CompletedBookingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompletedBookingsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CompletedBookingsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompletedBookingsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CompletedBookingsState.initial()';
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
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )
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
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )?
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
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )?
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

abstract class _Initial implements CompletedBookingsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$CompletedBookingsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompletedBookingsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'CompletedBookingsState.loading()';
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
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )
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
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )?
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
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )?
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

abstract class _Loading implements CompletedBookingsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<BookingsModel> completedBookings,
    String? nextPageUrl,
    bool isPaginating,
    String? startDate,
    String? endDate,
    String? searchQuery,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$CompletedBookingsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompletedBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completedBookings = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(
      _$LoadedImpl(
        completedBookings: null == completedBookings
            ? _value._completedBookings
            : completedBookings // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({
    required final List<BookingsModel> completedBookings,
    required this.nextPageUrl,
    this.isPaginating = false,
    this.startDate,
    this.endDate,
    this.searchQuery,
  }) : _completedBookings = completedBookings;

  final List<BookingsModel> _completedBookings;
  @override
  List<BookingsModel> get completedBookings {
    if (_completedBookings is EqualUnmodifiableListView)
      return _completedBookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedBookings);
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
    return 'CompletedBookingsState.loaded(completedBookings: $completedBookings, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, startDate: $startDate, endDate: $endDate, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(
              other._completedBookings,
              _completedBookings,
            ) &&
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
    const DeepCollectionEquality().hash(_completedBookings),
    nextPageUrl,
    isPaginating,
    startDate,
    endDate,
    searchQuery,
  );

  /// Create a copy of CompletedBookingsState
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
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )
    loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(
      completedBookings,
      nextPageUrl,
      isPaginating,
      startDate,
      endDate,
      searchQuery,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )?
    loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(
      completedBookings,
      nextPageUrl,
      isPaginating,
      startDate,
      endDate,
      searchQuery,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )?
    loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        completedBookings,
        nextPageUrl,
        isPaginating,
        startDate,
        endDate,
        searchQuery,
      );
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

abstract class _Loaded implements CompletedBookingsState {
  const factory _Loaded({
    required final List<BookingsModel> completedBookings,
    required final String? nextPageUrl,
    final bool isPaginating,
    final String? startDate,
    final String? endDate,
    final String? searchQuery,
  }) = _$LoadedImpl;

  List<BookingsModel> get completedBookings;
  String? get nextPageUrl;
  bool get isPaginating;
  String? get startDate;
  String? get endDate;
  String? get searchQuery;

  /// Create a copy of CompletedBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$CompletedBookingsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompletedBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$ErrorImpl(
        null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'CompletedBookingsState.error(error: $error)';
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

  /// Create a copy of CompletedBookingsState
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
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )
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
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )?
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
      List<BookingsModel> completedBookings,
      String? nextPageUrl,
      bool isPaginating,
      String? startDate,
      String? endDate,
      String? searchQuery,
    )?
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

abstract class _Error implements CompletedBookingsState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of CompletedBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
