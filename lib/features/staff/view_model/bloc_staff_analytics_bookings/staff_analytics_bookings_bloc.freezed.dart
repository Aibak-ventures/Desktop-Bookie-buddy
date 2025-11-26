// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_analytics_bookings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StaffAnalyticsBookingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int staffId, int month, int year) loadBookings,
    required TResult Function() loadNextPageBookings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int staffId, int month, int year)? loadBookings,
    TResult? Function()? loadNextPageBookings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int staffId, int month, int year)? loadBookings,
    TResult Function()? loadNextPageBookings,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextPageBookings value) loadNextPageBookings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffAnalyticsBookingsEventCopyWith<$Res> {
  factory $StaffAnalyticsBookingsEventCopyWith(
          StaffAnalyticsBookingsEvent value,
          $Res Function(StaffAnalyticsBookingsEvent) then) =
      _$StaffAnalyticsBookingsEventCopyWithImpl<$Res,
          StaffAnalyticsBookingsEvent>;
}

/// @nodoc
class _$StaffAnalyticsBookingsEventCopyWithImpl<$Res,
        $Val extends StaffAnalyticsBookingsEvent>
    implements $StaffAnalyticsBookingsEventCopyWith<$Res> {
  _$StaffAnalyticsBookingsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffAnalyticsBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadBookingsImplCopyWith<$Res> {
  factory _$$LoadBookingsImplCopyWith(
          _$LoadBookingsImpl value, $Res Function(_$LoadBookingsImpl) then) =
      __$$LoadBookingsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int staffId, int month, int year});
}

/// @nodoc
class __$$LoadBookingsImplCopyWithImpl<$Res>
    extends _$StaffAnalyticsBookingsEventCopyWithImpl<$Res, _$LoadBookingsImpl>
    implements _$$LoadBookingsImplCopyWith<$Res> {
  __$$LoadBookingsImplCopyWithImpl(
      _$LoadBookingsImpl _value, $Res Function(_$LoadBookingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffAnalyticsBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffId = null,
    Object? month = null,
    Object? year = null,
  }) {
    return _then(_$LoadBookingsImpl(
      staffId: null == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadBookingsImpl implements _LoadBookings {
  const _$LoadBookingsImpl(
      {required this.staffId, required this.month, required this.year});

  @override
  final int staffId;
  @override
  final int month;
  @override
  final int year;

  @override
  String toString() {
    return 'StaffAnalyticsBookingsEvent.loadBookings(staffId: $staffId, month: $month, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadBookingsImpl &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year));
  }

  @override
  int get hashCode => Object.hash(runtimeType, staffId, month, year);

  /// Create a copy of StaffAnalyticsBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadBookingsImplCopyWith<_$LoadBookingsImpl> get copyWith =>
      __$$LoadBookingsImplCopyWithImpl<_$LoadBookingsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int staffId, int month, int year) loadBookings,
    required TResult Function() loadNextPageBookings,
  }) {
    return loadBookings(staffId, month, year);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int staffId, int month, int year)? loadBookings,
    TResult? Function()? loadNextPageBookings,
  }) {
    return loadBookings?.call(staffId, month, year);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int staffId, int month, int year)? loadBookings,
    TResult Function()? loadNextPageBookings,
    required TResult orElse(),
  }) {
    if (loadBookings != null) {
      return loadBookings(staffId, month, year);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextPageBookings value) loadNextPageBookings,
  }) {
    return loadBookings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
  }) {
    return loadBookings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    required TResult orElse(),
  }) {
    if (loadBookings != null) {
      return loadBookings(this);
    }
    return orElse();
  }
}

abstract class _LoadBookings implements StaffAnalyticsBookingsEvent {
  const factory _LoadBookings(
      {required final int staffId,
      required final int month,
      required final int year}) = _$LoadBookingsImpl;

  int get staffId;
  int get month;
  int get year;

  /// Create a copy of StaffAnalyticsBookingsEvent
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
    extends _$StaffAnalyticsBookingsEventCopyWithImpl<$Res,
        _$LoadNextPageBookingsImpl>
    implements _$$LoadNextPageBookingsImplCopyWith<$Res> {
  __$$LoadNextPageBookingsImplCopyWithImpl(_$LoadNextPageBookingsImpl _value,
      $Res Function(_$LoadNextPageBookingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffAnalyticsBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageBookingsImpl implements _LoadNextPageBookings {
  const _$LoadNextPageBookingsImpl();

  @override
  String toString() {
    return 'StaffAnalyticsBookingsEvent.loadNextPageBookings()';
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
    required TResult Function(int staffId, int month, int year) loadBookings,
    required TResult Function() loadNextPageBookings,
  }) {
    return loadNextPageBookings();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int staffId, int month, int year)? loadBookings,
    TResult? Function()? loadNextPageBookings,
  }) {
    return loadNextPageBookings?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int staffId, int month, int year)? loadBookings,
    TResult Function()? loadNextPageBookings,
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
  }) {
    return loadNextPageBookings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
  }) {
    return loadNextPageBookings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    required TResult orElse(),
  }) {
    if (loadNextPageBookings != null) {
      return loadNextPageBookings(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageBookings implements StaffAnalyticsBookingsEvent {
  const factory _LoadNextPageBookings() = _$LoadNextPageBookingsImpl;
}

/// @nodoc
mixin _$StaffAnalyticsBookingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)?
        loaded,
    TResult Function(String message)? error,
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
abstract class $StaffAnalyticsBookingsStateCopyWith<$Res> {
  factory $StaffAnalyticsBookingsStateCopyWith(
          StaffAnalyticsBookingsState value,
          $Res Function(StaffAnalyticsBookingsState) then) =
      _$StaffAnalyticsBookingsStateCopyWithImpl<$Res,
          StaffAnalyticsBookingsState>;
}

/// @nodoc
class _$StaffAnalyticsBookingsStateCopyWithImpl<$Res,
        $Val extends StaffAnalyticsBookingsState>
    implements $StaffAnalyticsBookingsStateCopyWith<$Res> {
  _$StaffAnalyticsBookingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffAnalyticsBookingsState
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
    extends _$StaffAnalyticsBookingsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffAnalyticsBookingsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'StaffAnalyticsBookingsState.loading()';
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
    required TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)?
        loaded,
    TResult Function(String message)? error,
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

abstract class _Loading implements StaffAnalyticsBookingsState {
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
      int staffId,
      int month,
      int year});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$StaffAnalyticsBookingsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffAnalyticsBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookings = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? staffId = null,
    Object? month = null,
    Object? year = null,
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
      staffId: null == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<BookingsModel> bookings,
      required this.nextPageUrl,
      this.isPaginating = false,
      required this.staffId,
      required this.month,
      required this.year})
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
  final int staffId;
  @override
  final int month;
  @override
  final int year;

  @override
  String toString() {
    return 'StaffAnalyticsBookingsState.loaded(bookings: $bookings, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, staffId: $staffId, month: $month, year: $year)';
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
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_bookings),
      nextPageUrl,
      isPaginating,
      staffId,
      month,
      year);

  /// Create a copy of StaffAnalyticsBookingsState
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
    required TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(bookings, nextPageUrl, isPaginating, staffId, month, year);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
        bookings, nextPageUrl, isPaginating, staffId, month, year);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(bookings, nextPageUrl, isPaginating, staffId, month, year);
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

abstract class _Loaded implements StaffAnalyticsBookingsState {
  const factory _Loaded(
      {required final List<BookingsModel> bookings,
      required final String? nextPageUrl,
      final bool isPaginating,
      required final int staffId,
      required final int month,
      required final int year}) = _$LoadedImpl;

  List<BookingsModel> get bookings;
  String? get nextPageUrl;
  bool get isPaginating;
  int get staffId;
  int get month;
  int get year;

  /// Create a copy of StaffAnalyticsBookingsState
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
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$StaffAnalyticsBookingsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffAnalyticsBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'StaffAnalyticsBookingsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of StaffAnalyticsBookingsState
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
    required TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating, int staffId, int month, int year)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
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

abstract class _Error implements StaffAnalyticsBookingsState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of StaffAnalyticsBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
