// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matching_product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MatchingProductEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int fromVariantId, int toShopId)
        loadMatchingProducts,
    required TResult Function() loadNextPageMatchingProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int fromVariantId, int toShopId)? loadMatchingProducts,
    TResult? Function()? loadNextPageMatchingProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int fromVariantId, int toShopId)? loadMatchingProducts,
    TResult Function()? loadNextPageMatchingProducts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMatchingProducts value) loadMatchingProducts,
    required TResult Function(_LoadNextPageMatchingProducts value)
        loadNextPageMatchingProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMatchingProducts value)? loadMatchingProducts,
    TResult? Function(_LoadNextPageMatchingProducts value)?
        loadNextPageMatchingProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMatchingProducts value)? loadMatchingProducts,
    TResult Function(_LoadNextPageMatchingProducts value)?
        loadNextPageMatchingProducts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchingProductEventCopyWith<$Res> {
  factory $MatchingProductEventCopyWith(MatchingProductEvent value,
          $Res Function(MatchingProductEvent) then) =
      _$MatchingProductEventCopyWithImpl<$Res, MatchingProductEvent>;
}

/// @nodoc
class _$MatchingProductEventCopyWithImpl<$Res,
        $Val extends MatchingProductEvent>
    implements $MatchingProductEventCopyWith<$Res> {
  _$MatchingProductEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchingProductEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadMatchingProductsImplCopyWith<$Res> {
  factory _$$LoadMatchingProductsImplCopyWith(_$LoadMatchingProductsImpl value,
          $Res Function(_$LoadMatchingProductsImpl) then) =
      __$$LoadMatchingProductsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int fromVariantId, int toShopId});
}

/// @nodoc
class __$$LoadMatchingProductsImplCopyWithImpl<$Res>
    extends _$MatchingProductEventCopyWithImpl<$Res, _$LoadMatchingProductsImpl>
    implements _$$LoadMatchingProductsImplCopyWith<$Res> {
  __$$LoadMatchingProductsImplCopyWithImpl(_$LoadMatchingProductsImpl _value,
      $Res Function(_$LoadMatchingProductsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchingProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromVariantId = null,
    Object? toShopId = null,
  }) {
    return _then(_$LoadMatchingProductsImpl(
      fromVariantId: null == fromVariantId
          ? _value.fromVariantId
          : fromVariantId // ignore: cast_nullable_to_non_nullable
              as int,
      toShopId: null == toShopId
          ? _value.toShopId
          : toShopId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadMatchingProductsImpl implements _LoadMatchingProducts {
  const _$LoadMatchingProductsImpl(
      {required this.fromVariantId, required this.toShopId});

  @override
  final int fromVariantId;
  @override
  final int toShopId;

  @override
  String toString() {
    return 'MatchingProductEvent.loadMatchingProducts(fromVariantId: $fromVariantId, toShopId: $toShopId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMatchingProductsImpl &&
            (identical(other.fromVariantId, fromVariantId) ||
                other.fromVariantId == fromVariantId) &&
            (identical(other.toShopId, toShopId) ||
                other.toShopId == toShopId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fromVariantId, toShopId);

  /// Create a copy of MatchingProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMatchingProductsImplCopyWith<_$LoadMatchingProductsImpl>
      get copyWith =>
          __$$LoadMatchingProductsImplCopyWithImpl<_$LoadMatchingProductsImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int fromVariantId, int toShopId)
        loadMatchingProducts,
    required TResult Function() loadNextPageMatchingProducts,
  }) {
    return loadMatchingProducts(fromVariantId, toShopId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int fromVariantId, int toShopId)? loadMatchingProducts,
    TResult? Function()? loadNextPageMatchingProducts,
  }) {
    return loadMatchingProducts?.call(fromVariantId, toShopId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int fromVariantId, int toShopId)? loadMatchingProducts,
    TResult Function()? loadNextPageMatchingProducts,
    required TResult orElse(),
  }) {
    if (loadMatchingProducts != null) {
      return loadMatchingProducts(fromVariantId, toShopId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMatchingProducts value) loadMatchingProducts,
    required TResult Function(_LoadNextPageMatchingProducts value)
        loadNextPageMatchingProducts,
  }) {
    return loadMatchingProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMatchingProducts value)? loadMatchingProducts,
    TResult? Function(_LoadNextPageMatchingProducts value)?
        loadNextPageMatchingProducts,
  }) {
    return loadMatchingProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMatchingProducts value)? loadMatchingProducts,
    TResult Function(_LoadNextPageMatchingProducts value)?
        loadNextPageMatchingProducts,
    required TResult orElse(),
  }) {
    if (loadMatchingProducts != null) {
      return loadMatchingProducts(this);
    }
    return orElse();
  }
}

abstract class _LoadMatchingProducts implements MatchingProductEvent {
  const factory _LoadMatchingProducts(
      {required final int fromVariantId,
      required final int toShopId}) = _$LoadMatchingProductsImpl;

  int get fromVariantId;
  int get toShopId;

  /// Create a copy of MatchingProductEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadMatchingProductsImplCopyWith<_$LoadMatchingProductsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextPageMatchingProductsImplCopyWith<$Res> {
  factory _$$LoadNextPageMatchingProductsImplCopyWith(
          _$LoadNextPageMatchingProductsImpl value,
          $Res Function(_$LoadNextPageMatchingProductsImpl) then) =
      __$$LoadNextPageMatchingProductsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPageMatchingProductsImplCopyWithImpl<$Res>
    extends _$MatchingProductEventCopyWithImpl<$Res,
        _$LoadNextPageMatchingProductsImpl>
    implements _$$LoadNextPageMatchingProductsImplCopyWith<$Res> {
  __$$LoadNextPageMatchingProductsImplCopyWithImpl(
      _$LoadNextPageMatchingProductsImpl _value,
      $Res Function(_$LoadNextPageMatchingProductsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchingProductEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageMatchingProductsImpl
    implements _LoadNextPageMatchingProducts {
  const _$LoadNextPageMatchingProductsImpl();

  @override
  String toString() {
    return 'MatchingProductEvent.loadNextPageMatchingProducts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNextPageMatchingProductsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int fromVariantId, int toShopId)
        loadMatchingProducts,
    required TResult Function() loadNextPageMatchingProducts,
  }) {
    return loadNextPageMatchingProducts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int fromVariantId, int toShopId)? loadMatchingProducts,
    TResult? Function()? loadNextPageMatchingProducts,
  }) {
    return loadNextPageMatchingProducts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int fromVariantId, int toShopId)? loadMatchingProducts,
    TResult Function()? loadNextPageMatchingProducts,
    required TResult orElse(),
  }) {
    if (loadNextPageMatchingProducts != null) {
      return loadNextPageMatchingProducts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMatchingProducts value) loadMatchingProducts,
    required TResult Function(_LoadNextPageMatchingProducts value)
        loadNextPageMatchingProducts,
  }) {
    return loadNextPageMatchingProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMatchingProducts value)? loadMatchingProducts,
    TResult? Function(_LoadNextPageMatchingProducts value)?
        loadNextPageMatchingProducts,
  }) {
    return loadNextPageMatchingProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMatchingProducts value)? loadMatchingProducts,
    TResult Function(_LoadNextPageMatchingProducts value)?
        loadNextPageMatchingProducts,
    required TResult orElse(),
  }) {
    if (loadNextPageMatchingProducts != null) {
      return loadNextPageMatchingProducts(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageMatchingProducts implements MatchingProductEvent {
  const factory _LoadNextPageMatchingProducts() =
      _$LoadNextPageMatchingProductsImpl;
}

/// @nodoc
mixin _$MatchingProductState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)?
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
abstract class $MatchingProductStateCopyWith<$Res> {
  factory $MatchingProductStateCopyWith(MatchingProductState value,
          $Res Function(MatchingProductState) then) =
      _$MatchingProductStateCopyWithImpl<$Res, MatchingProductState>;
}

/// @nodoc
class _$MatchingProductStateCopyWithImpl<$Res,
        $Val extends MatchingProductState>
    implements $MatchingProductStateCopyWith<$Res> {
  _$MatchingProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchingProductState
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
    extends _$MatchingProductStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchingProductState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'MatchingProductState.loading()';
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
    required TResult Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)?
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

abstract class _Loading implements MatchingProductState {
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
      int fromVariantId,
      int toShopId,
      String? nextPageUrl,
      bool isPaginating});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$MatchingProductStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchingProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? fromVariantId = null,
    Object? toShopId = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
  }) {
    return _then(_$LoadedImpl(
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      fromVariantId: null == fromVariantId
          ? _value.fromVariantId
          : fromVariantId // ignore: cast_nullable_to_non_nullable
              as int,
      toShopId: null == toShopId
          ? _value.toShopId
          : toShopId // ignore: cast_nullable_to_non_nullable
              as int,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isPaginating: null == isPaginating
          ? _value.isPaginating
          : isPaginating // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<ProductModel> products,
      required this.fromVariantId,
      required this.toShopId,
      required this.nextPageUrl,
      this.isPaginating = false})
      : _products = products;

  final List<ProductModel> _products;
  @override
  List<ProductModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final int fromVariantId;
  @override
  final int toShopId;
  @override
  final String? nextPageUrl;
  @override
  @JsonKey()
  final bool isPaginating;

  @override
  String toString() {
    return 'MatchingProductState.loaded(products: $products, fromVariantId: $fromVariantId, toShopId: $toShopId, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.fromVariantId, fromVariantId) ||
                other.fromVariantId == fromVariantId) &&
            (identical(other.toShopId, toShopId) ||
                other.toShopId == toShopId) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.isPaginating, isPaginating) ||
                other.isPaginating == isPaginating));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      fromVariantId,
      toShopId,
      nextPageUrl,
      isPaginating);

  /// Create a copy of MatchingProductState
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
    required TResult Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(products, fromVariantId, toShopId, nextPageUrl, isPaginating);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(
        products, fromVariantId, toShopId, nextPageUrl, isPaginating);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
          products, fromVariantId, toShopId, nextPageUrl, isPaginating);
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

abstract class _Loaded implements MatchingProductState {
  const factory _Loaded(
      {required final List<ProductModel> products,
      required final int fromVariantId,
      required final int toShopId,
      required final String? nextPageUrl,
      final bool isPaginating}) = _$LoadedImpl;

  List<ProductModel> get products;
  int get fromVariantId;
  int get toShopId;
  String? get nextPageUrl;
  bool get isPaginating;

  /// Create a copy of MatchingProductState
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
    extends _$MatchingProductStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchingProductState
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
    return 'MatchingProductState.error(error: $error)';
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

  /// Create a copy of MatchingProductState
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
    required TResult Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ProductModel> products, int fromVariantId,
            int toShopId, String? nextPageUrl, bool isPaginating)?
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

abstract class _Error implements MatchingProductState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of MatchingProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
