// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_booking_upcoming_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductBookingUpcomingEvent {
  int get productId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int productId) loadBookings,
    required TResult Function(int productId) loadNextBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int productId)? loadBookings,
    TResult? Function(int productId)? loadNextBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int productId)? loadBookings,
    TResult Function(int productId)? loadNextBooking,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextBookings value) loadNextBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextBookings value)? loadNextBooking,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextBookings value)? loadNextBooking,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ProductBookingUpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductBookingUpcomingEventCopyWith<ProductBookingUpcomingEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductBookingUpcomingEventCopyWith<$Res> {
  factory $ProductBookingUpcomingEventCopyWith(
          ProductBookingUpcomingEvent value,
          $Res Function(ProductBookingUpcomingEvent) then) =
      _$ProductBookingUpcomingEventCopyWithImpl<$Res,
          ProductBookingUpcomingEvent>;
  @useResult
  $Res call({int productId});
}

/// @nodoc
class _$ProductBookingUpcomingEventCopyWithImpl<$Res,
        $Val extends ProductBookingUpcomingEvent>
    implements $ProductBookingUpcomingEventCopyWith<$Res> {
  _$ProductBookingUpcomingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductBookingUpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadBookingsImplCopyWith<$Res>
    implements $ProductBookingUpcomingEventCopyWith<$Res> {
  factory _$$LoadBookingsImplCopyWith(
          _$LoadBookingsImpl value, $Res Function(_$LoadBookingsImpl) then) =
      __$$LoadBookingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int productId});
}

/// @nodoc
class __$$LoadBookingsImplCopyWithImpl<$Res>
    extends _$ProductBookingUpcomingEventCopyWithImpl<$Res, _$LoadBookingsImpl>
    implements _$$LoadBookingsImplCopyWith<$Res> {
  __$$LoadBookingsImplCopyWithImpl(
      _$LoadBookingsImpl _value, $Res Function(_$LoadBookingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductBookingUpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_$LoadBookingsImpl(
      null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadBookingsImpl implements _LoadBookings {
  const _$LoadBookingsImpl(this.productId);

  @override
  final int productId;

  @override
  String toString() {
    return 'ProductBookingUpcomingEvent.loadBookings(productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadBookingsImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, productId);

  /// Create a copy of ProductBookingUpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadBookingsImplCopyWith<_$LoadBookingsImpl> get copyWith =>
      __$$LoadBookingsImplCopyWithImpl<_$LoadBookingsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int productId) loadBookings,
    required TResult Function(int productId) loadNextBooking,
  }) {
    return loadBookings(productId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int productId)? loadBookings,
    TResult? Function(int productId)? loadNextBooking,
  }) {
    return loadBookings?.call(productId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int productId)? loadBookings,
    TResult Function(int productId)? loadNextBooking,
    required TResult orElse(),
  }) {
    if (loadBookings != null) {
      return loadBookings(productId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextBookings value) loadNextBooking,
  }) {
    return loadBookings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextBookings value)? loadNextBooking,
  }) {
    return loadBookings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextBookings value)? loadNextBooking,
    required TResult orElse(),
  }) {
    if (loadBookings != null) {
      return loadBookings(this);
    }
    return orElse();
  }
}

abstract class _LoadBookings implements ProductBookingUpcomingEvent {
  const factory _LoadBookings(final int productId) = _$LoadBookingsImpl;

  @override
  int get productId;

  /// Create a copy of ProductBookingUpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadBookingsImplCopyWith<_$LoadBookingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextBookingsImplCopyWith<$Res>
    implements $ProductBookingUpcomingEventCopyWith<$Res> {
  factory _$$LoadNextBookingsImplCopyWith(_$LoadNextBookingsImpl value,
          $Res Function(_$LoadNextBookingsImpl) then) =
      __$$LoadNextBookingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int productId});
}

/// @nodoc
class __$$LoadNextBookingsImplCopyWithImpl<$Res>
    extends _$ProductBookingUpcomingEventCopyWithImpl<$Res,
        _$LoadNextBookingsImpl>
    implements _$$LoadNextBookingsImplCopyWith<$Res> {
  __$$LoadNextBookingsImplCopyWithImpl(_$LoadNextBookingsImpl _value,
      $Res Function(_$LoadNextBookingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductBookingUpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_$LoadNextBookingsImpl(
      null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadNextBookingsImpl implements _LoadNextBookings {
  const _$LoadNextBookingsImpl(this.productId);

  @override
  final int productId;

  @override
  String toString() {
    return 'ProductBookingUpcomingEvent.loadNextBooking(productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextBookingsImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, productId);

  /// Create a copy of ProductBookingUpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadNextBookingsImplCopyWith<_$LoadNextBookingsImpl> get copyWith =>
      __$$LoadNextBookingsImplCopyWithImpl<_$LoadNextBookingsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int productId) loadBookings,
    required TResult Function(int productId) loadNextBooking,
  }) {
    return loadNextBooking(productId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int productId)? loadBookings,
    TResult? Function(int productId)? loadNextBooking,
  }) {
    return loadNextBooking?.call(productId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int productId)? loadBookings,
    TResult Function(int productId)? loadNextBooking,
    required TResult orElse(),
  }) {
    if (loadNextBooking != null) {
      return loadNextBooking(productId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextBookings value) loadNextBooking,
  }) {
    return loadNextBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextBookings value)? loadNextBooking,
  }) {
    return loadNextBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextBookings value)? loadNextBooking,
    required TResult orElse(),
  }) {
    if (loadNextBooking != null) {
      return loadNextBooking(this);
    }
    return orElse();
  }
}

abstract class _LoadNextBookings implements ProductBookingUpcomingEvent {
  const factory _LoadNextBookings(final int productId) = _$LoadNextBookingsImpl;

  @override
  int get productId;

  /// Create a copy of ProductBookingUpcomingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadNextBookingsImplCopyWith<_$LoadNextBookingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProductBookingUpcomingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating)?
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
abstract class $ProductBookingUpcomingStateCopyWith<$Res> {
  factory $ProductBookingUpcomingStateCopyWith(
          ProductBookingUpcomingState value,
          $Res Function(ProductBookingUpcomingState) then) =
      _$ProductBookingUpcomingStateCopyWithImpl<$Res,
          ProductBookingUpcomingState>;
}

/// @nodoc
class _$ProductBookingUpcomingStateCopyWithImpl<$Res,
        $Val extends ProductBookingUpcomingState>
    implements $ProductBookingUpcomingStateCopyWith<$Res> {
  _$ProductBookingUpcomingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductBookingUpcomingState
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
    extends _$ProductBookingUpcomingStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductBookingUpcomingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ProductBookingUpcomingState.loading()';
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
            bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating)?
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

abstract class _Loading implements ProductBookingUpcomingState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<BookingsModel> bookings, String? nextPageUrl, bool isPaginating});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ProductBookingUpcomingStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductBookingUpcomingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookings = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
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
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<BookingsModel> bookings,
      required this.nextPageUrl,
      this.isPaginating = false})
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
  String toString() {
    return 'ProductBookingUpcomingState.loaded(bookings: $bookings, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating)';
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
                other.isPaginating == isPaginating));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_bookings),
      nextPageUrl,
      isPaginating);

  /// Create a copy of ProductBookingUpcomingState
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
            bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(bookings, nextPageUrl, isPaginating);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(bookings, nextPageUrl, isPaginating);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(bookings, nextPageUrl, isPaginating);
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

abstract class _Loaded implements ProductBookingUpcomingState {
  const factory _Loaded(
      {required final List<BookingsModel> bookings,
      required final String? nextPageUrl,
      final bool isPaginating}) = _$LoadedImpl;

  List<BookingsModel> get bookings;
  String? get nextPageUrl;
  bool get isPaginating;

  /// Create a copy of ProductBookingUpcomingState
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
    extends _$ProductBookingUpcomingStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductBookingUpcomingState
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
    return 'ProductBookingUpcomingState.error(error: $error)';
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

  /// Create a copy of ProductBookingUpcomingState
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
            bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<BookingsModel> bookings, String? nextPageUrl,
            bool isPaginating)?
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

abstract class _Error implements ProductBookingUpcomingState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of ProductBookingUpcomingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
