// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SalesDetailsEvent {
  int get saleId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int saleId) fetchSaleDetails,
    required TResult Function(int saleId) deleteSale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int saleId)? fetchSaleDetails,
    TResult? Function(int saleId)? deleteSale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int saleId)? fetchSaleDetails,
    TResult Function(int saleId)? deleteSale,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchSaleDetails value) fetchSaleDetails,
    required TResult Function(_DeleteSale value) deleteSale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchSaleDetails value)? fetchSaleDetails,
    TResult? Function(_DeleteSale value)? deleteSale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchSaleDetails value)? fetchSaleDetails,
    TResult Function(_DeleteSale value)? deleteSale,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of SalesDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesDetailsEventCopyWith<SalesDetailsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesDetailsEventCopyWith<$Res> {
  factory $SalesDetailsEventCopyWith(
          SalesDetailsEvent value, $Res Function(SalesDetailsEvent) then) =
      _$SalesDetailsEventCopyWithImpl<$Res, SalesDetailsEvent>;
  @useResult
  $Res call({int saleId});
}

/// @nodoc
class _$SalesDetailsEventCopyWithImpl<$Res, $Val extends SalesDetailsEvent>
    implements $SalesDetailsEventCopyWith<$Res> {
  _$SalesDetailsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleId = null,
  }) {
    return _then(_value.copyWith(
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FetchSaleDetailsImplCopyWith<$Res>
    implements $SalesDetailsEventCopyWith<$Res> {
  factory _$$FetchSaleDetailsImplCopyWith(_$FetchSaleDetailsImpl value,
          $Res Function(_$FetchSaleDetailsImpl) then) =
      __$$FetchSaleDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int saleId});
}

/// @nodoc
class __$$FetchSaleDetailsImplCopyWithImpl<$Res>
    extends _$SalesDetailsEventCopyWithImpl<$Res, _$FetchSaleDetailsImpl>
    implements _$$FetchSaleDetailsImplCopyWith<$Res> {
  __$$FetchSaleDetailsImplCopyWithImpl(_$FetchSaleDetailsImpl _value,
      $Res Function(_$FetchSaleDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleId = null,
  }) {
    return _then(_$FetchSaleDetailsImpl(
      null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FetchSaleDetailsImpl implements _FetchSaleDetails {
  const _$FetchSaleDetailsImpl(this.saleId);

  @override
  final int saleId;

  @override
  String toString() {
    return 'SalesDetailsEvent.fetchSaleDetails(saleId: $saleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchSaleDetailsImpl &&
            (identical(other.saleId, saleId) || other.saleId == saleId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saleId);

  /// Create a copy of SalesDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchSaleDetailsImplCopyWith<_$FetchSaleDetailsImpl> get copyWith =>
      __$$FetchSaleDetailsImplCopyWithImpl<_$FetchSaleDetailsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int saleId) fetchSaleDetails,
    required TResult Function(int saleId) deleteSale,
  }) {
    return fetchSaleDetails(saleId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int saleId)? fetchSaleDetails,
    TResult? Function(int saleId)? deleteSale,
  }) {
    return fetchSaleDetails?.call(saleId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int saleId)? fetchSaleDetails,
    TResult Function(int saleId)? deleteSale,
    required TResult orElse(),
  }) {
    if (fetchSaleDetails != null) {
      return fetchSaleDetails(saleId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchSaleDetails value) fetchSaleDetails,
    required TResult Function(_DeleteSale value) deleteSale,
  }) {
    return fetchSaleDetails(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchSaleDetails value)? fetchSaleDetails,
    TResult? Function(_DeleteSale value)? deleteSale,
  }) {
    return fetchSaleDetails?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchSaleDetails value)? fetchSaleDetails,
    TResult Function(_DeleteSale value)? deleteSale,
    required TResult orElse(),
  }) {
    if (fetchSaleDetails != null) {
      return fetchSaleDetails(this);
    }
    return orElse();
  }
}

abstract class _FetchSaleDetails implements SalesDetailsEvent {
  const factory _FetchSaleDetails(final int saleId) = _$FetchSaleDetailsImpl;

  @override
  int get saleId;

  /// Create a copy of SalesDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchSaleDetailsImplCopyWith<_$FetchSaleDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteSaleImplCopyWith<$Res>
    implements $SalesDetailsEventCopyWith<$Res> {
  factory _$$DeleteSaleImplCopyWith(
          _$DeleteSaleImpl value, $Res Function(_$DeleteSaleImpl) then) =
      __$$DeleteSaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int saleId});
}

/// @nodoc
class __$$DeleteSaleImplCopyWithImpl<$Res>
    extends _$SalesDetailsEventCopyWithImpl<$Res, _$DeleteSaleImpl>
    implements _$$DeleteSaleImplCopyWith<$Res> {
  __$$DeleteSaleImplCopyWithImpl(
      _$DeleteSaleImpl _value, $Res Function(_$DeleteSaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleId = null,
  }) {
    return _then(_$DeleteSaleImpl(
      null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DeleteSaleImpl implements _DeleteSale {
  const _$DeleteSaleImpl(this.saleId);

  @override
  final int saleId;

  @override
  String toString() {
    return 'SalesDetailsEvent.deleteSale(saleId: $saleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteSaleImpl &&
            (identical(other.saleId, saleId) || other.saleId == saleId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saleId);

  /// Create a copy of SalesDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteSaleImplCopyWith<_$DeleteSaleImpl> get copyWith =>
      __$$DeleteSaleImplCopyWithImpl<_$DeleteSaleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int saleId) fetchSaleDetails,
    required TResult Function(int saleId) deleteSale,
  }) {
    return deleteSale(saleId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int saleId)? fetchSaleDetails,
    TResult? Function(int saleId)? deleteSale,
  }) {
    return deleteSale?.call(saleId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int saleId)? fetchSaleDetails,
    TResult Function(int saleId)? deleteSale,
    required TResult orElse(),
  }) {
    if (deleteSale != null) {
      return deleteSale(saleId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchSaleDetails value) fetchSaleDetails,
    required TResult Function(_DeleteSale value) deleteSale,
  }) {
    return deleteSale(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchSaleDetails value)? fetchSaleDetails,
    TResult? Function(_DeleteSale value)? deleteSale,
  }) {
    return deleteSale?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchSaleDetails value)? fetchSaleDetails,
    TResult Function(_DeleteSale value)? deleteSale,
    required TResult orElse(),
  }) {
    if (deleteSale != null) {
      return deleteSale(this);
    }
    return orElse();
  }
}

abstract class _DeleteSale implements SalesDetailsEvent {
  const factory _DeleteSale(final int saleId) = _$DeleteSaleImpl;

  @override
  int get saleId;

  /// Create a copy of SalesDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteSaleImplCopyWith<_$DeleteSaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SalesDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SaleDetailsModel sale) loaded,
    required TResult Function(String message) error,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SaleDetailsModel sale)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SaleDetailsModel sale)? loaded,
    TResult Function(String message)? error,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesDetailsStateCopyWith<$Res> {
  factory $SalesDetailsStateCopyWith(
          SalesDetailsState value, $Res Function(SalesDetailsState) then) =
      _$SalesDetailsStateCopyWithImpl<$Res, SalesDetailsState>;
}

/// @nodoc
class _$SalesDetailsStateCopyWithImpl<$Res, $Val extends SalesDetailsState>
    implements $SalesDetailsStateCopyWith<$Res> {
  _$SalesDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SalesDetailsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SalesDetailsState.initial()';
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
    required TResult Function(SaleDetailsModel sale) loaded,
    required TResult Function(String message) error,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SaleDetailsModel sale)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SaleDetailsModel sale)? loaded,
    TResult Function(String message)? error,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
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
    required TResult Function(_Success value) success,
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
    TResult? Function(_Success value)? success,
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
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SalesDetailsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SalesDetailsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'SalesDetailsState.loading()';
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
    required TResult Function(SaleDetailsModel sale) loaded,
    required TResult Function(String message) error,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SaleDetailsModel sale)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SaleDetailsModel sale)? loaded,
    TResult Function(String message)? error,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
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
    required TResult Function(_Success value) success,
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
    TResult? Function(_Success value)? success,
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
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements SalesDetailsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SaleDetailsModel sale});

  $SaleDetailsModelCopyWith<$Res> get sale;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$SalesDetailsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sale = null,
  }) {
    return _then(_$LoadedImpl(
      sale: null == sale
          ? _value.sale
          : sale // ignore: cast_nullable_to_non_nullable
              as SaleDetailsModel,
    ));
  }

  /// Create a copy of SalesDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SaleDetailsModelCopyWith<$Res> get sale {
    return $SaleDetailsModelCopyWith<$Res>(_value.sale, (value) {
      return _then(_value.copyWith(sale: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({required this.sale});

  @override
  final SaleDetailsModel sale;

  @override
  String toString() {
    return 'SalesDetailsState.loaded(sale: $sale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.sale, sale) || other.sale == sale));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sale);

  /// Create a copy of SalesDetailsState
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
    required TResult Function(SaleDetailsModel sale) loaded,
    required TResult Function(String message) error,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
  }) {
    return loaded(sale);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SaleDetailsModel sale)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) {
    return loaded?.call(sale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SaleDetailsModel sale)? loaded,
    TResult Function(String message)? error,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(sale);
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
    required TResult Function(_Success value) success,
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
    TResult? Function(_Success value)? success,
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
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements SalesDetailsState {
  const factory _Loaded({required final SaleDetailsModel sale}) = _$LoadedImpl;

  SaleDetailsModel get sale;

  /// Create a copy of SalesDetailsState
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
    extends _$SalesDetailsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesDetailsState
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
    return 'SalesDetailsState.error(message: $message)';
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

  /// Create a copy of SalesDetailsState
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
    required TResult Function(SaleDetailsModel sale) loaded,
    required TResult Function(String message) error,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SaleDetailsModel sale)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SaleDetailsModel sale)? loaded,
    TResult Function(String message)? error,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Success value) success,
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
    TResult? Function(_Success value)? success,
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
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SalesDetailsState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of SalesDetailsState
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
  $Res call({String message, bool didPop, bool needRefresh});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$SalesDetailsStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? didPop = null,
    Object? needRefresh = null,
  }) {
    return _then(_$SuccessImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      didPop: null == didPop
          ? _value.didPop
          : didPop // ignore: cast_nullable_to_non_nullable
              as bool,
      needRefresh: null == needRefresh
          ? _value.needRefresh
          : needRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(
      {required this.message, this.didPop = false, this.needRefresh = false});

  @override
  final String message;
  @override
  @JsonKey()
  final bool didPop;
  @override
  @JsonKey()
  final bool needRefresh;

  @override
  String toString() {
    return 'SalesDetailsState.success(message: $message, didPop: $didPop, needRefresh: $needRefresh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.didPop, didPop) || other.didPop == didPop) &&
            (identical(other.needRefresh, needRefresh) ||
                other.needRefresh == needRefresh));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, didPop, needRefresh);

  /// Create a copy of SalesDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SaleDetailsModel sale) loaded,
    required TResult Function(String message) error,
    required TResult Function(String message, bool didPop, bool needRefresh)
        success,
  }) {
    return success(message, didPop, needRefresh);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SaleDetailsModel sale)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message, bool didPop, bool needRefresh)? success,
  }) {
    return success?.call(message, didPop, needRefresh);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SaleDetailsModel sale)? loaded,
    TResult Function(String message)? error,
    TResult Function(String message, bool didPop, bool needRefresh)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message, didPop, needRefresh);
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
    required TResult Function(_Success value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Success value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements SalesDetailsState {
  const factory _Success(
      {required final String message,
      final bool didPop,
      final bool needRefresh}) = _$SuccessImpl;

  String get message;
  bool get didPop;
  bool get needRefresh;

  /// Create a copy of SalesDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
