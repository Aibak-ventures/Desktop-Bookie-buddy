// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_pending_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WalletPendingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadPending,
    required TResult Function() loadNextPagePending,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadPending,
    TResult? Function()? loadNextPagePending,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadPending,
    TResult Function()? loadNextPagePending,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPending value) loadPending,
    required TResult Function(_LoadNextPagePending value) loadNextPagePending,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPending value)? loadPending,
    TResult? Function(_LoadNextPagePending value)? loadNextPagePending,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPending value)? loadPending,
    TResult Function(_LoadNextPagePending value)? loadNextPagePending,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletPendingEventCopyWith<$Res> {
  factory $WalletPendingEventCopyWith(
    WalletPendingEvent value,
    $Res Function(WalletPendingEvent) then,
  ) = _$WalletPendingEventCopyWithImpl<$Res, WalletPendingEvent>;
}

/// @nodoc
class _$WalletPendingEventCopyWithImpl<$Res, $Val extends WalletPendingEvent>
    implements $WalletPendingEventCopyWith<$Res> {
  _$WalletPendingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletPendingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadPendingImplCopyWith<$Res> {
  factory _$$LoadPendingImplCopyWith(
    _$LoadPendingImpl value,
    $Res Function(_$LoadPendingImpl) then,
  ) = __$$LoadPendingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? clientId});
}

/// @nodoc
class __$$LoadPendingImplCopyWithImpl<$Res>
    extends _$WalletPendingEventCopyWithImpl<$Res, _$LoadPendingImpl>
    implements _$$LoadPendingImplCopyWith<$Res> {
  __$$LoadPendingImplCopyWithImpl(
    _$LoadPendingImpl _value,
    $Res Function(_$LoadPendingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletPendingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientId = freezed}) {
    return _then(
      _$LoadPendingImpl(
        clientId: freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$LoadPendingImpl implements _LoadPending {
  const _$LoadPendingImpl({this.clientId});

  @override
  final int? clientId;

  @override
  String toString() {
    return 'WalletPendingEvent.loadPending(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPendingImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of WalletPendingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadPendingImplCopyWith<_$LoadPendingImpl> get copyWith =>
      __$$LoadPendingImplCopyWithImpl<_$LoadPendingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadPending,
    required TResult Function() loadNextPagePending,
  }) {
    return loadPending(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadPending,
    TResult? Function()? loadNextPagePending,
  }) {
    return loadPending?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadPending,
    TResult Function()? loadNextPagePending,
    required TResult orElse(),
  }) {
    if (loadPending != null) {
      return loadPending(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPending value) loadPending,
    required TResult Function(_LoadNextPagePending value) loadNextPagePending,
  }) {
    return loadPending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPending value)? loadPending,
    TResult? Function(_LoadNextPagePending value)? loadNextPagePending,
  }) {
    return loadPending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPending value)? loadPending,
    TResult Function(_LoadNextPagePending value)? loadNextPagePending,
    required TResult orElse(),
  }) {
    if (loadPending != null) {
      return loadPending(this);
    }
    return orElse();
  }
}

abstract class _LoadPending implements WalletPendingEvent {
  const factory _LoadPending({final int? clientId}) = _$LoadPendingImpl;

  int? get clientId;

  /// Create a copy of WalletPendingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadPendingImplCopyWith<_$LoadPendingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPagePendingImplCopyWith<$Res> {
  factory _$$LoadNextPagePendingImplCopyWith(
    _$LoadNextPagePendingImpl value,
    $Res Function(_$LoadNextPagePendingImpl) then,
  ) = __$$LoadNextPagePendingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPagePendingImplCopyWithImpl<$Res>
    extends _$WalletPendingEventCopyWithImpl<$Res, _$LoadNextPagePendingImpl>
    implements _$$LoadNextPagePendingImplCopyWith<$Res> {
  __$$LoadNextPagePendingImplCopyWithImpl(
    _$LoadNextPagePendingImpl _value,
    $Res Function(_$LoadNextPagePendingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletPendingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPagePendingImpl implements _LoadNextPagePending {
  const _$LoadNextPagePendingImpl();

  @override
  String toString() {
    return 'WalletPendingEvent.loadNextPagePending()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextPagePendingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadPending,
    required TResult Function() loadNextPagePending,
  }) {
    return loadNextPagePending();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadPending,
    TResult? Function()? loadNextPagePending,
  }) {
    return loadNextPagePending?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadPending,
    TResult Function()? loadNextPagePending,
    required TResult orElse(),
  }) {
    if (loadNextPagePending != null) {
      return loadNextPagePending();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPending value) loadPending,
    required TResult Function(_LoadNextPagePending value) loadNextPagePending,
  }) {
    return loadNextPagePending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPending value)? loadPending,
    TResult? Function(_LoadNextPagePending value)? loadNextPagePending,
  }) {
    return loadNextPagePending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPending value)? loadPending,
    TResult Function(_LoadNextPagePending value)? loadNextPagePending,
    required TResult orElse(),
  }) {
    if (loadNextPagePending != null) {
      return loadNextPagePending(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPagePending implements WalletPendingEvent {
  const factory _LoadNextPagePending() = _$LoadNextPagePendingImpl;
}

/// @nodoc
mixin _$WalletPendingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<LedgerPendingsDailyModel> walletPending,
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
      List<LedgerPendingsDailyModel> walletPending,
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
      List<LedgerPendingsDailyModel> walletPending,
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
abstract class $WalletPendingStateCopyWith<$Res> {
  factory $WalletPendingStateCopyWith(
    WalletPendingState value,
    $Res Function(WalletPendingState) then,
  ) = _$WalletPendingStateCopyWithImpl<$Res, WalletPendingState>;
}

/// @nodoc
class _$WalletPendingStateCopyWithImpl<$Res, $Val extends WalletPendingState>
    implements $WalletPendingStateCopyWith<$Res> {
  _$WalletPendingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletPendingState
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
    extends _$WalletPendingStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletPendingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'WalletPendingState.loading()';
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
      List<LedgerPendingsDailyModel> walletPending,
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
      List<LedgerPendingsDailyModel> walletPending,
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
      List<LedgerPendingsDailyModel> walletPending,
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

abstract class _Loading implements WalletPendingState {
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
    List<LedgerPendingsDailyModel> walletPending,
    String? nextPageUrl,
    bool isPaginating,
    int? clientId,
    bool isFirstFetch,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$WalletPendingStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletPendingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletPending = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? clientId = freezed,
    Object? isFirstFetch = null,
  }) {
    return _then(
      _$LoadedImpl(
        walletPending: null == walletPending
            ? _value._walletPending
            : walletPending // ignore: cast_nullable_to_non_nullable
                  as List<LedgerPendingsDailyModel>,
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
    required final List<LedgerPendingsDailyModel> walletPending,
    required this.nextPageUrl,
    this.isPaginating = false,
    this.clientId,
    this.isFirstFetch = false,
  }) : _walletPending = walletPending;

  final List<LedgerPendingsDailyModel> _walletPending;
  @override
  List<LedgerPendingsDailyModel> get walletPending {
    if (_walletPending is EqualUnmodifiableListView) return _walletPending;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_walletPending);
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
    return 'WalletPendingState.loaded(walletPending: $walletPending, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, clientId: $clientId, isFirstFetch: $isFirstFetch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(
              other._walletPending,
              _walletPending,
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
    const DeepCollectionEquality().hash(_walletPending),
    nextPageUrl,
    isPaginating,
    clientId,
    isFirstFetch,
  );

  /// Create a copy of WalletPendingState
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
      List<LedgerPendingsDailyModel> walletPending,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )
    loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(
      walletPending,
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
      List<LedgerPendingsDailyModel> walletPending,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
    loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(
      walletPending,
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
      List<LedgerPendingsDailyModel> walletPending,
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
        walletPending,
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

abstract class _Loaded implements WalletPendingState {
  const factory _Loaded({
    required final List<LedgerPendingsDailyModel> walletPending,
    required final String? nextPageUrl,
    final bool isPaginating,
    final int? clientId,
    final bool isFirstFetch,
  }) = _$LoadedImpl;

  List<LedgerPendingsDailyModel> get walletPending;
  String? get nextPageUrl;
  bool get isPaginating;
  int? get clientId;
  bool get isFirstFetch;

  /// Create a copy of WalletPendingState
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
    extends _$WalletPendingStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletPendingState
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
    return 'WalletPendingState.error(error: $error)';
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

  /// Create a copy of WalletPendingState
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
      List<LedgerPendingsDailyModel> walletPending,
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
      List<LedgerPendingsDailyModel> walletPending,
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
      List<LedgerPendingsDailyModel> walletPending,
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

abstract class _Error implements WalletPendingState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of WalletPendingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
