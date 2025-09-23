// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductSearchEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() loadNextData,
    required TResult Function(ProductModel selectedProduct) productSelected,
    required TResult Function() clearSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? loadNextData,
    TResult? Function(ProductModel selectedProduct)? productSelected,
    TResult? Function()? clearSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? loadNextData,
    TResult Function(ProductModel selectedProduct)? productSelected,
    TResult Function()? clearSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchQueryChanged value) searchQueryChanged,
    required TResult Function(_LoadNextData value) loadNextData,
    required TResult Function(_ProductSelected value) productSelected,
    required TResult Function(_ClearSelected value) clearSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(_LoadNextData value)? loadNextData,
    TResult? Function(_ProductSelected value)? productSelected,
    TResult? Function(_ClearSelected value)? clearSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchQueryChanged value)? searchQueryChanged,
    TResult Function(_LoadNextData value)? loadNextData,
    TResult Function(_ProductSelected value)? productSelected,
    TResult Function(_ClearSelected value)? clearSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductSearchEventCopyWith<$Res> {
  factory $ProductSearchEventCopyWith(
          ProductSearchEvent value, $Res Function(ProductSearchEvent) then) =
      _$ProductSearchEventCopyWithImpl<$Res, ProductSearchEvent>;
}

/// @nodoc
class _$ProductSearchEventCopyWithImpl<$Res, $Val extends ProductSearchEvent>
    implements $ProductSearchEventCopyWith<$Res> {
  _$ProductSearchEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductSearchEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SearchQueryChangedImplCopyWith<$Res> {
  factory _$$SearchQueryChangedImplCopyWith(_$SearchQueryChangedImpl value,
          $Res Function(_$SearchQueryChangedImpl) then) =
      __$$SearchQueryChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchQueryChangedImplCopyWithImpl<$Res>
    extends _$ProductSearchEventCopyWithImpl<$Res, _$SearchQueryChangedImpl>
    implements _$$SearchQueryChangedImplCopyWith<$Res> {
  __$$SearchQueryChangedImplCopyWithImpl(_$SearchQueryChangedImpl _value,
      $Res Function(_$SearchQueryChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$SearchQueryChangedImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchQueryChangedImpl implements _SearchQueryChanged {
  const _$SearchQueryChangedImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'ProductSearchEvent.searchQueryChanged(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchQueryChangedImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of ProductSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchQueryChangedImplCopyWith<_$SearchQueryChangedImpl> get copyWith =>
      __$$SearchQueryChangedImplCopyWithImpl<_$SearchQueryChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() loadNextData,
    required TResult Function(ProductModel selectedProduct) productSelected,
    required TResult Function() clearSelected,
  }) {
    return searchQueryChanged(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? loadNextData,
    TResult? Function(ProductModel selectedProduct)? productSelected,
    TResult? Function()? clearSelected,
  }) {
    return searchQueryChanged?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? loadNextData,
    TResult Function(ProductModel selectedProduct)? productSelected,
    TResult Function()? clearSelected,
    required TResult orElse(),
  }) {
    if (searchQueryChanged != null) {
      return searchQueryChanged(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchQueryChanged value) searchQueryChanged,
    required TResult Function(_LoadNextData value) loadNextData,
    required TResult Function(_ProductSelected value) productSelected,
    required TResult Function(_ClearSelected value) clearSelected,
  }) {
    return searchQueryChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(_LoadNextData value)? loadNextData,
    TResult? Function(_ProductSelected value)? productSelected,
    TResult? Function(_ClearSelected value)? clearSelected,
  }) {
    return searchQueryChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchQueryChanged value)? searchQueryChanged,
    TResult Function(_LoadNextData value)? loadNextData,
    TResult Function(_ProductSelected value)? productSelected,
    TResult Function(_ClearSelected value)? clearSelected,
    required TResult orElse(),
  }) {
    if (searchQueryChanged != null) {
      return searchQueryChanged(this);
    }
    return orElse();
  }
}

abstract class _SearchQueryChanged implements ProductSearchEvent {
  const factory _SearchQueryChanged(final String query) =
      _$SearchQueryChangedImpl;

  String get query;

  /// Create a copy of ProductSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchQueryChangedImplCopyWith<_$SearchQueryChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNextDataImplCopyWith<$Res> {
  factory _$$LoadNextDataImplCopyWith(
          _$LoadNextDataImpl value, $Res Function(_$LoadNextDataImpl) then) =
      __$$LoadNextDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextDataImplCopyWithImpl<$Res>
    extends _$ProductSearchEventCopyWithImpl<$Res, _$LoadNextDataImpl>
    implements _$$LoadNextDataImplCopyWith<$Res> {
  __$$LoadNextDataImplCopyWithImpl(
      _$LoadNextDataImpl _value, $Res Function(_$LoadNextDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductSearchEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextDataImpl implements _LoadNextData {
  const _$LoadNextDataImpl();

  @override
  String toString() {
    return 'ProductSearchEvent.loadNextData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadNextDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() loadNextData,
    required TResult Function(ProductModel selectedProduct) productSelected,
    required TResult Function() clearSelected,
  }) {
    return loadNextData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? loadNextData,
    TResult? Function(ProductModel selectedProduct)? productSelected,
    TResult? Function()? clearSelected,
  }) {
    return loadNextData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? loadNextData,
    TResult Function(ProductModel selectedProduct)? productSelected,
    TResult Function()? clearSelected,
    required TResult orElse(),
  }) {
    if (loadNextData != null) {
      return loadNextData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchQueryChanged value) searchQueryChanged,
    required TResult Function(_LoadNextData value) loadNextData,
    required TResult Function(_ProductSelected value) productSelected,
    required TResult Function(_ClearSelected value) clearSelected,
  }) {
    return loadNextData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(_LoadNextData value)? loadNextData,
    TResult? Function(_ProductSelected value)? productSelected,
    TResult? Function(_ClearSelected value)? clearSelected,
  }) {
    return loadNextData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchQueryChanged value)? searchQueryChanged,
    TResult Function(_LoadNextData value)? loadNextData,
    TResult Function(_ProductSelected value)? productSelected,
    TResult Function(_ClearSelected value)? clearSelected,
    required TResult orElse(),
  }) {
    if (loadNextData != null) {
      return loadNextData(this);
    }
    return orElse();
  }
}

abstract class _LoadNextData implements ProductSearchEvent {
  const factory _LoadNextData() = _$LoadNextDataImpl;
}

/// @nodoc
abstract class _$$ProductSelectedImplCopyWith<$Res> {
  factory _$$ProductSelectedImplCopyWith(_$ProductSelectedImpl value,
          $Res Function(_$ProductSelectedImpl) then) =
      __$$ProductSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProductModel selectedProduct});

  $ProductModelCopyWith<$Res> get selectedProduct;
}

/// @nodoc
class __$$ProductSelectedImplCopyWithImpl<$Res>
    extends _$ProductSearchEventCopyWithImpl<$Res, _$ProductSelectedImpl>
    implements _$$ProductSelectedImplCopyWith<$Res> {
  __$$ProductSelectedImplCopyWithImpl(
      _$ProductSelectedImpl _value, $Res Function(_$ProductSelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedProduct = null,
  }) {
    return _then(_$ProductSelectedImpl(
      null == selectedProduct
          ? _value.selectedProduct
          : selectedProduct // ignore: cast_nullable_to_non_nullable
              as ProductModel,
    ));
  }

  /// Create a copy of ProductSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res> get selectedProduct {
    return $ProductModelCopyWith<$Res>(_value.selectedProduct, (value) {
      return _then(_value.copyWith(selectedProduct: value));
    });
  }
}

/// @nodoc

class _$ProductSelectedImpl implements _ProductSelected {
  const _$ProductSelectedImpl(this.selectedProduct);

  @override
  final ProductModel selectedProduct;

  @override
  String toString() {
    return 'ProductSearchEvent.productSelected(selectedProduct: $selectedProduct)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductSelectedImpl &&
            (identical(other.selectedProduct, selectedProduct) ||
                other.selectedProduct == selectedProduct));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedProduct);

  /// Create a copy of ProductSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductSelectedImplCopyWith<_$ProductSelectedImpl> get copyWith =>
      __$$ProductSelectedImplCopyWithImpl<_$ProductSelectedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() loadNextData,
    required TResult Function(ProductModel selectedProduct) productSelected,
    required TResult Function() clearSelected,
  }) {
    return productSelected(selectedProduct);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? loadNextData,
    TResult? Function(ProductModel selectedProduct)? productSelected,
    TResult? Function()? clearSelected,
  }) {
    return productSelected?.call(selectedProduct);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? loadNextData,
    TResult Function(ProductModel selectedProduct)? productSelected,
    TResult Function()? clearSelected,
    required TResult orElse(),
  }) {
    if (productSelected != null) {
      return productSelected(selectedProduct);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchQueryChanged value) searchQueryChanged,
    required TResult Function(_LoadNextData value) loadNextData,
    required TResult Function(_ProductSelected value) productSelected,
    required TResult Function(_ClearSelected value) clearSelected,
  }) {
    return productSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(_LoadNextData value)? loadNextData,
    TResult? Function(_ProductSelected value)? productSelected,
    TResult? Function(_ClearSelected value)? clearSelected,
  }) {
    return productSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchQueryChanged value)? searchQueryChanged,
    TResult Function(_LoadNextData value)? loadNextData,
    TResult Function(_ProductSelected value)? productSelected,
    TResult Function(_ClearSelected value)? clearSelected,
    required TResult orElse(),
  }) {
    if (productSelected != null) {
      return productSelected(this);
    }
    return orElse();
  }
}

abstract class _ProductSelected implements ProductSearchEvent {
  const factory _ProductSelected(final ProductModel selectedProduct) =
      _$ProductSelectedImpl;

  ProductModel get selectedProduct;

  /// Create a copy of ProductSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductSelectedImplCopyWith<_$ProductSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearSelectedImplCopyWith<$Res> {
  factory _$$ClearSelectedImplCopyWith(
          _$ClearSelectedImpl value, $Res Function(_$ClearSelectedImpl) then) =
      __$$ClearSelectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSelectedImplCopyWithImpl<$Res>
    extends _$ProductSearchEventCopyWithImpl<$Res, _$ClearSelectedImpl>
    implements _$$ClearSelectedImplCopyWith<$Res> {
  __$$ClearSelectedImplCopyWithImpl(
      _$ClearSelectedImpl _value, $Res Function(_$ClearSelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductSearchEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSelectedImpl implements _ClearSelected {
  const _$ClearSelectedImpl();

  @override
  String toString() {
    return 'ProductSearchEvent.clearSelected()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSelectedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() loadNextData,
    required TResult Function(ProductModel selectedProduct) productSelected,
    required TResult Function() clearSelected,
  }) {
    return clearSelected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? loadNextData,
    TResult? Function(ProductModel selectedProduct)? productSelected,
    TResult? Function()? clearSelected,
  }) {
    return clearSelected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? loadNextData,
    TResult Function(ProductModel selectedProduct)? productSelected,
    TResult Function()? clearSelected,
    required TResult orElse(),
  }) {
    if (clearSelected != null) {
      return clearSelected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SearchQueryChanged value) searchQueryChanged,
    required TResult Function(_LoadNextData value) loadNextData,
    required TResult Function(_ProductSelected value) productSelected,
    required TResult Function(_ClearSelected value) clearSelected,
  }) {
    return clearSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(_LoadNextData value)? loadNextData,
    TResult? Function(_ProductSelected value)? productSelected,
    TResult? Function(_ClearSelected value)? clearSelected,
  }) {
    return clearSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SearchQueryChanged value)? searchQueryChanged,
    TResult Function(_LoadNextData value)? loadNextData,
    TResult Function(_ProductSelected value)? productSelected,
    TResult Function(_ClearSelected value)? clearSelected,
    required TResult orElse(),
  }) {
    if (clearSelected != null) {
      return clearSelected(this);
    }
    return orElse();
  }
}

abstract class _ClearSelected implements ProductSearchEvent {
  const factory _ClearSelected() = _$ClearSelectedImpl;
}

/// @nodoc
mixin _$ProductSearchState {
  List<ProductModel> get suggestions => throw _privateConstructorUsedError;
  ProductModel? get selectedProduct => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  String? get nextPageUrl => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<ProductModel> suggestions,
            ProductModel? selectedProduct,
            String searchQuery,
            String? nextPageUrl,
            bool isLoading)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<ProductModel> suggestions,
            ProductModel? selectedProduct,
            String searchQuery,
            String? nextPageUrl,
            bool isLoading)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<ProductModel> suggestions,
            ProductModel? selectedProduct,
            String searchQuery,
            String? nextPageUrl,
            bool isLoading)?
        initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ProductSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductSearchStateCopyWith<ProductSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductSearchStateCopyWith<$Res> {
  factory $ProductSearchStateCopyWith(
          ProductSearchState value, $Res Function(ProductSearchState) then) =
      _$ProductSearchStateCopyWithImpl<$Res, ProductSearchState>;
  @useResult
  $Res call(
      {List<ProductModel> suggestions,
      ProductModel? selectedProduct,
      String searchQuery,
      String? nextPageUrl,
      bool isLoading});

  $ProductModelCopyWith<$Res>? get selectedProduct;
}

/// @nodoc
class _$ProductSearchStateCopyWithImpl<$Res, $Val extends ProductSearchState>
    implements $ProductSearchStateCopyWith<$Res> {
  _$ProductSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestions = null,
    Object? selectedProduct = freezed,
    Object? searchQuery = null,
    Object? nextPageUrl = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      suggestions: null == suggestions
          ? _value.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      selectedProduct: freezed == selectedProduct
          ? _value.selectedProduct
          : selectedProduct // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of ProductSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res>? get selectedProduct {
    if (_value.selectedProduct == null) {
      return null;
    }

    return $ProductModelCopyWith<$Res>(_value.selectedProduct!, (value) {
      return _then(_value.copyWith(selectedProduct: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $ProductSearchStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ProductModel> suggestions,
      ProductModel? selectedProduct,
      String searchQuery,
      String? nextPageUrl,
      bool isLoading});

  @override
  $ProductModelCopyWith<$Res>? get selectedProduct;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ProductSearchStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestions = null,
    Object? selectedProduct = freezed,
    Object? searchQuery = null,
    Object? nextPageUrl = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$InitialImpl(
      suggestions: null == suggestions
          ? _value._suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
      selectedProduct: freezed == selectedProduct
          ? _value.selectedProduct
          : selectedProduct // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {required final List<ProductModel> suggestions,
      required this.selectedProduct,
      required this.searchQuery,
      this.nextPageUrl,
      this.isLoading = false})
      : _suggestions = suggestions;

  final List<ProductModel> _suggestions;
  @override
  List<ProductModel> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  @override
  final ProductModel? selectedProduct;
  @override
  final String searchQuery;
  @override
  final String? nextPageUrl;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ProductSearchState.initial(suggestions: $suggestions, selectedProduct: $selectedProduct, searchQuery: $searchQuery, nextPageUrl: $nextPageUrl, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            const DeepCollectionEquality()
                .equals(other._suggestions, _suggestions) &&
            (identical(other.selectedProduct, selectedProduct) ||
                other.selectedProduct == selectedProduct) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_suggestions),
      selectedProduct,
      searchQuery,
      nextPageUrl,
      isLoading);

  /// Create a copy of ProductSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<ProductModel> suggestions,
            ProductModel? selectedProduct,
            String searchQuery,
            String? nextPageUrl,
            bool isLoading)
        initial,
  }) {
    return initial(
        suggestions, selectedProduct, searchQuery, nextPageUrl, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<ProductModel> suggestions,
            ProductModel? selectedProduct,
            String searchQuery,
            String? nextPageUrl,
            bool isLoading)?
        initial,
  }) {
    return initial?.call(
        suggestions, selectedProduct, searchQuery, nextPageUrl, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<ProductModel> suggestions,
            ProductModel? selectedProduct,
            String searchQuery,
            String? nextPageUrl,
            bool isLoading)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(
          suggestions, selectedProduct, searchQuery, nextPageUrl, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ProductSearchState {
  const factory _Initial(
      {required final List<ProductModel> suggestions,
      required final ProductModel? selectedProduct,
      required final String searchQuery,
      final String? nextPageUrl,
      final bool isLoading}) = _$InitialImpl;

  @override
  List<ProductModel> get suggestions;
  @override
  ProductModel? get selectedProduct;
  @override
  String get searchQuery;
  @override
  String? get nextPageUrl;
  @override
  bool get isLoading;

  /// Create a copy of ProductSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
