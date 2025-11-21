// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_booking_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddBookingEvent {
  RequestBookingModel get booking => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RequestBookingModel booking) addNewBooking,
    required TResult Function(RequestBookingModel booking) updateBookingData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RequestBookingModel booking)? addNewBooking,
    TResult? Function(RequestBookingModel booking)? updateBookingData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RequestBookingModel booking)? addNewBooking,
    TResult Function(RequestBookingModel booking)? updateBookingData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddNewBooking value) addNewBooking,
    required TResult Function(_UpdateBookingData value) updateBookingData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddNewBooking value)? addNewBooking,
    TResult? Function(_UpdateBookingData value)? updateBookingData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddNewBooking value)? addNewBooking,
    TResult Function(_UpdateBookingData value)? updateBookingData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AddBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddBookingEventCopyWith<AddBookingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddBookingEventCopyWith<$Res> {
  factory $AddBookingEventCopyWith(
    AddBookingEvent value,
    $Res Function(AddBookingEvent) then,
  ) = _$AddBookingEventCopyWithImpl<$Res, AddBookingEvent>;
  @useResult
  $Res call({RequestBookingModel booking});

  $RequestBookingModelCopyWith<$Res> get booking;
}

/// @nodoc
class _$AddBookingEventCopyWithImpl<$Res, $Val extends AddBookingEvent>
    implements $AddBookingEventCopyWith<$Res> {
  _$AddBookingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? booking = null}) {
    return _then(
      _value.copyWith(
        booking: null == booking
            ? _value.booking
            : booking // ignore: cast_nullable_to_non_nullable
                as RequestBookingModel,
      ) as $Val,
    );
  }

  /// Create a copy of AddBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestBookingModelCopyWith<$Res> get booking {
    return $RequestBookingModelCopyWith<$Res>(_value.booking, (value) {
      return _then(_value.copyWith(booking: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddNewBookingImplCopyWith<$Res>
    implements $AddBookingEventCopyWith<$Res> {
  factory _$$AddNewBookingImplCopyWith(
    _$AddNewBookingImpl value,
    $Res Function(_$AddNewBookingImpl) then,
  ) = __$$AddNewBookingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RequestBookingModel booking});

  @override
  $RequestBookingModelCopyWith<$Res> get booking;
}

/// @nodoc
class __$$AddNewBookingImplCopyWithImpl<$Res>
    extends _$AddBookingEventCopyWithImpl<$Res, _$AddNewBookingImpl>
    implements _$$AddNewBookingImplCopyWith<$Res> {
  __$$AddNewBookingImplCopyWithImpl(
    _$AddNewBookingImpl _value,
    $Res Function(_$AddNewBookingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? booking = null}) {
    return _then(
      _$AddNewBookingImpl(
        null == booking
            ? _value.booking
            : booking // ignore: cast_nullable_to_non_nullable
                as RequestBookingModel,
      ),
    );
  }
}

/// @nodoc

class _$AddNewBookingImpl implements _AddNewBooking {
  const _$AddNewBookingImpl(this.booking);

  @override
  final RequestBookingModel booking;

  @override
  String toString() {
    return 'AddBookingEvent.addNewBooking(booking: $booking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddNewBookingImpl &&
            (identical(other.booking, booking) || other.booking == booking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, booking);

  /// Create a copy of AddBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddNewBookingImplCopyWith<_$AddNewBookingImpl> get copyWith =>
      __$$AddNewBookingImplCopyWithImpl<_$AddNewBookingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RequestBookingModel booking) addNewBooking,
    required TResult Function(RequestBookingModel booking) updateBookingData,
  }) {
    return addNewBooking(booking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RequestBookingModel booking)? addNewBooking,
    TResult? Function(RequestBookingModel booking)? updateBookingData,
  }) {
    return addNewBooking?.call(booking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RequestBookingModel booking)? addNewBooking,
    TResult Function(RequestBookingModel booking)? updateBookingData,
    required TResult orElse(),
  }) {
    if (addNewBooking != null) {
      return addNewBooking(booking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddNewBooking value) addNewBooking,
    required TResult Function(_UpdateBookingData value) updateBookingData,
  }) {
    return addNewBooking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddNewBooking value)? addNewBooking,
    TResult? Function(_UpdateBookingData value)? updateBookingData,
  }) {
    return addNewBooking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddNewBooking value)? addNewBooking,
    TResult Function(_UpdateBookingData value)? updateBookingData,
    required TResult orElse(),
  }) {
    if (addNewBooking != null) {
      return addNewBooking(this);
    }
    return orElse();
  }
}

abstract class _AddNewBooking implements AddBookingEvent {
  const factory _AddNewBooking(final RequestBookingModel booking) =
      _$AddNewBookingImpl;

  @override
  RequestBookingModel get booking;

  /// Create a copy of AddBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddNewBookingImplCopyWith<_$AddNewBookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateBookingDataImplCopyWith<$Res>
    implements $AddBookingEventCopyWith<$Res> {
  factory _$$UpdateBookingDataImplCopyWith(
    _$UpdateBookingDataImpl value,
    $Res Function(_$UpdateBookingDataImpl) then,
  ) = __$$UpdateBookingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RequestBookingModel booking});

  @override
  $RequestBookingModelCopyWith<$Res> get booking;
}

/// @nodoc
class __$$UpdateBookingDataImplCopyWithImpl<$Res>
    extends _$AddBookingEventCopyWithImpl<$Res, _$UpdateBookingDataImpl>
    implements _$$UpdateBookingDataImplCopyWith<$Res> {
  __$$UpdateBookingDataImplCopyWithImpl(
    _$UpdateBookingDataImpl _value,
    $Res Function(_$UpdateBookingDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? booking = null}) {
    return _then(
      _$UpdateBookingDataImpl(
        null == booking
            ? _value.booking
            : booking // ignore: cast_nullable_to_non_nullable
                as RequestBookingModel,
      ),
    );
  }
}

/// @nodoc

class _$UpdateBookingDataImpl implements _UpdateBookingData {
  const _$UpdateBookingDataImpl(this.booking);

  @override
  final RequestBookingModel booking;

  @override
  String toString() {
    return 'AddBookingEvent.updateBookingData(booking: $booking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateBookingDataImpl &&
            (identical(other.booking, booking) || other.booking == booking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, booking);

  /// Create a copy of AddBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBookingDataImplCopyWith<_$UpdateBookingDataImpl> get copyWith =>
      __$$UpdateBookingDataImplCopyWithImpl<_$UpdateBookingDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RequestBookingModel booking) addNewBooking,
    required TResult Function(RequestBookingModel booking) updateBookingData,
  }) {
    return updateBookingData(booking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RequestBookingModel booking)? addNewBooking,
    TResult? Function(RequestBookingModel booking)? updateBookingData,
  }) {
    return updateBookingData?.call(booking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RequestBookingModel booking)? addNewBooking,
    TResult Function(RequestBookingModel booking)? updateBookingData,
    required TResult orElse(),
  }) {
    if (updateBookingData != null) {
      return updateBookingData(booking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddNewBooking value) addNewBooking,
    required TResult Function(_UpdateBookingData value) updateBookingData,
  }) {
    return updateBookingData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddNewBooking value)? addNewBooking,
    TResult? Function(_UpdateBookingData value)? updateBookingData,
  }) {
    return updateBookingData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddNewBooking value)? addNewBooking,
    TResult Function(_UpdateBookingData value)? updateBookingData,
    required TResult orElse(),
  }) {
    if (updateBookingData != null) {
      return updateBookingData(this);
    }
    return orElse();
  }
}

abstract class _UpdateBookingData implements AddBookingEvent {
  const factory _UpdateBookingData(final RequestBookingModel booking) =
      _$UpdateBookingDataImpl;

  @override
  RequestBookingModel get booking;

  /// Create a copy of AddBookingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateBookingDataImplCopyWith<_$UpdateBookingDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AddBookingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RequestBookingModel booking) initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RequestBookingModel booking)? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RequestBookingModel booking)? initial,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddBookingStateCopyWith<$Res> {
  factory $AddBookingStateCopyWith(
    AddBookingState value,
    $Res Function(AddBookingState) then,
  ) = _$AddBookingStateCopyWithImpl<$Res, AddBookingState>;
}

/// @nodoc
class _$AddBookingStateCopyWithImpl<$Res, $Val extends AddBookingState>
    implements $AddBookingStateCopyWith<$Res> {
  _$AddBookingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddBookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RequestBookingModel booking});

  $RequestBookingModelCopyWith<$Res> get booking;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AddBookingStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddBookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? booking = null}) {
    return _then(
      _$InitialImpl(
        booking: null == booking
            ? _value.booking
            : booking // ignore: cast_nullable_to_non_nullable
                as RequestBookingModel,
      ),
    );
  }

  /// Create a copy of AddBookingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestBookingModelCopyWith<$Res> get booking {
    return $RequestBookingModelCopyWith<$Res>(_value.booking, (value) {
      return _then(_value.copyWith(booking: value));
    });
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl({required this.booking});

  @override
  final RequestBookingModel booking;

  @override
  String toString() {
    return 'AddBookingState.initial(booking: $booking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.booking, booking) || other.booking == booking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, booking);

  /// Create a copy of AddBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RequestBookingModel booking) initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(String error) error,
  }) {
    return initial(booking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RequestBookingModel booking)? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(String error)? error,
  }) {
    return initial?.call(booking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RequestBookingModel booking)? initial,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(booking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AddBookingState {
  const factory _Initial({required final RequestBookingModel booking}) =
      _$InitialImpl;

  RequestBookingModel get booking;

  /// Create a copy of AddBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmittingImplCopyWith<$Res> {
  factory _$$SubmittingImplCopyWith(
    _$SubmittingImpl value,
    $Res Function(_$SubmittingImpl) then,
  ) = __$$SubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmittingImplCopyWithImpl<$Res>
    extends _$AddBookingStateCopyWithImpl<$Res, _$SubmittingImpl>
    implements _$$SubmittingImplCopyWith<$Res> {
  __$$SubmittingImplCopyWithImpl(
    _$SubmittingImpl _value,
    $Res Function(_$SubmittingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddBookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmittingImpl implements _Submitting {
  const _$SubmittingImpl();

  @override
  String toString() {
    return 'AddBookingState.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmittingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RequestBookingModel booking) initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(String error) error,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RequestBookingModel booking)? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(String error)? error,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RequestBookingModel booking)? initial,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class _Submitting implements AddBookingState {
  const factory _Submitting() = _$SubmittingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
    _$SuccessImpl value,
    $Res Function(_$SuccessImpl) then,
  ) = __$$SuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$AddBookingStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
    _$SuccessImpl _value,
    $Res Function(_$SuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddBookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl();

  @override
  String toString() {
    return 'AddBookingState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RequestBookingModel booking) initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(String error) error,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RequestBookingModel booking)? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(String error)? error,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RequestBookingModel booking)? initial,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements AddBookingState {
  const factory _Success() = _$SuccessImpl;
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
    extends _$AddBookingStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddBookingState
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
    return 'AddBookingState.error(error: $error)';
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

  /// Create a copy of AddBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RequestBookingModel booking) initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RequestBookingModel booking)? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RequestBookingModel booking)? initial,
    TResult Function()? submitting,
    TResult Function()? success,
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
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AddBookingState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of AddBookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
