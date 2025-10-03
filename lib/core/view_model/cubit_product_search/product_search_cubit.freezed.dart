// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductSearchState {
  List<ProductModel> get suggestions => throw _privateConstructorUsedError;
  ProductModel? get selectedProduct => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  String? get nextPageUrl => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of ProductSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductSearchStateCopyWith<ProductSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductSearchStateCopyWith<$Res> {
  factory $ProductSearchStateCopyWith(
    ProductSearchState value,
    $Res Function(ProductSearchState) then,
  ) = _$ProductSearchStateCopyWithImpl<$Res, ProductSearchState>;
  @useResult
  $Res call({
    List<ProductModel> suggestions,
    ProductModel? selectedProduct,
    String searchQuery,
    String? nextPageUrl,
    bool isLoading,
  });

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
    return _then(
      _value.copyWith(
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
          )
          as $Val,
    );
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
abstract class _$$ProductSearchStateImplCopyWith<$Res>
    implements $ProductSearchStateCopyWith<$Res> {
  factory _$$ProductSearchStateImplCopyWith(
    _$ProductSearchStateImpl value,
    $Res Function(_$ProductSearchStateImpl) then,
  ) = __$$ProductSearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ProductModel> suggestions,
    ProductModel? selectedProduct,
    String searchQuery,
    String? nextPageUrl,
    bool isLoading,
  });

  @override
  $ProductModelCopyWith<$Res>? get selectedProduct;
}

/// @nodoc
class __$$ProductSearchStateImplCopyWithImpl<$Res>
    extends _$ProductSearchStateCopyWithImpl<$Res, _$ProductSearchStateImpl>
    implements _$$ProductSearchStateImplCopyWith<$Res> {
  __$$ProductSearchStateImplCopyWithImpl(
    _$ProductSearchStateImpl _value,
    $Res Function(_$ProductSearchStateImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$ProductSearchStateImpl(
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
      ),
    );
  }
}

/// @nodoc

class _$ProductSearchStateImpl implements _ProductSearchState {
  const _$ProductSearchStateImpl({
    required final List<ProductModel> suggestions,
    required this.selectedProduct,
    required this.searchQuery,
    this.nextPageUrl,
    this.isLoading = false,
  }) : _suggestions = suggestions;

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
    return 'ProductSearchState(suggestions: $suggestions, selectedProduct: $selectedProduct, searchQuery: $searchQuery, nextPageUrl: $nextPageUrl, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductSearchStateImpl &&
            const DeepCollectionEquality().equals(
              other._suggestions,
              _suggestions,
            ) &&
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
    isLoading,
  );

  /// Create a copy of ProductSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductSearchStateImplCopyWith<_$ProductSearchStateImpl> get copyWith =>
      __$$ProductSearchStateImplCopyWithImpl<_$ProductSearchStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ProductSearchState implements ProductSearchState {
  const factory _ProductSearchState({
    required final List<ProductModel> suggestions,
    required final ProductModel? selectedProduct,
    required final String searchQuery,
    final String? nextPageUrl,
    final bool isLoading,
  }) = _$ProductSearchStateImpl;

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
  _$$ProductSearchStateImplCopyWith<_$ProductSearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
