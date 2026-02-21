// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectProductEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)
        loadProducts,
    required TResult Function() loadNextPageProducts,
    required TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)
        searchProducts,
    required TResult Function() loadNextSearchResults,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        loadProducts,
    TResult? Function()? loadNextPageProducts,
    TResult? Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        searchProducts,
    TResult? Function()? loadNextSearchResults,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        loadProducts,
    TResult Function()? loadNextPageProducts,
    TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        searchProducts,
    TResult Function()? loadNextSearchResults,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadNextPageProducts value) loadNextPageProducts,
    required TResult Function(_SearchProducts value) searchProducts,
    required TResult Function(_LoadNextSearchResults value)
        loadNextSearchResults,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult? Function(_SearchProducts value)? searchProducts,
    TResult? Function(_LoadNextSearchResults value)? loadNextSearchResults,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult Function(_SearchProducts value)? searchProducts,
    TResult Function(_LoadNextSearchResults value)? loadNextSearchResults,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectProductEventCopyWith<$Res> {
  factory $SelectProductEventCopyWith(
          SelectProductEvent value, $Res Function(SelectProductEvent) then) =
      _$SelectProductEventCopyWithImpl<$Res, SelectProductEvent>;
}

/// @nodoc
class _$SelectProductEventCopyWithImpl<$Res, $Val extends SelectProductEvent>
    implements $SelectProductEventCopyWith<$Res> {
  _$SelectProductEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectProductEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadProductsImplCopyWith<$Res> {
  factory _$$LoadProductsImplCopyWith(
          _$LoadProductsImpl value, $Res Function(_$LoadProductsImpl) then) =
      __$$LoadProductsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int? serviceId,
      String pickupDate,
      String returnDate,
      TimeOfDay? pickupTime,
      TimeOfDay? returnTime,
      bool useAvailableProductsApi,
      bool isSales,
      int? bookingId,
      List<int>? variantIds});
}

/// @nodoc
class __$$LoadProductsImplCopyWithImpl<$Res>
    extends _$SelectProductEventCopyWithImpl<$Res, _$LoadProductsImpl>
    implements _$$LoadProductsImplCopyWith<$Res> {
  __$$LoadProductsImplCopyWithImpl(
      _$LoadProductsImpl _value, $Res Function(_$LoadProductsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = freezed,
    Object? pickupDate = null,
    Object? returnDate = null,
    Object? pickupTime = freezed,
    Object? returnTime = freezed,
    Object? useAvailableProductsApi = null,
    Object? isSales = null,
    Object? bookingId = freezed,
    Object? variantIds = freezed,
  }) {
    return _then(_$LoadProductsImpl(
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      pickupDate: null == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String,
      returnDate: null == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as String,
      pickupTime: freezed == pickupTime
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      returnTime: freezed == returnTime
          ? _value.returnTime
          : returnTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      useAvailableProductsApi: null == useAvailableProductsApi
          ? _value.useAvailableProductsApi
          : useAvailableProductsApi // ignore: cast_nullable_to_non_nullable
              as bool,
      isSales: null == isSales
          ? _value.isSales
          : isSales // ignore: cast_nullable_to_non_nullable
              as bool,
      bookingId: freezed == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int?,
      variantIds: freezed == variantIds
          ? _value._variantIds
          : variantIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc

class _$LoadProductsImpl implements _LoadProducts {
  const _$LoadProductsImpl(
      {this.serviceId,
      required this.pickupDate,
      required this.returnDate,
      this.pickupTime,
      this.returnTime,
      this.useAvailableProductsApi = true,
      this.isSales = false,
      this.bookingId,
      final List<int>? variantIds})
      : _variantIds = variantIds;

  @override
  final int? serviceId;
  @override
  final String pickupDate;
  @override
  final String returnDate;
  @override
  final TimeOfDay? pickupTime;
  @override
  final TimeOfDay? returnTime;
  @override
  @JsonKey()
  final bool useAvailableProductsApi;
  @override
  @JsonKey()
  final bool isSales;
  @override
  final int? bookingId;
// For edit mode - to check availability excluding current booking
  final List<int>? _variantIds;
// For edit mode - to check availability excluding current booking
  @override
  List<int>? get variantIds {
    final value = _variantIds;
    if (value == null) return null;
    if (_variantIds is EqualUnmodifiableListView) return _variantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SelectProductEvent.loadProducts(serviceId: $serviceId, pickupDate: $pickupDate, returnDate: $returnDate, pickupTime: $pickupTime, returnTime: $returnTime, useAvailableProductsApi: $useAvailableProductsApi, isSales: $isSales, bookingId: $bookingId, variantIds: $variantIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadProductsImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.pickupDate, pickupDate) ||
                other.pickupDate == pickupDate) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime) &&
            (identical(other.returnTime, returnTime) ||
                other.returnTime == returnTime) &&
            (identical(
                    other.useAvailableProductsApi, useAvailableProductsApi) ||
                other.useAvailableProductsApi == useAvailableProductsApi) &&
            (identical(other.isSales, isSales) || other.isSales == isSales) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            const DeepCollectionEquality()
                .equals(other._variantIds, _variantIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      serviceId,
      pickupDate,
      returnDate,
      pickupTime,
      returnTime,
      useAvailableProductsApi,
      isSales,
      bookingId,
      const DeepCollectionEquality().hash(_variantIds));

  /// Create a copy of SelectProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadProductsImplCopyWith<_$LoadProductsImpl> get copyWith =>
      __$$LoadProductsImplCopyWithImpl<_$LoadProductsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)
        loadProducts,
    required TResult Function() loadNextPageProducts,
    required TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)
        searchProducts,
    required TResult Function() loadNextSearchResults,
  }) {
    return loadProducts(serviceId, pickupDate, returnDate, pickupTime,
        returnTime, useAvailableProductsApi, isSales, bookingId, variantIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        loadProducts,
    TResult? Function()? loadNextPageProducts,
    TResult? Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        searchProducts,
    TResult? Function()? loadNextSearchResults,
  }) {
    return loadProducts?.call(serviceId, pickupDate, returnDate, pickupTime,
        returnTime, useAvailableProductsApi, isSales, bookingId, variantIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        loadProducts,
    TResult Function()? loadNextPageProducts,
    TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        searchProducts,
    TResult Function()? loadNextSearchResults,
    required TResult orElse(),
  }) {
    if (loadProducts != null) {
      return loadProducts(serviceId, pickupDate, returnDate, pickupTime,
          returnTime, useAvailableProductsApi, isSales, bookingId, variantIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadNextPageProducts value) loadNextPageProducts,
    required TResult Function(_SearchProducts value) searchProducts,
    required TResult Function(_LoadNextSearchResults value)
        loadNextSearchResults,
  }) {
    return loadProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult? Function(_SearchProducts value)? searchProducts,
    TResult? Function(_LoadNextSearchResults value)? loadNextSearchResults,
  }) {
    return loadProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult Function(_SearchProducts value)? searchProducts,
    TResult Function(_LoadNextSearchResults value)? loadNextSearchResults,
    required TResult orElse(),
  }) {
    if (loadProducts != null) {
      return loadProducts(this);
    }
    return orElse();
  }
}

abstract class _LoadProducts implements SelectProductEvent {
  const factory _LoadProducts(
      {final int? serviceId,
      required final String pickupDate,
      required final String returnDate,
      final TimeOfDay? pickupTime,
      final TimeOfDay? returnTime,
      final bool useAvailableProductsApi,
      final bool isSales,
      final int? bookingId,
      final List<int>? variantIds}) = _$LoadProductsImpl;

  int? get serviceId;
  String get pickupDate;
  String get returnDate;
  TimeOfDay? get pickupTime;
  TimeOfDay? get returnTime;
  bool get useAvailableProductsApi;
  bool get isSales;
  int?
      get bookingId; // For edit mode - to check availability excluding current booking
  List<int>? get variantIds;

  /// Create a copy of SelectProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadProductsImplCopyWith<_$LoadProductsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPageProductsImplCopyWith<$Res> {
  factory _$$LoadNextPageProductsImplCopyWith(_$LoadNextPageProductsImpl value,
          $Res Function(_$LoadNextPageProductsImpl) then) =
      __$$LoadNextPageProductsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPageProductsImplCopyWithImpl<$Res>
    extends _$SelectProductEventCopyWithImpl<$Res, _$LoadNextPageProductsImpl>
    implements _$$LoadNextPageProductsImplCopyWith<$Res> {
  __$$LoadNextPageProductsImplCopyWithImpl(_$LoadNextPageProductsImpl _value,
      $Res Function(_$LoadNextPageProductsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectProductEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageProductsImpl implements _LoadNextPageProducts {
  const _$LoadNextPageProductsImpl();

  @override
  String toString() {
    return 'SelectProductEvent.loadNextPageProducts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextPageProductsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)
        loadProducts,
    required TResult Function() loadNextPageProducts,
    required TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)
        searchProducts,
    required TResult Function() loadNextSearchResults,
  }) {
    return loadNextPageProducts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        loadProducts,
    TResult? Function()? loadNextPageProducts,
    TResult? Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        searchProducts,
    TResult? Function()? loadNextSearchResults,
  }) {
    return loadNextPageProducts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        loadProducts,
    TResult Function()? loadNextPageProducts,
    TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        searchProducts,
    TResult Function()? loadNextSearchResults,
    required TResult orElse(),
  }) {
    if (loadNextPageProducts != null) {
      return loadNextPageProducts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadNextPageProducts value) loadNextPageProducts,
    required TResult Function(_SearchProducts value) searchProducts,
    required TResult Function(_LoadNextSearchResults value)
        loadNextSearchResults,
  }) {
    return loadNextPageProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult? Function(_SearchProducts value)? searchProducts,
    TResult? Function(_LoadNextSearchResults value)? loadNextSearchResults,
  }) {
    return loadNextPageProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult Function(_SearchProducts value)? searchProducts,
    TResult Function(_LoadNextSearchResults value)? loadNextSearchResults,
    required TResult orElse(),
  }) {
    if (loadNextPageProducts != null) {
      return loadNextPageProducts(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageProducts implements SelectProductEvent {
  const factory _LoadNextPageProducts() = _$LoadNextPageProductsImpl;
}

/// @nodoc
abstract class _$$SearchProductsImplCopyWith<$Res> {
  factory _$$SearchProductsImplCopyWith(_$SearchProductsImpl value,
          $Res Function(_$SearchProductsImpl) then) =
      __$$SearchProductsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int? serviceId,
      String pickupDate,
      String returnDate,
      String? query,
      String? type,
      int? startPrice,
      int? endPrice,
      TimeOfDay? pickupTime,
      TimeOfDay? returnTime,
      bool useAvailableProductsApi,
      bool isSales,
      int? bookingId,
      List<int>? variantIds});
}

/// @nodoc
class __$$SearchProductsImplCopyWithImpl<$Res>
    extends _$SelectProductEventCopyWithImpl<$Res, _$SearchProductsImpl>
    implements _$$SearchProductsImplCopyWith<$Res> {
  __$$SearchProductsImplCopyWithImpl(
      _$SearchProductsImpl _value, $Res Function(_$SearchProductsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = freezed,
    Object? pickupDate = null,
    Object? returnDate = null,
    Object? query = freezed,
    Object? type = freezed,
    Object? startPrice = freezed,
    Object? endPrice = freezed,
    Object? pickupTime = freezed,
    Object? returnTime = freezed,
    Object? useAvailableProductsApi = null,
    Object? isSales = null,
    Object? bookingId = freezed,
    Object? variantIds = freezed,
  }) {
    return _then(_$SearchProductsImpl(
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      pickupDate: null == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String,
      returnDate: null == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as String,
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      startPrice: freezed == startPrice
          ? _value.startPrice
          : startPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      endPrice: freezed == endPrice
          ? _value.endPrice
          : endPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      pickupTime: freezed == pickupTime
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      returnTime: freezed == returnTime
          ? _value.returnTime
          : returnTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      useAvailableProductsApi: null == useAvailableProductsApi
          ? _value.useAvailableProductsApi
          : useAvailableProductsApi // ignore: cast_nullable_to_non_nullable
              as bool,
      isSales: null == isSales
          ? _value.isSales
          : isSales // ignore: cast_nullable_to_non_nullable
              as bool,
      bookingId: freezed == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int?,
      variantIds: freezed == variantIds
          ? _value._variantIds
          : variantIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc

class _$SearchProductsImpl implements _SearchProducts {
  const _$SearchProductsImpl(
      {this.serviceId,
      required this.pickupDate,
      required this.returnDate,
      this.query,
      this.type = 'name',
      this.startPrice,
      this.endPrice,
      this.pickupTime,
      this.returnTime,
      this.useAvailableProductsApi = true,
      this.isSales = false,
      this.bookingId,
      final List<int>? variantIds})
      : _variantIds = variantIds;

  @override
  final int? serviceId;
  @override
  final String pickupDate;
  @override
  final String returnDate;
  @override
  final String? query;
  @override
  @JsonKey()
  final String? type;
  @override
  final int? startPrice;
  @override
  final int? endPrice;
  @override
  final TimeOfDay? pickupTime;
  @override
  final TimeOfDay? returnTime;
  @override
  @JsonKey()
  final bool useAvailableProductsApi;
  @override
  @JsonKey()
  final bool isSales;
  @override
  final int? bookingId;
// For edit mode
  final List<int>? _variantIds;
// For edit mode
  @override
  List<int>? get variantIds {
    final value = _variantIds;
    if (value == null) return null;
    if (_variantIds is EqualUnmodifiableListView) return _variantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SelectProductEvent.searchProducts(serviceId: $serviceId, pickupDate: $pickupDate, returnDate: $returnDate, query: $query, type: $type, startPrice: $startPrice, endPrice: $endPrice, pickupTime: $pickupTime, returnTime: $returnTime, useAvailableProductsApi: $useAvailableProductsApi, isSales: $isSales, bookingId: $bookingId, variantIds: $variantIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchProductsImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.pickupDate, pickupDate) ||
                other.pickupDate == pickupDate) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startPrice, startPrice) ||
                other.startPrice == startPrice) &&
            (identical(other.endPrice, endPrice) ||
                other.endPrice == endPrice) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime) &&
            (identical(other.returnTime, returnTime) ||
                other.returnTime == returnTime) &&
            (identical(
                    other.useAvailableProductsApi, useAvailableProductsApi) ||
                other.useAvailableProductsApi == useAvailableProductsApi) &&
            (identical(other.isSales, isSales) || other.isSales == isSales) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            const DeepCollectionEquality()
                .equals(other._variantIds, _variantIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      serviceId,
      pickupDate,
      returnDate,
      query,
      type,
      startPrice,
      endPrice,
      pickupTime,
      returnTime,
      useAvailableProductsApi,
      isSales,
      bookingId,
      const DeepCollectionEquality().hash(_variantIds));

  /// Create a copy of SelectProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchProductsImplCopyWith<_$SearchProductsImpl> get copyWith =>
      __$$SearchProductsImplCopyWithImpl<_$SearchProductsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)
        loadProducts,
    required TResult Function() loadNextPageProducts,
    required TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)
        searchProducts,
    required TResult Function() loadNextSearchResults,
  }) {
    return searchProducts(
        serviceId,
        pickupDate,
        returnDate,
        query,
        type,
        startPrice,
        endPrice,
        pickupTime,
        returnTime,
        useAvailableProductsApi,
        isSales,
        bookingId,
        variantIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        loadProducts,
    TResult? Function()? loadNextPageProducts,
    TResult? Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        searchProducts,
    TResult? Function()? loadNextSearchResults,
  }) {
    return searchProducts?.call(
        serviceId,
        pickupDate,
        returnDate,
        query,
        type,
        startPrice,
        endPrice,
        pickupTime,
        returnTime,
        useAvailableProductsApi,
        isSales,
        bookingId,
        variantIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        loadProducts,
    TResult Function()? loadNextPageProducts,
    TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        searchProducts,
    TResult Function()? loadNextSearchResults,
    required TResult orElse(),
  }) {
    if (searchProducts != null) {
      return searchProducts(
          serviceId,
          pickupDate,
          returnDate,
          query,
          type,
          startPrice,
          endPrice,
          pickupTime,
          returnTime,
          useAvailableProductsApi,
          isSales,
          bookingId,
          variantIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadNextPageProducts value) loadNextPageProducts,
    required TResult Function(_SearchProducts value) searchProducts,
    required TResult Function(_LoadNextSearchResults value)
        loadNextSearchResults,
  }) {
    return searchProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult? Function(_SearchProducts value)? searchProducts,
    TResult? Function(_LoadNextSearchResults value)? loadNextSearchResults,
  }) {
    return searchProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult Function(_SearchProducts value)? searchProducts,
    TResult Function(_LoadNextSearchResults value)? loadNextSearchResults,
    required TResult orElse(),
  }) {
    if (searchProducts != null) {
      return searchProducts(this);
    }
    return orElse();
  }
}

abstract class _SearchProducts implements SelectProductEvent {
  const factory _SearchProducts(
      {final int? serviceId,
      required final String pickupDate,
      required final String returnDate,
      final String? query,
      final String? type,
      final int? startPrice,
      final int? endPrice,
      final TimeOfDay? pickupTime,
      final TimeOfDay? returnTime,
      final bool useAvailableProductsApi,
      final bool isSales,
      final int? bookingId,
      final List<int>? variantIds}) = _$SearchProductsImpl;

  int? get serviceId;
  String get pickupDate;
  String get returnDate;
  String? get query;
  String? get type;
  int? get startPrice;
  int? get endPrice;
  TimeOfDay? get pickupTime;
  TimeOfDay? get returnTime;
  bool get useAvailableProductsApi;
  bool get isSales;
  int? get bookingId; // For edit mode
  List<int>? get variantIds;

  /// Create a copy of SelectProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchProductsImplCopyWith<_$SearchProductsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextSearchResultsImplCopyWith<$Res> {
  factory _$$LoadNextSearchResultsImplCopyWith(
          _$LoadNextSearchResultsImpl value,
          $Res Function(_$LoadNextSearchResultsImpl) then) =
      __$$LoadNextSearchResultsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextSearchResultsImplCopyWithImpl<$Res>
    extends _$SelectProductEventCopyWithImpl<$Res, _$LoadNextSearchResultsImpl>
    implements _$$LoadNextSearchResultsImplCopyWith<$Res> {
  __$$LoadNextSearchResultsImplCopyWithImpl(_$LoadNextSearchResultsImpl _value,
      $Res Function(_$LoadNextSearchResultsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectProductEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextSearchResultsImpl implements _LoadNextSearchResults {
  const _$LoadNextSearchResultsImpl();

  @override
  String toString() {
    return 'SelectProductEvent.loadNextSearchResults()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextSearchResultsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)
        loadProducts,
    required TResult Function() loadNextPageProducts,
    required TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)
        searchProducts,
    required TResult Function() loadNextSearchResults,
  }) {
    return loadNextSearchResults();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        loadProducts,
    TResult? Function()? loadNextPageProducts,
    TResult? Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        searchProducts,
    TResult? Function()? loadNextSearchResults,
  }) {
    return loadNextSearchResults?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        loadProducts,
    TResult Function()? loadNextPageProducts,
    TResult Function(
            int? serviceId,
            String pickupDate,
            String returnDate,
            String? query,
            String? type,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales,
            int? bookingId,
            List<int>? variantIds)?
        searchProducts,
    TResult Function()? loadNextSearchResults,
    required TResult orElse(),
  }) {
    if (loadNextSearchResults != null) {
      return loadNextSearchResults();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadNextPageProducts value) loadNextPageProducts,
    required TResult Function(_SearchProducts value) searchProducts,
    required TResult Function(_LoadNextSearchResults value)
        loadNextSearchResults,
  }) {
    return loadNextSearchResults(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult? Function(_SearchProducts value)? searchProducts,
    TResult? Function(_LoadNextSearchResults value)? loadNextSearchResults,
  }) {
    return loadNextSearchResults?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult Function(_SearchProducts value)? searchProducts,
    TResult Function(_LoadNextSearchResults value)? loadNextSearchResults,
    required TResult orElse(),
  }) {
    if (loadNextSearchResults != null) {
      return loadNextSearchResults(this);
    }
    return orElse();
  }
}

abstract class _LoadNextSearchResults implements SelectProductEvent {
  const factory _LoadNextSearchResults() = _$LoadNextSearchResultsImpl;
}

/// @nodoc
mixin _$SelectProductState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)?
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
abstract class $SelectProductStateCopyWith<$Res> {
  factory $SelectProductStateCopyWith(
          SelectProductState value, $Res Function(SelectProductState) then) =
      _$SelectProductStateCopyWithImpl<$Res, SelectProductState>;
}

/// @nodoc
class _$SelectProductStateCopyWithImpl<$Res, $Val extends SelectProductState>
    implements $SelectProductStateCopyWith<$Res> {
  _$SelectProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectProductState
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
    extends _$SelectProductStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectProductState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'SelectProductState.loading()';
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
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)
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
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)?
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
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)?
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

abstract class _Loading implements SelectProductState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<ProductModel> products,
      String? nextPageUrl,
      int? serviceId,
      String pickupDate,
      String returnDate,
      bool isPaginating,
      bool isSearching,
      String? searchQuery,
      String? searchType,
      int? startPrice,
      int? endPrice,
      TimeOfDay? pickupTime,
      TimeOfDay? returnTime,
      bool useAvailableProductsApi,
      bool isSales});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$SelectProductStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? nextPageUrl = freezed,
    Object? serviceId = freezed,
    Object? pickupDate = null,
    Object? returnDate = null,
    Object? isPaginating = null,
    Object? isSearching = null,
    Object? searchQuery = freezed,
    Object? searchType = freezed,
    Object? startPrice = freezed,
    Object? endPrice = freezed,
    Object? pickupTime = freezed,
    Object? returnTime = freezed,
    Object? useAvailableProductsApi = null,
    Object? isSales = null,
  }) {
    return _then(_$LoadedImpl(
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      pickupDate: null == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String,
      returnDate: null == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as String,
      isPaginating: null == isPaginating
          ? _value.isPaginating
          : isPaginating // ignore: cast_nullable_to_non_nullable
              as bool,
      isSearching: null == isSearching
          ? _value.isSearching
          : isSearching // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      searchType: freezed == searchType
          ? _value.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as String?,
      startPrice: freezed == startPrice
          ? _value.startPrice
          : startPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      endPrice: freezed == endPrice
          ? _value.endPrice
          : endPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      pickupTime: freezed == pickupTime
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      returnTime: freezed == returnTime
          ? _value.returnTime
          : returnTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      useAvailableProductsApi: null == useAvailableProductsApi
          ? _value.useAvailableProductsApi
          : useAvailableProductsApi // ignore: cast_nullable_to_non_nullable
              as bool,
      isSales: null == isSales
          ? _value.isSales
          : isSales // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<ProductModel> products,
      required this.nextPageUrl,
      this.serviceId,
      required this.pickupDate,
      required this.returnDate,
      this.isPaginating = false,
      this.isSearching = false,
      this.searchQuery,
      this.searchType,
      this.startPrice,
      this.endPrice,
      this.pickupTime,
      this.returnTime,
      this.useAvailableProductsApi = true,
      this.isSales = false})
      : _products = products;

  final List<ProductModel> _products;
  @override
  List<ProductModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final String? nextPageUrl;
  @override
  final int? serviceId;
  @override
  final String pickupDate;
  @override
  final String returnDate;
  @override
  @JsonKey()
  final bool isPaginating;
  @override
  @JsonKey()
  final bool isSearching;
  @override
  final String? searchQuery;
  @override
  final String? searchType;
  @override
  final int? startPrice;
  @override
  final int? endPrice;
  @override
  final TimeOfDay? pickupTime;
  @override
  final TimeOfDay? returnTime;
  @override
  @JsonKey()
  final bool useAvailableProductsApi;
  @override
  @JsonKey()
  final bool isSales;

  @override
  String toString() {
    return 'SelectProductState.loaded(products: $products, nextPageUrl: $nextPageUrl, serviceId: $serviceId, pickupDate: $pickupDate, returnDate: $returnDate, isPaginating: $isPaginating, isSearching: $isSearching, searchQuery: $searchQuery, searchType: $searchType, startPrice: $startPrice, endPrice: $endPrice, pickupTime: $pickupTime, returnTime: $returnTime, useAvailableProductsApi: $useAvailableProductsApi, isSales: $isSales)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.pickupDate, pickupDate) ||
                other.pickupDate == pickupDate) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate) &&
            (identical(other.isPaginating, isPaginating) ||
                other.isPaginating == isPaginating) &&
            (identical(other.isSearching, isSearching) ||
                other.isSearching == isSearching) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.searchType, searchType) ||
                other.searchType == searchType) &&
            (identical(other.startPrice, startPrice) ||
                other.startPrice == startPrice) &&
            (identical(other.endPrice, endPrice) ||
                other.endPrice == endPrice) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime) &&
            (identical(other.returnTime, returnTime) ||
                other.returnTime == returnTime) &&
            (identical(
                    other.useAvailableProductsApi, useAvailableProductsApi) ||
                other.useAvailableProductsApi == useAvailableProductsApi) &&
            (identical(other.isSales, isSales) || other.isSales == isSales));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      nextPageUrl,
      serviceId,
      pickupDate,
      returnDate,
      isPaginating,
      isSearching,
      searchQuery,
      searchType,
      startPrice,
      endPrice,
      pickupTime,
      returnTime,
      useAvailableProductsApi,
      isSales);

  /// Create a copy of SelectProductState
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
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(
        products,
        nextPageUrl,
        serviceId,
        pickupDate,
        returnDate,
        isPaginating,
        isSearching,
        searchQuery,
        searchType,
        startPrice,
        endPrice,
        pickupTime,
        returnTime,
        useAvailableProductsApi,
        isSales);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(
        products,
        nextPageUrl,
        serviceId,
        pickupDate,
        returnDate,
        isPaginating,
        isSearching,
        searchQuery,
        searchType,
        startPrice,
        endPrice,
        pickupTime,
        returnTime,
        useAvailableProductsApi,
        isSales);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
          products,
          nextPageUrl,
          serviceId,
          pickupDate,
          returnDate,
          isPaginating,
          isSearching,
          searchQuery,
          searchType,
          startPrice,
          endPrice,
          pickupTime,
          returnTime,
          useAvailableProductsApi,
          isSales);
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

abstract class _Loaded implements SelectProductState {
  const factory _Loaded(
      {required final List<ProductModel> products,
      required final String? nextPageUrl,
      final int? serviceId,
      required final String pickupDate,
      required final String returnDate,
      final bool isPaginating,
      final bool isSearching,
      final String? searchQuery,
      final String? searchType,
      final int? startPrice,
      final int? endPrice,
      final TimeOfDay? pickupTime,
      final TimeOfDay? returnTime,
      final bool useAvailableProductsApi,
      final bool isSales}) = _$LoadedImpl;

  List<ProductModel> get products;
  String? get nextPageUrl;
  int? get serviceId;
  String get pickupDate;
  String get returnDate;
  bool get isPaginating;
  bool get isSearching;
  String? get searchQuery;
  String? get searchType;
  int? get startPrice;
  int? get endPrice;
  TimeOfDay? get pickupTime;
  TimeOfDay? get returnTime;
  bool get useAvailableProductsApi;
  bool get isSales;

  /// Create a copy of SelectProductState
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
    extends _$SelectProductStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectProductState
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
    return 'SelectProductState.error(error: $error)';
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

  /// Create a copy of SelectProductState
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
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)
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
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)?
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
            List<ProductModel> products,
            String? nextPageUrl,
            int? serviceId,
            String pickupDate,
            String returnDate,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice,
            TimeOfDay? pickupTime,
            TimeOfDay? returnTime,
            bool useAvailableProductsApi,
            bool isSales)?
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

abstract class _Error implements SelectProductState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of SelectProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
