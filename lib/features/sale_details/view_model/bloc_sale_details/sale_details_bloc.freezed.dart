// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SaleDetailsEvent {
  int get saleId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int saleId) getSaleDetails,
    required TResult Function(int saleId) deleteSale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int saleId)? getSaleDetails,
    TResult? Function(int saleId)? deleteSale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int saleId)? getSaleDetails,
    TResult Function(int saleId)? deleteSale,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetSaleDetails value) getSaleDetails,
    required TResult Function(_DeleteSale value) deleteSale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetSaleDetails value)? getSaleDetails,
    TResult? Function(_DeleteSale value)? deleteSale,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetSaleDetails value)? getSaleDetails,
    TResult Function(_DeleteSale value)? deleteSale,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of SaleDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleDetailsEventCopyWith<SaleDetailsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleDetailsEventCopyWith<$Res> {
  factory $SaleDetailsEventCopyWith(
          SaleDetailsEvent value, $Res Function(SaleDetailsEvent) then) =
      _$SaleDetailsEventCopyWithImpl<$Res, SaleDetailsEvent>;
  @useResult
  $Res call({int saleId});
}

/// @nodoc
class _$SaleDetailsEventCopyWithImpl<$Res, $Val extends SaleDetailsEvent>
    implements $SaleDetailsEventCopyWith<$Res> {
  _$SaleDetailsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleDetailsEvent
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
abstract class _$$GetSaleDetailsImplCopyWith<$Res>
    implements $SaleDetailsEventCopyWith<$Res> {
  factory _$$GetSaleDetailsImplCopyWith(_$GetSaleDetailsImpl value,
          $Res Function(_$GetSaleDetailsImpl) then) =
      __$$GetSaleDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int saleId});
}

/// @nodoc
class __$$GetSaleDetailsImplCopyWithImpl<$Res>
    extends _$SaleDetailsEventCopyWithImpl<$Res, _$GetSaleDetailsImpl>
    implements _$$GetSaleDetailsImplCopyWith<$Res> {
  __$$GetSaleDetailsImplCopyWithImpl(
      _$GetSaleDetailsImpl _value, $Res Function(_$GetSaleDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleId = null,
  }) {
    return _then(_$GetSaleDetailsImpl(
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GetSaleDetailsImpl implements _GetSaleDetails {
  const _$GetSaleDetailsImpl({required this.saleId});

  @override
  final int saleId;

  @override
  String toString() {
    return 'SaleDetailsEvent.getSaleDetails(saleId: $saleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetSaleDetailsImpl &&
            (identical(other.saleId, saleId) || other.saleId == saleId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saleId);

  /// Create a copy of SaleDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetSaleDetailsImplCopyWith<_$GetSaleDetailsImpl> get copyWith =>
      __$$GetSaleDetailsImplCopyWithImpl<_$GetSaleDetailsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int saleId) getSaleDetails,
    required TResult Function(int saleId) deleteSale,
  }) {
    return getSaleDetails(saleId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int saleId)? getSaleDetails,
    TResult? Function(int saleId)? deleteSale,
  }) {
    return getSaleDetails?.call(saleId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int saleId)? getSaleDetails,
    TResult Function(int saleId)? deleteSale,
    required TResult orElse(),
  }) {
    if (getSaleDetails != null) {
      return getSaleDetails(saleId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetSaleDetails value) getSaleDetails,
    required TResult Function(_DeleteSale value) deleteSale,
  }) {
    return getSaleDetails(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetSaleDetails value)? getSaleDetails,
    TResult? Function(_DeleteSale value)? deleteSale,
  }) {
    return getSaleDetails?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetSaleDetails value)? getSaleDetails,
    TResult Function(_DeleteSale value)? deleteSale,
    required TResult orElse(),
  }) {
    if (getSaleDetails != null) {
      return getSaleDetails(this);
    }
    return orElse();
  }
}

abstract class _GetSaleDetails implements SaleDetailsEvent {
  const factory _GetSaleDetails({required final int saleId}) =
      _$GetSaleDetailsImpl;

  @override
  int get saleId;

  /// Create a copy of SaleDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetSaleDetailsImplCopyWith<_$GetSaleDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteSaleImplCopyWith<$Res>
    implements $SaleDetailsEventCopyWith<$Res> {
  factory _$$DeleteSaleImplCopyWith(
          _$DeleteSaleImpl value, $Res Function(_$DeleteSaleImpl) then) =
      __$$DeleteSaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int saleId});
}

/// @nodoc
class __$$DeleteSaleImplCopyWithImpl<$Res>
    extends _$SaleDetailsEventCopyWithImpl<$Res, _$DeleteSaleImpl>
    implements _$$DeleteSaleImplCopyWith<$Res> {
  __$$DeleteSaleImplCopyWithImpl(
      _$DeleteSaleImpl _value, $Res Function(_$DeleteSaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleId = null,
  }) {
    return _then(_$DeleteSaleImpl(
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DeleteSaleImpl implements _DeleteSale {
  const _$DeleteSaleImpl({required this.saleId});

  @override
  final int saleId;

  @override
  String toString() {
    return 'SaleDetailsEvent.deleteSale(saleId: $saleId)';
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

  /// Create a copy of SaleDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteSaleImplCopyWith<_$DeleteSaleImpl> get copyWith =>
      __$$DeleteSaleImplCopyWithImpl<_$DeleteSaleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int saleId) getSaleDetails,
    required TResult Function(int saleId) deleteSale,
  }) {
    return deleteSale(saleId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int saleId)? getSaleDetails,
    TResult? Function(int saleId)? deleteSale,
  }) {
    return deleteSale?.call(saleId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int saleId)? getSaleDetails,
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
    required TResult Function(_GetSaleDetails value) getSaleDetails,
    required TResult Function(_DeleteSale value) deleteSale,
  }) {
    return deleteSale(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetSaleDetails value)? getSaleDetails,
    TResult? Function(_DeleteSale value)? deleteSale,
  }) {
    return deleteSale?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetSaleDetails value)? getSaleDetails,
    TResult Function(_DeleteSale value)? deleteSale,
    required TResult orElse(),
  }) {
    if (deleteSale != null) {
      return deleteSale(this);
    }
    return orElse();
  }
}

abstract class _DeleteSale implements SaleDetailsEvent {
  const factory _DeleteSale({required final int saleId}) = _$DeleteSaleImpl;

  @override
  int get saleId;

  /// Create a copy of SaleDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteSaleImplCopyWith<_$DeleteSaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SaleDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(SaleDetailsModel saleDetails, bool isDeleted)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(SaleDetailsModel saleDetails, bool isDeleted)? loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(SaleDetailsModel saleDetails, bool isDeleted)? loaded,
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
abstract class $SaleDetailsStateCopyWith<$Res> {
  factory $SaleDetailsStateCopyWith(
          SaleDetailsState value, $Res Function(SaleDetailsState) then) =
      _$SaleDetailsStateCopyWithImpl<$Res, SaleDetailsState>;
}

/// @nodoc
class _$SaleDetailsStateCopyWithImpl<$Res, $Val extends SaleDetailsState>
    implements $SaleDetailsStateCopyWith<$Res> {
  _$SaleDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleDetailsState
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
    extends _$SaleDetailsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'SaleDetailsState.loading()';
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
    required TResult Function(SaleDetailsModel saleDetails, bool isDeleted)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(SaleDetailsModel saleDetails, bool isDeleted)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(SaleDetailsModel saleDetails, bool isDeleted)? loaded,
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

abstract class _Loading implements SaleDetailsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SaleDetailsModel saleDetails, bool isDeleted});

  $SaleDetailsModelCopyWith<$Res> get saleDetails;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$SaleDetailsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleDetails = null,
    Object? isDeleted = null,
  }) {
    return _then(_$LoadedImpl(
      saleDetails: null == saleDetails
          ? _value.saleDetails
          : saleDetails // ignore: cast_nullable_to_non_nullable
              as SaleDetailsModel,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of SaleDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SaleDetailsModelCopyWith<$Res> get saleDetails {
    return $SaleDetailsModelCopyWith<$Res>(_value.saleDetails, (value) {
      return _then(_value.copyWith(saleDetails: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({required this.saleDetails, this.isDeleted = false});

  @override
  final SaleDetailsModel saleDetails;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'SaleDetailsState.loaded(saleDetails: $saleDetails, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.saleDetails, saleDetails) ||
                other.saleDetails == saleDetails) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saleDetails, isDeleted);

  /// Create a copy of SaleDetailsState
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
    required TResult Function(SaleDetailsModel saleDetails, bool isDeleted)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(saleDetails, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(SaleDetailsModel saleDetails, bool isDeleted)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(saleDetails, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(SaleDetailsModel saleDetails, bool isDeleted)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(saleDetails, isDeleted);
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

abstract class _Loaded implements SaleDetailsState {
  const factory _Loaded(
      {required final SaleDetailsModel saleDetails,
      final bool isDeleted}) = _$LoadedImpl;

  SaleDetailsModel get saleDetails;
  bool get isDeleted;

  /// Create a copy of SaleDetailsState
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
    extends _$SaleDetailsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleDetailsState
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
    return 'SaleDetailsState.error(error: $error)';
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

  /// Create a copy of SaleDetailsState
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
    required TResult Function(SaleDetailsModel saleDetails, bool isDeleted)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(SaleDetailsModel saleDetails, bool isDeleted)? loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(SaleDetailsModel saleDetails, bool isDeleted)? loaded,
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

abstract class _Error implements SaleDetailsState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of SaleDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
