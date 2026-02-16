// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_sales_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllSalesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int? page, String? searchQuery, String? fromDate, String? toDate)
        loadSales,
    required TResult Function() loadMoreSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? page, String? searchQuery, String? fromDate, String? toDate)?
        loadSales,
    TResult? Function()? loadMoreSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? page, String? searchQuery, String? fromDate, String? toDate)?
        loadSales,
    TResult Function()? loadMoreSales,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSales value) loadSales,
    required TResult Function(_LoadMoreSales value) loadMoreSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSales value)? loadSales,
    TResult? Function(_LoadMoreSales value)? loadMoreSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSales value)? loadSales,
    TResult Function(_LoadMoreSales value)? loadMoreSales,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllSalesEventCopyWith<$Res> {
  factory $AllSalesEventCopyWith(
          AllSalesEvent value, $Res Function(AllSalesEvent) then) =
      _$AllSalesEventCopyWithImpl<$Res, AllSalesEvent>;
}

/// @nodoc
class _$AllSalesEventCopyWithImpl<$Res, $Val extends AllSalesEvent>
    implements $AllSalesEventCopyWith<$Res> {
  _$AllSalesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllSalesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadSalesImplCopyWith<$Res> {
  factory _$$LoadSalesImplCopyWith(
          _$LoadSalesImpl value, $Res Function(_$LoadSalesImpl) then) =
      __$$LoadSalesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? page, String? searchQuery, String? fromDate, String? toDate});
}

/// @nodoc
class __$$LoadSalesImplCopyWithImpl<$Res>
    extends _$AllSalesEventCopyWithImpl<$Res, _$LoadSalesImpl>
    implements _$$LoadSalesImplCopyWith<$Res> {
  __$$LoadSalesImplCopyWithImpl(
      _$LoadSalesImpl _value, $Res Function(_$LoadSalesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllSalesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? searchQuery = freezed,
    Object? fromDate = freezed,
    Object? toDate = freezed,
  }) {
    return _then(_$LoadSalesImpl(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
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

class _$LoadSalesImpl implements _LoadSales {
  const _$LoadSalesImpl(
      {this.page, this.searchQuery, this.fromDate, this.toDate});

  @override
  final int? page;
  @override
  final String? searchQuery;
  @override
  final String? fromDate;
  @override
  final String? toDate;

  @override
  String toString() {
    return 'AllSalesEvent.loadSales(page: $page, searchQuery: $searchQuery, fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSalesImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, page, searchQuery, fromDate, toDate);

  /// Create a copy of AllSalesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSalesImplCopyWith<_$LoadSalesImpl> get copyWith =>
      __$$LoadSalesImplCopyWithImpl<_$LoadSalesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int? page, String? searchQuery, String? fromDate, String? toDate)
        loadSales,
    required TResult Function() loadMoreSales,
  }) {
    return loadSales(page, searchQuery, fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? page, String? searchQuery, String? fromDate, String? toDate)?
        loadSales,
    TResult? Function()? loadMoreSales,
  }) {
    return loadSales?.call(page, searchQuery, fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? page, String? searchQuery, String? fromDate, String? toDate)?
        loadSales,
    TResult Function()? loadMoreSales,
    required TResult orElse(),
  }) {
    if (loadSales != null) {
      return loadSales(page, searchQuery, fromDate, toDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSales value) loadSales,
    required TResult Function(_LoadMoreSales value) loadMoreSales,
  }) {
    return loadSales(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSales value)? loadSales,
    TResult? Function(_LoadMoreSales value)? loadMoreSales,
  }) {
    return loadSales?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSales value)? loadSales,
    TResult Function(_LoadMoreSales value)? loadMoreSales,
    required TResult orElse(),
  }) {
    if (loadSales != null) {
      return loadSales(this);
    }
    return orElse();
  }
}

abstract class _LoadSales implements AllSalesEvent {
  const factory _LoadSales(
      {final int? page,
      final String? searchQuery,
      final String? fromDate,
      final String? toDate}) = _$LoadSalesImpl;

  int? get page;
  String? get searchQuery;
  String? get fromDate;
  String? get toDate;

  /// Create a copy of AllSalesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadSalesImplCopyWith<_$LoadSalesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMoreSalesImplCopyWith<$Res> {
  factory _$$LoadMoreSalesImplCopyWith(
          _$LoadMoreSalesImpl value, $Res Function(_$LoadMoreSalesImpl) then) =
      __$$LoadMoreSalesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreSalesImplCopyWithImpl<$Res>
    extends _$AllSalesEventCopyWithImpl<$Res, _$LoadMoreSalesImpl>
    implements _$$LoadMoreSalesImplCopyWith<$Res> {
  __$$LoadMoreSalesImplCopyWithImpl(
      _$LoadMoreSalesImpl _value, $Res Function(_$LoadMoreSalesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllSalesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreSalesImpl implements _LoadMoreSales {
  const _$LoadMoreSalesImpl();

  @override
  String toString() {
    return 'AllSalesEvent.loadMoreSales()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMoreSalesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int? page, String? searchQuery, String? fromDate, String? toDate)
        loadSales,
    required TResult Function() loadMoreSales,
  }) {
    return loadMoreSales();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? page, String? searchQuery, String? fromDate, String? toDate)?
        loadSales,
    TResult? Function()? loadMoreSales,
  }) {
    return loadMoreSales?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? page, String? searchQuery, String? fromDate, String? toDate)?
        loadSales,
    TResult Function()? loadMoreSales,
    required TResult orElse(),
  }) {
    if (loadMoreSales != null) {
      return loadMoreSales();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSales value) loadSales,
    required TResult Function(_LoadMoreSales value) loadMoreSales,
  }) {
    return loadMoreSales(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSales value)? loadSales,
    TResult? Function(_LoadMoreSales value)? loadMoreSales,
  }) {
    return loadMoreSales?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSales value)? loadSales,
    TResult Function(_LoadMoreSales value)? loadMoreSales,
    required TResult orElse(),
  }) {
    if (loadMoreSales != null) {
      return loadMoreSales(this);
    }
    return orElse();
  }
}

abstract class _LoadMoreSales implements AllSalesEvent {
  const factory _LoadMoreSales() = _$LoadMoreSalesImpl;
}

/// @nodoc
mixin _$AllSalesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)?
        loaded,
    TResult Function(String message)? error,
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
abstract class $AllSalesStateCopyWith<$Res> {
  factory $AllSalesStateCopyWith(
          AllSalesState value, $Res Function(AllSalesState) then) =
      _$AllSalesStateCopyWithImpl<$Res, AllSalesState>;
}

/// @nodoc
class _$AllSalesStateCopyWithImpl<$Res, $Val extends AllSalesState>
    implements $AllSalesStateCopyWith<$Res> {
  _$AllSalesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllSalesState
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
    extends _$AllSalesStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllSalesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AllSalesState.loading()';
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
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)
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
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)?
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
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)?
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

abstract class _Loading implements AllSalesState {
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
      String? searchQuery,
      bool isPaginating,
      String? fromDate,
      String? toDate});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$AllSalesStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllSalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sales = null,
    Object? nextPageUrl = freezed,
    Object? searchQuery = freezed,
    Object? isPaginating = null,
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
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      isPaginating: null == isPaginating
          ? _value.isPaginating
          : isPaginating // ignore: cast_nullable_to_non_nullable
              as bool,
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
      this.searchQuery,
      this.isPaginating = false,
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
  final String? searchQuery;
  @override
  @JsonKey()
  final bool isPaginating;
  @override
  final String? fromDate;
  @override
  final String? toDate;

  @override
  String toString() {
    return 'AllSalesState.loaded(sales: $sales, nextPageUrl: $nextPageUrl, searchQuery: $searchQuery, isPaginating: $isPaginating, fromDate: $fromDate, toDate: $toDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._sales, _sales) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.isPaginating, isPaginating) ||
                other.isPaginating == isPaginating) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sales),
      nextPageUrl,
      searchQuery,
      isPaginating,
      fromDate,
      toDate);

  /// Create a copy of AllSalesState
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
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
        sales, nextPageUrl, searchQuery, isPaginating, fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
        sales, nextPageUrl, searchQuery, isPaginating, fromDate, toDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
          sales, nextPageUrl, searchQuery, isPaginating, fromDate, toDate);
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

abstract class _Loaded implements AllSalesState {
  const factory _Loaded(
      {required final List<SaleModel> sales,
      final String? nextPageUrl,
      final String? searchQuery,
      final bool isPaginating,
      final String? fromDate,
      final String? toDate}) = _$LoadedImpl;

  List<SaleModel> get sales;
  String? get nextPageUrl;
  String? get searchQuery;
  bool get isPaginating;
  String? get fromDate;
  String? get toDate;

  /// Create a copy of AllSalesState
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
    extends _$AllSalesStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllSalesState
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
    return 'AllSalesState.error(message: $message)';
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

  /// Create a copy of AllSalesState
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
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)
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
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)?
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
            List<SaleModel> sales,
            String? nextPageUrl,
            String? searchQuery,
            bool isPaginating,
            String? fromDate,
            String? toDate)?
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

abstract class _Error implements AllSalesState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of AllSalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
