// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_bookings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LedgerBookingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadBookings,
    required TResult Function() loadNextPageBookings,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadBookings,
    TResult? Function()? loadNextPageBookings,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadBookings,
    TResult Function()? loadNextPageBookings,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBookings value) loadBookings,
    required TResult Function(_LoadNextPageBookings value) loadNextPageBookings,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBookings value)? loadBookings,
    TResult? Function(_LoadNextPageBookings value)? loadNextPageBookings,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBookings value)? loadBookings,
    TResult Function(_LoadNextPageBookings value)? loadNextPageBookings,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerBookingsEventCopyWith<$Res> {
  factory $LedgerBookingsEventCopyWith(
    LedgerBookingsEvent value,
    $Res Function(LedgerBookingsEvent) then,
  ) = _$LedgerBookingsEventCopyWithImpl<$Res, LedgerBookingsEvent>;
}

/// @nodoc
class _$LedgerBookingsEventCopyWithImpl<$Res, $Val extends LedgerBookingsEvent>
    implements $LedgerBookingsEventCopyWith<$Res> {
  _$LedgerBookingsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadBookingsImplCopyWith<$Res> {
  factory _$$LoadBookingsImplCopyWith(
    _$LoadBookingsImpl value,
    $Res Function(_$LoadBookingsImpl) then,
  ) = __$$LoadBookingsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? clientId});
}

/// @nodoc
class __$$LoadBookingsImplCopyWithImpl<$Res>
    extends _$LedgerBookingsEventCopyWithImpl<$Res, _$LoadBookingsImpl>
    implements _$$LoadBookingsImplCopyWith<$Res> {
  __$$LoadBookingsImplCopyWithImpl(
    _$LoadBookingsImpl _value,
    $Res Function(_$LoadBookingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientId = freezed}) {
    return _then(
      _$LoadBookingsImpl(
        clientId: freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$LoadBookingsImpl implements _LoadBookings {
  const _$LoadBookingsImpl({this.clientId});

  @override
  final int? clientId;

  @override
  String toString() {
    return 'LedgerBookingsEvent.loadBookings(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadBookingsImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of LedgerBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadBookingsImplCopyWith<_$LoadBookingsImpl> get copyWith =>
      __$$LoadBookingsImplCopyWithImpl<_$LoadBookingsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadBookings,
    required TResult Function() loadNextPageBookings,
  }) {
    return loadBookings(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadBookings,
    TResult? Function()? loadNextPageBookings,
  }) {
    return loadBookings?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadBookings,
    TResult Function()? loadNextPageBookings,
    required TResult orElse(),
  }) {
    if (loadBookings != null) {
      return loadBookings(clientId);
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

abstract class _LoadBookings implements LedgerBookingsEvent {
  const factory _LoadBookings({final int? clientId}) = _$LoadBookingsImpl;

  int? get clientId;

  /// Create a copy of LedgerBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadBookingsImplCopyWith<_$LoadBookingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPageBookingsImplCopyWith<$Res> {
  factory _$$LoadNextPageBookingsImplCopyWith(
    _$LoadNextPageBookingsImpl value,
    $Res Function(_$LoadNextPageBookingsImpl) then,
  ) = __$$LoadNextPageBookingsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPageBookingsImplCopyWithImpl<$Res>
    extends _$LedgerBookingsEventCopyWithImpl<$Res, _$LoadNextPageBookingsImpl>
    implements _$$LoadNextPageBookingsImplCopyWith<$Res> {
  __$$LoadNextPageBookingsImplCopyWithImpl(
    _$LoadNextPageBookingsImpl _value,
    $Res Function(_$LoadNextPageBookingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerBookingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageBookingsImpl implements _LoadNextPageBookings {
  const _$LoadNextPageBookingsImpl();

  @override
  String toString() {
    return 'LedgerBookingsEvent.loadNextPageBookings()';
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
    required TResult Function(int? clientId) loadBookings,
    required TResult Function() loadNextPageBookings,
  }) {
    return loadNextPageBookings();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadBookings,
    TResult? Function()? loadNextPageBookings,
  }) {
    return loadNextPageBookings?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadBookings,
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

abstract class _LoadNextPageBookings implements LedgerBookingsEvent {
  const factory _LoadNextPageBookings() = _$LoadNextPageBookingsImpl;
}

/// @nodoc
mixin _$LedgerBookingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )
    loaded,
    required TResult Function(String error) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
    loaded,
    TResult? Function(String error)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
    loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerBookingsStateCopyWith<$Res> {
  factory $LedgerBookingsStateCopyWith(
    LedgerBookingsState value,
    $Res Function(LedgerBookingsState) then,
  ) = _$LedgerBookingsStateCopyWithImpl<$Res, LedgerBookingsState>;
}

/// @nodoc
class _$LedgerBookingsStateCopyWithImpl<$Res, $Val extends LedgerBookingsState>
    implements $LedgerBookingsStateCopyWith<$Res> {
  _$LedgerBookingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerBookingsState
  /// with the given fields replaced by the non-null parameter values.
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
    extends _$LedgerBookingsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerBookingsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'LedgerBookingsState.loading()';
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
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )
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
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
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
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
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

abstract class _Loading implements LedgerBookingsState {
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
    List<LedgerBookingDailyModel> ledgerBookings,
    String? nextPageUrl,
    bool isPaginating,
    int? clientId,
    bool isFirstFetch,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$LedgerBookingsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ledgerBookings = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? clientId = freezed,
    Object? isFirstFetch = null,
  }) {
    return _then(
      _$LoadedImpl(
        ledgerBookings: null == ledgerBookings
            ? _value._ledgerBookings
            : ledgerBookings // ignore: cast_nullable_to_non_nullable
                  as List<LedgerBookingDailyModel>,
        nextPageUrl: freezed == nextPageUrl
            ? _value.nextPageUrl
            : nextPageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPaginating: null == isPaginating
            ? _value.isPaginating
            : isPaginating // ignore: cast_nullable_to_non_nullable
                  as bool,
        clientId: freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as int?,
        isFirstFetch: null == isFirstFetch
            ? _value.isFirstFetch
            : isFirstFetch // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({
    required final List<LedgerBookingDailyModel> ledgerBookings,
    required this.nextPageUrl,
    this.isPaginating = false,
    this.clientId,
    this.isFirstFetch = false,
  }) : _ledgerBookings = ledgerBookings;

  final List<LedgerBookingDailyModel> _ledgerBookings;
  @override
  List<LedgerBookingDailyModel> get ledgerBookings {
    if (_ledgerBookings is EqualUnmodifiableListView) return _ledgerBookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ledgerBookings);
  }

  @override
  final String? nextPageUrl;
  @override
  @JsonKey()
  final bool isPaginating;
  @override
  final int? clientId;
  @override
  @JsonKey()
  final bool isFirstFetch;

  @override
  String toString() {
    return 'LedgerBookingsState.loaded(ledgerBookings: $ledgerBookings, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, clientId: $clientId, isFirstFetch: $isFirstFetch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(
              other._ledgerBookings,
              _ledgerBookings,
            ) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.isPaginating, isPaginating) ||
                other.isPaginating == isPaginating) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.isFirstFetch, isFirstFetch) ||
                other.isFirstFetch == isFirstFetch));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_ledgerBookings),
    nextPageUrl,
    isPaginating,
    clientId,
    isFirstFetch,
  );

  /// Create a copy of LedgerBookingsState
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
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )
    loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(
      ledgerBookings,
      nextPageUrl,
      isPaginating,
      clientId,
      isFirstFetch,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
    loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(
      ledgerBookings,
      nextPageUrl,
      isPaginating,
      clientId,
      isFirstFetch,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
    loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        ledgerBookings,
        nextPageUrl,
        isPaginating,
        clientId,
        isFirstFetch,
      );
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

abstract class _Loaded implements LedgerBookingsState {
  const factory _Loaded({
    required final List<LedgerBookingDailyModel> ledgerBookings,
    required final String? nextPageUrl,
    final bool isPaginating,
    final int? clientId,
    final bool isFirstFetch,
  }) = _$LoadedImpl;

  List<LedgerBookingDailyModel> get ledgerBookings;
  String? get nextPageUrl;
  bool get isPaginating;
  int? get clientId;
  bool get isFirstFetch;

  /// Create a copy of LedgerBookingsState
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
    extends _$LedgerBookingsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerBookingsState
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
    return 'LedgerBookingsState.error(error: $error)';
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

  /// Create a copy of LedgerBookingsState
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
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )
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
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
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
      List<LedgerBookingDailyModel> ledgerBookings,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
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

abstract class _Error implements LedgerBookingsState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of LedgerBookingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
