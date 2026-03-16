// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductEvent {
  int get serviceId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int serviceId) loadProducts,
    required TResult Function(int serviceId) loadNextPageProducts,
    required TResult Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)
        searchProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int serviceId)? loadProducts,
    TResult? Function(int serviceId)? loadNextPageProducts,
    TResult? Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)?
        searchProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int serviceId)? loadProducts,
    TResult Function(int serviceId)? loadNextPageProducts,
    TResult Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)?
        searchProducts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadNextPageProducts value) loadNextPageProducts,
    required TResult Function(_SearchProducts value) searchProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult? Function(_SearchProducts value)? searchProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult Function(_SearchProducts value)? searchProducts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductEventCopyWith<ProductEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductEventCopyWith<$Res> {
  factory $ProductEventCopyWith(
          ProductEvent value, $Res Function(ProductEvent) then) =
      _$ProductEventCopyWithImpl<$Res, ProductEvent>;
  @useResult
  $Res call({int serviceId});
}

/// @nodoc
class _$ProductEventCopyWithImpl<$Res, $Val extends ProductEvent>
    implements $ProductEventCopyWith<$Res> {
  _$ProductEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
  }) {
    return _then(_value.copyWith(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadProductsImplCopyWith<$Res>
    implements $ProductEventCopyWith<$Res> {
  factory _$$LoadProductsImplCopyWith(
          _$LoadProductsImpl value, $Res Function(_$LoadProductsImpl) then) =
      __$$LoadProductsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int serviceId});
}

/// @nodoc
class __$$LoadProductsImplCopyWithImpl<$Res>
    extends _$ProductEventCopyWithImpl<$Res, _$LoadProductsImpl>
    implements _$$LoadProductsImplCopyWith<$Res> {
  __$$LoadProductsImplCopyWithImpl(
      _$LoadProductsImpl _value, $Res Function(_$LoadProductsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
  }) {
    return _then(_$LoadProductsImpl(
      null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadProductsImpl implements _LoadProducts {
  const _$LoadProductsImpl(this.serviceId);

  @override
  final int serviceId;

  @override
  String toString() {
    return 'ProductEvent.loadProducts(serviceId: $serviceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadProductsImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, serviceId);

  /// Create a copy of ProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadProductsImplCopyWith<_$LoadProductsImpl> get copyWith =>
      __$$LoadProductsImplCopyWithImpl<_$LoadProductsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int serviceId) loadProducts,
    required TResult Function(int serviceId) loadNextPageProducts,
    required TResult Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)
        searchProducts,
  }) {
    return loadProducts(serviceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int serviceId)? loadProducts,
    TResult? Function(int serviceId)? loadNextPageProducts,
    TResult? Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)?
        searchProducts,
  }) {
    return loadProducts?.call(serviceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int serviceId)? loadProducts,
    TResult Function(int serviceId)? loadNextPageProducts,
    TResult Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)?
        searchProducts,
    required TResult orElse(),
  }) {
    if (loadProducts != null) {
      return loadProducts(serviceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadNextPageProducts value) loadNextPageProducts,
    required TResult Function(_SearchProducts value) searchProducts,
  }) {
    return loadProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult? Function(_SearchProducts value)? searchProducts,
  }) {
    return loadProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult Function(_SearchProducts value)? searchProducts,
    required TResult orElse(),
  }) {
    if (loadProducts != null) {
      return loadProducts(this);
    }
    return orElse();
  }
}

abstract class _LoadProducts implements ProductEvent {
  const factory _LoadProducts(final int serviceId) = _$LoadProductsImpl;

  @override
  int get serviceId;

  /// Create a copy of ProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadProductsImplCopyWith<_$LoadProductsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPageProductsImplCopyWith<$Res>
    implements $ProductEventCopyWith<$Res> {
  factory _$$LoadNextPageProductsImplCopyWith(_$LoadNextPageProductsImpl value,
          $Res Function(_$LoadNextPageProductsImpl) then) =
      __$$LoadNextPageProductsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int serviceId});
}

/// @nodoc
class __$$LoadNextPageProductsImplCopyWithImpl<$Res>
    extends _$ProductEventCopyWithImpl<$Res, _$LoadNextPageProductsImpl>
    implements _$$LoadNextPageProductsImplCopyWith<$Res> {
  __$$LoadNextPageProductsImplCopyWithImpl(_$LoadNextPageProductsImpl _value,
      $Res Function(_$LoadNextPageProductsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
  }) {
    return _then(_$LoadNextPageProductsImpl(
      null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadNextPageProductsImpl implements _LoadNextPageProducts {
  const _$LoadNextPageProductsImpl(this.serviceId);

  @override
  final int serviceId;

  @override
  String toString() {
    return 'ProductEvent.loadNextPageProducts(serviceId: $serviceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextPageProductsImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, serviceId);

  /// Create a copy of ProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadNextPageProductsImplCopyWith<_$LoadNextPageProductsImpl>
      get copyWith =>
          __$$LoadNextPageProductsImplCopyWithImpl<_$LoadNextPageProductsImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int serviceId) loadProducts,
    required TResult Function(int serviceId) loadNextPageProducts,
    required TResult Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)
        searchProducts,
  }) {
    return loadNextPageProducts(serviceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int serviceId)? loadProducts,
    TResult? Function(int serviceId)? loadNextPageProducts,
    TResult? Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)?
        searchProducts,
  }) {
    return loadNextPageProducts?.call(serviceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int serviceId)? loadProducts,
    TResult Function(int serviceId)? loadNextPageProducts,
    TResult Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)?
        searchProducts,
    required TResult orElse(),
  }) {
    if (loadNextPageProducts != null) {
      return loadNextPageProducts(serviceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadNextPageProducts value) loadNextPageProducts,
    required TResult Function(_SearchProducts value) searchProducts,
  }) {
    return loadNextPageProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult? Function(_SearchProducts value)? searchProducts,
  }) {
    return loadNextPageProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult Function(_SearchProducts value)? searchProducts,
    required TResult orElse(),
  }) {
    if (loadNextPageProducts != null) {
      return loadNextPageProducts(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageProducts implements ProductEvent {
  const factory _LoadNextPageProducts(final int serviceId) =
      _$LoadNextPageProductsImpl;

  @override
  int get serviceId;

  /// Create a copy of ProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadNextPageProductsImplCopyWith<_$LoadNextPageProductsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchProductsImplCopyWith<$Res>
    implements $ProductEventCopyWith<$Res> {
  factory _$$SearchProductsImplCopyWith(_$SearchProductsImpl value,
          $Res Function(_$SearchProductsImpl) then) =
      __$$SearchProductsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int serviceId,
      String? query,
      String? type,
      int? startPrice,
      int? endPrice});
}

/// @nodoc
class __$$SearchProductsImplCopyWithImpl<$Res>
    extends _$ProductEventCopyWithImpl<$Res, _$SearchProductsImpl>
    implements _$$SearchProductsImplCopyWith<$Res> {
  __$$SearchProductsImplCopyWithImpl(
      _$SearchProductsImpl _value, $Res Function(_$SearchProductsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? query = freezed,
    Object? type = freezed,
    Object? startPrice = freezed,
    Object? endPrice = freezed,
  }) {
    return _then(_$SearchProductsImpl(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int,
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
    ));
  }
}

/// @nodoc

class _$SearchProductsImpl implements _SearchProducts {
  const _$SearchProductsImpl(
      {required this.serviceId,
      this.query,
      this.type = 'name',
      this.startPrice,
      this.endPrice});

  @override
  final int serviceId;
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
  String toString() {
    return 'ProductEvent.searchProducts(serviceId: $serviceId, query: $query, type: $type, startPrice: $startPrice, endPrice: $endPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchProductsImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startPrice, startPrice) ||
                other.startPrice == startPrice) &&
            (identical(other.endPrice, endPrice) ||
                other.endPrice == endPrice));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, serviceId, query, type, startPrice, endPrice);

  /// Create a copy of ProductEvent
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
    required TResult Function(int serviceId) loadProducts,
    required TResult Function(int serviceId) loadNextPageProducts,
    required TResult Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)
        searchProducts,
  }) {
    return searchProducts(serviceId, query, type, startPrice, endPrice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int serviceId)? loadProducts,
    TResult? Function(int serviceId)? loadNextPageProducts,
    TResult? Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)?
        searchProducts,
  }) {
    return searchProducts?.call(serviceId, query, type, startPrice, endPrice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int serviceId)? loadProducts,
    TResult Function(int serviceId)? loadNextPageProducts,
    TResult Function(int serviceId, String? query, String? type,
            int? startPrice, int? endPrice)?
        searchProducts,
    required TResult orElse(),
  }) {
    if (searchProducts != null) {
      return searchProducts(serviceId, query, type, startPrice, endPrice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProducts value) loadProducts,
    required TResult Function(_LoadNextPageProducts value) loadNextPageProducts,
    required TResult Function(_SearchProducts value) searchProducts,
  }) {
    return searchProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProducts value)? loadProducts,
    TResult? Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult? Function(_SearchProducts value)? searchProducts,
  }) {
    return searchProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProducts value)? loadProducts,
    TResult Function(_LoadNextPageProducts value)? loadNextPageProducts,
    TResult Function(_SearchProducts value)? searchProducts,
    required TResult orElse(),
  }) {
    if (searchProducts != null) {
      return searchProducts(this);
    }
    return orElse();
  }
}

abstract class _SearchProducts implements ProductEvent {
  const factory _SearchProducts(
      {required final int serviceId,
      final String? query,
      final String? type,
      final int? startPrice,
      final int? endPrice}) = _$SearchProductsImpl;

  @override
  int get serviceId;
  String? get query;
  String? get type;
  int? get startPrice;
  int? get endPrice;

  /// Create a copy of ProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchProductsImplCopyWith<_$SearchProductsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProductState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductStateCopyWith<$Res> {
  factory $ProductStateCopyWith(
          ProductState value, $Res Function(ProductState) then) =
      _$ProductStateCopyWithImpl<$Res, ProductState>;
}

/// @nodoc
class _$ProductStateCopyWithImpl<$Res, $Val extends ProductState>
    implements $ProductStateCopyWith<$Res> {
  _$ProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductState
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
    extends _$ProductStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ProductState.initial()';
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
    required TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)
        loaded,
    required TResult Function(String error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)?
        loaded,
    TResult Function(String error)? error,
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
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ProductState {
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
    extends _$ProductStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ProductState.loading()';
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
    required TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)?
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
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
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ProductState {
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
      bool isPaginating,
      bool isSearching,
      String? searchQuery,
      String? searchType,
      int? startPrice,
      int? endPrice});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ProductStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? isSearching = null,
    Object? searchQuery = freezed,
    Object? searchType = freezed,
    Object? startPrice = freezed,
    Object? endPrice = freezed,
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
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<ProductModel> products,
      required this.nextPageUrl,
      this.isPaginating = false,
      this.isSearching = false,
      this.searchQuery,
      this.searchType,
      this.startPrice,
      this.endPrice})
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
  String toString() {
    return 'ProductState.loaded(products: $products, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, isSearching: $isSearching, searchQuery: $searchQuery, searchType: $searchType, startPrice: $startPrice, endPrice: $endPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
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
                other.endPrice == endPrice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      nextPageUrl,
      isPaginating,
      isSearching,
      searchQuery,
      searchType,
      startPrice,
      endPrice);

  /// Create a copy of ProductState
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
    required TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(products, nextPageUrl, isPaginating, isSearching, searchQuery,
        searchType, startPrice, endPrice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(products, nextPageUrl, isPaginating, isSearching,
        searchQuery, searchType, startPrice, endPrice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(products, nextPageUrl, isPaginating, isSearching,
          searchQuery, searchType, startPrice, endPrice);
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
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ProductState {
  const factory _Loaded(
      {required final List<ProductModel> products,
      required final String? nextPageUrl,
      final bool isPaginating,
      final bool isSearching,
      final String? searchQuery,
      final String? searchType,
      final int? startPrice,
      final int? endPrice}) = _$LoadedImpl;

  List<ProductModel> get products;
  String? get nextPageUrl;
  bool get isPaginating;
  bool get isSearching;
  String? get searchQuery;
  String? get searchType;
  int? get startPrice;
  int? get endPrice;

  /// Create a copy of ProductState
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
    extends _$ProductStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductState
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
    return 'ProductState.error(error: $error)';
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

  /// Create a copy of ProductState
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
    required TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<ProductModel> products,
            String? nextPageUrl,
            bool isPaginating,
            bool isSearching,
            String? searchQuery,
            String? searchType,
            int? startPrice,
            int? endPrice)?
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
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
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ProductState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of ProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
