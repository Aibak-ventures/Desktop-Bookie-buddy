// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_payments_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletPaymentsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadPayments,
    required TResult Function() loadNextPagePayments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadPayments,
    TResult? Function()? loadNextPagePayments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadPayments,
    TResult Function()? loadNextPagePayments,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPayments value) loadPayments,
    required TResult Function(_LoadNextPagePayments value) loadNextPagePayments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPayments value)? loadPayments,
    TResult? Function(_LoadNextPagePayments value)? loadNextPagePayments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPayments value)? loadPayments,
    TResult Function(_LoadNextPagePayments value)? loadNextPagePayments,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletPaymentsEventCopyWith<$Res> {
  factory $WalletPaymentsEventCopyWith(
          WalletPaymentsEvent value, $Res Function(WalletPaymentsEvent) then) =
      _$WalletPaymentsEventCopyWithImpl<$Res, WalletPaymentsEvent>;
}

/// @nodoc
class _$WalletPaymentsEventCopyWithImpl<$Res, $Val extends WalletPaymentsEvent>
    implements $WalletPaymentsEventCopyWith<$Res> {
  _$WalletPaymentsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletPaymentsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadPaymentsImplCopyWith<$Res> {
  factory _$$LoadPaymentsImplCopyWith(
          _$LoadPaymentsImpl value, $Res Function(_$LoadPaymentsImpl) then) =
      __$$LoadPaymentsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? clientId});
}

/// @nodoc
class __$$LoadPaymentsImplCopyWithImpl<$Res>
    extends _$WalletPaymentsEventCopyWithImpl<$Res, _$LoadPaymentsImpl>
    implements _$$LoadPaymentsImplCopyWith<$Res> {
  __$$LoadPaymentsImplCopyWithImpl(
      _$LoadPaymentsImpl _value, $Res Function(_$LoadPaymentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPaymentsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = freezed,
  }) {
    return _then(_$LoadPaymentsImpl(
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$LoadPaymentsImpl implements _LoadPayments {
  const _$LoadPaymentsImpl({this.clientId});

  @override
  final int? clientId;

  @override
  String toString() {
    return 'WalletPaymentsEvent.loadPayments(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPaymentsImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of WalletPaymentsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadPaymentsImplCopyWith<_$LoadPaymentsImpl> get copyWith =>
      __$$LoadPaymentsImplCopyWithImpl<_$LoadPaymentsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadPayments,
    required TResult Function() loadNextPagePayments,
  }) {
    return loadPayments(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadPayments,
    TResult? Function()? loadNextPagePayments,
  }) {
    return loadPayments?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadPayments,
    TResult Function()? loadNextPagePayments,
    required TResult orElse(),
  }) {
    if (loadPayments != null) {
      return loadPayments(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPayments value) loadPayments,
    required TResult Function(_LoadNextPagePayments value) loadNextPagePayments,
  }) {
    return loadPayments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPayments value)? loadPayments,
    TResult? Function(_LoadNextPagePayments value)? loadNextPagePayments,
  }) {
    return loadPayments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPayments value)? loadPayments,
    TResult Function(_LoadNextPagePayments value)? loadNextPagePayments,
    required TResult orElse(),
  }) {
    if (loadPayments != null) {
      return loadPayments(this);
    }
    return orElse();
  }
}

abstract class _LoadPayments implements WalletPaymentsEvent {
  const factory _LoadPayments({final int? clientId}) = _$LoadPaymentsImpl;

  int? get clientId;

  /// Create a copy of WalletPaymentsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadPaymentsImplCopyWith<_$LoadPaymentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPagePaymentsImplCopyWith<$Res> {
  factory _$$LoadNextPagePaymentsImplCopyWith(_$LoadNextPagePaymentsImpl value,
          $Res Function(_$LoadNextPagePaymentsImpl) then) =
      __$$LoadNextPagePaymentsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPagePaymentsImplCopyWithImpl<$Res>
    extends _$WalletPaymentsEventCopyWithImpl<$Res, _$LoadNextPagePaymentsImpl>
    implements _$$LoadNextPagePaymentsImplCopyWith<$Res> {
  __$$LoadNextPagePaymentsImplCopyWithImpl(_$LoadNextPagePaymentsImpl _value,
      $Res Function(_$LoadNextPagePaymentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPaymentsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPagePaymentsImpl implements _LoadNextPagePayments {
  const _$LoadNextPagePaymentsImpl();

  @override
  String toString() {
    return 'WalletPaymentsEvent.loadNextPagePayments()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextPagePaymentsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadPayments,
    required TResult Function() loadNextPagePayments,
  }) {
    return loadNextPagePayments();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadPayments,
    TResult? Function()? loadNextPagePayments,
  }) {
    return loadNextPagePayments?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadPayments,
    TResult Function()? loadNextPagePayments,
    required TResult orElse(),
  }) {
    if (loadNextPagePayments != null) {
      return loadNextPagePayments();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPayments value) loadPayments,
    required TResult Function(_LoadNextPagePayments value) loadNextPagePayments,
  }) {
    return loadNextPagePayments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPayments value)? loadPayments,
    TResult? Function(_LoadNextPagePayments value)? loadNextPagePayments,
  }) {
    return loadNextPagePayments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPayments value)? loadPayments,
    TResult Function(_LoadNextPagePayments value)? loadNextPagePayments,
    required TResult orElse(),
  }) {
    if (loadNextPagePayments != null) {
      return loadNextPagePayments(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPagePayments implements WalletPaymentsEvent {
  const factory _LoadNextPagePayments() = _$LoadNextPagePaymentsImpl;
}

/// @nodoc
mixin _$WalletPaymentsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)?
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
abstract class $WalletPaymentsStateCopyWith<$Res> {
  factory $WalletPaymentsStateCopyWith(
          WalletPaymentsState value, $Res Function(WalletPaymentsState) then) =
      _$WalletPaymentsStateCopyWithImpl<$Res, WalletPaymentsState>;
}

/// @nodoc
class _$WalletPaymentsStateCopyWithImpl<$Res, $Val extends WalletPaymentsState>
    implements $WalletPaymentsStateCopyWith<$Res> {
  _$WalletPaymentsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletPaymentsState
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
    extends _$WalletPaymentsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPaymentsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'WalletPaymentsState.loading()';
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
    required TResult Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)?
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

abstract class _Loading implements WalletPaymentsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<MonthlyPaymentsModel> paymentHistory,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$WalletPaymentsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPaymentsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentHistory = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? clientId = freezed,
  }) {
    return _then(_$LoadedImpl(
      paymentHistory: null == paymentHistory
          ? _value._paymentHistory
          : paymentHistory // ignore: cast_nullable_to_non_nullable
              as List<MonthlyPaymentsModel>,
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
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<MonthlyPaymentsModel> paymentHistory,
      required this.nextPageUrl,
      this.isPaginating = false,
      this.clientId})
      : _paymentHistory = paymentHistory;

  final List<MonthlyPaymentsModel> _paymentHistory;
  @override
  List<MonthlyPaymentsModel> get paymentHistory {
    if (_paymentHistory is EqualUnmodifiableListView) return _paymentHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentHistory);
  }

  @override
  final String? nextPageUrl;
  @override
  @JsonKey()
  final bool isPaginating;
  @override
  final int? clientId;

  @override
  String toString() {
    return 'WalletPaymentsState.loaded(paymentHistory: $paymentHistory, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._paymentHistory, _paymentHistory) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.isPaginating, isPaginating) ||
                other.isPaginating == isPaginating) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_paymentHistory),
      nextPageUrl,
      isPaginating,
      clientId);

  /// Create a copy of WalletPaymentsState
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
    required TResult Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(paymentHistory, nextPageUrl, isPaginating, clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(paymentHistory, nextPageUrl, isPaginating, clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(paymentHistory, nextPageUrl, isPaginating, clientId);
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

abstract class _Loaded implements WalletPaymentsState {
  const factory _Loaded(
      {required final List<MonthlyPaymentsModel> paymentHistory,
      required final String? nextPageUrl,
      final bool isPaginating,
      final int? clientId}) = _$LoadedImpl;

  List<MonthlyPaymentsModel> get paymentHistory;
  String? get nextPageUrl;
  bool get isPaginating;
  int? get clientId;

  /// Create a copy of WalletPaymentsState
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
    extends _$WalletPaymentsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPaymentsState
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
    return 'WalletPaymentsState.error(error: $error)';
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

  /// Create a copy of WalletPaymentsState
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
    required TResult Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<MonthlyPaymentsModel> paymentHistory,
            String? nextPageUrl, bool isPaginating, int? clientId)?
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

abstract class _Error implements WalletPaymentsState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of WalletPaymentsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
