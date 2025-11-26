// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_expense_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletExpenseEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadExpense,
    required TResult Function() loadNextPageExpense,
    required TResult Function(int expenseId, int? variantId) deleteExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadExpense,
    TResult? Function()? loadNextPageExpense,
    TResult? Function(int expenseId, int? variantId)? deleteExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadExpense,
    TResult Function()? loadNextPageExpense,
    TResult Function(int expenseId, int? variantId)? deleteExpense,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadExpense value) loadExpense,
    required TResult Function(_LoadNextPageExpense value) loadNextPageExpense,
    required TResult Function(_DeleteExpense value) deleteExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadExpense value)? loadExpense,
    TResult? Function(_LoadNextPageExpense value)? loadNextPageExpense,
    TResult? Function(_DeleteExpense value)? deleteExpense,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadExpense value)? loadExpense,
    TResult Function(_LoadNextPageExpense value)? loadNextPageExpense,
    TResult Function(_DeleteExpense value)? deleteExpense,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletExpenseEventCopyWith<$Res> {
  factory $WalletExpenseEventCopyWith(
          WalletExpenseEvent value, $Res Function(WalletExpenseEvent) then) =
      _$WalletExpenseEventCopyWithImpl<$Res, WalletExpenseEvent>;
}

/// @nodoc
class _$WalletExpenseEventCopyWithImpl<$Res, $Val extends WalletExpenseEvent>
    implements $WalletExpenseEventCopyWith<$Res> {
  _$WalletExpenseEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadExpenseImplCopyWith<$Res> {
  factory _$$LoadExpenseImplCopyWith(
          _$LoadExpenseImpl value, $Res Function(_$LoadExpenseImpl) then) =
      __$$LoadExpenseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? clientId});
}

/// @nodoc
class __$$LoadExpenseImplCopyWithImpl<$Res>
    extends _$WalletExpenseEventCopyWithImpl<$Res, _$LoadExpenseImpl>
    implements _$$LoadExpenseImplCopyWith<$Res> {
  __$$LoadExpenseImplCopyWithImpl(
      _$LoadExpenseImpl _value, $Res Function(_$LoadExpenseImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = freezed,
  }) {
    return _then(_$LoadExpenseImpl(
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$LoadExpenseImpl implements _LoadExpense {
  const _$LoadExpenseImpl({this.clientId});

  @override
  final int? clientId;

  @override
  String toString() {
    return 'WalletExpenseEvent.loadExpense(clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadExpenseImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId);

  /// Create a copy of WalletExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadExpenseImplCopyWith<_$LoadExpenseImpl> get copyWith =>
      __$$LoadExpenseImplCopyWithImpl<_$LoadExpenseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadExpense,
    required TResult Function() loadNextPageExpense,
    required TResult Function(int expenseId, int? variantId) deleteExpense,
  }) {
    return loadExpense(clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadExpense,
    TResult? Function()? loadNextPageExpense,
    TResult? Function(int expenseId, int? variantId)? deleteExpense,
  }) {
    return loadExpense?.call(clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadExpense,
    TResult Function()? loadNextPageExpense,
    TResult Function(int expenseId, int? variantId)? deleteExpense,
    required TResult orElse(),
  }) {
    if (loadExpense != null) {
      return loadExpense(clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadExpense value) loadExpense,
    required TResult Function(_LoadNextPageExpense value) loadNextPageExpense,
    required TResult Function(_DeleteExpense value) deleteExpense,
  }) {
    return loadExpense(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadExpense value)? loadExpense,
    TResult? Function(_LoadNextPageExpense value)? loadNextPageExpense,
    TResult? Function(_DeleteExpense value)? deleteExpense,
  }) {
    return loadExpense?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadExpense value)? loadExpense,
    TResult Function(_LoadNextPageExpense value)? loadNextPageExpense,
    TResult Function(_DeleteExpense value)? deleteExpense,
    required TResult orElse(),
  }) {
    if (loadExpense != null) {
      return loadExpense(this);
    }
    return orElse();
  }
}

abstract class _LoadExpense implements WalletExpenseEvent {
  const factory _LoadExpense({final int? clientId}) = _$LoadExpenseImpl;

  int? get clientId;

  /// Create a copy of WalletExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadExpenseImplCopyWith<_$LoadExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPageExpenseImplCopyWith<$Res> {
  factory _$$LoadNextPageExpenseImplCopyWith(_$LoadNextPageExpenseImpl value,
          $Res Function(_$LoadNextPageExpenseImpl) then) =
      __$$LoadNextPageExpenseImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPageExpenseImplCopyWithImpl<$Res>
    extends _$WalletExpenseEventCopyWithImpl<$Res, _$LoadNextPageExpenseImpl>
    implements _$$LoadNextPageExpenseImplCopyWith<$Res> {
  __$$LoadNextPageExpenseImplCopyWithImpl(_$LoadNextPageExpenseImpl _value,
      $Res Function(_$LoadNextPageExpenseImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageExpenseImpl implements _LoadNextPageExpense {
  const _$LoadNextPageExpenseImpl();

  @override
  String toString() {
    return 'WalletExpenseEvent.loadNextPageExpense()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextPageExpenseImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadExpense,
    required TResult Function() loadNextPageExpense,
    required TResult Function(int expenseId, int? variantId) deleteExpense,
  }) {
    return loadNextPageExpense();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadExpense,
    TResult? Function()? loadNextPageExpense,
    TResult? Function(int expenseId, int? variantId)? deleteExpense,
  }) {
    return loadNextPageExpense?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadExpense,
    TResult Function()? loadNextPageExpense,
    TResult Function(int expenseId, int? variantId)? deleteExpense,
    required TResult orElse(),
  }) {
    if (loadNextPageExpense != null) {
      return loadNextPageExpense();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadExpense value) loadExpense,
    required TResult Function(_LoadNextPageExpense value) loadNextPageExpense,
    required TResult Function(_DeleteExpense value) deleteExpense,
  }) {
    return loadNextPageExpense(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadExpense value)? loadExpense,
    TResult? Function(_LoadNextPageExpense value)? loadNextPageExpense,
    TResult? Function(_DeleteExpense value)? deleteExpense,
  }) {
    return loadNextPageExpense?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadExpense value)? loadExpense,
    TResult Function(_LoadNextPageExpense value)? loadNextPageExpense,
    TResult Function(_DeleteExpense value)? deleteExpense,
    required TResult orElse(),
  }) {
    if (loadNextPageExpense != null) {
      return loadNextPageExpense(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageExpense implements WalletExpenseEvent {
  const factory _LoadNextPageExpense() = _$LoadNextPageExpenseImpl;
}

/// @nodoc
abstract class _$$DeleteExpenseImplCopyWith<$Res> {
  factory _$$DeleteExpenseImplCopyWith(
          _$DeleteExpenseImpl value, $Res Function(_$DeleteExpenseImpl) then) =
      __$$DeleteExpenseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int expenseId, int? variantId});
}

/// @nodoc
class __$$DeleteExpenseImplCopyWithImpl<$Res>
    extends _$WalletExpenseEventCopyWithImpl<$Res, _$DeleteExpenseImpl>
    implements _$$DeleteExpenseImplCopyWith<$Res> {
  __$$DeleteExpenseImplCopyWithImpl(
      _$DeleteExpenseImpl _value, $Res Function(_$DeleteExpenseImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseId = null,
    Object? variantId = freezed,
  }) {
    return _then(_$DeleteExpenseImpl(
      expenseId: null == expenseId
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as int,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$DeleteExpenseImpl implements _DeleteExpense {
  const _$DeleteExpenseImpl({required this.expenseId, required this.variantId});

  @override
  final int expenseId;
  @override
  final int? variantId;

  @override
  String toString() {
    return 'WalletExpenseEvent.deleteExpense(expenseId: $expenseId, variantId: $variantId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteExpenseImpl &&
            (identical(other.expenseId, expenseId) ||
                other.expenseId == expenseId) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, expenseId, variantId);

  /// Create a copy of WalletExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteExpenseImplCopyWith<_$DeleteExpenseImpl> get copyWith =>
      __$$DeleteExpenseImplCopyWithImpl<_$DeleteExpenseImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? clientId) loadExpense,
    required TResult Function() loadNextPageExpense,
    required TResult Function(int expenseId, int? variantId) deleteExpense,
  }) {
    return deleteExpense(expenseId, variantId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? clientId)? loadExpense,
    TResult? Function()? loadNextPageExpense,
    TResult? Function(int expenseId, int? variantId)? deleteExpense,
  }) {
    return deleteExpense?.call(expenseId, variantId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? clientId)? loadExpense,
    TResult Function()? loadNextPageExpense,
    TResult Function(int expenseId, int? variantId)? deleteExpense,
    required TResult orElse(),
  }) {
    if (deleteExpense != null) {
      return deleteExpense(expenseId, variantId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadExpense value) loadExpense,
    required TResult Function(_LoadNextPageExpense value) loadNextPageExpense,
    required TResult Function(_DeleteExpense value) deleteExpense,
  }) {
    return deleteExpense(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadExpense value)? loadExpense,
    TResult? Function(_LoadNextPageExpense value)? loadNextPageExpense,
    TResult? Function(_DeleteExpense value)? deleteExpense,
  }) {
    return deleteExpense?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadExpense value)? loadExpense,
    TResult Function(_LoadNextPageExpense value)? loadNextPageExpense,
    TResult Function(_DeleteExpense value)? deleteExpense,
    required TResult orElse(),
  }) {
    if (deleteExpense != null) {
      return deleteExpense(this);
    }
    return orElse();
  }
}

abstract class _DeleteExpense implements WalletExpenseEvent {
  const factory _DeleteExpense(
      {required final int expenseId,
      required final int? variantId}) = _$DeleteExpenseImpl;

  int get expenseId;
  int? get variantId;

  /// Create a copy of WalletExpenseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteExpenseImplCopyWith<_$DeleteExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletExpenseState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)
        loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) success,
    required TResult Function(String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? success,
    TResult? Function(String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletExpenseStateCopyWith<$Res> {
  factory $WalletExpenseStateCopyWith(
          WalletExpenseState value, $Res Function(WalletExpenseState) then) =
      _$WalletExpenseStateCopyWithImpl<$Res, WalletExpenseState>;
}

/// @nodoc
class _$WalletExpenseStateCopyWithImpl<$Res, $Val extends WalletExpenseState>
    implements $WalletExpenseStateCopyWith<$Res> {
  _$WalletExpenseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletExpenseState
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
    extends _$WalletExpenseStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletExpenseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'WalletExpenseState.loading()';
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
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)
        loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) success,
    required TResult Function(String message) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? success,
    TResult? Function(String message)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? success,
    TResult Function(String message)? failure,
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
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements WalletExpenseState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<LedgerExpenseDailyModel> expenseGroupedList,
      String? nextPageUrl,
      bool isPaginating,
      int? clientId,
      bool isFirstFetch});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$WalletExpenseStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseGroupedList = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? clientId = freezed,
    Object? isFirstFetch = null,
  }) {
    return _then(_$LoadedImpl(
      expenseGroupedList: null == expenseGroupedList
          ? _value._expenseGroupedList
          : expenseGroupedList // ignore: cast_nullable_to_non_nullable
              as List<LedgerExpenseDailyModel>,
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
      {required final List<LedgerExpenseDailyModel> expenseGroupedList,
      required this.nextPageUrl,
      this.isPaginating = false,
      this.clientId,
      this.isFirstFetch = false})
      : _expenseGroupedList = expenseGroupedList;

  final List<LedgerExpenseDailyModel> _expenseGroupedList;
  @override
  List<LedgerExpenseDailyModel> get expenseGroupedList {
    if (_expenseGroupedList is EqualUnmodifiableListView)
      return _expenseGroupedList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenseGroupedList);
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
    return 'WalletExpenseState.loaded(expenseGroupedList: $expenseGroupedList, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, clientId: $clientId, isFirstFetch: $isFirstFetch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._expenseGroupedList, _expenseGroupedList) &&
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
      const DeepCollectionEquality().hash(_expenseGroupedList),
      nextPageUrl,
      isPaginating,
      clientId,
      isFirstFetch);

  /// Create a copy of WalletExpenseState
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
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)
        loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) success,
    required TResult Function(String message) failure,
  }) {
    return loaded(
        expenseGroupedList, nextPageUrl, isPaginating, clientId, isFirstFetch);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? success,
    TResult? Function(String message)? failure,
  }) {
    return loaded?.call(
        expenseGroupedList, nextPageUrl, isPaginating, clientId, isFirstFetch);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(expenseGroupedList, nextPageUrl, isPaginating, clientId,
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
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements WalletExpenseState {
  const factory _Loaded(
      {required final List<LedgerExpenseDailyModel> expenseGroupedList,
      required final String? nextPageUrl,
      final bool isPaginating,
      final int? clientId,
      final bool isFirstFetch}) = _$LoadedImpl;

  List<LedgerExpenseDailyModel> get expenseGroupedList;
  String? get nextPageUrl;
  bool get isPaginating;
  int? get clientId;
  bool get isFirstFetch;

  /// Create a copy of WalletExpenseState
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
    extends _$WalletExpenseStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletExpenseState
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
    return 'WalletExpenseState.error(error: $error)';
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

  /// Create a copy of WalletExpenseState
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
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)
        loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) success,
    required TResult Function(String message) failure,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? success,
    TResult? Function(String message)? failure,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? success,
    TResult Function(String message)? failure,
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
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements WalletExpenseState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of WalletExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$WalletExpenseStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SuccessImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'WalletExpenseState.success(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of WalletExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)
        loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) success,
    required TResult Function(String message) failure,
  }) {
    return success(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? success,
    TResult? Function(String message)? failure,
  }) {
    return success?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements WalletExpenseState {
  const factory _Success(final String message) = _$SuccessImpl;

  String get message;

  /// Create a copy of WalletExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$WalletExpenseStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$FailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'WalletExpenseState.failure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of WalletExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)
        loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) success,
    required TResult Function(String message) failure,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? success,
    TResult? Function(String message)? failure,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<LedgerExpenseDailyModel> expenseGroupedList,
            String? nextPageUrl,
            bool isPaginating,
            int? clientId,
            bool isFirstFetch)?
        loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements WalletExpenseState {
  const factory _Failure(final String message) = _$FailureImpl;

  String get message;

  /// Create a copy of WalletExpenseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
