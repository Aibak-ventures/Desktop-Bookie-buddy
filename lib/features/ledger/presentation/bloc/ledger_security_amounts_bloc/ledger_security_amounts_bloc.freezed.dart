// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_security_amounts_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LedgerSecurityAmountsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadSecurityAmounts,
    required TResult Function() loadNextPageSecurityAmounts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadSecurityAmounts,
    TResult? Function()? loadNextPageSecurityAmounts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadSecurityAmounts,
    TResult Function()? loadNextPageSecurityAmounts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSecurityAmounts value) loadSecurityAmounts,
    required TResult Function(_LoadNextPageSecurityAmounts value)
        loadNextPageSecurityAmounts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSecurityAmounts value)? loadSecurityAmounts,
    TResult? Function(_LoadNextPageSecurityAmounts value)?
        loadNextPageSecurityAmounts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSecurityAmounts value)? loadSecurityAmounts,
    TResult Function(_LoadNextPageSecurityAmounts value)?
        loadNextPageSecurityAmounts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerSecurityAmountsEventCopyWith<$Res> {
  factory $LedgerSecurityAmountsEventCopyWith(LedgerSecurityAmountsEvent value,
          $Res Function(LedgerSecurityAmountsEvent) then) =
      _$LedgerSecurityAmountsEventCopyWithImpl<$Res,
          LedgerSecurityAmountsEvent>;
}

/// @nodoc
class _$LedgerSecurityAmountsEventCopyWithImpl<$Res,
        $Val extends LedgerSecurityAmountsEvent>
    implements $LedgerSecurityAmountsEventCopyWith<$Res> {
  _$LedgerSecurityAmountsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerSecurityAmountsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadSecurityAmountsImplCopyWith<$Res> {
  factory _$$LoadSecurityAmountsImplCopyWith(_$LoadSecurityAmountsImpl value,
          $Res Function(_$LoadSecurityAmountsImpl) then) =
      __$$LoadSecurityAmountsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? clientId});
}

/// @nodoc
class __$$LoadSecurityAmountsImplCopyWithImpl<$Res>
    extends _$LedgerSecurityAmountsEventCopyWithImpl<$Res,
        _$LoadSecurityAmountsImpl>
    implements _$$LoadSecurityAmountsImplCopyWith<$Res> {
  __$$LoadSecurityAmountsImplCopyWithImpl(_$LoadSecurityAmountsImpl _value,
      $Res Function(_$LoadSecurityAmountsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LedgerSecurityAmountsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = freezed,
  }) {
    return _then(_$LoadSecurityAmountsImpl(
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$LoadSecurityAmountsImpl implements _LoadSecurityAmounts {
  const _$LoadSecurityAmountsImpl({this.clientId});

  @override
  final int? clientId;

  @override
  String toString() {
    return 'LedgerSecurityAmountsEvent.loadSecurityAmounts(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSecurityAmountsImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of LedgerSecurityAmountsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSecurityAmountsImplCopyWith<_$LoadSecurityAmountsImpl> get copyWith =>
      __$$LoadSecurityAmountsImplCopyWithImpl<_$LoadSecurityAmountsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadSecurityAmounts,
    required TResult Function() loadNextPageSecurityAmounts,
  }) {
    return loadSecurityAmounts(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadSecurityAmounts,
    TResult? Function()? loadNextPageSecurityAmounts,
  }) {
    return loadSecurityAmounts?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadSecurityAmounts,
    TResult Function()? loadNextPageSecurityAmounts,
    required TResult orElse(),
  }) {
    if (loadSecurityAmounts != null) {
      return loadSecurityAmounts(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSecurityAmounts value) loadSecurityAmounts,
    required TResult Function(_LoadNextPageSecurityAmounts value)
        loadNextPageSecurityAmounts,
  }) {
    return loadSecurityAmounts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSecurityAmounts value)? loadSecurityAmounts,
    TResult? Function(_LoadNextPageSecurityAmounts value)?
        loadNextPageSecurityAmounts,
  }) {
    return loadSecurityAmounts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSecurityAmounts value)? loadSecurityAmounts,
    TResult Function(_LoadNextPageSecurityAmounts value)?
        loadNextPageSecurityAmounts,
    required TResult orElse(),
  }) {
    if (loadSecurityAmounts != null) {
      return loadSecurityAmounts(this);
    }
    return orElse();
  }
}

abstract class _LoadSecurityAmounts implements LedgerSecurityAmountsEvent {
  const factory _LoadSecurityAmounts({final int? clientId}) =
      _$LoadSecurityAmountsImpl;

  int? get clientId;

  /// Create a copy of LedgerSecurityAmountsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadSecurityAmountsImplCopyWith<_$LoadSecurityAmountsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPageSecurityAmountsImplCopyWith<$Res> {
  factory _$$LoadNextPageSecurityAmountsImplCopyWith(
          _$LoadNextPageSecurityAmountsImpl value,
          $Res Function(_$LoadNextPageSecurityAmountsImpl) then) =
      __$$LoadNextPageSecurityAmountsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPageSecurityAmountsImplCopyWithImpl<$Res>
    extends _$LedgerSecurityAmountsEventCopyWithImpl<$Res,
        _$LoadNextPageSecurityAmountsImpl>
    implements _$$LoadNextPageSecurityAmountsImplCopyWith<$Res> {
  __$$LoadNextPageSecurityAmountsImplCopyWithImpl(
      _$LoadNextPageSecurityAmountsImpl _value,
      $Res Function(_$LoadNextPageSecurityAmountsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LedgerSecurityAmountsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageSecurityAmountsImpl
    implements _LoadNextPageSecurityAmounts {
  const _$LoadNextPageSecurityAmountsImpl();

  @override
  String toString() {
    return 'LedgerSecurityAmountsEvent.loadNextPageSecurityAmounts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextPageSecurityAmountsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadSecurityAmounts,
    required TResult Function() loadNextPageSecurityAmounts,
  }) {
    return loadNextPageSecurityAmounts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadSecurityAmounts,
    TResult? Function()? loadNextPageSecurityAmounts,
  }) {
    return loadNextPageSecurityAmounts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadSecurityAmounts,
    TResult Function()? loadNextPageSecurityAmounts,
    required TResult orElse(),
  }) {
    if (loadNextPageSecurityAmounts != null) {
      return loadNextPageSecurityAmounts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSecurityAmounts value) loadSecurityAmounts,
    required TResult Function(_LoadNextPageSecurityAmounts value)
        loadNextPageSecurityAmounts,
  }) {
    return loadNextPageSecurityAmounts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSecurityAmounts value)? loadSecurityAmounts,
    TResult? Function(_LoadNextPageSecurityAmounts value)?
        loadNextPageSecurityAmounts,
  }) {
    return loadNextPageSecurityAmounts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSecurityAmounts value)? loadSecurityAmounts,
    TResult Function(_LoadNextPageSecurityAmounts value)?
        loadNextPageSecurityAmounts,
    required TResult orElse(),
  }) {
    if (loadNextPageSecurityAmounts != null) {
      return loadNextPageSecurityAmounts(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageSecurityAmounts
    implements LedgerSecurityAmountsEvent {
  const factory _LoadNextPageSecurityAmounts() =
      _$LoadNextPageSecurityAmountsImpl;
}

/// @nodoc
mixin _$LedgerSecurityAmountsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
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
abstract class $LedgerSecurityAmountsStateCopyWith<$Res> {
  factory $LedgerSecurityAmountsStateCopyWith(LedgerSecurityAmountsState value,
          $Res Function(LedgerSecurityAmountsState) then) =
      _$LedgerSecurityAmountsStateCopyWithImpl<$Res,
          LedgerSecurityAmountsState>;
}

/// @nodoc
class _$LedgerSecurityAmountsStateCopyWithImpl<$Res,
        $Val extends LedgerSecurityAmountsState>
    implements $LedgerSecurityAmountsStateCopyWith<$Res> {
  _$LedgerSecurityAmountsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerSecurityAmountsState
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
    extends _$LedgerSecurityAmountsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of LedgerSecurityAmountsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'LedgerSecurityAmountsState.loading()';
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
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)
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
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
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
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
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

abstract class _Loading implements LedgerSecurityAmountsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$LedgerSecurityAmountsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LedgerSecurityAmountsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ledgerSecurityAmounts = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? clientId = freezed,
    Object? isFirstFetch = null,
  }) {
    return _then(_$LoadedImpl(
      ledgerSecurityAmounts: null == ledgerSecurityAmounts
          ? _value._ledgerSecurityAmounts
          : ledgerSecurityAmounts // ignore: cast_nullable_to_non_nullable
              as List<LedgerSecurityAmountDailyModel>,
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
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<LedgerSecurityAmountDailyModel>
          ledgerSecurityAmounts,
      required this.nextPageUrl,
      this.isPaginating = false,
      this.clientId,
      this.isFirstFetch = false})
      : _ledgerSecurityAmounts = ledgerSecurityAmounts;

  final List<LedgerSecurityAmountDailyModel> _ledgerSecurityAmounts;
  @override
  List<LedgerSecurityAmountDailyModel> get ledgerSecurityAmounts {
    if (_ledgerSecurityAmounts is EqualUnmodifiableListView)
      return _ledgerSecurityAmounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ledgerSecurityAmounts);
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
    return 'LedgerSecurityAmountsState.loaded(ledgerSecurityAmounts: $ledgerSecurityAmounts, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, clientId: $clientId, isFirstFetch: $isFirstFetch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._ledgerSecurityAmounts, _ledgerSecurityAmounts) &&
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
      const DeepCollectionEquality().hash(_ledgerSecurityAmounts),
      nextPageUrl,
      isPaginating,
      clientId,
      isFirstFetch);

  /// Create a copy of LedgerSecurityAmountsState
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
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(ledgerSecurityAmounts, nextPageUrl, isPaginating, clientId,
        isFirstFetch);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(ledgerSecurityAmounts, nextPageUrl, isPaginating,
        clientId, isFirstFetch);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(ledgerSecurityAmounts, nextPageUrl, isPaginating, clientId,
          isFirstFetch);
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

abstract class _Loaded implements LedgerSecurityAmountsState {
  const factory _Loaded(
      {required final List<LedgerSecurityAmountDailyModel>
          ledgerSecurityAmounts,
      required final String? nextPageUrl,
      final bool isPaginating,
      final int? clientId,
      final bool isFirstFetch}) = _$LoadedImpl;

  List<LedgerSecurityAmountDailyModel> get ledgerSecurityAmounts;
  String? get nextPageUrl;
  bool get isPaginating;
  int? get clientId;
  bool get isFirstFetch;

  /// Create a copy of LedgerSecurityAmountsState
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
    extends _$LedgerSecurityAmountsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of LedgerSecurityAmountsState
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
    return 'LedgerSecurityAmountsState.error(error: $error)';
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

  /// Create a copy of LedgerSecurityAmountsState
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
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)
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
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
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
            List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
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

abstract class _Error implements LedgerSecurityAmountsState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of LedgerSecurityAmountsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
