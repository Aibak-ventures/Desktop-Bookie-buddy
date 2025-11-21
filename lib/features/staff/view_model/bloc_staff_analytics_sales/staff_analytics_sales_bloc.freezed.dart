// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_analytics_sales_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StaffAnalyticsSalesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int staffId, int month, int year) loadSales,
    required TResult Function() loadNextPageSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int staffId, int month, int year)? loadSales,
    TResult? Function()? loadNextPageSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int staffId, int month, int year)? loadSales,
    TResult Function()? loadNextPageSales,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSales value) loadSales,
    required TResult Function(_LoadNextPageSales value) loadNextPageSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadSales value)? loadSales,
    TResult? Function(_LoadNextPageSales value)? loadNextPageSales,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSales value)? loadSales,
    TResult Function(_LoadNextPageSales value)? loadNextPageSales,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffAnalyticsSalesEventCopyWith<$Res> {
  factory $StaffAnalyticsSalesEventCopyWith(
    StaffAnalyticsSalesEvent value,
    $Res Function(StaffAnalyticsSalesEvent) then,
  ) = _$StaffAnalyticsSalesEventCopyWithImpl<$Res, StaffAnalyticsSalesEvent>;
}

/// @nodoc
class _$StaffAnalyticsSalesEventCopyWithImpl<$Res,
        $Val extends StaffAnalyticsSalesEvent>
    implements $StaffAnalyticsSalesEventCopyWith<$Res> {
  _$StaffAnalyticsSalesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffAnalyticsSalesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadSalesImplCopyWith<$Res> {
  factory _$$LoadSalesImplCopyWith(
    _$LoadSalesImpl value,
    $Res Function(_$LoadSalesImpl) then,
  ) = __$$LoadSalesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int staffId, int month, int year});
}

/// @nodoc
class __$$LoadSalesImplCopyWithImpl<$Res>
    extends _$StaffAnalyticsSalesEventCopyWithImpl<$Res, _$LoadSalesImpl>
    implements _$$LoadSalesImplCopyWith<$Res> {
  __$$LoadSalesImplCopyWithImpl(
    _$LoadSalesImpl _value,
    $Res Function(_$LoadSalesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffAnalyticsSalesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffId = null,
    Object? month = null,
    Object? year = null,
  }) {
    return _then(
      _$LoadSalesImpl(
        staffId: null == staffId
            ? _value.staffId
            : staffId // ignore: cast_nullable_to_non_nullable
                as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$LoadSalesImpl implements _LoadSales {
  const _$LoadSalesImpl({
    required this.staffId,
    required this.month,
    required this.year,
  });

  @override
  final int staffId;
  @override
  final int month;
  @override
  final int year;

  @override
  String toString() {
    return 'StaffAnalyticsSalesEvent.loadSales(staffId: $staffId, month: $month, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSalesImpl &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year));
  }

  @override
  int get hashCode => Object.hash(runtimeType, staffId, month, year);

  /// Create a copy of StaffAnalyticsSalesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSalesImplCopyWith<_$LoadSalesImpl> get copyWith =>
      __$$LoadSalesImplCopyWithImpl<_$LoadSalesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int staffId, int month, int year) loadSales,
    required TResult Function() loadNextPageSales,
  }) {
    return loadSales(staffId, month, year);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int staffId, int month, int year)? loadSales,
    TResult? Function()? loadNextPageSales,
  }) {
    return loadSales?.call(staffId, month, year);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int staffId, int month, int year)? loadSales,
    TResult Function()? loadNextPageSales,
    required TResult orElse(),
  }) {
    if (loadSales != null) {
      return loadSales(staffId, month, year);
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

abstract class _LoadSales implements StaffAnalyticsSalesEvent {
  const factory _LoadSales({
    required final int staffId,
    required final int month,
    required final int year,
  }) = _$LoadSalesImpl;

  int get staffId;
  int get month;
  int get year;

  /// Create a copy of StaffAnalyticsSalesEvent
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
    extends _$StaffAnalyticsSalesEventCopyWithImpl<$Res,
        _$LoadNextPageSalesImpl>
    implements _$$LoadNextPageSalesImplCopyWith<$Res> {
  __$$LoadNextPageSalesImplCopyWithImpl(
    _$LoadNextPageSalesImpl _value,
    $Res Function(_$LoadNextPageSalesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffAnalyticsSalesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageSalesImpl implements _LoadNextPageSales {
  const _$LoadNextPageSalesImpl();

  @override
  String toString() {
    return 'StaffAnalyticsSalesEvent.loadNextPageSales()';
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
    required TResult Function(int staffId, int month, int year) loadSales,
    required TResult Function() loadNextPageSales,
  }) {
    return loadNextPageSales();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int staffId, int month, int year)? loadSales,
    TResult? Function()? loadNextPageSales,
  }) {
    return loadNextPageSales?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int staffId, int month, int year)? loadSales,
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

abstract class _LoadNextPageSales implements StaffAnalyticsSalesEvent {
  const factory _LoadNextPageSales() = _$LoadNextPageSalesImpl;
}

/// @nodoc
mixin _$StaffAnalyticsSalesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<SaleModel> sales,
      String? nextPageUrl,
      bool isPaginating,
      int staffId,
      int month,
      int year,
    ) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<SaleModel> sales,
      String? nextPageUrl,
      bool isPaginating,
      int staffId,
      int month,
      int year,
    )? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<SaleModel> sales,
      String? nextPageUrl,
      bool isPaginating,
      int staffId,
      int month,
      int year,
    )? loaded,
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
abstract class $StaffAnalyticsSalesStateCopyWith<$Res> {
  factory $StaffAnalyticsSalesStateCopyWith(
    StaffAnalyticsSalesState value,
    $Res Function(StaffAnalyticsSalesState) then,
  ) = _$StaffAnalyticsSalesStateCopyWithImpl<$Res, StaffAnalyticsSalesState>;
}

/// @nodoc
class _$StaffAnalyticsSalesStateCopyWithImpl<$Res,
        $Val extends StaffAnalyticsSalesState>
    implements $StaffAnalyticsSalesStateCopyWith<$Res> {
  _$StaffAnalyticsSalesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffAnalyticsSalesState
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
    extends _$StaffAnalyticsSalesStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffAnalyticsSalesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'StaffAnalyticsSalesState.loading()';
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
      bool isPaginating,
      int staffId,
      int month,
      int year,
    ) loaded,
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
      bool isPaginating,
      int staffId,
      int month,
      int year,
    )? loaded,
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
      bool isPaginating,
      int staffId,
      int month,
      int year,
    )? loaded,
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

abstract class _Loading implements StaffAnalyticsSalesState {
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
    List<SaleModel> sales,
    String? nextPageUrl,
    bool isPaginating,
    int staffId,
    int month,
    int year,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$StaffAnalyticsSalesStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffAnalyticsSalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sales = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? staffId = null,
    Object? month = null,
    Object? year = null,
  }) {
    return _then(
      _$LoadedImpl(
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
        staffId: null == staffId
            ? _value.staffId
            : staffId // ignore: cast_nullable_to_non_nullable
                as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({
    required final List<SaleModel> sales,
    required this.nextPageUrl,
    this.isPaginating = false,
    required this.staffId,
    required this.month,
    required this.year,
  }) : _sales = sales;

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
  final int staffId;
  @override
  final int month;
  @override
  final int year;

  @override
  String toString() {
    return 'StaffAnalyticsSalesState.loaded(sales: $sales, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, staffId: $staffId, month: $month, year: $year)';
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
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(_sales),
        nextPageUrl,
        isPaginating,
        staffId,
        month,
        year,
      );

  /// Create a copy of StaffAnalyticsSalesState
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
      bool isPaginating,
      int staffId,
      int month,
      int year,
    ) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(sales, nextPageUrl, isPaginating, staffId, month, year);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<SaleModel> sales,
      String? nextPageUrl,
      bool isPaginating,
      int staffId,
      int month,
      int year,
    )? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(sales, nextPageUrl, isPaginating, staffId, month, year);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<SaleModel> sales,
      String? nextPageUrl,
      bool isPaginating,
      int staffId,
      int month,
      int year,
    )? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(sales, nextPageUrl, isPaginating, staffId, month, year);
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

abstract class _Loaded implements StaffAnalyticsSalesState {
  const factory _Loaded({
    required final List<SaleModel> sales,
    required final String? nextPageUrl,
    final bool isPaginating,
    required final int staffId,
    required final int month,
    required final int year,
  }) = _$LoadedImpl;

  List<SaleModel> get sales;
  String? get nextPageUrl;
  bool get isPaginating;
  int get staffId;
  int get month;
  int get year;

  /// Create a copy of StaffAnalyticsSalesState
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
    extends _$StaffAnalyticsSalesStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffAnalyticsSalesState
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
    return 'StaffAnalyticsSalesState.error(message: $message)';
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

  /// Create a copy of StaffAnalyticsSalesState
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
      bool isPaginating,
      int staffId,
      int month,
      int year,
    ) loaded,
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
      bool isPaginating,
      int staffId,
      int month,
      int year,
    )? loaded,
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
      bool isPaginating,
      int staffId,
      int month,
      int year,
    )? loaded,
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

abstract class _Error implements StaffAnalyticsSalesState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of StaffAnalyticsSalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
