// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SalesListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? search, String? fromDate, String? toDate)
        getSales,
    required TResult Function() getNextPageSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? search, String? fromDate, String? toDate)?
        getSales,
    TResult? Function()? getNextPageSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? search, String? fromDate, String? toDate)?
        getSales,
    TResult Function()? getNextPageSales,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetSales value) getSales,
    required TResult Function(_GetNextPageSales value) getNextPageSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetSales value)? getSales,
    TResult? Function(_GetNextPageSales value)? getNextPageSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetSales value)? getSales,
    TResult Function(_GetNextPageSales value)? getNextPageSales,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesListEventCopyWith<$Res> {
  factory $SalesListEventCopyWith(
          SalesListEvent value, $Res Function(SalesListEvent) then) =
      _$SalesListEventCopyWithImpl<$Res, SalesListEvent>;
}

/// @nodoc
class _$SalesListEventCopyWithImpl<$Res, $Val extends SalesListEvent>
    implements $SalesListEventCopyWith<$Res> {
  _$SalesListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GetSalesImplCopyWith<$Res> {
  factory _$$GetSalesImplCopyWith(
          _$GetSalesImpl value, $Res Function(_$GetSalesImpl) then) =
      __$$GetSalesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? search, String? fromDate, String? toDate});
}

/// @nodoc
class __$$GetSalesImplCopyWithImpl<$Res>
    extends _$SalesListEventCopyWithImpl<$Res, _$GetSalesImpl>
    implements _$$GetSalesImplCopyWith<$Res> {
  __$$GetSalesImplCopyWithImpl(
      _$GetSalesImpl _value, $Res Function(_$GetSalesImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? search = freezed,
    Object? fromDate = freezed,
    Object? toDate = freezed,
  }) {
    return _then(_$GetSalesImpl(
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      fromDate: freezed == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String?,
      toDate: freezed == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GetSalesImpl implements _GetSales {
  const _$GetSalesImpl({this.search, this.fromDate, this.toDate});

  @override
  final String? search;
  @override
  final String? fromDate;
  @override
  final String? toDate;

  @override
  String toString() {
    return 'SalesListEvent.getSales(search: $search, fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetSalesImpl &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, search, fromDate, toDate);

  /// Create a copy of SalesListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetSalesImplCopyWith<_$GetSalesImpl> get copyWith =>
      __$$GetSalesImplCopyWithImpl<_$GetSalesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? search, String? fromDate, String? toDate)
        getSales,
    required TResult Function() getNextPageSales,
  }) {
    return getSales(search, fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? search, String? fromDate, String? toDate)?
        getSales,
    TResult? Function()? getNextPageSales,
  }) {
    return getSales?.call(search, fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? search, String? fromDate, String? toDate)?
        getSales,
    TResult Function()? getNextPageSales,
    required TResult orElse(),
  }) {
    if (getSales != null) {
      return getSales(search, fromDate, toDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetSales value) getSales,
    required TResult Function(_GetNextPageSales value) getNextPageSales,
  }) {
    return getSales(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetSales value)? getSales,
    TResult? Function(_GetNextPageSales value)? getNextPageSales,
  }) {
    return getSales?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetSales value)? getSales,
    TResult Function(_GetNextPageSales value)? getNextPageSales,
    required TResult orElse(),
  }) {
    if (getSales != null) {
      return getSales(this);
    }
    return orElse();
  }
}

abstract class _GetSales implements SalesListEvent {
  const factory _GetSales(
      {final String? search,
      final String? fromDate,
      final String? toDate}) = _$GetSalesImpl;

  String? get search;
  String? get fromDate;
  String? get toDate;

  /// Create a copy of SalesListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetSalesImplCopyWith<_$GetSalesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetNextPageSalesImplCopyWith<$Res> {
  factory _$$GetNextPageSalesImplCopyWith(_$GetNextPageSalesImpl value,
          $Res Function(_$GetNextPageSalesImpl) then) =
      __$$GetNextPageSalesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetNextPageSalesImplCopyWithImpl<$Res>
    extends _$SalesListEventCopyWithImpl<$Res, _$GetNextPageSalesImpl>
    implements _$$GetNextPageSalesImplCopyWith<$Res> {
  __$$GetNextPageSalesImplCopyWithImpl(_$GetNextPageSalesImpl _value,
      $Res Function(_$GetNextPageSalesImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetNextPageSalesImpl implements _GetNextPageSales {
  const _$GetNextPageSalesImpl();

  @override
  String toString() {
    return 'SalesListEvent.getNextPageSales()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetNextPageSalesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? search, String? fromDate, String? toDate)
        getSales,
    required TResult Function() getNextPageSales,
  }) {
    return getNextPageSales();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? search, String? fromDate, String? toDate)?
        getSales,
    TResult? Function()? getNextPageSales,
  }) {
    return getNextPageSales?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? search, String? fromDate, String? toDate)?
        getSales,
    TResult Function()? getNextPageSales,
    required TResult orElse(),
  }) {
    if (getNextPageSales != null) {
      return getNextPageSales();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetSales value) getSales,
    required TResult Function(_GetNextPageSales value) getNextPageSales,
  }) {
    return getNextPageSales(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetSales value)? getSales,
    TResult? Function(_GetNextPageSales value)? getNextPageSales,
  }) {
    return getNextPageSales?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetSales value)? getSales,
    TResult Function(_GetNextPageSales value)? getNextPageSales,
    required TResult orElse(),
  }) {
    if (getNextPageSales != null) {
      return getNextPageSales(this);
    }
    return orElse();
  }
}

abstract class _GetNextPageSales implements SalesListEvent {
  const factory _GetNextPageSales() = _$GetNextPageSalesImpl;
}

/// @nodoc
mixin _$SalesListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<SaleModel> sales, String? nextPageUrl,
            bool isPaginating, String? search, String? fromDate, String? toDate)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<SaleModel> sales,
            String? nextPageUrl,
            bool isPaginating,
            String? search,
            String? fromDate,
            String? toDate)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<SaleModel> sales,
            String? nextPageUrl,
            bool isPaginating,
            String? search,
            String? fromDate,
            String? toDate)?
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
abstract class $SalesListStateCopyWith<$Res> {
  factory $SalesListStateCopyWith(
          SalesListState value, $Res Function(SalesListState) then) =
      _$SalesListStateCopyWithImpl<$Res, SalesListState>;
}

/// @nodoc
class _$SalesListStateCopyWithImpl<$Res, $Val extends SalesListState>
    implements $SalesListStateCopyWith<$Res> {
  _$SalesListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesListState
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
    extends _$SalesListStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'SalesListState.loading()';
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
    required TResult Function(List<SaleModel> sales, String? nextPageUrl,
            bool isPaginating, String? search, String? fromDate, String? toDate)
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
            List<SaleModel> sales,
            String? nextPageUrl,
            bool isPaginating,
            String? search,
            String? fromDate,
            String? toDate)?
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
            List<SaleModel> sales,
            String? nextPageUrl,
            bool isPaginating,
            String? search,
            String? fromDate,
            String? toDate)?
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

abstract class _Loading implements SalesListState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<SaleModel> sales,
      String? nextPageUrl,
      bool isPaginating,
      String? search,
      String? fromDate,
      String? toDate});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$SalesListStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sales = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? search = freezed,
    Object? fromDate = freezed,
    Object? toDate = freezed,
  }) {
    return _then(_$LoadedImpl(
      sales: null == sales
          ? _value._sales
          : sales // ignore: cast_nullable_to_non_nullable
              as List<SaleModel>,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isPaginating: null == isPaginating
          ? _value.isPaginating
          : isPaginating // ignore: cast_nullable_to_non_nullable
              as bool,
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      fromDate: freezed == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String?,
      toDate: freezed == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<SaleModel> sales,
      this.nextPageUrl,
      this.isPaginating = false,
      this.search,
      this.fromDate,
      this.toDate})
      : _sales = sales;

  final List<SaleModel> _sales;
  @override
  List<SaleModel> get sales {
    if (_sales is EqualUnmodifiableListView) return _sales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sales);
  }

  @override
  final String? nextPageUrl;
  @override
  @JsonKey()
  final bool isPaginating;
  @override
  final String? search;
  @override
  final String? fromDate;
  @override
  final String? toDate;

  @override
  String toString() {
    return 'SalesListState.loaded(sales: $sales, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, search: $search, fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._sales, _sales) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.isPaginating, isPaginating) ||
                other.isPaginating == isPaginating) &&
            (identical(other.search, search) || other.search == search) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sales),
      nextPageUrl,
      isPaginating,
      search,
      fromDate,
      toDate);

  /// Create a copy of SalesListState
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
    required TResult Function(List<SaleModel> sales, String? nextPageUrl,
            bool isPaginating, String? search, String? fromDate, String? toDate)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(sales, nextPageUrl, isPaginating, search, fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<SaleModel> sales,
            String? nextPageUrl,
            bool isPaginating,
            String? search,
            String? fromDate,
            String? toDate)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(
        sales, nextPageUrl, isPaginating, search, fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<SaleModel> sales,
            String? nextPageUrl,
            bool isPaginating,
            String? search,
            String? fromDate,
            String? toDate)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(sales, nextPageUrl, isPaginating, search, fromDate, toDate);
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

abstract class _Loaded implements SalesListState {
  const factory _Loaded(
      {required final List<SaleModel> sales,
      final String? nextPageUrl,
      final bool isPaginating,
      final String? search,
      final String? fromDate,
      final String? toDate}) = _$LoadedImpl;

  List<SaleModel> get sales;
  String? get nextPageUrl;
  bool get isPaginating;
  String? get search;
  String? get fromDate;
  String? get toDate;

  /// Create a copy of SalesListState
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
    extends _$SalesListStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesListState
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
    return 'SalesListState.error(error: $error)';
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

  /// Create a copy of SalesListState
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
    required TResult Function(List<SaleModel> sales, String? nextPageUrl,
            bool isPaginating, String? search, String? fromDate, String? toDate)
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
            List<SaleModel> sales,
            String? nextPageUrl,
            bool isPaginating,
            String? search,
            String? fromDate,
            String? toDate)?
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
            List<SaleModel> sales,
            String? nextPageUrl,
            bool isPaginating,
            String? search,
            String? fromDate,
            String? toDate)?
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

abstract class _Error implements SalesListState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of SalesListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
