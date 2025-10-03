// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_sales_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LedgerSalesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadSales,
    required TResult Function() loadNextPageSales,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadSales,
    TResult? Function()? loadNextPageSales,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadSales,
    TResult Function()? loadNextPageSales,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSales value) loadSales,
    required TResult Function(_LoadNextPageSales value) loadNextPageSales,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSales value)? loadSales,
    TResult? Function(_LoadNextPageSales value)? loadNextPageSales,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSales value)? loadSales,
    TResult Function(_LoadNextPageSales value)? loadNextPageSales,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerSalesEventCopyWith<$Res> {
  factory $LedgerSalesEventCopyWith(
    LedgerSalesEvent value,
    $Res Function(LedgerSalesEvent) then,
  ) = _$LedgerSalesEventCopyWithImpl<$Res, LedgerSalesEvent>;
}

/// @nodoc
class _$LedgerSalesEventCopyWithImpl<$Res, $Val extends LedgerSalesEvent>
    implements $LedgerSalesEventCopyWith<$Res> {
  _$LedgerSalesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerSalesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadSalesImplCopyWith<$Res> {
  factory _$$LoadSalesImplCopyWith(
    _$LoadSalesImpl value,
    $Res Function(_$LoadSalesImpl) then,
  ) = __$$LoadSalesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? clientId});
}

/// @nodoc
class __$$LoadSalesImplCopyWithImpl<$Res>
    extends _$LedgerSalesEventCopyWithImpl<$Res, _$LoadSalesImpl>
    implements _$$LoadSalesImplCopyWith<$Res> {
  __$$LoadSalesImplCopyWithImpl(
    _$LoadSalesImpl _value,
    $Res Function(_$LoadSalesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerSalesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientId = freezed}) {
    return _then(
      _$LoadSalesImpl(
        clientId: freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$LoadSalesImpl implements _LoadSales {
  const _$LoadSalesImpl({this.clientId});

  @override
  final int? clientId;

  @override
  String toString() {
    return 'LedgerSalesEvent.loadSales(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSalesImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of LedgerSalesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSalesImplCopyWith<_$LoadSalesImpl> get copyWith =>
      __$$LoadSalesImplCopyWithImpl<_$LoadSalesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadSales,
    required TResult Function() loadNextPageSales,
  }) {
    return loadSales(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadSales,
    TResult? Function()? loadNextPageSales,
  }) {
    return loadSales?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadSales,
    TResult Function()? loadNextPageSales,
    required TResult orElse(),
  }) {
    if (loadSales != null) {
      return loadSales(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSales value) loadSales,
    required TResult Function(_LoadNextPageSales value) loadNextPageSales,
  }) {
    return loadSales(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSales value)? loadSales,
    TResult? Function(_LoadNextPageSales value)? loadNextPageSales,
  }) {
    return loadSales?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSales value)? loadSales,
    TResult Function(_LoadNextPageSales value)? loadNextPageSales,
    required TResult orElse(),
  }) {
    if (loadSales != null) {
      return loadSales(this);
    }
    return orElse();
  }
}

abstract class _LoadSales implements LedgerSalesEvent {
  const factory _LoadSales({final int? clientId}) = _$LoadSalesImpl;

  int? get clientId;

  /// Create a copy of LedgerSalesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadSalesImplCopyWith<_$LoadSalesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPageSalesImplCopyWith<$Res> {
  factory _$$LoadNextPageSalesImplCopyWith(
    _$LoadNextPageSalesImpl value,
    $Res Function(_$LoadNextPageSalesImpl) then,
  ) = __$$LoadNextPageSalesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPageSalesImplCopyWithImpl<$Res>
    extends _$LedgerSalesEventCopyWithImpl<$Res, _$LoadNextPageSalesImpl>
    implements _$$LoadNextPageSalesImplCopyWith<$Res> {
  __$$LoadNextPageSalesImplCopyWithImpl(
    _$LoadNextPageSalesImpl _value,
    $Res Function(_$LoadNextPageSalesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerSalesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageSalesImpl implements _LoadNextPageSales {
  const _$LoadNextPageSalesImpl();

  @override
  String toString() {
    return 'LedgerSalesEvent.loadNextPageSales()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadNextPageSalesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadSales,
    required TResult Function() loadNextPageSales,
  }) {
    return loadNextPageSales();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadSales,
    TResult? Function()? loadNextPageSales,
  }) {
    return loadNextPageSales?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadSales,
    TResult Function()? loadNextPageSales,
    required TResult orElse(),
  }) {
    if (loadNextPageSales != null) {
      return loadNextPageSales();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSales value) loadSales,
    required TResult Function(_LoadNextPageSales value) loadNextPageSales,
  }) {
    return loadNextPageSales(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSales value)? loadSales,
    TResult? Function(_LoadNextPageSales value)? loadNextPageSales,
  }) {
    return loadNextPageSales?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSales value)? loadSales,
    TResult Function(_LoadNextPageSales value)? loadNextPageSales,
    required TResult orElse(),
  }) {
    if (loadNextPageSales != null) {
      return loadNextPageSales(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageSales implements LedgerSalesEvent {
  const factory _LoadNextPageSales() = _$LoadNextPageSalesImpl;
}

/// @nodoc
mixin _$LedgerSalesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
    loaded,
    TResult Function(String message)? error,
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
abstract class $LedgerSalesStateCopyWith<$Res> {
  factory $LedgerSalesStateCopyWith(
    LedgerSalesState value,
    $Res Function(LedgerSalesState) then,
  ) = _$LedgerSalesStateCopyWithImpl<$Res, LedgerSalesState>;
}

/// @nodoc
class _$LedgerSalesStateCopyWithImpl<$Res, $Val extends LedgerSalesState>
    implements $LedgerSalesStateCopyWith<$Res> {
  _$LedgerSalesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerSalesState
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
    extends _$LedgerSalesStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerSalesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'LedgerSalesState.loading()';
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
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
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

abstract class _Loading implements LedgerSalesState {
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
    List<LedgerSaleDailyModel> ledgerSales,
    String? nextPageUrl,
    bool isPaginating,
    int? clientId,
    bool isFirstFetch,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$LedgerSalesStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerSalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ledgerSales = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? clientId = freezed,
    Object? isFirstFetch = null,
  }) {
    return _then(
      _$LoadedImpl(
        ledgerSales: null == ledgerSales
            ? _value._ledgerSales
            : ledgerSales // ignore: cast_nullable_to_non_nullable
                  as List<LedgerSaleDailyModel>,
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
    required final List<LedgerSaleDailyModel> ledgerSales,
    required this.nextPageUrl,
    this.isPaginating = false,
    required this.clientId,
    required this.isFirstFetch,
  }) : _ledgerSales = ledgerSales;

  final List<LedgerSaleDailyModel> _ledgerSales;
  @override
  List<LedgerSaleDailyModel> get ledgerSales {
    if (_ledgerSales is EqualUnmodifiableListView) return _ledgerSales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ledgerSales);
  }

  @override
  final String? nextPageUrl;
  @override
  @JsonKey()
  final bool isPaginating;
  @override
  final int? clientId;
  @override
  final bool isFirstFetch;

  @override
  String toString() {
    return 'LedgerSalesState.loaded(ledgerSales: $ledgerSales, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, clientId: $clientId, isFirstFetch: $isFirstFetch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(
              other._ledgerSales,
              _ledgerSales,
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
    const DeepCollectionEquality().hash(_ledgerSales),
    nextPageUrl,
    isPaginating,
    clientId,
    isFirstFetch,
  );

  /// Create a copy of LedgerSalesState
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
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
      ledgerSales,
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
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
      ledgerSales,
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
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        ledgerSales,
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

abstract class _Loaded implements LedgerSalesState {
  const factory _Loaded({
    required final List<LedgerSaleDailyModel> ledgerSales,
    required final String? nextPageUrl,
    final bool isPaginating,
    required final int? clientId,
    required final bool isFirstFetch,
  }) = _$LoadedImpl;

  List<LedgerSaleDailyModel> get ledgerSales;
  String? get nextPageUrl;
  bool get isPaginating;
  int? get clientId;
  bool get isFirstFetch;

  /// Create a copy of LedgerSalesState
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
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$LedgerSalesStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerSalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'LedgerSalesState.error(message: $message)';
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

  /// Create a copy of LedgerSalesState
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
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<LedgerSaleDailyModel> ledgerSales,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch,
    )?
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

abstract class _Error implements LedgerSalesState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of LedgerSalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
